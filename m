Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0ACE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 02:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIXC1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 22:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXC1M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 22:27:12 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2E109
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 19:27:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64cca551ae2so25684506d6.0
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 19:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695522425; x=1696127225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPFm4DpDZ+cpASE4YzvJ5p/Ml41Fp/5Qk++rbXki/4c=;
        b=B5gFwNcrzoFHi7cL9h9o390MPgW3xnMasyOit7hNMUn2S0eQ7aFaPwZ/NnaJuo/90q
         wQJzqrm6emW5t9p211rJXixAM6MfVeKb62MWPh0a4IEA+36EVnJpl7ODoGOPP/NasD17
         V4k+XlN9EZAm9dfqCjr7TTwPGbrvSdpwfBf7Vq47RK+5UIJiWuieDL/m5kc5X3tsHKTj
         zyrbf/teqPyeo6kOcelb+BPwk3u3RjJfZY0Mz2+Go3LAjyADxBYVEyeh15SaoykmuHAg
         YdHDUMzZW2LS19PF5umtu6SHEx4cm+0wDwEBw9R2gwescN5E4VMu4nrJg8f7UvCwiMhr
         ShjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695522425; x=1696127225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPFm4DpDZ+cpASE4YzvJ5p/Ml41Fp/5Qk++rbXki/4c=;
        b=f2NQXTYUpfN5OxCdB5KEevfhmu4qOSTk7xwayWwVRPaqQnKKeZGw1S6QrDnMSdQ0Cf
         GondEz4n+b2eFwLyI955lpiHdxorBRPbudaBmJ1tsVaSq9RL3K2gTwaR36ahXsdwWJcQ
         XzAZ4c/IxQH+tNXnpwY7nYeFbRpNIs/h0czzchMM6Mza+e4CtsH9mbWf8i8igxcp5d3y
         hY6/V68NEp5OwcZy2AsGyTVzzcUx2tJCAVu3bJPDLJmYzFW0NAFn3yNCFJIP+KNaqO6h
         AxY4yfr2Cyrk5u/hSvj3MCbUz6yexyOxqPsLw7v0QEEMLHRn/g0Q54pEaPBZJWSuv4pC
         7inw==
X-Gm-Message-State: AOJu0YwwAli/VqjtyPzoRe6Mbuo5Gs4zqxzzTn/DjS1FX8AS283n1b3c
        zjrCJWwKWYE21h+ovUITZsL77vzPQgGcup2we/U=
X-Google-Smtp-Source: AGHT+IEuozW4ir8NvRiuQ179myWI51BRBYGRTs3w6oQXxFP1zMikMT+Ott83M7mOGTK81J/KFVsDY+A7XnmAfYyQSCI=
X-Received: by 2002:a05:6214:5b05:b0:656:32a0:febd with SMTP id
 ma5-20020a0562145b0500b0065632a0febdmr3513433qvb.35.1695522425360; Sat, 23
 Sep 2023 19:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com> <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Sun, 24 Sep 2023 10:26:53 +0800
Message-ID: <CAFWsj_VxkF7rrK3cxWkcs8Xg+qqGEe0N_2AENNbvX7dG1_rgUA@mail.gmail.com>
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your advice! I've uploaded a new patch to support more
strategy options and the parse option issue.
