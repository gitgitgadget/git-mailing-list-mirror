Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC154C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiK1OaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiK1O3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:29:51 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795F22539
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:29:45 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so7013297otl.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weXP5cssvPfdFARI4zIlI2o8Xj+DtLdmI3dBLbrE604=;
        b=M5jiDLdRQ9WJr8C60gJQWJBbIvxPigrjtGmlMzMtjYSXitGaHA9WXlxSaPK4inphic
         6SjlQUZpYhyljxDyoyl7p4jTIykzbmKqeD/vkUCXy7G4Vrb+vIUBE6V0y7MuUBSpo5th
         9+H4CsokUrnb/SxO1hj3grAlvv9y/Mrq1AgDAOcNP/s7bFbq1fjz4lZeR8eAiwa6FrpY
         NbOTpwUQ6DPftVQYpyW8BAFQUa/ZWswdWAXlOfAyjSDCLPr7G3m0gq1ZYac/kykYynUS
         kLEmcyVq9U1utjP8KSPd/8C/LUSuUDOrm/3lwKL/gSPyATOF89w0obi+S4qaVFEtyEd/
         pk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weXP5cssvPfdFARI4zIlI2o8Xj+DtLdmI3dBLbrE604=;
        b=bwkbwKxw9CbVa/07/NZ1RFO1DRrXcALoeQyxCYhnNZ9x12NlYlLLXDVzJrk7CS0yK/
         wabIdH1WdAlBPqGapLdSM8opWQxIt8eazt6SqjhRO4WNTuiMTpAb6JgNM/VKM/dQTO/e
         0CtjwoUh/4RAssgCnEW3hZjBRFxLtB24x9sY1tmLIVX0+Zf10+j89KEEenzKyDAoIsYf
         PRMSRDnE8RPqsAewSpzyvR8FZ9yjFCeubaQT9jeTzEUd7xVLLwkBnxauv5uuKWvUY3K7
         arVHQEyDjIf7TavxyvXe/v/Tx9kXeqL9hnkBBzAdsEfBqqKlGHvMBQf7S3bdsfJc/ImB
         AEuw==
X-Gm-Message-State: ANoB5pmGzgm9bz4sBZC89m6wtWKRjonoK2p25TZcCO/pSqDTpigRYSAR
        pGUNqSCqRmMjCXEtOL8JvN9Rp63l+zTdM/JD+F8=
X-Google-Smtp-Source: AA0mqf6wCZ73G+eA+J2TpglY2xs8lHu4S5c/LqrWpo937yp2dCn0mD47D8YFRsJ3tfhKF0eyQwB3d+hh8bVyqQLurFA=
X-Received: by 2002:a05:6830:134f:b0:66c:68e7:d673 with SMTP id
 r15-20020a056830134f00b0066c68e7d673mr16196836otq.31.1669645784535; Mon, 28
 Nov 2022 06:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221128130323.8914-4-worldhello.net@gmail.com> <221128.86ilizkybr.gmgdl@evledraar.gmail.com>
In-Reply-To: <221128.86ilizkybr.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 22:29:32 +0800
Message-ID: <CANYiYbG2LNALFzOj+VvZZWQAhFjYY8y3ymLh9KTptFL2OXs7gQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t1301: do not change $CWD in "shared=all" test case
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 9:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I think this approach goes against the effort to implicitly stop relying
> on templates. See 3d3874d537a (Merge branch 'ab/test-without-templates',
> 2022-07-18) for commits related to that.

As I said in the cover letter, it was the conflict of ".git/info" with
our internal reference transactions that drew my attention to this
test case. This is because our builtin reference-transaction hook
which will automatically create a ".git/info" directory to create some
files inside, such as ".git/info/checksum", I have to change "mkdir
.git/info" to "mkdir -p .git/info" one by one. And I found in this
test case, there is a wrong template dir.

> I think better thing to do here is to squash this in:
>
>         diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
>         index 0b3722aa149..b7222b7bc07 100755
>         --- a/t/t1301-shared-repo.sh
>         +++ b/t/t1301-shared-repo.sh
>         @@ -8,6 +8,7 @@ test_description=3D'Test shared repository initia=
lization'
>          GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>          export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>         +TEST_CREATE_REPO_NO_TEMPLATE=3D1
>          . ./test-lib.sh

Will use this implementation instead.

Thanks.

--
Jiang Xin
