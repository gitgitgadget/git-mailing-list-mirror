Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87FBC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 19:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354276AbiDZTvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiDZTvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 15:51:45 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63022DD6F
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 12:48:36 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id js10so683742qvb.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v+8ImZ3yXh0V4WAqRjrHX/iuXu/sTGyk2243yuzEODI=;
        b=GN90LyrL/5XSJFmrTxF7VIcoq6nDPHyjPf8lCiv4Hdt/UgpyUyRpT7wbC2MQg5923O
         pynwOfsAt/z8xKU9qYA+z0BsadE1Sj5L11a9FXQEHP9eydj2z5W5iyvUmmbZ/w125bl2
         myZ0RUfavXWn9MFjy57KconRu+3MMUrYtKeV4HEsZ5R+Bqe3tEXKjWgoeeVFn3i9FPrj
         +niy1yF832MeTElTVgZuE/NyO35dYFcp4IWCn0b9Zqnf0n/XyE+0tCjb4Uv1VXawz459
         +B+jS4wTVnMFyV3N+zEN72O4dpwUj6uo/NrTKl0YWlkLcO6Uy976YPkWvYjmI5tfoqDz
         6v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v+8ImZ3yXh0V4WAqRjrHX/iuXu/sTGyk2243yuzEODI=;
        b=ghuV2CBzqPYrRwKrrYh6LhhUIw3cICffMn7VGbeACS4y6wDH3y2N5TOyva/QTK9b0o
         Y/ZnntbjNUB+d8T/+XvPQjlqymVpZd9ePS/tUsqOLl4VUKg/2LfmhZ4wRUK+PnC8lNJP
         YYxzkV+jCI2Fy9wxd+upUaMioIciS2IVWhUxZZLIzd/jdtvFkiM5BCvpeLcMeRmiQtC4
         xrRSITnq20w2uy8F1q3Jvn5iDXWWlcbexlwrwHm7sMelF0ZY/4OINnAWIHqpGc0nvFOM
         2OwXjeSNvJpW5YzGmXg9YLsNqa6V9xMtLeOzwiowRnWX14hSw/1L1SOPgKIDwZrxxtTe
         93Ww==
X-Gm-Message-State: AOAM532CoiVGVcj6cn4Vtl8zf9YvAUYlDvPt4zXod7sPaH4yLUZCQuQb
        ShHGFXGWXlbuWdUGdrnyV7Oy
X-Google-Smtp-Source: ABdhPJwoHz+XC8TZqfjnmd4UTzNc1J/2AO4hodQ+wBT77asJpRAEuhAZr+Cu6uOMwf4lvc/zb2iQgg==
X-Received: by 2002:ad4:5968:0:b0:446:4aae:631a with SMTP id eq8-20020ad45968000000b004464aae631amr17227988qvb.94.1651002515787;
        Tue, 26 Apr 2022 12:48:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6dbb:3c4:4900:218b? ([2600:1700:e72:80a0:6dbb:3c4:4900:218b])
        by smtp.gmail.com with ESMTPSA id 15-20020ac8594f000000b002f200ea2518sm8375257qtz.59.2022.04.26.12.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 12:48:35 -0700 (PDT)
Message-ID: <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
Date:   Tue, 26 Apr 2022 15:48:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks
 if running priviledged
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     philipoakley@iee.email, me@ttaylorr.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220426183105.99779-1-carenas@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220426183105.99779-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2022 2:31 PM, Carlo Marcelo Arenas Belón wrote:
> bdc77d1d685 (Add a function to determine whether a path is owned by the
> current user, 2022-03-02) checks for the effective uid of the running
> process using geteuid() but didn't account for cases where that uid was
> root (because git was invoked through sudo or doas) and the effetive id

s/effetive/effective

> that repositiry trusted for its config was different, therefore failing

s/repositiry/repository

> the following common call:
> 
>   guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
>   [sudo] password for guy:
>   fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)
> 
> Attempt to detect those cases by using the environment variables that
> those tools create to keep track of the original user id, and do the
> ownership check using those instead.
> 
> This assumes the environment the user is running with after going
> priviledged can't be tampered with, and also does the check only for

s/priviledged/privileged 

> root to keep the most common case less complicated, but as a side effect
> will miss cases where sudo (or an equivalent) was used to change to
> another unpriviledged user.

s/unpriviledged/unpriviledged 

> Sent as an RFC as it has been only lightly tested and because some of
> the assumptions I have to make, made me unconfortable.

 
> Ex, in order to make the atoi() calls safe, I was originally doing
> is_digit(), but that would require this function to move further down
> to work.
>
> It is also now big enough that would make sense for it to move into
> its own compat file and outside for git-compat-util.h, but if that is
> done we might not keep the "root uid is not always 0" bits that seem
> useful to have for the future.
>
> getent() is not thread safe, so it might be worth to use an alternative
> but that would require a bigger change.

These points make sense. It would be worth taking our time and
doing some refactoring in advance of this functional change.
 
> IMHO it should have a test added, but not sure where it would fit.

I wonder how we could test a multi-user scenario. The tests I
added in e47363e5a (t0033: add tests for safe.directory, 2022-04-13)
purposefully avoid the user-id functionality.

> Original discussion in :
> 
>   https://lore.kernel.org/git/4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de/

I agree that the idea behind this change is a good one. The escalation
of privilege isn't a huge concern when the "real" user is the same.
The only way to trick the root user here is to set an environment
variable, in which case they might as well modify PATH and be done with
it.

> +	euid = geteuid();
> +	if (euid == ROOT_UID) {
> +		/* we might have raised our priviledges with sudo or doas */

Similar spelling error here.

> +		const char *real_uid = getenv("SUDO_UID");
> +		if (real_uid && *real_uid)
> +			euid = atoi(real_uid);
> +		else {
> +			real_uid = getenv("DOAS_UID");
> +			if (real_uid && *real_uid)
> +				euid = atoi(real_uid);
> +		}

I imagine that something else could be added here to help Windows
users who have elevated to administrator privileges. It will use a
completely different mechanism, though, if needed at all. We can
delay that for now.

Thanks,
-Stolee
