Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F8C43461
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 05:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974C520BED
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 05:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="KpWSkkHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgH2FBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 01:01:45 -0400
Received: from out0.migadu.com ([94.23.1.103]:53014 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgH2FBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 01:01:45 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1598677303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=9kN2OLmtPc8gTRYfZGJZejOlgqIU1xoXmbjNpJgcFjw=;
        b=KpWSkkHBOoNZVEd2/Z3cWsyyUN5ZKHPn2wln6C+u+Skj2SgU/A3UVOJ6aVN2Oc+dbwYTF0
        p0CA889+tCTAM8cg1L/SdST6w5JTaXhCOFqmtkB7q8dt5D3P6fE8rzdf1+iBavalwHSooi
        fgZ+glgIEmQ7uDYqDj8/IVzCdTO+GtI=
Content-Type: text/plain; charset=UTF-8
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Ivan Baldo" <ibaldo@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Fastest way to set files date and time to latest commit time of
 each one
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
Date:   Sat, 29 Aug 2020 00:59:58 -0400
Message-Id: <C597RQ1V1DCG.3EEXY0665KK35@ziyou.local>
In-Reply-To: <xmqq8sdym93d.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Aug 28, 2020 at 11:20 PM EDT, Junio C Hamano wrote:
> - The source of the rsync transfer is a git working tree. It often
> has the checkout of the latest and greatest version, but during
> development, it may switch to older commit (e.g. to find where
> regression occurred) or not-yet-ready commit (e.g. work in
> progress that is not given to upstream). You check out the
> version you want to sync to the destination before initiating
> rsync.

Assuming this is the case, perhaps a separate worktree that you touch
less often being the source for rsync might save rsync some
bandwidth/cpu checking things.
