Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8E42981E
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289197; cv=none; b=jdtWpxC3UT18CiH2ZE6deqKqbAiOcF/+y93f4x3p252VB0RWOZ2F6N9cTjwziF1Q0AO0+Lduy6mrSMmmevgjcadrS37LAEZVdbAYBs4p4Wx5nauG2tOfO+Nnfn/Hfkl8eORm2MClqC0IZvDIKRGzfbQlWkaCkxmrg1tHDk/hujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289197; c=relaxed/simple;
	bh=f9pDBNwNFgcBRf9BmETNYTDY7YqatL1lJ/dq6HvZWYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kn77355p28hWek0IiSTzc/VJ+1EAvvZvri6kRBBUBoM03CzAEdnSxeJqr0J99W8Uxku5XeRyedkmmiGwYkp3DrFWlN+ZdUT51ZwNYg+qa11CZCgKcCUqUF8rPpM4GOsaOSnEdjWEbUbVlNbI7DgmIHMCefIt4YtKuGTAp4PVgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgs2AlL0; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgs2AlL0"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a803458ba0so473951a12.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289194; x=1790893994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fa9tEWZG+po7Zw2aFaqHuNFJJxRzF0G4M5BS3vHWH/Y=;
        b=Zgs2AlL0lDLT0hiVIQXTWRrtYUa9Xp62itvISrxlZ13ez5DmK2QlX03h9kbDG1Iaan
         Lsb+B/unpL7SFzCtgzx1Ts0dyBasHhOa0QadG96Yq3DZZ8MsKoZu9zQHxR3kip0RY/Zr
         LZRMrUjjffjOcBFIhip5KipuG9JhcwQM6AV1i4HygE99pjk4erOeicCAnOLjXhxw5rTT
         WuCydJdDXaCWy7Ism2ArFCNmkZG5Kgpvldt8SNoX/xTOHyD61+QjCHOuCMTWwyyNmZxv
         9V0fSYf7RlZMDnQ8v6u84YV/ggdvM1aEm3P0pVLT/gtsjA0ntoD9yqrWONYt9jRlkmBk
         gd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289194; x=1790893994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fa9tEWZG+po7Zw2aFaqHuNFJJxRzF0G4M5BS3vHWH/Y=;
        b=CBoBUKLMAvmr4yCuHMdcLLPAyhDUqnZs/VUCwvu1H/lwIVwykzsfr8z4Ndep0cgrkv
         gXW2RMaXG7KEBDfzzqwRlwZCJF8vWbWziYRJgNYM2zknS61SJobtLjfuMg0uZTrdzg8I
         nDe19XtiGcdFEqrSxKsrpyi0h0o+C0g6wACQWy+FsFPulO+4IR17m3HQPiAvUWRsP7et
         priYxt7HuxmPPVkG5Fc7mq3qWW2LAbuVTlkYbg3pG6Q6k7vWtENEQhklUPMoWw++KJtm
         vFqg6w0Kt0u3OqRHTdeL/y/7O08ALjINMpqjJ5IasxSpdsR+njedgc/3PDqJ7R4GlZfS
         GGCQ==
X-Gm-Message-State: AFuF++kzLwsIERLIo6IS55eCzYgcWswKMX0s/awgI/Mb8ORf38iVIBpB
	mw8pRShOjG7dbJ6QC2DLo7Pt/3HN0R3mc6Eyaf9ugZfrjdF5m82tZmr5PnYpptlh
