Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02D48987F
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827479; cv=none; b=Uis9l8p0lksQdOxPtq+N23vcfVMxWjcf/jN0g2YyaiLXsWO9XSD9CBaLGxd2BYxM5jGWL+7YA7ApuZK4I+ZMEPuDZXUojZntgygWdYyuIF7fPxE56+0xDcnvClveLIyTxr2oecbH5JBHXmv1J8zaStchFfcHUyJQpXqnCEu4Uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827479; c=relaxed/simple;
	bh=f7UfA2yBPlGP7BInCbpGvQjtm/y6IjPxVkIyvwAQsk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBj6utRrf8UIKxaZNRX2ViPmJbx2SjYj8rd0sEnCdLU0GJiSgQOG761AJDKvENk+2tmtN5COhr14rN5tZXfq/ZM67+XTz34EW5j7UYdmezyJXDf+l/Cz74KX5NUbRnj7rHyoEChLOgTIXCw0F8j95Yi7V6xNthAmUx8PTCSVUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2AXYIK1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2AXYIK1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c8bde2dcso12378997b3.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827476; x=1792432276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Y8b+YGelvGS8pbxZ9EseHerXCM3yqh7PNegR1qKKXU=;
        b=o2AXYIK1FYf6b8xwo7uixtLsgzmogMVEMxl8zEfzwDVlb2ASgvxE45rE3OIpIcqyOW
         TPS8PPrmi1Gx/dFMS2kZGaQIh21YvRtIf6Bg5dYS5rU2n3jga2ExonBOuon3YjV9fV+G
         r6bTS5IJlHJkIH4vHs+wC5PyVCI+0Z8caMYhv3JbCgUDmenrwMHbQ6jN0XLjOlFG+k12
         jwjFD2zOpqRhErd+Mej+dyy7rNQ5mlVsWZ6dlGheaG4fqKN4Lo42o5EXO/pQLsKAgAe7
         nep9AHvcVUxyp3rGmi0aEnbOGU/MhK+i2NiVyK77afVQjeR0vZqAeG5Dp47zsUoVT0XO
         AiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827476; x=1792432276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Y8b+YGelvGS8pbxZ9EseHerXCM3yqh7PNegR1qKKXU=;
        b=ES0mwJaxzh4rhg/SPH4z5oj/ezwIv0zrjlElmANSuLpdG8GLEA4hDVcbFhg7nMF4No
         qdbtgv6puUIJVdCj67icKsJ0uMyRa11J9nhaIJgr7q3COZq5uoYKQdTndnocHC1UduQd
         nAHV1BfVWiS4BW2XE9a0Q5d3Ru2ISREhSArWwHAz8zDrHRAekvyvSZI4JFtmGJHrC7J9
         v0hui/ylfib2GtGF9p6HbaWM41bJNGhkr5q8Ggxfh1/qeQE8j2B+hqQH6KeyAHub3jBZ
         its8Lu94DKxPYZe9CfPyu3+N7I9Hd34+/4RRgJ7odZzXyrh1C+PZ+zmMYOTjkdgrXAry
         cyWw==
X-Gm-Message-State: AFq9FYK/Eeg1677genfavQF+Hh1T9H5wIBNNDDqx99HtI/3AKyaECM8r
	M1kt8f9cWa9oI7W69a8s3hyYkzAjMb/D2pPG4FlU53bs3DeCA3eqGDZ3cjT/rMe8
X-Gm-Gg: AYBFou2z/kv6/hqy5M4in8VSEcphL03iDX4niezPSgX5Kc51CSs/W97h0fJX0EEQIWE
	SP74eBfoVgSWtIWjchvciC5Ceseq7ZwF8hieGSgHE+2XCvubsaM74o/wRWGUaqya89k3IVRSou8
	yMc646Kx2ZXBzIURv1aS5TXoSEvO0KRHtLgiyQ8iuGChiIwZGjYDAQmUiN5EOiyi0v+mGPTrw4n
	H/Yl7NMcoy9vxkyeBXCPNc0LgbM2TA51ZAsNcFq2j+D1ZS7T5SKTLnb+cemLIt3EX7xEHU/Q3Nv
	HZMED2foR5t4Gk/ZXm/NiT9/9APlDya5bJv4YpmCrzDKrK593sJ/MifHQbnuY78OSRTRk3CzaCB
	XJYwCarJiBKiUIWXGexNHFy8O0kxB1/bsXfIX0DO101nFgyTX82rxh+alsV2vdBqEVyOGKoqS+1
	yXKLHAK91xFBdOFUjsNJzrxUoq1SZOJsWsYtRPiG+OOgDtxPVkBfgAIfWe6mJDE7TEox/TDFCKo
	DDnfaTb/4JEvws20S73mCWkW9jRXQYEuIIBeYfgDraHSzEPeXdUsHVmIMm63ZYQCORByhddMoDZ
	gnr6TJI0zEOPtby/r2BJSg==
X-Received: by 2002:a05:690c:a60b:b0:8a6:1f92:1f0a with SMTP id 00721157ae682-8b07eded80cmr25715927b3.59.1791827476429;
        Mon, 12 Oct 2026 10:51:16 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee8603fsm36797127b3.4.2026.10.12.10.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:51:15 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] completion: extract common stash listing code
Date: Mon, 12 Oct 2026 13:48:28 -0400
Message-ID: <34fd7f793fa21e83d073ee0547d8de150f460fa9.1791827304.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.184.g5a00b4a6e9.dirty
In-Reply-To: <cover.1791827304.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With no change in behavior, prepare to adjust how stashes are completed
by centralizing candidate generation.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d60e85479c..697fef5462 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3593,20 +3593,23 @@ _git_stash ()
 		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
 			__git_complete_refs
 		else
-			__gitcomp_nl "$(__git stash list \
-					| sed -n -e 's/:.*//p')"
+			__git_complete_stashes
 		fi
 		;;
 	import,*)
 		__git_complete_refs
 		;;
 	show,*|apply,*|drop,*|pop,*|export,*)
-		__gitcomp_nl "$(__git stash list \
-				| sed -n -e 's/:.*//p')"
+		__git_complete_stashes
 		;;
 	esac
 }
 
+__git_complete_stashes ()
+{
+	__gitcomp_nl "$(__git stash list | sed -n -e 's/:.*//p')"
+}
+
 _git_submodule ()
 {
 	__git_has_doubledash && return
-- 
2.56.0.184.g5a00b4a6e9.dirty

