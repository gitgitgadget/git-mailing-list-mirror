Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25095C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1908613F0
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhD2RPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhD2RPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 13:15:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81EC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:14:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c22so15838055edn.7
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DWQS2v0M9wReWem4MKyE7Er5PZJscMw/zp88Yvu9Jzg=;
        b=ugiVrpbr5Ie8HF7I+F+WhzIOFLciPR9URQOr1W48CCFKHyDLMcjm4ufqVlCyRn5iqR
         h+fGa8982WCxqlkFRmO5jRRGMWwwrMYDDpEGnqXQmU8OQw9jr+BxRVouo/PzC5jRJRMA
         sbT9IqhOuPgtz4ngQ4cAbzr8yF90bR6J/ab0aPAqI+5/nIDeVvZ0Iq2jW+RP1Oh/cqs2
         Zw/4pTUzxNmv+93c2nV7ohLrl5N8ji6gROOvfY6TKTy3OpORHxNqpz7qAwX+6nZq0bpr
         2UxJGgHOSnHaDlqhcailCTQexRM7D+UrXaIZGpOnLPW+Kn2JnEiuhxMG1LM3SOGvxknq
         Wrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DWQS2v0M9wReWem4MKyE7Er5PZJscMw/zp88Yvu9Jzg=;
        b=V8ArMF0WG5s3mn68/eMi79YjICpkaqA4lovZnumEXAryAkv7KP3wJzT4irWywxsoN4
         7jckAC9uQFHKtOkcFkQXou+iKWq2cec4RLn8lFtCOGcIY3iT9kC8lLvdnRtNgRGdbGGW
         pBSk3FW/U0OiSpYZXOa9MDCm1A7nvGhwNW7T7pBVr/b8FrH/F6LnJasMvrmaZPuKmCSt
         jZ4cXFE3GbJ/6hD0dtMtC6vMKfx8bXA7aBPU84bfV9UlTt7wLZusTi/oqO1M9l5uGB1z
         mSexq9wvRBi+ltSTtw9kP2Ah2K6KQFfVaL+HHmGNMto/PigDy5Jk9eCuzTkvAzd3/gT7
         8bfA==
X-Gm-Message-State: AOAM530/aTJ0bqR1aKyGYtU6jjQMNU7n/VOLcb2XOceDMksfGqS15MQH
        cnSbJTmDQ54DlS2h4crGm6Osz6MgwouF/lHE7pU=
X-Google-Smtp-Source: ABdhPJxixE20TkzMNoTEjF0splwOFZ99On1n5BUX50C/9a5Wj208Ifq78tLw5uno0bPox2BED8+LhgHOMcqcq5+bYHw=
X-Received: by 2002:a05:6402:35d3:: with SMTP id z19mr730524edc.143.1619716485453;
 Thu, 29 Apr 2021 10:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210428145824.43c4t7hkjfqjyspb@tb-raspi4> <20210429074458.891-1-tzadik.vanderhoof@gmail.com>
 <c4c48615-d1f4-fd37-0960-979535907f15@web.de>
In-Reply-To: <c4c48615-d1f4-fd37-0960-979535907f15@web.de>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Thu, 29 Apr 2021 10:14:33 -0700
Message-ID: <CAKu1iLXJAdtKYQq25mZ4vvQUO=4K1S-p5vg0UioUQMBKzRtumA@mail.gmail.com>
Subject: Re: [PATCH v6] Add git-p4.fallbackEncoding
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 7:12 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> Hej Tzadik,
>
> This version went only to my email ?
>

v6 went to the list as well as your email.  I just forgot to include
you in the email to the list, so I sent you another copy with just
you.

> The test case number seems to be fixed, thanks.
>
> (Normally we don't have this collision, but right now
> it seem as if there is much going on in the git-p4 area,
> which is good)
>
> The "headline" is still overlong, it seams.
>

I did shorten the first line of my commit as you asked and used that
commit to create the v6 path. That first (short) line goes into the
Subject line of the patch. When you do "git am" it will use the
subject (which is short) as the first line of the commit. The overlong
summary will become the 3rd line of the commit (after a blank second
line)
