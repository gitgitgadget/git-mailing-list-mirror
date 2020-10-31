Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F8C388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 22:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4142072C
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 22:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UejYCWU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJaWWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 18:22:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57342 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgJaWWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 18:22:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DEA39364C;
        Sat, 31 Oct 2020 18:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PTifOuLh9fReCz9QSqbIK1dme9I=; b=UejYCW
        U9FAOvV1u0aLUHvdl9jNqs+gvDE1a/5JA02Rn9NfX3EzC+zjJbSIaDMO367eRghT
        arVJzqMJtQ4SIb4jal3aJ3kvW6dOEoZ5Go4/aKVOXRg5vJqPyimx5X44Zr7iLSco
        x/ZAEqJ6VCcmb2L4ZqsBoeTS4oc5fXlB0daJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hvBelJk1rM1vt3YIWgc/NeiyD/UziEcd
        wEKHhnLs1Bl97EtYh0IyPLNEUYKYsCFfmrbib5QalF7B4T3kOjtM2ypF0QZyr1uO
        juYQp3ztByt/FX0YMtVYZfEzVXt/ZB3wG5TfB7PLJiaP5c9bea7pGCqXEuBCnVyQ
        I82+wjfw+sQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF1B9364A;
        Sat, 31 Oct 2020 18:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF43F93641;
        Sat, 31 Oct 2020 18:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
Date:   Sat, 31 Oct 2020 15:22:08 -0700
In-Reply-To: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 31 Oct 2020 21:04:58 +0000")
Message-ID: <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 845279E4-1BC7-11EB-9CAA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With -Wsparse-error, "make sparse" would fail, instead of just
giving a warning message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git c/config.mak.dev w/config.mak.dev
index 3126a5364d..022fb58218 100644
--- c/config.mak.dev
+++ w/config.mak.dev
@@ -1,5 +1,6 @@
 ifeq ($(filter no-error,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -Werror
+SPARSE_FLAGS += -Wsparse-error
 endif
 ifneq ($(filter pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
