Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5513DDD5
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762314; cv=none; b=UBB0k2Odvd4jhY9SOJtI8lglvCsY+GlpeAtW4HcskJ41G7s+4fSL1iOYHyFoNeVTOtMr2o/CD522ajlkl4yT9vGHXDll4bG0P/16D1txZE0HUBYTS2+oLwkt3NwAmOPRQ+k/p7AiERK7+mB1p9LuADd27cc3GwPQ0A+d4aLkLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762314; c=relaxed/simple;
	bh=PeWD7Xzsyt+Jh9Nqsn4TpYWX2egoJFqBtWAUMS9nZWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i9NImjmSEfNH/Fue0vlqcnL8fM3xNqUosqfkyVN4vfDsOe8k8LeRQtm05klfpRFiPZl+WqUgMqnr1t9mNE09hIk8pak4domTU9oE/M9wZ6LLTj88tsUB8eLMnpp+YHxhlLE9e3uYpHlJsKTIrX39TNPE6ydba6SiULywijHBD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp0Pa4yH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp0Pa4yH"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so73369221fa.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762311; x=1722367111; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=hp0Pa4yHSLEeCP9BYy9sukoNb6RGfkb8RI+GU+AlI6SMMEvIMAki7csgyrlayMrNwI
         SLfQd+3iMq4gcnxnlXd6argTb+E9ggvCaunarkHXbg9WVcv/XYqPf5uNfVRsksKYQmXe
         OUjOhMTTnjcn4G8Y5yVgHUNsRhB421x2whlf/xs/3K061F2ibSxM1xD9R84i71brfjDV
         Z84Iy47HN6YOVaNLW+Baq+3Sc5HMxMACYcXC/NP6OT0i/uzQQI/9svpnmMFL57TYLGis
         CMJuYXgKudW+6wFAWlZCBXEJAnQxrnmf5AEAhDcJ7PBJCdbXoOqEwu6sF/FkhF0DSdS6
         gRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762311; x=1722367111;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=hjA+b6Gv82LX2S+zRa2EdULdjQ+dEBmuHHN+8ev4HApf7gXL7bncpgJ627W0alvhfX
         L+WJ/cmtWduwkf3TPXk76XVPBX57gRbGZLACJ5zwohbMOWgrMVf0ezpQTp04jmV/CVs/
         3IjEjMX3CoF6HJK0WK2+B7JpYrhDTip55GScmVUr+UHNGuv1un8pmgFj2GQQ93EdvItT
         atMSG66lojAkBsRCEkDGeTsZ0lL+ezZu30NfTX3/oeCpf/My3JJ33sUGyTFT1pbNI5ey
         oYOfRwHlq/owCoMJlEpSWrTku7v2GBWzLQbrsblyDeUd7Dd6DQ519TD/6jw3w7Gn175p
         2yYQ==
X-Gm-Message-State: AOJu0YwJVO3K7TclYv46LlEh0NEVG91WOG47nVepcor61Yk938IfP+eT
	h8avwIKu19g0piC4zAJzLtCVdQLF/i/TkwEZpgluYPYAvRMOMy1LYvc22A==
X-Google-Smtp-Source: AGHT+IFlfxB+74NEDyc3d4YpbJbAEoa5fBrOYjysV/DH5RZ7+iIDRrgRPMPzJZLeoUX9/oG4Pkg4YA==
X-Received: by 2002:a2e:9198:0:b0:2ef:265e:bb93 with SMTP id 38308e7fff4ca-2f02b6f52eamr6065991fa.3.1721762310665;
        Tue, 23 Jul 2024 12:18:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d7575sm7912214a12.14.2024.07.23.12.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:30 -0700 (PDT)
Message-Id: <680ecb524040c64f886c4e484a64f0d17b512e27.1721762306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:20 +0000
Subject: [PATCH 2/8] git-prompt: fix uninitialized variable
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
Cc: Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

First use is in the form:  local var; ...; var=$var$whatever...

If the variable was unset (as bash and others do after "local x"),
then it would error if set -u is in effect.

Also, many shells inherit the existing value after "local var"
without init, but in this case it's unlikely to have a prior value.

Now we initialize it.

(local var= is enough, but local var="" is the custom in this file)

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index ebf2e30d684..4cc2cf91bb6 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -116,7 +116,7 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 __git_ps1_show_upstream ()
 {
 	local key value
-	local svn_remote svn_url_pattern count n
+	local svn_remote svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
 
 	svn_remote=()
-- 
gitgitgadget

