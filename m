Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E956F201A7
	for <e@80x24.org>; Thu, 18 May 2017 05:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbdERFij (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 01:38:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34120 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbdERFii (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 01:38:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so4579629pgb.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 22:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rFXFhNPicXCaoqA7xzgqCm6YGLZWJBb65rOAd3RsUOs=;
        b=LwobsI8s58goV1sg2lZwtSA4rsE6rZk7MIxaDkQIjfrAzhFJFMwyMxVPilvnkScaV0
         qOSHponlpLnpmPwBWDByGcnJbRVBccQtWPpBCRwAvq4VFnF8hsybjYUA2fSnaz69Y1ar
         FH5EPqlhtN9+fEirZL1jGFf7FTkJe1h9DY1BTTSEZTkiUAsia6T/2+HqFB0WcDHiaRW0
         bFn6Is6UEfF5mcowBy7z3aOLwcN83CJXQs7PUSZzc8LEM0FT1mc0nY8PoWVfpl/wyf9C
         9tAJyFjTs1ii+/JxihQT+ZySTFdpmBbpLBDqcL9gBT9lRmjg0QWpOfBiO8w1Jip+OvUK
         pzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rFXFhNPicXCaoqA7xzgqCm6YGLZWJBb65rOAd3RsUOs=;
        b=sm9DKyLfeN5Ql9738ZhlNupsCDnyggA3RMWHvDiQz81OeA3XKqFoE6rkut5Ebgv5LG
         zSTlk4h3p2HRWbtjJz60bYisUQ4FLuK22yZaz6Rtb7tMRIJttmuTYYcswEOTsnylr7lR
         dC5Oo2dFTT9wZQG4DhdO4NGzCgbMqbCnIhui/EDMfI8QrcShk+9pm8jVSgdmMRVlX0mO
         tpJPrrATRymEZyD7qpg+1xzQBZTz3F64xJnBlGdFrUtNSW6Ofa7/TIQCaAZZLSWOuPM4
         o0tFFKbsuYjwiEDxHL/NP0WuhWpxB8lZsD+paXWa0SWga1lfeSc/rmZD+S7OcC12AMgy
         RZaw==
X-Gm-Message-State: AODbwcAqVCc73n2wPeR9t1kMN9jgExxOylJeZA3mJUzDspwBceP+c1qV
        3g8GbeFncOe6ewRYgGI=
X-Received: by 10.98.139.21 with SMTP id j21mr2529131pfe.5.1495085917955;
        Wed, 17 May 2017 22:38:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id d13sm6884761pfl.12.2017.05.17.22.38.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 22:38:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org
Subject: Re: [PATCH 1/3] submodule.c: add has_submodules to check if we have any submodules
References: <20170517213135.20988-1-sbeller@google.com>
        <20170517213135.20988-2-sbeller@google.com>
Date:   Thu, 18 May 2017 14:38:36 +0900
In-Reply-To: <20170517213135.20988-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 17 May 2017 14:31:33 -0700")
Message-ID: <xmqqshk2u3kz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 4ef7a08afc..510ef1c9de 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1344,7 +1344,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			set_config_fetch_recurse_submodules(arg);
>  		}
>  		gitmodules_config();
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  	}
>  
> ...
> +static enum {
> +	SUBMODULE_CONFIG_NOT_READ = 0,
> +	SUBMODULE_CONFIG_NO_CONFIG,
> +	SUBMODULE_CONFIG_EXISTS,
> +} submodule_config_reading;
> +
>  /*
>   * The following flag is set if the .gitmodules file is unmerged. We then
>   * disable recursion for all submodules where .git/config doesn't have a
> @@ -83,6 +89,62 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
>  	return 0;
>  }
>  
> +static int submodule_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "submodule.fetchjobs")) {
> +...
> +	}
> +	return 0;
> +}
> +
> +void load_submodule_config(void)
> +{
> +	submodule_config_reading = SUBMODULE_CONFIG_NO_CONFIG;
> +	git_config(submodule_config, NULL);
> +}

OK, so anybody who does the git_config(submodule_config) must
instead call this one, so that we can notice there is some
"submodule" stuff configured.  And that is ensured by making
submodule_config private to this module.

Nicely done.

On a possibly related tangent, I've often found it somewhat
irritating that that these two calls have to go hand-in-hand.

>  		gitmodules_config();
> -		git_config(submodule_config, NULL);

I wonder if it makes sense to roll that gitmodule_config() thing
into this function as well?  

Or do some callsites of load_submodule_config() need to omit call to
gitmodules_config()?  If so please disregard.

Thanks.



