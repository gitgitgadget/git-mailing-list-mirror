Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199D3CEB99
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833362; cv=none; b=rp6JfPFQdWQ73QYCO5sqgBPx3pJJEIWUkRFdH/j4dSUnMN/QK76wsRdl1wLKkozZhPg9DiRoqVSYnxApAzz58GfqsoWmPx45FBQhECb0luIotB/48En4A6ZEin7cykC/cSrwRNrMWmiRC7XdiePHcn6U2MN6ywWMCCSkXaZHEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833362; c=relaxed/simple;
	bh=mM9CfmoTFeMVBum3cXetYtfPu6HA6HQwGqVMlWZaIyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpJoHWba13OXRe72GH42lf5COFjMbBYG1hfkhxacj0JYa8Sj58wCtmdzi84LwlBtD0ra8QTsF4Q6fdNCMt75wUFLOMzbvRwkaah+QEtjiCKuKcA2acEYGJBEatpMdPkoPuv5AELypY4ef5JhUKVsuV9E7uqoQHBj8OCOwos/Udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UneudVMu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UneudVMu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49395888c7bso41480185e9.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833357; x=1783438157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aACL7BSbEb9namQivHiPGIPwBcqSR61+bMhGbPVzFew=;
        b=UneudVMuaCcZHvBurEX1C/V2RinkxiR92UCPOjoBDT1GQ7HVBkshXxbb6DNce7iKUl
         3Lt1IaaM6NHogGQZzBcdN0GT1fDM0Yu5LQTIVpfKsjdbmmYa+5ylbNXiSZq0vVu4utyZ
         bRZzZqEhVBLeHyP/kBwRapVpbUwBzed/k05wMqQR4CBNQW6t9HBNq5mS6H0Nl0cb5zcK
         FQBQLWAD/cdrJsu2iSPh9ZQwutDMGNMLLXE3QG5SdwjGvoZpI0lJsiGtcChSuSGr5+PH
         vnJ1h/SQBFdgvJDUW3drMiAeYvtiCdjVNwcrO575u2GxsWkQdFJNCTo4X+G6g5h5LcvH
         TE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833357; x=1783438157;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aACL7BSbEb9namQivHiPGIPwBcqSR61+bMhGbPVzFew=;
        b=qIaniDxWLyFqBs6RHCprKfpMLvNu3G1EtI6zBaQxZo0ZLFgnZ93qQBVRrwhCFQN1tc
         ZXUJX0vTcLGWTYNBRMZoRlkTCgIJ6jL25vR1AkqNv6cBObb9tmEdpXxfFrqK/VxlKKR/
         wdNla7sLG7O7fK5HiZmjSNAIx+5Y1WRWEA9wnUoym03AWSGe0WPJaumxga+MO/cT/+tT
         utaa1oHK7AS4h70VSGvYJINqjqNHBX6BTJgiPJD+OurlniqoE5zn3gUjvyV9y64ap0FQ
         NADOYbTGMIuqeTRCSDaQbkZO9UM2PfdGXC8JOnl+mE4Z8WLz9OK3KV2Oq7nu3huPgq39
         HVaw==
X-Gm-Message-State: AOJu0Yy4YQIHo7i7BTZSwG+i5x6Xd2ciDpADQVPhbfsIgZ3eppsqdIWI
	c0GIve/0kqSusIrBc6nuxhUQNFXPpPkBnjn3XD1MyNmvdCY9ehT7M55WjpEnuw==
X-Gm-Gg: AfdE7cmu4JLBVfEmn/GIRPtJLnk7E6llVPfZqTqATb8QdQDN04ynjzNvDS47nsAz8Yp
	qZojU4XDSLtH+A/ff8f70OKqxtjqi+wwBlWTVxy0+V2BYNiA0y6vPmdPneZmmdqhqVq9qD1RXUR
	Vg+ucAr7eA+vT7Osk3636b/hBM81pAcyGMXXUXvp37ppK18sF6sHP3JI5I/QFcGwBEU8oz2S86G
	El21uuXO3XFiGTVBTpvb5fbOUladL+rgB0BefMy5Nylwz5I2pR+sHY46R8+/lhfAmeUnIS+bypA
	p5mJwL+N9zwti+XMHuaqJPCmdf6qzhKuj8zfogL5MDkfuIeCBkmdDYKPVmeQexQJMk4jWyhUepG
	zJdkhMksh7itL1iHVfTLbnEqKj0//0id8DXjxj4ABW8TEExO7w7RwVKmkWzbt7Qmegjg/6KANz2
	d/s1SOm6cx8BsKaH+6
X-Received: by 2002:a05:600c:c089:b0:493:bdf1:fcde with SMTP id 5b1f17b1804b1-493bdf1fd21mr9027075e9.19.1782833356799;
        Tue, 30 Jun 2026 08:29:16 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:16 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 02/11] sequencer: move definition of is_final_fixup()
Date: Tue, 30 Jun 2026 16:28:52 +0100
Message-ID: <02670f57e7d81d4ff7341fecff3ef04b9fdc0102.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move this function earlier in the file in preparation for adding a
new caller in a later commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 57855b0066a..32a09b6e87d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4627,21 +4627,6 @@ static int do_update_refs(struct repository *r, int quiet)
 	strbuf_release(&update_msg);
 	strbuf_release(&error_msg);
 	return res;
-}
-
-static int is_final_fixup(struct todo_list *todo_list)
-{
-	int i = todo_list->current;
-
-	if (!is_fixup(todo_list->items[i].command))
-		return 0;
-
-	while (++i < todo_list->nr)
-		if (is_fixup(todo_list->items[i].command))
-			return 0;
-		else if (!is_noop(todo_list->items[i].command))
-			break;
-	return 1;
 }
 
 static enum todo_command peek_command(struct todo_list *todo_list, int offset)
@@ -4925,6 +4910,21 @@ static int reread_todo_if_changed(struct repository *r,
 	strbuf_release(&buf);
 
 	return 0;
+}
+
+static int is_final_fixup(struct todo_list *todo_list)
+{
+	int i = todo_list->current;
+
+	if (!is_fixup(todo_list->items[i].command))
+		return 0;
+
+	while (++i < todo_list->nr)
+		if (is_fixup(todo_list->items[i].command))
+			return 0;
+		else if (!is_noop(todo_list->items[i].command))
+			break;
+	return 1;
 }
 
 static const char rescheduled_advice[] =
-- 
2.54.0.200.gfd8d68259e3

