From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] diff.c: Do not initialize a variable, which gets
 reassigned anyway.
Date: Sun, 14 Jul 2013 15:18:48 -0700
Message-ID: <20130714221848.GE13444@google.com>
References: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
 <1373837749-14402-4-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 00:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyUdN-0003JS-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 00:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab3GNWSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 18:18:53 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56001 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab3GNWSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 18:18:52 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so10254502pdj.28
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gzzOR1jw1nU//aSYa1DSGxIfKdyEPRjtGPTcv/NUNCI=;
        b=U9L9tKPiRHQAKOc+m1vT2wUZS4Be97tcSCGDX6YgQlap0HAP32PHlTNYbwi4f34Ywu
         YqsuDQIvMRtLFLPcvIXxSgXP/b2tX4Lw691iCWo26g5dt0RxuO3wpjSSFE4aXjSkc1Dd
         LnGjQa0XSKqRQ/TekXn6RIy0T4IbJ248MWbWvzSbhMOhX4ZQaPyL0bt3mcctw97wc2hN
         9gykGBXknkikg4Gdd12vrlVpA8SKzpVgHIBgmHSIYhOACYZS7SP+KMLI4cQ1H4Lu6Um3
         nmG/hzR4ZaeuzbniXN8za25+furLfBoObIOsmo1MHlC7FxYdVuLXuhBtwbosU2mNPqzW
         UDlg==
X-Received: by 10.68.143.73 with SMTP id sc9mr51411434pbb.2.1373840331981;
        Sun, 14 Jul 2013 15:18:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iv4sm57243146pbc.9.2013.07.14.15.18.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 15:18:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373837749-14402-4-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230401>

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  diff.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
[...]
> --- a/diff.c
> +++ b/diff.c
> @@ -1677,21 +1677,19 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		}
>  
>  		/*
>  		 * scale the add/delete
>  		 */
>  		add = added;
>  		del = deleted;
>  
>  		if (graph_width <= max_change) {
> -			int total = add + del;
> -
> -			total = scale_linear(add + del, graph_width, max_change);
> +			int total = scale_linear(add + del, graph_width, max_change);

Yeah, we should have caught this in review.

Thanks for reporting.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
