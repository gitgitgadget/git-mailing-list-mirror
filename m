From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv8 1/9] submodule-config: keep update strategy around
Date: Thu, 4 Feb 2016 16:59:46 -0800
Message-ID: <20160205005946.GA19501@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
 <1454623776-3347-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 02:00:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRUl3-00087L-RL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 02:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbcBEBAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 20:00:16 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33141 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbcBEBAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 20:00:15 -0500
Received: by mail-pf0-f171.google.com with SMTP id w123so59184863pfb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 17:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aNNepksPnaegyvQ3SIApl2SRzjvzto2exPMJVzPiz94=;
        b=CPoL/E0ja/KlmsdbUhfw/y9Y1w1+KE48wV6YO/vm1LDnrHD6dxLwgcE44dXdL/SYQe
         f8kpWCJHqXMbhHbPQtGRx9Y3oEzo+HfcQWsln95LU8TM5YOekTIr5w0MSoUG3bKub90B
         PZCJjuqZcpzhHyq/F3xzW1DH8cguZrIy2pMrCLIfxYwKHksn/1Va3MH5Qj8LgJvAZJuY
         pqoVfjQmj23nO3MVXlp3t+ONLGbBLtiXaTNiGiT0QdQkkwvaQu2xjmqocpICmMzYygs8
         PZ4NgmY/TWHC0Kd+fAXGQwThWqgJ8xMtejEYaTzPgy6FSw57t8jlwirQPNZafaoWiuWP
         rCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aNNepksPnaegyvQ3SIApl2SRzjvzto2exPMJVzPiz94=;
        b=EUXEi8AAm6QFvT7yYXVQjNioXccCE9Tb4UsKNkNjekM91/RY2IS5DoUVN0mSExIk+t
         WOmLiaxDYXIXCLRVbu0QagrFpkZpDSuiL2Dp2BLv8kTLeGAEeEahjbDn105y7iZCHoKy
         Hr9zXeR62Bg1rtPgldL4Z+3Vp2NVjqL/Dxui+fTaadZse4KuaFqrMzyDqSPJMyDWz1YP
         KqfahfGjJtiWZKocibpmACvYk3TcN2JWw9qnQ5SVWFf+dVDs/UTHPJWl+h5yZqe1sBhU
         Ob49VYoj1b8nlkT2rzovLb7odAPI6aiUrOL8xFqhTr5ez4xIEvmvq2f/370QEY107Q7y
         n9pw==
X-Gm-Message-State: AG10YOR7Ka7EOwkVqsPzrCc1qXFEQH1zLfH4Z14r6GQMH62B9VxtdrG2k1KCB6XctJD1tA==
X-Received: by 10.98.10.149 with SMTP id 21mr15834439pfk.75.1454634014650;
        Thu, 04 Feb 2016 17:00:14 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:13b:4e5f:e68f:7e5b])
        by smtp.gmail.com with ESMTPSA id w12sm19785383pfa.79.2016.02.04.17.00.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 17:00:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454623776-3347-2-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285533>

Hi,

It's been a while since I looked at this series.  Hopefully I can
come at it with some fresh eyes.  Thanks for your perseverance.

Stefan Beller wrote:

> We need the submodule update strategies in a later patch.

This description doesn't explain what the patch will do or why
parse_config didn't already retain the value.  If I look back
at this patch later and want to understand why it was written,
what would I want to know?

It could say

	Currently submodule.<name>.update is only handled by git-submodule.sh.
	C code will start to need to make use of that value as more of the
	functionality of git-submodule.sh moves into library code in C.

	Add the update field to 'struct submodule' and populate it so it can
	be read as sm->update.

[...]
> +++ b/submodule-config.c
> @@ -311,6 +312,16 @@ static int parse_config(const char *var, const char *value, void *data)
>  			free((void *) submodule->url);
>  			submodule->url = xstrdup(value);
>  		}
> +	} else if (!strcmp(item.buf, "update")) {
> +		if (!value)
> +			ret = config_error_nonbool(var);
> +		else if (!me->overwrite && submodule->update != NULL)
> +			warn_multiple_config(me->commit_sha1, submodule->name,
> +					     "update");
> +		else {
> +			free((void *) submodule->update);
> +			submodule->update = xstrdup(value);
> +		}

(not about this patch) This code is repetitive.  Would there be a way
to share code between the parsing of different per-submodule settings?

[...]
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -14,6 +14,7 @@ struct submodule {
>  	const char *url;
>  	int fetch_recurse;
>  	const char *ignore;
> +	const char *update;

gitmodules(5) tells me the only allowed values are checkout, rebase,
merge, and none.  I wouldn't know at a glance how to match against
those in calling code.  Can this be an enum?

Thanks,
Jonathan
