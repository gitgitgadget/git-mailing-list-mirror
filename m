Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A8AC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA27420663
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hHVx0gUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLKSqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:46:38 -0500
Received: from mout.web.de ([212.227.17.11]:57275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLKSqh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 13:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576089992;
        bh=vlydlbYyC7/kMyKP+v5c+cwaEdgvDH53KdnRxpNG7hY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=hHVx0gUeCFx+dDsN3MywxdKHzlB74/KA5Of3rELBi/b+zKfzHXm0ELScLD8UnN1VO
         atEUnnsmbQJ81uduLGLXBBZMedar/9WMzNHyn+FXKYEpL/NKG+cd7QV7Va/lgRaGad
         QfgB0FcxN4sWRZgSE3supSIfG2ynd9dqiWF4K/ps=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzXS-1iSPhi0Z6o-00DpzW; Wed, 11
 Dec 2019 19:46:32 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t7004: don't create unused file
Message-ID: <98eca6e4-f3d5-8bb2-efde-0160b3d5e507@web.de>
Date:   Wed, 11 Dec 2019 19:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9NdINWME1nZpxoZC/u5sWtJnBb/iZx8knMlIK+Jb54kFY8qFyre
 I4lyb3aTjKUyP7C/osw5MpiMuB5HrJ+AWxr6a8fFZxEjLAeBN+Cvug/YkC4QyXRDqa6SKOB
 t+rpCSM6wyMkJqG+sni2BXD2eoCLhx6anh1+yZZXH2/IeDJ6PDEJWid3mtKExVFtz1a0is+
 AtM0dGYmX8rI3wxHkYPaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:urCqyY58FxE=:IRiQ4VvE+s44FL/xza8Uwx
 JuIhsEr+Nnm4oTYG96/iMva/QP7Rf5UIoFxPjLMPXSaeW4X0aMlocE18UJlMzqasgzjB7Nd7w
 AW7KGesvLmDM9XfhO/Z+Gtpi5oTyhSyHmdc2PrUrqIngorIFlZkDQBLBYV18CJQKFKkYarAj3
 6hUKns3vKc6xOKhUtv8Bl/+UZko1MKocNkbUDYEX3FW9hH+TUe0g1RwEn27ss18bV/q6Q1AzF
 Biqk2pSPwBgRxLXkST3grYLIHLATYI21+H2mWRTFHwAUgZ5YroT86Inz3OxZT+SNVIDqRKmnG
 8oZII1RY6zqCTSeQNx0S2B8BrQq0jqsvew2lXOVMySH+AHxoxHzA/hc0uFnr9kgGPIj7anuIh
 4+ZQEiNcgUIuswHiznJExH4gwXl9cg8pVmC9TmHaMYf3/LLZEtzOuPbuGGYMQPZo7690NCTe+
 pV281JB/CXINfOvBwRQ0TaHbfGCf63ga1/tpt+NBxKC7RcszAQfnu4lF6Iqfu6y6lx0zp8yGG
 omRhUqAA6Hr6F9eMjfWZVbl7sPVNUCFECQ90lcYilCX4uIS2PUqyWKwy9E7UcttZZjPuSh2bv
 Hvpq5sMn3nbAOByjnAhHnWX+1GuE31niMYqr4nLbP2saqSnz81w8mqTArQtO+HrrJzFmQVfuy
 iB1CIbY1Cu74jAxhlCk7KR1rELZGS/A42Rln391ykUzTstC/U2Ry8LxM1VFqWlySdkvJBxQw9
 Xvr4+c75t/qu2Lm0g/L2uEk5hsXuuOS64FMNOzKDZs2woiMMT7Min1hRnnJIY5HUKx63cQ/ZN
 /xTtEpSQAEtq7WiSBhBrohBvk5ee11qA0Unh7MCRWwmWbCHCjs6qTsWC6vZs/pHeiNi6Of56f
 oHIYwcbuy5O0fvfCExbBdd7//SNgAb9OwohiDeNSl/YuHs2qZPIy8Toyqm8KsVK6hv7d/iTGT
 HZo1RknS+z7xDpvSL8oryBmQRGkHpo+RpmcxtUsOj7G5M0Kd09muNQE34Lx7+9lT+Ao0miINZ
 nnqdJq1PlZkBwilfByfe3X0g+g6aY+Uf22BMsQoSqlm27HZSWiNlz2IFG8rLv1yjBIIUetOPk
 ZlbWUNJdzFC+WgNL5Z2aIR0XQHlZWgwcvmt55Q/bXsiVWpDlLBqTeYlJe09iDGvvEgI6AqiJ1
 Z0jDkYhdarHDVol2Gl9Z+ygfGZVtRJUFQ7BGWHkpibdLChwSVPd4794sUB4gPB/ajgJQ6PVm7
 z3/2dYxdnmq3xMyvgT7GAJUgZX8A0TVd7sSDc/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

msgfile2 became unused with 3968658599 (Make builtin-tag.c use
parse_options., 2007-11-09), get rid of it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t7004-tag.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 4a09bea1d6..6db92bd3ba 100755
=2D-- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -517,7 +517,6 @@ test_expect_success \
 test_expect_success \
 	'trying to create tags giving both -m or -F options should fail' '
 	echo "message file 1" >msgfile1 &&
-	echo "message file 2" >msgfile2 &&
 	! tag_exists msgtag &&
 	test_must_fail git tag -m "message 1" -F msgfile1 msgtag &&
 	! tag_exists msgtag &&
=2D-
2.24.1
