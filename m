From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 2/5] Rework diff options
Date: Sat, 24 Jun 2006 01:40:21 +0300
Message-ID: <20060624014021.ebce199e.tihirvon@gmail.com>
References: <20060624003315.804a1796.tihirvon@gmail.com>
	<20060624005252.c694e421.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:40:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtuKJ-0007Xk-U9
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbWFWWk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbWFWWk0
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:40:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:22057 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752143AbWFWWkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:40:24 -0400
Received: by nf-out-0910.google.com with SMTP id m19so280191nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:40:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JC4gcu+pFlKnEEStO1UNRs1fxENjzFJeRguLrOSEoK+Jaj1wxuR0Zzk1/Chy2anrjMhRKzxMw9LKV71e3kUH4Wdv/R1qLiQm6OwnD1ScvsTMxYPnBG54s4DJhMwTj9cqq9jf3U5I/8o2RajRoVAr3ihMS8kgJNLjtTCEUfBWnPY=
Received: by 10.49.60.17 with SMTP id n17mr2880421nfk;
        Fri, 23 Jun 2006 15:40:23 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id l32sm251376nfa.2006.06.23.15.40.22;
        Fri, 23 Jun 2006 15:40:22 -0700 (PDT)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624005252.c694e421.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22449>

Timo Hirvonen <tihirvon@gmail.com> wrote:

> @@ -878,13 +867,13 @@ void diff_tree_combined(const unsigned c
>  			num_paths++;
>  	}
>  	if (num_paths) {
> -		if (opt->with_raw) {
> -			int saved_format = opt->output_format;
> -			opt->output_format = DIFF_FORMAT_RAW;
> +		if (opt->output_fmt & OUTPUT_FMT_RAW) {
> +			int saved_fmt = opt->output_fmt;
> +			opt->output_fmt |= OUTPUT_FMT_RAW;

I have no idea if this is more right than this:

                        opt->output_fmt = OUTPUT_FMT_RAW;

> @@ -852,8 +852,8 @@ int setup_revisions(int argc, const char
>  	if (revs->combine_merges) {
>  		revs->ignore_merges = 0;
>  		if (revs->dense_combined_merges &&
> -		    (revs->diffopt.output_format != DIFF_FORMAT_DIFFSTAT))
> -			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
> +		   !(revs->diffopt.output_fmt & OUTPUT_FMT_DIFFSTAT))
> +			revs->diffopt.output_fmt |= OUTPUT_FMT_PATCH;

I'm not sure about this. Didn't really understand the code :)

-- 
http://onion.dynserv.net/~timo/
