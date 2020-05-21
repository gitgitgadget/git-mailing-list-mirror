Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5377FC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3FD207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dLs9jD/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEUJwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 05:52:49 -0400
Received: from mout.web.de ([212.227.15.4]:44825 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgEUJws (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 05:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590054764;
        bh=D/WSjFvuStkunqOxV8wyk6eOFUHFA7QdEhp8KbrFOlM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dLs9jD/jaxTNLYimFCXCYyAkfL429twpmLCrecAeeZ8QXHp+Bn3PUzP+NIa6vA/nX
         hYkrdSc1fUAmZcfdMnbQ4CC7KLVvohODQf3I21+ZD4kXtyhxmettLqr2scS9TYFwSo
         DjqmETSyeu7+d2rbq/LufiaPa6x5Xk7nlxR+pFvk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQyl-1jZCcK3r7D-00XsbZ; Thu, 21
 May 2020 11:52:43 +0200
Subject: [PATCH 3/4] t1450: demonstrate undetected in-tree d/f conflict
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f5ec1823-438d-58ee-a63a-f3f0d0836e82@web.de>
Date:   Thu, 21 May 2020 11:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uW8t7Vfojp/pbuHOKjHfmP0uCly2I/+HQfQmqvRJwAoT3hYfViv
 6fqQynWT0V5CACsI0qRJlse0qHU8bXDCL9ikCJd1opv3jvEX1YwzwdaC1+7jDjGb7ium9Ad
 hMmOvH/1dv4rSfm0Adzg0cTywcFY52cLpZw6eN91jNZ4ZrWbKt89h062j/vUodunWomyaeI
 xM1RNvhgKkZNaExwEjttg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WHJiSOYyluM=:Np+LOP0EyRaESgu0d3Hj35
 68o9uOnWYvBYC7/nCCmC3lPIx0YOBP49VeGO3tIN/kCse3KafMmYHKGVAMxQkDt2A7x8dsLKf
 0vfBAOw57xN7hjTF2Sgg8uGzo/Qyovd1vlB5RmsICMZXlemsioPNfmY7QWX4GmSzbN30PPT7u
 tkhIpYtbaNV/8u42O8RrP6hv9jamb0/1RQS7B5+wq/nrWTmmAKgmUfDHK8Uk+/MVK1F98wbqK
 4/t2zXtCHeC5Rfq6OUuN8JlVIky1YffUfhzTCp0HOsTj/t2H+dUaGRmnx2S70gY8W5SxhwPkL
 2YiZ0/o6HzJcHIGUqKjqykRxNlp1CYXvbPOpIKgZSb+7CUuOWauWnLWR6ZkKDzR7kmCTzA5Hc
 WlN/KuLuCk2vIRwzgjk9GwqJX1jVJJyG+Us04GtklwV010+JESVxvH/E5vvT8zc42qJ2aMdVK
 fCJxeFsgzkDhr/A/DQX17ki4YzF2W0Q3zmbBIO+U9YZ5bA6QSulq2ebAxoRWAiX4i2tXYxxYk
 llNp0wqF0/Hy95iPlONqymowD3psJhUKYX/4Skkq2Hf9BDd5WR9sUYuZiSAwz+3UiXtAylpbU
 Ee1nOtqlFROlJMFle4fpb6qoerAzhIkHvNQO1P6eQx5e8lxihLORMtP7ZipngYSaIN+WWOMf0
 cSWlp8yrBids2MqwWj3dEKwouvUelnHJ6wpIm5Xm+RrPKqmoh5mPg5w27DYnNszvvwlSM/jE4
 4RD+JDhilDCgWOqop39TUcZcTLvSznIJPxU78xXS8BonkVohaZBPniOCO0DVFJQiEqlZ8QydM
 9nL5q0ppUddCNxxTFxZ4xLdQQL4vwyHfYd5ddcv7VopMKPfkRQHz6svrnCgeCdpsdWfQ8JXYg
 SO1plidpkc+KSqIw5Npv94JMlweeQQa2R/QUqwXONi+tT00LJEy3IReNOZbgmZDPha5TNisV9
 sXp+kupMKJeePQJXe/+JnCI9vMyItP86xQpqik40ZgXNdAZuWvbb3rBadWHpNldFC7r4CLhlA
 GdN9JSNioQdGR0G8p8afr1cGsdrq1zz0ny3MX5T+Jtr5ZWsvuDZQVsCzjYnTac+inu7lmPEQM
 KW1zoUdEgdQ0GaMk7KKVXUDw3qFvzhzwYibb91fxfqtPEXr+/5dgCbnrlxcQsgdwnGiHzt1wD
 hMdaH5J9vLNcpipBFzo+WgwteBeoRGTCLWzIbVNl/nvsZMG+GXOj0MWgepKNCEk1P+kuqrhTE
 eSnHeh3qWaxhzEBbV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1450-fsck.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 9640ac8ff2..5780e10cbc 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -284,6 +284,7 @@ check_duplicate_names () {

 check_duplicate_names success x x.1 x/
 check_duplicate_names success x x.1.2 x.1/ x/
+check_duplicate_names failure x x.1 x.1.2 x/

 test_expect_success 'unparseable tree object' '
 	test_oid_cache <<-\EOF &&
=2D-
2.26.2
