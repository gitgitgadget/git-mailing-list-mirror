Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3941C30F
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572359; cv=none; b=tIK3IBYMl//tCEKNnYErT5LIuRIE/qMuGf9xtlzRvzx0JW1uQbExOyT9JVLYD6DQeMU8P3Lw/G4l+ylZIg9Hfhv4hk2Iaic307S8V6Q22act+gw3/XDaLClLBa2ylifdX7nW7cF1uhOaA5ahgU0ORLrMcrOBUjdiW7g11iUfmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572359; c=relaxed/simple;
	bh=E+Zu/gLpwFdOoLT0qZ+ft+aEDEi/8wu+fy/zfdwmo3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f14h5Wh/O1ZS3Jy5I8seOigqOh6z6S+q6yivUYB3tfuFyF1XtiyvG1/Bf97qapAXymTbieDsb2FqwXUrT/znTe2HS6xkJS+1fWxqtl8AIBfHg7+7nLC7zb4vJXhAgHZ7gHkycC5Kq8SmoTfhdm3cLXK7flJZkFDuu1yjtQfbHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WHUwKjZt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Avjw1l81; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WHUwKjZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Avjw1l81"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D7F83EC00DB
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 07:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572357;
	 x=1780658757; bh=MksxXw30h3xtMYCrxrl+FuUaaZaPcsq/H1cPvUcPcS8=; b=
	WHUwKjZtuRV6P52R2QKwr9h9hvsXGjTTpiWDq1GxgBVaZd1nl8U0XoAtTSguABn0
	gHImTk/GSvM2r0i4Ym6sjZifYgIXHlovDggObLM/RWF2x0pEZiYV74xEZVP0KvKf
	I9PvO+YmAwzUfXQNCMVBvjwXR/hTC5LoVQm8bYE+XQiMoszBUkAIGN1YMF0iyW+R
	h/JQZ0qau3/isYTo/2td/ckIohyqIqvuPUQGnZfO9oRTfMPnc01R+CoqGWH5rHtc
	N0Kzmx2EjDUzCc1ucZB25/QfnX1nb4SOEPmdXsTZOx7MZZBrkBKcTz+iZ5dEeF4Y
	zygDuJxnaBrR4WBL6MDS3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572357; x=
	1780658757; bh=MksxXw30h3xtMYCrxrl+FuUaaZaPcsq/H1cPvUcPcS8=; b=A
	vjw1l81Jp48giHrvst85e4xjEC0wV76L8LH+pkcXx714RTb38g66k9b+Q/OinQbD
	v3tepNBfv17Wk7INgraSbGb5JCtB8aVEOUk6NEeF34er/zhTq/hUA2MAwZMwE1q2
	yr84wovFam57UQm9pG4TrA8vONESAhsvpPzFNSYUDintScyi/0+dWhhEtNEcBhMA
	ysxfQ5tb3c+mTMjMcZ3K5BivxJ+HFkq76eCN7kMLLO/GLo879jsue358Yb/cQs+c
	OYpzyJ7Ga+w9bjAR5VFxDDEzuZ+KNOR4ND35JvzjlwKYeN/u6Rv2VfDtJxJCFOOp
	Vx3PZ8bVauUMFa83RHxlw==
X-ME-Sender: <xms:xWAham_EfBbKozBWnoAVK9S_-W1FsiI9FedtCC8OWBbLJFg_Vbkdhw>
    <xme:xWAhatpxj6rCpflkzoXvFYq4y2bLgbJXpoMP75wd2F5wGC2IAWyrAt9BoeHcB-tp4
    jJN18MoPB57Sso-_uLyZB9tfqRLX1fyHGWAXjPNU24nTdE1XEtg>
X-ME-Received: <xmr:xWAhahrBd_z9Dc8XVftEFoLEzXjcXSC492OgPJvHpGIH2w4vztLUX0hmtFupvbkpTSChumLNq-sZuzMjzZfi_95QVxPcadj3ysJshs7HYeE>
X-ME-Proxy-Cause: dmFkZTEYHzFJBFB+4bChrJKGYDCEcg3QnvUP1qwQrlSe82+x0ZFMOU1uZt+I9IOUwuIYzY
    5FJW2zmYmmVzc9jSQIdzFOV69kwEnY+wAWkTq18nzWl7yzMZ3nlxEfHrkou2ZBLllMjbmy
    eV7x/3MCnm+Z04m+K5Urw9lg/inFMZV/oui19nCLLs536OFX1PqntAhqLpfir53C2kK0fs
    QdtOHleMnIE1rNhaobgUk71KceWT7y/OoZFaRv5M3yqZMou9Gx643lfiUbGT557EpgCWPT
    j2ETdafwZqtWvFTDy6TA0fRmfkvMSk7uISqimxUr4GjTqckpA9gPVUogLYgU8RsR5cUgNX
    DR816XGn8/d4PdDzgoTsAJvtMIvd8D7Ls1I5BSj9aKzmTF2R8g1xKb7tInh4HxzxEVguu5
    untaW8oTURf8VuTd0cqUEf3q1dO0CZF25YFnAIgvYBzCArWp5NTmNuxAbq2wjlLLWhu8UX
    FOVXJnKIzlPXmz0Z15dfKAq9WLuNAleMT5kIr7dL9zwPlxKJPG4YxCZCRUqy7kkXkWl+/o
    SAyuI4LqCmsz2Ava70a6uK+tI1sESpsBfoOUDz+gVgs3wMosWM249k0vX/RZ616fMw6UBw
    7U26hMJ+R523DG5AViHSR8+E1f2VbsXCUp+CDbQQPdtoSzOIoG7Es1O5Q08w
X-ME-Proxy: <xmx:xWAhajkV6A6EaBHXyHPlJLHTucq9jkfYIRNtEaIvxV7kAcvUOO87Xw>
    <xmx:xWAharE0k3sSWmYCT67zub-F5HF_yuIL846vc1cW2K2Md709r4ZFQA>
    <xmx:xWAhakpi27FWZWABRp8OmenPVJG5fz1jQhwGhhV_VsrdDfXFKRyttQ>
    <xmx:xWAhav5e7qv5M0URt5Em31P4P_vs9nQFXZe0cq6AaIrpiQAwLCcHRA>
    <xmx:xWAhausk4Pi-9GkJQ3pW6W55hrdQblA-JvVxlrc3Tc_vQJGuIiLCiWkX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 560da494 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:34 +0200
Subject: [PATCH 07/16] packfile: use higher-level interface to implement
 `has_object_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-7-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In `has_object_pack()` we're checking whether a specific object exists
as part of a packfile. This is done by calling the low-level function
`find_pack_entry()`, but this function will eventually be moved into
"odb/source-packed.c" and made file-local.

Refactor the code to use `packfile_store_read_object_info()` instead.
This refactoring is functionally equivalent as that function will call
`find_pack_entry()` itself and then return immediately when it ain't got
no object info pointer as parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 902b7f70f2..3ee71d7f71 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2132,14 +2132,12 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed
 int has_object_pack(struct repository *r, const struct object_id *oid)
 {
 	struct odb_source *source;
-	struct pack_entry e;
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		int ret = find_pack_entry(files->packed, oid, &e);
-		if (ret)
-			return ret;
+		if (!packfile_store_read_object_info(files->packed, oid, NULL, 0))
+			return 1;
 	}
 
 	return 0;

-- 
2.54.0.1064.gd145956f57.dirty

