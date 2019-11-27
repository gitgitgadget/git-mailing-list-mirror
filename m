Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A96C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16272084D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nottheoilrig.com header.i=@nottheoilrig.com header.b="wsEOBEOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfK0UTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:19:06 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:54904 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfK0UTG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 15:19:06 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id 26FAB203D8
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1574885946;
        bh=L8dGO0V1m+myWPll3Ok/hG8nIqK3/vbwuOEUluOX6CI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wsEOBEOxXRLqkjXZid0HyJ6lrkEHh/uDz74bDOM/7ZLGFpK9kArnjG7OqXzKsGFmD
         lgHvyRgBpttBRQszrWLJK5mWJ8TAgEaqtpxgKEI8TIqrSYgbIy9bb9AmWvxaCiNL9e
         zjGt5SoRTnrhmxKIsvWfxioJ+TRHFeZUHm38N+kA=
Received: from [192.168.1.101] (198-48-158-226.cpe.pppoe.ca [198.48.158.226])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Wed, 27 Nov 2019 20:19:05 +0000 (UTC)
Subject: Re: Bug? clone ignores --git-dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <7d28416e-c927-4cd3-bac2-d8bfd02ce949@nottheoilrig.com>
 <xmqqh82pv6qi.fsf@gitster-ct.c.googlers.com>
From:   Jack Bates <bk874k@nottheoilrig.com>
Message-ID: <91fa0f24-fd11-a0ff-c258-c0f480910ade@nottheoilrig.com>
Date:   Wed, 27 Nov 2019 13:19:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqh82pv6qi.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-27 5:33 a.m., Junio C Hamano wrote:
> An intentional design decision (and it may be an unfortunate one by
> now [*1*]) was to have the GIT_DIR (hence --git-dir) talk about the
> *source side* of the clone, not the destination, e.g.

Ah ha, the following does what I want, regardless of 
`GIT_DIR`/`GIT_WORK_TREE`:

> git init repository
> GIT_DIR=bogus GIT_WORK_TREE=bogus git --work-tree directory clone repository directory/.git

Thank you!
