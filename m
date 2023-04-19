Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D6C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 02:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjDSCws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 22:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDSCwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 22:52:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1FA6A49
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 19:52:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso2559442e87.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681872763; x=1684464763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhtZ3hxikLCtzvzblTB1389A67MArTLDr/JTOjFV+j0=;
        b=p6mjTLP3FcvPV1gvOItIciiYAkoxRwcLKD1ycQD/GahWWPrmv3NzUqlSfP86MMqdOj
         TvL3FbYq2j2OovwU1QZa9eNUb7DxwlH6fOI80pG7wk50475g4Fg2+zEd40wnHnuyDM/G
         BYIjaGVOG6cmY04LO1xlD+fE7Mc/K0xbEgel5OuZ0viCIl5ZBv+lqyD/xzZatx5E/d21
         L34JbyQ2rUC85HJw/8+Xq4EC6eE5/2ep+BUpMBr9B97A4CZ1y5ucr/NiNwbnALpFYuvk
         SH+qKBYCpRaTps3FH7CvvgQhs0M1o6M6O1K1kL3E448ZwpKTbLp0hhjJ2QcqUlF5zYXD
         QqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681872763; x=1684464763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhtZ3hxikLCtzvzblTB1389A67MArTLDr/JTOjFV+j0=;
        b=ArEkGYjLCi+V7VD9JZF49rCFdmtO7Uqmrz0ldbI33c6H2/SrnPOaD5XUTV6WKnrhtN
         AbL0SzIPGRqe5KHd/M45jB1IJAyCRcoWaacONeItcvjltIZWULvRgqJ20TNb87nu3+iz
         ExnYohl1U5zgww+d6LX/TlCoGOxYAzCyAuU2Dr/q67D/sb6bCv9HvRPf5trOAEfuTCfp
         5/JlM7GCUqFCBFtjqHGNhnW5CU+95WnIHX7ldQucee0FTBsMEZn+Xh9qNgoaVHrkbK90
         c1iXXb1bwCpZBReA+0X3VruSBeHc2YlbwMSajxLxx/+xqJjnmJkSHkVH/H4+w9USrMwC
         +czA==
X-Gm-Message-State: AAQBX9cOOnyIYeuC5u/CKY8oxliwkD9NdTkjvNW8Y7pjmsbqE5KPCVRu
        2N7//lqNkbfe8FQT315+6fA9MOikbodhRySInm8hIv5x
X-Google-Smtp-Source: AKy350ZQXqGOdNLxVxELU6G0mC9cN3D2n6A62NM+aKvWPrkW1u+thayQtLCa9XYp3XHFM/0aiJLZjA9ty7Wwh9Pb2LM=
X-Received: by 2002:a19:7001:0:b0:4ec:4f58:f24d with SMTP id
 h1-20020a197001000000b004ec4f58f24dmr3991624lfc.7.1681872763407; Tue, 18 Apr
 2023 19:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqfs8xfw25.fsf@gitster.g>
In-Reply-To: <xmqqfs8xfw25.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Apr 2023 19:51:00 -0700
Message-ID: <CABPp-BGF53Sfs_wg4iPJ-gmEkBRddQS+Uaw=wF74eK_j+kykDw@mail.gmail.com>
Subject: en/header-split-cache-h (Was Re: What's cooking in git.git (Apr 2023,
 #05; Mon, 17))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 1:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> * en/header-split-cache-h (2023-04-11) 24 commits
>   (merged to 'next' on 2023-04-13 at b9afefff0b)
>  + mailmap, quote: move declarations of global vars to correct unit
>  + treewide: reduce includes of cache.h in other headers
>  + treewide: remove double forward declaration of read_in_full
>  + cache.h: remove unnecessary includes
>  + treewide: remove cache.h inclusion due to pager.h changes
>  + pager.h: move declarations for pager.c functions from cache.h
>  + treewide: remove cache.h inclusion due to editor.h changes
>  + editor: move editor-related functions and declarations into common fil=
e
>  + treewide: remove cache.h inclusion due to object.h changes
>  + object.h: move some inline functions and defines from cache.h
>  + treewide: remove cache.h inclusion due to object-file.h changes
>  + object-file.h: move declarations for object-file.c functions from cach=
e.h
>  + treewide: remove cache.h inclusion due to git-zlib changes
>  + git-zlib: move declarations for git-zlib functions from cache.h
>  + treewide: remove cache.h inclusion due to object-name.h changes
>  + object-name.h: move declarations for object-name.c functions from cach=
e.h
>  + treewide: remove unnecessary cache.h inclusion
>  + treewide: be explicit about dependence on mem-pool.h
>  + treewide: be explicit about dependence on oid-array.h
>  + treewide: be explicit about dependence on pack-revindex.h
>  + treewide: be explicit about dependence on convert.h
>  + treewide: be explicit about dependence on advice.h
>  + treewide: be explicit about dependence on trace.h & trace2.h
>  + Merge branch 'ab/remove-implicit-use-of-the-repository' into en/header=
-split-cache-h
>
>  Header clean-up.
>
>  Will merge to 'master'.
>  source: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>

To avoid breaking connections via the git protocol on master, before
merging we should first either apply my fix[1] or Peff's fix[2].  (Or
both.)

[1] https://lore.kernel.org/git/20230416054735.3386065-1-newren@gmail.com/
[2] https://lore.kernel.org/git/20230418033904.GA60552@coredump.intra.peff.=
net/
