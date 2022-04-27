Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C7C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiD0SPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiD0SPC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:15:02 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C372B258
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:11:49 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id c62so2459105vsc.10
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF5+5qW7TPQPn07ey9kiRjlDgekV3kYyQ36W4I8L80Y=;
        b=lt4QGlFkdaM3Ngd8mte2V+IsocgHgyknmvzDYfJuP1boX++JU7XppdfD+H1vlHm1Qz
         LLjGpAhvMRH5tU6Chrqu57/gWn4Ap9jj7JrFRVlXaSQD8Zo6VZKMlWsUCsrGAsol+1R/
         4b73P2eyuh8VW/eyhAQ70PUxOVbPbk/7dNMwlKooPaM7pHvTUgpDLsTbcmoWnDVTv7V7
         rUn6mJOtynXMNVICFaMhW6xz4iYjUuBw/iilOg6sEWpzJz3qQhYPLwiBLIpl1g6a0Yub
         ysszQUvLNsnapH7+jdYIKeCeUMHyYVQS9eP7+C5uZXVsUT33pZxbltjTU2KTCxm+lq2O
         WxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF5+5qW7TPQPn07ey9kiRjlDgekV3kYyQ36W4I8L80Y=;
        b=HDGRgVjZaEKx+357ZJyyAz7ltRJzTwO4XBRiphUTDNNFLQils1K1ewYOfhbhhV4454
         1ol524Vh9N7T5QfcvKtjBBxXyJ8nHysTZEtfkYaVj3r0pC0C3COrp85li23x1PXuWcTz
         r3VVOv932it7tEGJnTAq8SXsV+U7iIsWWUPVlzO6rb8YT4Rxu9KzHPmZEZvLfVl9SjFr
         qoFXT0gsxuHrf5sIgCNZJZk7rTdiyXUEVBdOEBIbUyaqjUGCsyEz/thkTM95wT4kYEPq
         9BFRzQC0X8S7Yqtt5FPsovxjYOgYolOAtt3qmHb7Q2dE2HiRqOE0ohZh/e4tpJ49B8Wk
         AeMA==
X-Gm-Message-State: AOAM530M7Bv+xyqwZKB8eEqHijbMEcwALVsYbULZQFbsVwHHz6jqOZzc
        3jFL6/CwiVnWVg+gLXvUt2NBrc64H/ytYQDW2J0=
X-Google-Smtp-Source: ABdhPJzdT7Fw9+dDNg8ICpplRoUQEu57VCH9zgU4GS8gwUl6bQ8pqx0EEGTp+JYvmX20Tp1Zq+89HTeSSwdcdzwf1ag=
X-Received: by 2002:a67:1a02:0:b0:320:a51f:8067 with SMTP id
 a2-20020a671a02000000b00320a51f8067mr9457753vsa.38.1651083108797; Wed, 27 Apr
 2022 11:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
 <xmqqczh2o5xg.fsf@gitster.g> <ed2cdc8f-1908-a095-ddf1-660ef8b5a90b@gmail.com>
 <00ab01d85a5f$2831e0a0$7895a1e0$@nexbridge.com> <CAPUEspjgMw2CwFCj4i+iH8phX_8mSRT0wPYhNrEA0E6avNTaTQ@mail.gmail.com>
 <00b501d85a61$74130240$5c3906c0$@nexbridge.com>
In-Reply-To: <00b501d85a61$74130240$5c3906c0$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 11:11:37 -0700
Message-ID: <CAPUEspgOwmQwqBjauKW=VYJjry3537Te4RLjB=ZuT=CU+rRA4A@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     rsbecker@nexbridge.com
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 11:06 AM <rsbecker@nexbridge.com> wrote:
> Results on NonStop: strtol("123456789012345678", &endptr, 10) returns 4294967295 and *endptr == '\0' just beyond the last 8.

Thanks and errno == ERANGE as POSIX requires, right?, the code
(untested) I was planning to use instead looks like :

static inline void extract_id_from_env(const char *env, uid_t *id)
{
        const char *real_uid = getenv(env);

        /* discard any empty values */
        if (real_uid && *real_uid) {
                unsigned long extracted_id;
                int saved_errno = errno;

                errno = 0;
                extracted_id = strtoul(real_uid, NULL, 10);
                if (!errno)
                        *id = (uid_t)extracted_id;
                errno = saved_errno;
        }
        return 0;
}

Carlo
