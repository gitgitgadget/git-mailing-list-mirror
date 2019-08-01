Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CC91F731
	for <e@80x24.org>; Thu,  1 Aug 2019 01:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfHABgp (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 21:36:45 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:54657 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbfHABgo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jul 2019 21:36:44 -0400
Received: from mxback1q.mail.yandex.net (mxback1q.mail.yandex.net [IPv6:2a02:6b8:c0e:39:0:640:25b3:aea5])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 794733500287;
        Thu,  1 Aug 2019 04:36:41 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id I48rPNQJTE-aeQSEods;
        Thu, 01 Aug 2019 04:36:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564623400;
        bh=UJPSk2claKyf8wiztmOkibdTmxByGDu694dadPhBl+o=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=BihACeP8EONlCqVBtWVR6tpH6TCXeOkZxdWRNBHQrRWOvOJWjYcMB9r/zBPDB/RRn
         GMxgn3Bzf/p+rmeigbxUe/UrL3MzxpSf69b7uFMhY2IlJiOXUVDJq6uTSlqnLSpkqO
         RV5T1Cff9Xvbb0f5Y4feD0ySCaPeiBURH6tN90VI=
Authentication-Results: mxback1q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-83cc2ae1c2ed.qloud-c.yandex.net with HTTP;
        Thu, 01 Aug 2019 04:36:40 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Philip McGraw via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, luke <luke@diamand.org>
In-Reply-To: <pull.301.git.gitgitgadget@gmail.com>
References: <pull.301.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/1] git-p4: close temporary file before removing
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 31 Jul 2019 21:36:40 -0400
Message-Id: <2689051564623400@vla1-83cc2ae1c2ed.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



31.07.2019, 20:36, "Philip McGraw via GitGitGadget" <gitgitgadget@gmail.com>:
> python os.remove() throws exceptions on Windows platform when attempting to
> remove file while still open.
>
> Add local allocateTempFileName() to clarify that only the name is being
> allocated by NamedTemporaryFile(); file and handle are closed (but not
> deleted) when leave scope. Subsequent file deletion will succeed since file
> was closed.

I would also mention that this avoids double-open issue on Windows.

>
> Also print error details after resulting IOError to make debugging cause of
> exception less mysterious when it has nothing to do with "git version recent
> enough."
>
> Philip.McGraw (1):
>   git-p4: close temporary file before removing
>
>  git-p4.py | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-301%2Fphilip-mcgraw%2Fgit-p4-close-temporary-file-before-remove-v2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-301/philip-mcgraw/git-p4-close-temporary-file-before-remove-v2-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/301
> --
> gitgitgadget

Please, feel free to add
Reviewed-by: Andrey Mazo <ahippo@yandex.com>

Thank you,
Andrey.