X-Gm-Gg: AYBFou3MC5wa0OrYZU0IZvDudRwbf4dOrIpAt97pLfp3TaayRX5eDSp1qU+zFW0cP+/
	ZrCAGmzchRGCBY0vtS8Ce1UEhq/I3DrhsgfmDAzXKSRirvDA/Kg3r3SI72nGlfPyjzBeuLWxdVN
	gstQsAAoCpiwnepuZWAFa8NccE9OdfqCUm+4vx2ihmdlpzeCN5RkMg7Kb0dGubBOCOAnJ3K5jDb
	WxtS6qra+04oWEg8pKgvS3NhbxmV1dZu6Z/eX5TjIFXkVpOShJpFoqxuoUpnA6LE9Oij8wQk06C
	Mdl1IiQJ7WwNjcNBmJWz3eapVdaVndXTLbsjZ3Xq8QBfkcSQaxAQAfL/7XbtrE6SdBk495UsPku
	UqixcFrXoYawboYhL+Ss6IwEIfNwckfq4C1RQPqSPWvTZGTA/nnfXN4DsqeqqrFgWHQAJSgrZvj
	eKIyR4R6wqmTxumsP1PgtQel5xikVSvf1R2UxT+QOMaBLCY7jiFjup0wS0TyqAPmlpQM78M180M
	t9CxFQY2QMdQ34QRj9rW2cC8VL7I2987w0n25O1bq1HX+riH3EGNhnpu0wxv66zAJlckjLZGR3G
	o9qMK57TQYRXkNjrRHS73fu0elgSu3VCjI/FEWnt3XKlDPbah/ulbyn94EI=
X-Received: by 2002:a05:6402:42c8:b0:6aa:1db:f7f3 with SMTP id 4fb4d7f45d1cf-6aac90eaa5amr3452403a12.37.1790289193987;
        Thu, 24 Sep 2026 15:33:13 -0700 (PDT)
Received: from localhost.localdomain ([37.31.48.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dd7dc5sm210791a12.21.2026.09.24.15.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 15:33:13 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH v6 0/1] refs: report old values to transaction hooks
Date: Fri, 25 Sep 2026 00:33:09 +0200
Message-Id: <cover.1790269745.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows up on the reference-transaction bug report at [1].

The reference-transaction hook currently reports an all-zero old object ID
when a caller queues an unconditional update. As a result, batched branch,
tag, and remote-ref deletions report zero for both the old and new values.

Earlier versions changed refs_delete_refs() and its callers to pass expected
old OIDs. As Patrick pointed out, that makes previously unconditional
deletions conditional and adds complexity at the wrong layer.

Resolve the old value in the common transaction hook layer instead. Keep it
separate from the caller-supplied old_oid and old_target so it cannot
constrain the update. Resolve it before the "preparing" hook and refresh it
after the backend locks the references, allowing later phases to report the
value protected by those locks. Do this work only when a
reference-transaction hook exists.

Changes since v5:

 * Replace the three-patch caller-specific approach with one transaction
   layer change.
 * Leave refs_delete_refs(), ref_transaction_delete(), and all command call
   sites unchanged.
 * Preserve unconditional deletion semantics and test a concurrent update
   from the "preparing" hook.
 * Report observed old values for all unconditional transactions, including
   symbolic ref targets.
 * Document that the unlocked value reported in "preparing" may differ from
   later phases if the reference changes before it is locked.

The full test suite passes (1060 files, 34660 tests). The focused
reference-transaction tests also pass with SHA-1 and SHA-256 using both the
files and reftable backends.

[1] https://lore.kernel.org/git/CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com/

Maciej Ciemborowicz (1):
  refs: report old values to transaction hooks

 Documentation/githooks.adoc      | 17 +++++----
 refs.c                           | 54 ++++++++++++++++++++++++---
 refs/refs-internal.h             |  8 ++++
 t/t1416-ref-transaction-hooks.sh | 64 +++++++++++++++++++++++++++++++-
 4 files changed, 128 insertions(+), 15 deletions(-)

Range-diff against v5:
1:  9b76cc2c40 < -:  ---------- refs: allow callers to supply old OIDs for batch deletion
2:  6a8401c448 < -:  ---------- branch, tag: retain old OIDs in batched deletions
3:  541da44c37 < -:  ---------- fetch, remote: retain old OIDs when pruning refs
-:  ---------- > 1:  2af3eeadd1 refs: report old values to transaction hooks
-- 
2.39.3 (Apple Git-146)
