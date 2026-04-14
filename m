Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9128136F
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161312; cv=none; b=TDZbFznGFihDkW8QKFTPd4/MtP2b3EV0i6EAkGn1EgxYAePDrmRcte/2nVL1/FWQGGWoLtKvrAgSL4mjXxlBWdsOHmreAk7yt2wNPlu/0hS2j94UxV+1VMtnWfFNxMXksttnmHPanORGL878NAJoB0MxbBTejWsfiufGenwM3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161312; c=relaxed/simple;
	bh=np1YYPHIkmUe5u+KkLh2bJrci9exda49L9AruCLo2n0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L7RCk5hS4io6rYimY7L/KQmpOG/NuNIB/5IVx4Mk5msLOAcaJfxvWjHFq7DxcfkQ2hzeDGYggBklhW2pgXwWcBa/KCu9eFHx0a9RDhIzNgy9+XYcEK9UBImb4WYR1I82LUgqEynQOFmlzjlR4kyAxkwNfHRxW0SbJcbaJv+updk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqyn+TAM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqyn+TAM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so38058605e9.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776161310; x=1776766110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFF4yAWvWRBWPFr8zsGRf7Gdd1/iZc06sBENVCMtGMk=;
        b=Fqyn+TAMKcZcCwGU6rhCs7DqBVe6JZxwtp0ukGnJwuaTWOYewRWVNksxSJpfBb1XDJ
         9F0KjhxofiZdcNEFqV+WRzrUjBLzXfmDTysTmERwE0ojOk0Zdd61wWnqYGLaMO3vLvr2
         NxpzgvF9TOD5mf5zp8CYoaleNWeVzbLAZTb44JmnTGre0UdmrRkXtwYNSFiizzgHvSUk
         6Zd8zweq8iLtnMyzN+zJC0biBZjvmMwJQ2UAxSzjOYyvHas3Oe7Yzwrri6/x3NqM9R2B
         +Rksa0Y0F+hZh7AOfgacac9MfqMRpR4AfqdWePCD+SiqUYWK8aDtSRnLroEf1BEd4JVC
         sbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161310; x=1776766110;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFF4yAWvWRBWPFr8zsGRf7Gdd1/iZc06sBENVCMtGMk=;
        b=tIW93K9XhximYqz3z0xm1b5/DcOLYjZwgUlviKZ/aFCBY04mp1y1lhj2MmvEjo6IAu
         l3PcZp4OMaZVgJy3pNCR7YPfbDRftKN5/u+NvDjuiYHEVX1xngQAxQyspSm3Tppumby4
         0KbJPBkbqABMRZM2vuMZ3zG7T5Se45PxWmOuImQjpRkGKanY7XwfUHD0ghaiH6a5ZCGM
         +zMHpvKrf01a+HqwFssdRN0YcvohZYbTGwx0t56BP461Djw4X6VlPNpwjUnQAqiwlKQE
         eH9+z3TY3nnIynUkt4QvNNXUQaVWdo8K8W4M05GFu/HxgPdCRFghzLBjEqckaIHOyCma
         fR2A==
X-Forwarded-Encrypted: i=1; AFNElJ85b3x9SIzLl1QqcXiXQgNjD/VWK4k2FufuMEWSGKW+E2Wo9ewSDnBStMlkjYJ1cCF4mIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfO75evXepOanzJM8ACsln/qVZf6RAl7n7PXhHAzwDUiPEEC6
	Hm9eEtLKJ8jZN6fmr/1eIilTaF2Zd0TjIzibj8FsGwNBwPEDCLUW6hA4
X-Gm-Gg: AeBDieua+DVoBVWU18EBshPXPwcLEPcxYMMbPtcRZoMn7lkw5hNz6l/CrL2D+EXJaDV
	jNtUj6zMNVma3fRAQtKYG4ZTvBNDCGRQBErri71P7yKq2k/BMrqO3hsgX/1Q8VfJ0flEMn4U4St
	WiclJ4kbJbaZXALDbDpk+iZtk09rHZeSE/Qw2WiwuYbWOnEFUUMilwoRXa4pq75rdrPPbO/e0kR
	Eo47INU1jtW441LTfFTr6Wf3Iws1eK6nXvK67MSOHU6EP2IGXUEwFhz4vsTHloHrv/+zcnIY92D
	ZiGQCyGWl3UdqzX9hy3YVYV38cXTxcM5/Xkf3hiAMh98uvI1hMFe/BlRDUC+u4bi2efKHtSRZKz
	+gVwc+V0iS5TDUI+ymJKjY8dMBDwYTYKNWLk/rL1m9R97+6E9mxhfPlgzBhuUBChl94XO2RAMvX
	42CHr+EAx5aYhYafUPQfPY1HCmahN9jFU3XNi5lX0JnsAUY6MYzhJZiaHZbjOlUO9cBjLk640yD
	ouGPo+D
X-Received: by 2002:a05:600c:c0dc:b0:488:aa3d:fab1 with SMTP id 5b1f17b1804b1-488d68364f2mr150982355e9.17.1776161309528;
        Tue, 14 Apr 2026 03:08:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:b886:6d6:9111:f662? ([2a0a:ef40:7d8:fa01:b886:6d6:9111:f662])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee019e44sm67772825e9.15.2026.04.14.03.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:08:29 -0700 (PDT)
Message-ID: <df244360-e9a9-44c0-946d-29288e6dd269@gmail.com>
Date: Tue, 14 Apr 2026 11:08:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/6] Xdiff cleanup part 3
Reply-To: phillip.wood@dunelm.org.uk
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2026 21:26, Ezekiel Newren via GitGitGadget wrote:
> Changes in v5:
> 
>   * drop commit "xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for
>     clarity".
>   * add braces around the else clause
> 
> I didn't see a better way to rewrite how action is used so I reverted to
> what it used to be.

That's a shame, the diff below uses a local variable to avoid altering the
arrays as suggested in [1]. The comments about the double evaluation of
xdl_bogosort() in patch 4 [2,3] also seem to have been overlooked.

Thanks

Phillip

[1] https://lore.kernel.org/git/87a54698-396d-4de8-bd9d-cd72f8d1e8df@gmail.com
[2] https://lore.kernel.org/git/32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com
[3] https://lore.kernel.org/git/xmqqcy0oj2s1.fsf@gitster.g

---- 8< ----
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 471d9567c9..9966b4715d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -329,24 +329,42 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
  	 */
  	xdf1->nreff = 0;
  	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
-		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
+		uint8_t action = action1[i];
+
+		if (action == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
+				action = KEEP;
+			else
+				action = DISCARD;
+		}
+
+		if (action == KEEP) {
  			xdf1->reference_index[xdf1->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action == DISCARD)
  			xdf1->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action1[i]");
  	}

  	xdf2->nreff = 0;
  	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
-		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
+		uint8_t action = action2[i];
+
+		if (action == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
+				action = KEEP;
+			else
+				action = DISCARD;
+		}
+
+		if (action == KEEP) {
  			xdf2->reference_index[xdf2->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action == DISCARD)
  			xdf2->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action2[i]");
  	}

  cleanup:

