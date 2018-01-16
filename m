Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FBC1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 22:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeAPW2k (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 17:28:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51423 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeAPW2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 17:28:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7578DCFFE0;
        Tue, 16 Jan 2018 17:28:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iLZavA/2pj7GHmJygP92Z7ynGYY=; b=DkoaDo
        /mNLHjY7n/MeUuSuDtPItwK9TcleyKG3QsKNgzhQqfWf72MGWgm6/9AP12vgabfp
        zPOuNt7xTjk/2gZ26LP9ruZCDgIrcpKz7FkSm9wuJRh5fjoHMdLDRM1egF9QeS6m
        ctFGyxbT9nulIBmZr0M0QkF6eR2zRTFt9wlQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gEKxzzsMfKOYsSI9IDxJbMx3JGRz891q
        MglweksnVCMmDrHSK2tIdx5ApqDXdrichmlhY9ymDMXgII+NoTm2u2n2v++qhgy1
        G1U4CpilDzmyNeJKya4rhsPTCtmjyhBRzUJYgKIkAiMHFNy/YQbyrRFTTtoyw4WK
        VjMXJ0SOEsU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C171CFFDF;
        Tue, 16 Jan 2018 17:28:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4D3ECFFDD;
        Tue, 16 Jan 2018 17:28:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH] Removed unnecessary void* from hashmap.h that caused compile warnings
References: <20180114180748.14584-1-randall.s.becker@rogers.com>
        <20180115204301.GL2641@hank>
        <007801d38e42$6b6df3b0$4249db10$@nexbridge.com>
Date:   Tue, 16 Jan 2018 14:28:35 -0800
In-Reply-To: <007801d38e42$6b6df3b0$4249db10$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 15 Jan 2018 15:49:58 -0500")
Message-ID: <xmqqinc1tp4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9956E0A2-FB0C-11E7-BCE2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I like it. Do you need this resubmitted? Or should I just learn for next
> time?

I'll queue the attached for today's iteration.  Thanks, both.

-- >8 --
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Sun, 14 Jan 2018 13:07:48 -0500
Subject: [PATCH] hashmap.h: remove unused variable

In 'hashmap_enable_item_counting()', item is assigned but never
used.  This causes a warning on HP NonStop.  As the variable is
never used, fix this by just removing it.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 hashmap.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index 7cb29a6aed..c41ce392b7 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -402,7 +402,6 @@ static inline void hashmap_disable_item_counting(struct hashmap *map)
  */
 static inline void hashmap_enable_item_counting(struct hashmap *map)
 {
-	void *item;
 	unsigned int n = 0;
 	struct hashmap_iter iter;
 
@@ -410,7 +409,7 @@ static inline void hashmap_enable_item_counting(struct hashmap *map)
 		return;
 
 	hashmap_iter_init(map, &iter);
-	while ((item = hashmap_iter_next(&iter)))
+	while (hashmap_iter_next(&iter))
 		n++;
 
 	map->do_count_items = 1;
-- 
2.16.0-rc2-196-ge713b39cb6

