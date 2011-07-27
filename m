From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard
 file
Date: Wed, 27 Jul 2011 05:39:56 +0200
Message-ID: <20110727033956.GA18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qluyw-0001WW-SO
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab1G0DkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:40:21 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:35148 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab1G0DkU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:40:20 -0400
Received: by eye22 with SMTP id 22so1525496eye.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6eYY97rV8XWu7KeFHNL5v3L+x2sUEEnBcaUQzk2Z0yU=;
        b=EkTj5ECv0PAccXBtyHwffTwBnXda04a0lyXU+hui8c3keJa6O+gs/IAoNArVij1xZY
         NQcYtIBEFHwA0xHZq57pPxnXDmuiUsdL1Wi9MblhIF/xgeda0fMCYL7vw3Hk/38bOZ1K
         S5KgflEhk23eO4fhnTAvMs5KgD3Df1rbEsBAQ=
Received: by 10.14.22.9 with SMTP id s9mr1997536ees.215.1311738019690;
        Tue, 26 Jul 2011 20:40:19 -0700 (PDT)
Received: from elie (adsl-165-228-149.teol.net [109.165.228.149])
        by mx.google.com with ESMTPS id e9sm793764eeb.20.2011.07.26.20.40.17
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:40:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177923>

Ramkumar Ramachandra wrote:

> --- a/config.c
> +++ b/config.c
> @@ -1387,6 +1387,24 @@ write_err_out:
>  
>  }
>  
> +int git_config_set_multivar(const char *key, const char *value,
> +			const char *value_regex, int multi_replace)
> +{
> +	const char *config_filename;
> +	char *filename_buf = NULL;
> +	int ret;
> +
> +	if (config_exclusive_filename)
> +		config_filename = config_exclusive_filename;
> +	else
> +		config_filename = filename_buf = git_pathdup("config");

I know my sloppy example before is to blame for this, but the
"filename_buf" variable name is needlessly verbose --- its semantics
are just that it is something to be free()ed.  So if I were submitting
this I would use "buf".

The change description needs copyediting.

Anyway, with or without the variable name change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  Patch 1 also looks sensible.
