Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84570C4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 10:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjADK0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 05:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjADKZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 05:25:56 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33656F6F
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 02:25:48 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so20514622otp.9
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P96ZauVYdsIZJpLcSIKUCP/u2AGsmrvEpkdeDJI3Jvg=;
        b=NOZj63Yr7MG9U8loqTQCOenp3WyY2GpBMh+uTI+s2igsP6E83xPyvs56NRYX366fgw
         pfWvkXRRU49vL870D2mkuczqj4tvuejGvKiSIiCJTjsDkrX6VR7IkGBAVWHrMl/qxm5r
         2MkXntuY3YbfzyjHlpa0lN5O9lPjah5HRfP2NP212vmyYibwLep9k17RHqNAkEqPmf2O
         mXU8P2d1dZSh7QkYHDH13Up+lc0ceylPEMSxyFVNCtqAp+iwowJ83uCMWRnXbpbra2Tc
         Y09R77oie5X44ksyw5qKE0nT21BvsKU67yKcvvHhm7MYa2q3XTU+V7Yx6DB0FjOv3/j+
         q2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P96ZauVYdsIZJpLcSIKUCP/u2AGsmrvEpkdeDJI3Jvg=;
        b=TU/NgHLITkw9I+BGBu9kJGzkb6R2Tk2vAwr9hxKEmEelEuM1Hs33oxAHFbf59NGTN/
         OzuDW/Tl+uetN+l8yxDmPgca9O3+T++YloCuudfit9igiZTRHhosmmhw+eD2YWlPkcWk
         m1puq5vB2DrSjLpe7OLrXdbn2RR3Lgrl8npW73O0W5jykJyDUm6tJrw6xeoNgV0aSSx3
         i1DtiJY3rFzvHGOfyuTtawNthnb5FCiewSNTuBq0qzeCZqVsGEXUbLOucwsFOwSM1RZD
         NO+ERPOs8yNHuAWeWXer0ikGuIVzI4lIfv0pDfXCU7RU9xFeXbi8T/fo2BLBzyEhJqUM
         tiEw==
X-Gm-Message-State: AFqh2kqQWs/3ajUr+9xzrGIi66sNajVoe2XcdLLyah3ZdiuxsERhIlWj
        vECrnCpbVI0rc9Qm54IF0cJbLPMrN5OChSpaMyfN9YessD8=
X-Google-Smtp-Source: AMrXdXvYjkHdVSpD6qCsQvNA5xiCKImvlId4HUFRn/bj+x40qDkPum70VXZnGEdax1XalAXD2S6I21lBu9WRTdnWnz4=
X-Received: by 2002:a05:6830:12c6:b0:663:c86f:7573 with SMTP id
 a6-20020a05683012c600b00663c86f7573mr3165220otq.187.1672827947412; Wed, 04
 Jan 2023 02:25:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671793109.git.karthik.188@gmail.com> <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
 <xmqq1qocwlr9.fsf@gitster.g>
In-Reply-To: <xmqq1qocwlr9.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 4 Jan 2023 11:25:21 +0100
Message-ID: <CAOLa=ZStKKgyaHGjGVpQ5jsSpkdqXuH2RhvWOgrU2qKxGbQFGA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] attr: add flag `--source` to work with tree-ish
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2023 at 12:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Likewise.
>
> Perhaps squash something like this in in the next iteration?
>
>  attr.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git i/attr.h w/attr.h
> index 84a3279215..fca6c30430 100644
> --- i/attr.h
> +++ w/attr.h
> @@ -108,6 +108,7 @@
>   */
>
>  struct index_state;
> +struct object_id;
>
>  /**
>   * An attribute is an opaque object that is identified by its name. Pass the

Thanks Junio, I'll squash this in, waiting for more reviews before
rolling out a new version.

-- 
- Karthik
