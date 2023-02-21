Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E85C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 05:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBUFhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 00:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBUFhV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 00:37:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D793323861
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 21:37:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o16so3622667pjp.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 21:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4zBD7OXKsAyjSJ1+4AuTU2fsDAYMSZX0pQ/UJvfdFw=;
        b=eAd/SE0CuaZTXjr2Rg7j+GdHE8DreFEn/tkXQDSWxejfJ1XVIpvTP4kmNBYHDFRfOR
         Kl4VmiFookPlWB+dE/b/JE1cuLnZUV2YPmZ7xCMGXL12+h8YXfJXvTKL1/kt8FyKDKcZ
         3uvpB8wSIZPaEmNzHCkCG2L8ZSgoz0XXYGEt9u99EMeVYke6+TsbDHMz3VaGctCoqBw2
         sQVCs/Gf6aowMMlhlOJLr3kuNST96KITj18WpOowiKYF1r7UCmqJrFCDoSC9b7F9KQ1/
         hgrm/lDX+sx9RY80XVtOesNakM6ZoTZVdN3EjLavZRDBe8QTnWPqib5I2g6s/SVlDoJG
         LrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4zBD7OXKsAyjSJ1+4AuTU2fsDAYMSZX0pQ/UJvfdFw=;
        b=L91V2uD94+JNAhQfd0CCXIShLnXbIwEdnO93YEm3InKwAkeHNMevC54yt/nuGdpEzA
         XEqtPpEYFOnYRjseybZWOMzg1lBDv38xvUD+PmY/a3QLuUP8rAeievkPEcrDUUDS/hdj
         MlDaOkf8a89g6U+/W8As34OaJSeY8LoQjB+EnyESu5ElNQ+8axhZh403Pm5IBhJAyQnu
         VCD5sh8k/8U1nNQpwCUCXbF+Qa3PElfn2HzJ45zNaOYfT3INKHidi+Dpw7GgWE/E80+3
         wU5q84PXREmzku0bfq6PD1IVDdKO2sptsKkQ5Kxj4IdRGLCsTcNtcpTApSrqcChRuumR
         m8IQ==
X-Gm-Message-State: AO0yUKUbXT7fMudSb2vI7ZtCvbQ3nXJmH/eyW8mZbFWgVY3kJsqKKMCV
        5Mv9WYc0Pqeyaj86/rWZXu0=
X-Google-Smtp-Source: AK7set+8yM5SEzyaBSOG6cbdnE5WUMPiL2nVsDON3mjMjhoQnmUUleLJGoWjhx0fOlj1pVYfJVWpGQ==
X-Received: by 2002:a17:90b:1806:b0:234:a9df:db96 with SMTP id lw6-20020a17090b180600b00234a9dfdb96mr5416771pjb.33.1676957839178;
        Mon, 20 Feb 2023 21:37:19 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t18-20020a632252000000b004f25fc5b490sm2295358pgm.5.2023.02.20.21.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 21:37:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] archive: add --mtime
References: <Y+6G9n6cWRT9EKyl@google.com>
        <91a73f5d-ca3e-6cb0-4ba3-38d703074ee6@web.de>
        <xmqqilfykhsf.fsf@gitster.g>
        <57b6643a-b9ff-3ea4-d60d-1a434d9ea75e@web.de>
Date:   Mon, 20 Feb 2023 21:37:18 -0800
Message-ID: <xmqqlekrh94h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> This is the solution with least damage, letting the existing code to
>> set archive_time and then discard the result and overwrite with the
>> command line option.
>
> I actually like Peff's solution more, because it's short and solves the
> specific problem of non-deterministic timestamps for tree archives.

Yes.  That would be my preference as well.  Without any UI to
educate users about.

> The --mtime option on the other hand mimics GNU tar, so it is more
> familiar and proven, though.

And that gives us the second best option ;-)

> It isn't all that careful, but you're right that we should do what we
> can.  Like this on top?  The message string is borrowed from commit's
> handling of --date.

Yeah, something like that, I would think.

Thanks.

> ---
>  archive.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/archive.c b/archive.c
> index 122860b39d..871d80ee79 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -438,6 +438,15 @@ static void parse_pathspec_arg(const char **pathspec,
>  	}
>  }
>
> +static timestamp_t approxidate_or_die(const char *date_str)
> +{
> +	int errors = 0;
> +	timestamp_t date = approxidate_careful(date_str, &errors);
> +	if (errors)
> +		die(_("invalid date format: %s"), date_str);
> +	return date;
> +}
> +
>  static void parse_treeish_arg(const char **argv,
>  		struct archiver_args *ar_args, const char *prefix,
>  		int remote)
> @@ -473,7 +482,7 @@ static void parse_treeish_arg(const char **argv,
>  		archive_time = time(NULL);
>  	}
>  	if (ar_args->mtime_option)
> -		archive_time = approxidate(ar_args->mtime_option);
> +		archive_time = approxidate_or_die(ar_args->mtime_option);
>
>  	tree = parse_tree_indirect(&oid);
>  	if (!tree)
> --
> 2.39.2
