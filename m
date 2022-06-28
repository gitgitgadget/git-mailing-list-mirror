Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE0FC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiF1Qyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiF1QyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 12:54:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7782A73C
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:52:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h18-20020a170902f55200b0016a4a78bd71so7212889plf.9
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=rIO6MAMtdu+8BL2YrObPZzh6cdDwjB+DleGh1uo4zQI=;
        b=WPyP/+agVm+IvCLWFzJ30+kZFU4MPUoXI6bHwyyQTm5OAH2vhQ/5bATV5wl0muF9Cj
         Mi+S0MlkgKp3bnSKvuEwyUUBnnLJ03ctkBWwQzU3dQRxLOiVo6Vr0rMOOS6d3jgdOuIE
         cSJr4QV6YlacQ1StMBP1llkDRoKxoHfAjsA8H6vRg2XQnlueS5DqSqAaWcWSOgbi7HqM
         /o8+Uca0U5n7l3yiB0fRHQbwEL5qdyZa6uB3hAWRwQ1iPSCH6sfFdf+tzFUbxxnovA/o
         dNLTThlyrVXw1mfbapW9sOH1MSrua9o6KYff1nLaZJ1CEovw8mKl4OghtNvXMbsn2PYM
         2lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=rIO6MAMtdu+8BL2YrObPZzh6cdDwjB+DleGh1uo4zQI=;
        b=rpfF4gB4Wso056KvJEy367jG0MOPQshzxL6CCmGFijWYLWtmKxseBB2q8PVqFoM4up
         SRativ7C+4TAw05pGMcP5M4awFuWwvdoMbIRd5kjXI2Qmpy2VtQ/O/y0KMaw6pvaXVOM
         SgxAIKN2QYCKiuZDXWleZfyAXLDSMq6hw9t5aM1jrcRijAEE/++YvvvWWCKIa3K8EKKX
         GCCZ54Sz3N2MNqcL3XqGmxwPMgS36Pz6Un3+t9a8TXJHTj1owggRRNMG6bYIWrWA6V2R
         JumBr1gH/OadouCsqc7G2Yo6odEUPMoI+6W290TVDvhQmMLtL3cTAws58LJQ8YDlkh4u
         YRsg==
X-Gm-Message-State: AJIora9iJIFYwZujsDzhHa9aoOLrIcCiAbcnv4S2zJwBOHdnDDDh6r3A
        VNKbi6dVd3Wy81bRvl77uxEIrKq8Q/OJQA==
X-Google-Smtp-Source: AGRyM1vdVO8Icxo8+CdG9LctVqqBMBxcT3Sz0Lh23NxBx/79KDUxB/wOw5b1VLgBV+MtRdU1YEhRxtQIvKS4bg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:a882:b0:1ec:918a:150d with SMTP
 id h2-20020a17090aa88200b001ec918a150dmr573884pjq.137.1656435140970; Tue, 28
 Jun 2022 09:52:20 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:52:19 -0700
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
Message-Id: <kl6l1qv8ivcs.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
Subject: Re: [PATCH v4 00/12] submodule: make "git submodule--helper" behave
 like "git submodule"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Changes since v3:
>
>  * Leave the --super-prefix changes aside for now. As discussed in the
>    v3 follow-up, now we're only removing the unused $prefix variable.
>
>    Since the v2 was submitted Glen's submitted a series of his own. I
>    think any non-trivial updates to --super-prefix are better done
>    there, as noted in:
>    https://lore.kernel.org/git/220628.86wnd1f9t1.gmgdl@evledraar.gmail.co=
m/
>
>    The overall diffstat is much smaller as a result, and I think this
>    series should be ready for "next" now, as the remaining changes are
>    well-revieweda at this point, with no outstanding issues.

Agreed. Since we no longer touch "--super-prefix", I think there aren't
any remaining concerns.

In v3, I was slightly concerned that we didn't fully understand the
rationale behind "--super-prefix" before changing it, but I still gave
that version my Reviewed-by because I'm convinced that the
"--super-prefix" check isn't doing anything useful (and can be
annoyingly overzealous).
