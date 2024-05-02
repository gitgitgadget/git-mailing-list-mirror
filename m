Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5217BA0
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678880; cv=none; b=RGCmeI9W25UVvoSmgQE9Jc27bbOyPmsrxPHLIZ/VOe3UwnHgS6OHiYfO0jEhrfznv3/3UQK8fYA39BzoXxguwtGC3PkJrEDnViwL5HNWqE8hB4Z02OUcld0p5ZQWArtAzDxXma+zMiQCFzYGZpEOuFzq3dwAAaiA1tgIFloVIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678880; c=relaxed/simple;
	bh=kPWZWHrWJeIfy/w4RFmod9jplc/tZ+Emui/avpXenSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F40HNfdB+ttrCidUN1iM0ZoMjHmLLb9aJUlp0p38ZTcOanZyS6VrfwXriyuSTC5nu3olOy4i713Yv6LVRdvDjeii+oM1ISGktjlevfTQgnQuJubTihkNAAtMaI5ieNR86qv76Iknz5ussMv7FC4BbUgvd9xViuuouLSGVG5tVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBEScHGr; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBEScHGr"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22fa7e4b0beso3491959fac.1
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678878; x=1715283678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDQ9+UkM02IRkgzYyXz6zpT1AsYfEg3PAFp5x/fCFqQ=;
        b=iBEScHGrPj5lYwoKnqKvzIL799iOYCvuXmuS+Gdlwpwaf5Kt8PqDlOyI2WyFApIBYr
         xh36I8COyd32/uZ1f0yq7VKsSj97Mh+wB1pqrFomKwUFooMQsnav8t+SVXJz0HQ6VP5d
         +BXUOkFZr20lTiGP2OWj61HvOXTvD1vFBrYojG5Puh91AZQi0F09mhJRKsJ/sk4sVPGs
         EyEGrhDryZyxS8vqmYivw7L7NyTClGpSP8EF8rTOUvJ1fr+rwMsbRBw2knPu3GvQYnze
         WWn5VAGNkgja54+1z/qCs23rpPWoGfTA+Zbo5Wy4foC1free0VRkcwDb3KXke77UuJTw
         ffVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678878; x=1715283678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDQ9+UkM02IRkgzYyXz6zpT1AsYfEg3PAFp5x/fCFqQ=;
        b=SzJBft5kOsZVvHVUkls86OoU+BpvTmJwX6pkPugpKznUCrxUf5bwg5NciBddWzGR0e
         ENj/c7q5pZbHKBnH48SU8S1EaWTWtx8y1DHSv9LhHxkYgTR+B84o1VbySRzHQTbPMRv2
         mRDVSgwpnPkUTBqWqUoZ8tbyibYXyAqeQi4sc3WRUp2DnbWJ2k+ZLBzKPtFXY1NWJ/5l
         ukqMNJYwJXWYDMYdFhXaf6CmfLGDUT9nJo/8neqCNZopynyttmKOa/anWPQxeUODtllq
         WmmfjQeFFHXoe0/76kFbLRCXBHfqkz0tPfnEJntn7Kijg3IOn5b7IY6/DphgjxK+/m4U
         12pA==
X-Gm-Message-State: AOJu0YxOVbIQvqw3lFcdUBcAVIVLt6NOB7mWwBoCEatwsFiCQiIJ1tCh
	bAMqL5wWSYZbiwUtTTGKl/u4H39+SFb84LE3bSnK6swaCdrjLvsCmG9O7w==
X-Google-Smtp-Source: AGHT+IFK3cEMgk0+WbkEBiddGVLUr6/6sJRTwjRsdkCGquD8xdkWFJcCi7atslDFf5V93+HeQcByww==
X-Received: by 2002:a05:6870:d60a:b0:22e:7b1b:32a3 with SMTP id a10-20020a056870d60a00b0022e7b1b32a3mr976119oaq.52.1714678878090;
        Thu, 02 May 2024 12:41:18 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id uj12-20020a0568714e4c00b002390714e903sm297443oab.3.2024.05.02.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:41:17 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/5] ci: pre-collapse GitLab CI sections
Date: Thu,  2 May 2024 14:38:35 -0500
Message-ID: <20240502193840.105355-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502193840.105355-1-jltobler@gmail.com>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sections of CI output defined by `begin_group()` and `end_group()` are
expanded in GitLab pipelines by default. This can make CI job output
rather noisy and harder to navigate. Update the behavior for GitLab
pipelines to now collapse sections by default.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 0a73fc7bd1..02e5e058dd 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -18,7 +18,7 @@ elif test true = "$GITLAB_CI"
 then
 	begin_group () {
 		need_to_end_group=t
-		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K$1\n"
+		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
 		trap "end_group '$1'" EXIT
 		set -x
 	}
-- 
2.45.0

