Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA225745
	for <git@vger.kernel.org>; Sun,  5 May 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934957; cv=none; b=nFe/S9YSmn3+Ameo+My/ImleV+gwcIPQU5Bbne4OYJBOPjZXRXa8V8zK5WLx4DIVl8+CZM2rvRBIfmCn9Hnjzi/PRymbwpF22WrbxzWPVWig0pCtt788J/9tUPWuSFbB0Up+NuEhk0Rhvgdv51eK1H4MCTPDeFJOzqei45NC9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934957; c=relaxed/simple;
	bh=4NCWFMtRTPSIc86cPymWZlO2yuHrOPCwq5qO4PxqK1A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZX9JLluPyfVehttwKxGVXu3HHOSZ5t5dRMQfYy1Nv/PzvUxJ+ILPMt0Kqe4Sd0GLcv0agGrghQoIwNdY3HPvsbHyzaxJlqtfLtUokogVa5XN7iOcCojCJucRKWFTpWdSP4YBmIZuAjYu+c53IHapzl9Te4qBpcEm7QpqXUQK5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUHeUcjW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUHeUcjW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b782405bbso8549395e9.1
        for <git@vger.kernel.org>; Sun, 05 May 2024 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714934953; x=1715539753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKCG2dO8zAqMC/M1isHJqVhqlH5cCUVS7CzSAHkfNoE=;
        b=lUHeUcjW6RD9a8iCjRPfTdf4pucEGH9eeFY49IA0WE3Y6B7aMdzFwdbLRePa7+E/7w
         Xkfnxbu8CAIYMHfj1dFsyMRkTALeLSPkpWgSR3uvR1hz1XZBz/ZALifxivQGSUW7Xtxr
         fzi5G9Qf2TMI7PB0LfRWyPaCKzomM+UC/mOPViUTDX2Byvy9NmSsEKo1pYQ18GO7jHQj
         24M53EG3qu1kZ6qvN2uR/3yuwc3SlhnbGl2rLWe6Dm1p3Ht1EWJE1+XK4aMlnksMHbFB
         nkgyBXMuq8LGFRNahj+EYGGRDHk7vG0cwVbWMsJqwaQK50z/6oV11eElNKfxv2K5r+ll
         98Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934953; x=1715539753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKCG2dO8zAqMC/M1isHJqVhqlH5cCUVS7CzSAHkfNoE=;
        b=VJxUg2sNZGQAlA7VunrgJ0weSTs0kGX4BtA28lyT2lGzsMG7RytDl4ljjVWQ1Hjddg
         YQm/Z459I7ec1l6fuXBlf8AYQhl07wZkU5Dc23E2FO9LNKA7i+9Ruli1QNkxy+jrhAsp
         0fvo2vvT+/wvbSdNllnH6YVME4WXnlbrq7nxtlkpQgYuWyY79ajmJ8KR9rFROVgC92Lm
         aQ4MU5KT43cy69WoEbqhMK8prQsb9OzhKJsMoSISAcjJ8+wyIxF3axKHZVsdXaEPh8LT
         6ZjT8Jcble/53f/Mu0C2m/To50ir5oQghsgF246DuAmCPNXP0oA5bRTRg5UOUwlsdxZT
         GfOQ==
X-Gm-Message-State: AOJu0Yw9AmYiQYAXgcqNI8IH1A04cQGB1o7c/D3Oz3jhX63Snypd2W9u
	ryHDR/+KhTbuzooUeQIhjbiuM0fWa6wGm+Z2YuJLXxkQ4hqxPHjvVE2Fyw==
X-Google-Smtp-Source: AGHT+IEYM3bJKLvIrxPdLpOQfY7grKcO9YGpfzOCYY22Sm5achca1cuotgV12w5P28pcbaUn9dNisQ==
X-Received: by 2002:a05:600c:4f81:b0:419:f3f9:8ee3 with SMTP id n1-20020a05600c4f8100b00419f3f98ee3mr5553579wmq.5.1714934953466;
        Sun, 05 May 2024 11:49:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b0041c23148330sm17113508wmb.10.2024.05.05.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:49:13 -0700 (PDT)
Message-Id: <85f45a57f3529a90324ded07856fca610f7b5eda.1714934950.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
	<pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 May 2024 18:49:08 +0000
Subject: [PATCH v5 1/3] builtin/commit: use ARGV macro to collect trailers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

From: John Passaro <john.a.passaro@gmail.com>

Replace git-commit's callback for --trailer with the standard
OPT_PASSTHRU_ARGV macro. The callback only adds its values to a strvec
and sanity-checking that `unset` is always false; both of these are
already implemented in the parse-option API.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 builtin/commit.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6e1484446b0..5a3248370db 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -142,14 +142,6 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
-static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
-{
-	BUG_ON_OPT_NEG(unset);
-
-	strvec_pushl(opt->value, "--trailer", arg, NULL);
-	return 0;
-}
-
 static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
 {
 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
@@ -1673,7 +1665,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
+		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
-- 
gitgitgadget

