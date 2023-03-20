Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC2C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjCTQte (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjCTQr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7922DE6D
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:41:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a32so12769849ljr.9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679330476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71dB5VCT/2aH+RpT/CkADr+dA8ZJRquu2i/KanbbCpY=;
        b=LDtKY37l4n8MLCWQLS1xcHlq7JYyEuzIhEfnScB80iBh2aT9WPwyIwQvVcZW/4kvoq
         IGyh4HOeZUuY1G7a2V4X/ZtG1S7U5OwVw57UQzOBxq2aPwXMJSD4PajnrE+F5pXOO2YH
         xyL0/6K8JFy1Bvm80BOGCFTwihrDNvMhaPfBcKDGFVz/7plWU3uKehhGqva6kinnSPAe
         0opo7j45kU9gwHGU7I5MjfTPZ9UmDvFGbq34MpU77+TwpMc/yqUu7G1S3prE5IjBW1N6
         1RiHIFEh3YEWoOOlAppsU216v3VzGrQ5cFRK52wGT9w8Goh883oSB5OMKeVqqH21xReO
         977A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679330476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71dB5VCT/2aH+RpT/CkADr+dA8ZJRquu2i/KanbbCpY=;
        b=LsoqjZpsXbgoVeFevaalSWsOV9m41GSXVznDL7obGRVZfv335gebdVUVViicBVs9LG
         0eiERi+Ny6uiMkQ4h0M6rSVyjM7W4ctViD0O43x8bA+72b2lSD7GdzEXklNdbcjTDTxa
         dJLcdcMFZ8I6QGbTjm0hExgDlOtpYabhTZLRjjYtvWfectHXEtSv9mhYZloLBV85FGP5
         boLxfo3j3xq7dNPFmkZgIt3mBD0Kd03kpRN9GHSQbHZwE2un50PImyOEqtkJrhQ4QZ/N
         y0Wuwvbn5vKpRxWLLEvzz3BdCOlv4dXLDUK8OzHY2ZpZl0bG1JfadIQUNHtoWtF+Jvi+
         le5Q==
X-Gm-Message-State: AO0yUKXVQS0oY3M1iLELF+h6Ho2lNd2h/Z9e4rQDwXrfCtUknIkCrjWq
        U1A0iCcEkgtqm5GI+GmLY7mubosJp0sbRK1V6hAFelUel7s=
X-Google-Smtp-Source: AK7set8AqUvm/jBwH+IFsNZHwfZ1S6cMCEePWn73wm7mau2Fawube5ld/gzEnbQP6jBRxtBGnfYv75Qf/PkOfCvzb1Y=
X-Received: by 2002:a2e:9d54:0:b0:295:93eb:e796 with SMTP id
 y20-20020a2e9d54000000b0029593ebe796mr209115ljj.1.1679330475936; Mon, 20 Mar
 2023 09:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230319162712.654137-1-szeder.dev@gmail.com>
In-Reply-To: <20230319162712.654137-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Mar 2023 09:41:03 -0700
Message-ID: <CABPp-BHVsxVQJrar3qc1xGCSwFXKtBmma1V4xo__8YMOi0Xc2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove unnecessary inclusions of parse-options.h from headers
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2023 at 10:13=E2=80=AFAM SZEDER G=C3=A1bor <szeder.dev@gmai=
l.com> wrote:
>
> Some source files use parse_options(), but don't include
> parse-options.h, while some headers do include parse-options.h, though
> don't really need it.  These patches fix these issues.

Nice!

Reviewed-by: Elijah Newren <newren@gmail.com>

> This series has a small and simple conflict with the 'ds/ahead-behind'
> topic, and it will have small conflicts with Elijah's header cleanup
> series as well:
>
>   https://public-inbox.org/git/pull.1493.git.1679207282.gitgitgadget@gmai=
l.com/T/#t

Perhaps it makes sense to rebase your series on that one?  (And/or add
the headers earlier in the list instead of at the end to reduce the
odds of patch collisions?  I really wish we had our #include's in
alphabetical order instead of always appending to the end, because it
both reduces the odds of conflicts and is so much easier for humans to
check.)
