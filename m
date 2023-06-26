Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A6EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 15:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFZPZr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 26 Jun 2023 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjFZPZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 11:25:46 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8317818D
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:25:44 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 35QFO00s2934142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 15:24:00 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Iv=C3=A1n_Exp=C3=B3sito'?=" <byjokese@gmail.com>,
        <git@vger.kernel.org>
References: <CAPDGPD5UK8+Z0ksX-tv2Rs8ESZ+LCY-Tic-dZSGV0QNStFN=Pg@mail.gmail.com>
In-Reply-To: <CAPDGPD5UK8+Z0ksX-tv2Rs8ESZ+LCY-Tic-dZSGV0QNStFN=Pg@mail.gmail.com>
Subject: RE: Git question rewarding git merge and its exit codes
Date:   Mon, 26 Jun 2023 11:25:35 -0400
Organization: Nexbridge Inc.
Message-ID: <004c01d9a842$77e75ee0$67b61ca0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEPpH4jKfo4vXfkLPV3KLtdC6X5WrExO1SA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, June 26, 2023 8:15 AM, Iván Expósito wrote:
>Recently, we have been working on some automations for Git, especially auto-
>merging some branches. Just noticed that when using: git merge --commit --no-ff -m
>"test message", and no changes are needed, git returns  "Already up-to-date" with
>exit code 0. Is this correct? Git hasn't done anything, so not sure how correct is to
>return 0 for success when nothing has been done. We have here a problem because
>the only way we can detect if a commit has been made or not is to check the return
>text, which is not the best idea for future-proof, or changes in the return text.
>
>Is this exit code as defined, or maybe is something we would need to look into for
>future improvements? Is there any other alternatives to detect what has happened,
>not comparing the standard output text?

If you want to script this, use --no-commit instead of --commit. After the merge runs, use git status --porcelain to determine whether merge performed any actions involving staging to unstaged (conflicts) files. This removes the need to use the completion code.

--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



