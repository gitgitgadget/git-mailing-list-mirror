Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C731AC636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 17:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjBGRz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjBGRz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 12:55:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7197313E
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 09:55:27 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id jn16-20020a170903051000b00198f5741d23so5106717plb.18
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 09:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhbH9Nf/19UwlhUOJKiIhOVx9wunC4yQ+Io2CawujF4=;
        b=c9QwL+iiVCfHYGr/u/2RKRFtJATP2k6UE/bzL+Y/DnWaoxOBw6CI+aZxXZCIe1yMpW
         svk5koL9NVapOCY80A/t9EebyzA6rN+SMJdh53FNWhDMJHGb2iQf1nDiBTyr+GH0Mec1
         w30/cKaFvtLr3y7y1KVWnjfp/UjMWwp7S7xVUWugbHGCyRx60E+A2mBTEwt6Rs01UtCl
         27bcAUxXKNYXYeAYNI+woONdeQ5HDCXSsOOq6us+jrTT2CAMwQWg6JTzzH7fm4/+mS9y
         2bu+6SrQTBgqKM1tT/jo7FT+EKR3n+7aBOfU6kyAt1tbHddHfl2ig7ivDaCtYy5RwrQQ
         V3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qhbH9Nf/19UwlhUOJKiIhOVx9wunC4yQ+Io2CawujF4=;
        b=Ffl12Xg1BDLYn0sF6Fx0/vVpFYLzr/MzQqpbjHvtSDOEmRi5doUgUeaqS52v1cJaPQ
         kmGVKbIkmBMtV7isLH0fmGdTbMUlx5myVl1rdkcY+eBZGKfphjY4zRP0lhjsWT+I+e3s
         hexfxn0hbJBWgVczcleuQyytl/wtNpCsB2k934lnJxbXqlNSol7bizgeB0VU2/gJlGsm
         JxkgEKBQiSrd8RL29WImBJsXMM31uNrkzf3c15d0OKQjzjwtxuRGEuZCU1WWW0K+Zp4x
         +heK5M3Z9XbXrC7S9w/jP489GA7m27v3l4j8XBYvM6Wv672aQXKISWc7WZPlcmuD/MmA
         bPnw==
X-Gm-Message-State: AO0yUKW/aCgnNrtHUs/ThrNhJSpTP2TNNa71R6QnvnMkm8/4XL1ty8v4
        WrPGwlmO6efSOCqow9PvTQCK0HZ93N4ZoQ==
X-Google-Smtp-Source: AK7set/RVG+MXmpSwXiGnDxzWqOFDxocaCZxbafKRXD8r/mKWAJDEb31m4OxlLC83+8iRMuF7afzFJhOahEMHw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4003:b0:230:a1ad:2c94 with SMTP
 id ie3-20020a17090b400300b00230a1ad2c94mr2582311pjb.127.1675792526899; Tue,
 07 Feb 2023 09:55:26 -0800 (PST)
Date:   Wed, 08 Feb 2023 01:55:24 +0800
In-Reply-To: <patch-1.1-31f4a08c068-20230207T161453Z-avarab@gmail.com>
Mime-Version: 1.0
References: <patch-1.1-31f4a08c068-20230207T161453Z-avarab@gmail.com>
Message-ID: <kl6lo7q5icmr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] config.h: remove unused git_configset_add_parameters()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This function was removed in ecec57b3c97 (config: respect includes in
> protected config, 2022-10-13), but its prototype was left here.

Ugh, that's my mistake. Thanks for the catch.

> diff --git a/config.h b/config.h
> index ef9eade6414..7606246531a 100644
> --- a/config.h
> +++ b/config.h
> @@ -447,15 +447,6 @@ void git_configset_init(struct config_set *cs);
>   */
>  int git_configset_add_file(struct config_set *cs, const char *filename);
> =20
> -/**
> - * Parses command line options and environment variables, and adds the
> - * variable-value pairs to the `config_set`. Returns 0 on success, or -1
> - * if there is an error in parsing. The caller decides whether to free
> - * the incomplete configset or continue using it when the function
> - * returns -1.
> - */
> -int git_configset_add_parameters(struct config_set *cs);
> -
>  /**
>   * Finds and returns the value list, sorted in order of increasing prior=
ity
>   * for the configuration variable `key` and config set `cs`. When the
> --=20
> 2.39.1.1430.gb2471c0aaf4


Reviewed-by: Glen Choo <chooglen@google.com>
