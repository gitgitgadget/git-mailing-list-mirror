Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A931F1513
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268581; cv=none; b=hzXZw4T3R0xeWF111u8F3HqgcVPyWy5CoyyK9BmWuso9ZgDrbj0Q6whUc633hl53qoTrg1st7cugw84Q8rhRITxSOiBnC2BWpl7cVOvg1GwheP+u9uL2XkjKRyTlLdWqypb6uCPfX7+9Ws0Im4lW8+1Vi1eJ3Dcy1dTLh/TywbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268581; c=relaxed/simple;
	bh=t1cbcHDxa2pRopURNSF24/klR3HytLs2HdXoiIqXb7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imL31+TegTd77Rq976BwtwVGMFi4JngPZVsxOIb/lNWLxKUtghcjTEXCTw3kPGpvjWdyveiPUSaASMPG2jMJxLKb51LlOnKNnI7hhCAils9w8X4UyjIXibJv/msyWmVQbB6hg4P8EvAK/yhm03jgou0rPuqaG7FRtQfgZao5Trw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9fnBIST; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9fnBIST"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ce9df31840so6552696d6.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268580; x=1780873380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgh5HL0xsdg9sa1sFLIbfrTkJQoDDwfsT1GtwJqPTAs=;
        b=m9fnBISTtRTvFgaH0E78E7v/6xnu6oiqErBZf1qVlffTF0EWLSMM6H8q0G+gkA+4Xp
         Ccn/HfgT9x5tvM/YYJQU9EeDIgaw0sOvwukUg8JYk+6kJ6eTkR8iyAluptW7nXdsttpk
         bvp3+9TAV70dG/ZmgG2RW5e7BgJuCipTjwu/Zvm/JbMKPBJ2ZstjPMoLADnNa0uBmFBd
         JU0GliPNc2x76fW753go2JztphfbXBGZ284+xcpWq1sxqSUUXUFs8PLtfRQKAE7He80W
         QrRGwxZLDTuPImzEBFL+86YtATZQQXbROlSWRErcL/SX4zD3Pn+uodEyMwTPz7lMZjyi
         VupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268580; x=1780873380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lgh5HL0xsdg9sa1sFLIbfrTkJQoDDwfsT1GtwJqPTAs=;
        b=BbXsXSYwVSjswEI1ORNPYlpm8NCi3UixO4kc0jd3qJHd5GzKD/B0rOo/mQvRaHxqTX
         m03/PBlVtI1OERu2M8ErBqbVKy+5V8ni6C89qta/u+shx1ssLsvSNP0EiVTJFBoFb9R+
         ZFF3/NL/poQA2ZSgVUPwrEZw99u8AA6VjxG5nuyALGffznDzvMLMSbTnoDIwX61XdVxc
         y5nLf2XDJF+xeeh0hgY2zowf67SXdHjdx1OwPubkaS1I5BCT3w7jVu3u15mkD68JbwKa
         sLqdnC9dgZ6YhXoOmKkiEMmzYJ1GrMdqWH+09hnBPcm1Ehp643qWqQeCIM2An4zhVFyi
         EsVg==
X-Gm-Message-State: AOJu0YxvNKFRXyJeRZ7iYiqQU0fyfQqlEUi9xRsSops8Ko2Cck/6gHA8
	XnXBEhMtUf8DnvWJU68Yuie+AA07Apw8d8YX7WSXGggI4e2M//fnKvfWW6rjS+9+
X-Gm-Gg: Acq92OF76ArxbJyPnrcFmemmAOpQaPsHV/0Qri4YqxyNC0HGR3v46oOSutRNiBnPUGK
	8jZnAJHt4rQNTdWmGOVmnUaS9/YsuJW8iPawROx39MXnAC5/vhCn1gzavFzZSR6XmcYPeCWKAh8
	BZOE/ePAr9e8vZ66wDWXL8TzWKX313px9lJeWbETG0hXpo5OMpd7+L8vFZBAyhSC98LgPxhADvs
	w9Fvuo1iKKldjdp/dfL1XPChOd/nmAa8aHaQubqW0qzokNEZm5TYMflEBVeU7kWBjAeDzub5e7h
	igs5srNQuP4v5ORGKYdTjWDjzoR9qVZFXFfYc9nC4CB5Z2rPsFdKNqeSpZ41bc1cjFWKb9ulUzT
	FmjaGKp3uub7YJNjxc9iBhycwrvzP7fP77bsE4h7+ygfeA0U8izuUYbqc50ofkG7W7stHD8LEch
	3UVSd8XYrgT0aGdTs1lmZ/9LlwG7QR33D4ZfIx
X-Received: by 2002:a05:6214:500d:b0:8cc:e25a:675e with SMTP id 6a1803df08f44-8ccefe17be9mr137568096d6.46.1780268579679;
        Sun, 31 May 2026 16:02:59 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:02:59 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 01/12] git-gui: use HEAD as current branch when detached
Date: Sun, 31 May 2026 19:02:14 -0400
Message-ID: <20260531230225.126817-2-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f87a36b697 ("git-gui: use git-branch --show-current", 2024-02-12)
changed git-gui to use git-branch to access refs, rather than directly
reading files as doing the latter is not compatible with the reftable
backend. git branch --show-current reports an empty branch name when the
head is detached, and in this case load_current_branch needs to report
HEAD using special case logic as it did prior to the above commit. Make
it do so.

This addresses an issue with git-gui browser failing with a detached
head.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 23fe76e498..f70a54a61b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -670,6 +670,9 @@ proc load_current_branch {} {
 
 	set current_branch [git branch --show-current]
 	set is_detached [expr [string length $current_branch] == 0]
+	if {$is_detached} {
+		set current_branch {HEAD}
+	}
 }
 
 auto_load tk_optionMenu
-- 
2.54.0.99.14

