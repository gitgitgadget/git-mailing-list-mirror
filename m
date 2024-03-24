Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BE288DB
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711318747; cv=none; b=KVYgQg2KYV0eacaJWQHMVUqA5WSfQXZQHO2t9J3smh1ppyCrOMXUiMyEDnhO0gcExqJBWGWm0eI4ejDoxyGvBh/nb17PWVr07hFc14s6PmuwHZdNGRurFlNUfpFsIO1uHOi6BDHchtDHdwwkiRkoINkf8rVrWRkE8kLUchWHyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711318747; c=relaxed/simple;
	bh=UkF4hrfEO4rL64BOS8hylXJeSVeekcz63ErR7m0Eudc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Lb6U58CW33UzIwTjsXeSFO1/k37lOcxXbJ4TbSswVK5R/N/puI5wcnB4lbodddlFA33UAXIPt+rZRgkyusMQsfb1+f3zIf+3pltC+TR3TdsNXMCEA5S+7z7tus3hg0nKGsEwCY67KeIpkTBGJi15ia1GJqQjx1ygEOivVfozkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4ahUC24; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4ahUC24"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41482aa8237so9844125e9.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711318743; x=1711923543; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG5PM73cqbTYJJbql1RWM9irH0dQDC8HRnVua/7OBmQ=;
        b=a4ahUC24bA1PL3jAkgYJv4mOrkYEPYUZgvBrr8E+Bu8h3dQ1ZCCbPjSndbXf2b1LZb
         IJsUfNVntG4KuS3WML6iyMx7PcfxvC+314xba8GNNdKu+zidb44juBv5BPe41tiNWaAT
         UVSePVxyPDK05Jf0msdSnJa1H8o/5lfiOiZzxd30s8eneGFuvaHKP56vwr0fgXB/2/Na
         h8ZH1KTEPBQLTbMXgWiIbZEFBkrCQIqp2APhFDYB9+nVjkLOzDSkkUB3pSZfppDndSee
         2+KcJu4EbOY5pN69afB4GHbTjL0AHV7R88zBkS9nu5kh6uBAD0iWQ5XL6E1ND+HU+You
         XBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711318743; x=1711923543;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG5PM73cqbTYJJbql1RWM9irH0dQDC8HRnVua/7OBmQ=;
        b=UcWOZmNBMB7JnbpXis559ZitkqmJniS+Xm8ASVz3uIPo+8rs0XfrktScM2M2kk9mvn
         NlpWyroXguQY8i4Yr039tQvvDnRjWZs9bxOqpHN6ZCXRV5SbdjBqMGMv6H41Swtlhxh/
         QT5Eie4LZedhlRPk9zElOSX0Fp1vbZwuhbAiNeO4BuSh7/IwkjMsM0CjSY3Ar7K15T8g
         rdyljkEjg0zvVsRl69w8LZ6WYQWHply8dSadfL33JYnFlBMiIUl0zNWjNmsfG5XtKvwL
         c14KQBNFK50FjIsfi+4nlafRO4aph8sqmFupjV1nB8vRcJnqLLkxhtAITZ1Q6sOdUIk9
         FXzw==
X-Gm-Message-State: AOJu0YxhSs0S31cnIxRgupd052xWAmvkkV8KRwkRqtCFfm3r2DKRQ+P3
	Sq1wISmfpu1o6bev7d41vN8aFKvap2R6d72Wn8+qTED9oYA9+S8fBGttaPOV
X-Google-Smtp-Source: AGHT+IE+GcZZtNy4wdu6byWxxp6BjQ5Z5OM0MuVVcKUKlDnNQSdZnijo3wvKfCa2SCIYBKD8UyQlag==
X-Received: by 2002:a05:600c:3146:b0:413:271d:8889 with SMTP id h6-20020a05600c314600b00413271d8889mr4722782wmo.11.1711318743534;
        Sun, 24 Mar 2024 15:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0041489d50c26sm743662wmq.27.2024.03.24.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:19:02 -0700 (PDT)
Message-Id: <202ed891463c134904b89a0d746d85bb62338d52.1711318739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 Mar 2024 22:18:57 +0000
Subject: [PATCH 2/4] doc: allow literal and emphasis format in doc vs help
 tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

As the new formatting of literal and placeholders is introduced,
the synopsis in the man pages can now hold additional markup with
respect to the command help.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 t/t0450-txt-doc-vs-help.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index cd3969e852b..e47599cbf26 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -59,7 +59,7 @@ txt_to_synopsis () {
 		-e '/^\[verse\]$/,/^$/ {
 			/^$/d;
 			/^\[verse\]$/d;
-
+			s/{empty}\|_\|`//g;
 			s/{litdd}/--/g;
 			s/'\''\(git[ a-z-]*\)'\''/\1/g;
 
-- 
gitgitgadget

