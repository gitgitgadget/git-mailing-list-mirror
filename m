Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D213FD86
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124136; cv=none; b=aNmx/cukItqRBFr42dYu724v81AeCSJ7qKRY07Xe5xyBuGIo+V9EWODjNKguUlc3e0RUZYCHpsploiMiw9VLTyDDsK4OaSO1bL2IhnoZ2h7ksqRkqBkr2WSoXLhIpc1C6ePJeP9z9q5f0DMEPAN9ES5vVLZP7frKmQXhV/olaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124136; c=relaxed/simple;
	bh=J8O9rrams01Csgw/7vq5iZTBem3U6Zt34kMbZrSDvlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQRVoVrwn8YAvbWaQ2oRPwCdXZZGZkOEIFWu0ef++fMxw2aKk8PeEoU9B2MlSTWgtFkL1GRaxM58qjrupjcbAWTB3+2AuB+hYKWr7fc9EWk+AO1g3qgLHNn/oZa939wEy7D101WID2PoygMQTdmQ5B4AR9LFyAh25Kq/fmn0rKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhrddxlW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhrddxlW"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f0c8448f99so7953488a12.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124132; x=1744728932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPYIUTzXbL7bnFS4trC/BMzpOR1dg3sH9m1g0Ym/Rl0=;
        b=bhrddxlWvy1/tu5TQYMYCfPlzRq0IgiMSuDkSUseR9FkepLE9owPZWiES2aFi7Nqoo
         Nl+r9hCr6zJPfCOfljp17oml5PcDB117O8Sbih2BLmhGcvNmWJFWzWM1X1qGNoamY8k8
         lW/Ikucz1X6SoeJ4m6K38DYNiRlUF58Y45Yx7Buusu/QckjCtcMdgKhEX/VVwovqGGdz
         wRMW1IVb/EivEmjeDApHINCUbGihMo1JUlx0M7+qboVt6wdd4T73iqiI8OQnQZz5hbly
         0I0GGTTi+pVGBg6rEEOYbAnTF/wvG63KT12ZyksRjJrD1sRNAuDl0UnNJ04LB1QgZURg
         4+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124132; x=1744728932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPYIUTzXbL7bnFS4trC/BMzpOR1dg3sH9m1g0Ym/Rl0=;
        b=DYfBXheFHVg7N/uCyxS1ThZSEW3TCKrEDtzQdszGI6WVazbcvAcVkIQHvQcxsK00S8
         M12uX3am/N5gPCM5gWYmcMg0efftYtcgBppb7hazRPsbPZ7y3SNqVKxXwVqI8w5MfrVL
         jqfqsQx/r4n+YKmOmWRQ16Gjq/Mf3ayX5O3Q2+6uDfaKbKWfzscC6zq9xuVGzGdl9G6C
         rf+Firt0a57wcOdwLSdVb3Z4Z5echr1zLUR2ILdVwx81CR7P68dskEHWWHl2FZZfYU8f
         fznj64jxi2iiXSXx7rvYNVvn4aJu5iezL5Pjag0ql+rxGTsguBJ1KyTCN0J636Ke9wyN
         o4Bg==
X-Gm-Message-State: AOJu0Yw654jc6S0OrFvGnmyIWu4QqE/ziIlOoTZUJNPwqRgH4okt5s/k
	wbYNehazHcGWB+mrkcMQuvh9beTxPpBfq/vlTw13AN266XRet3rjZTEPUGmW
X-Gm-Gg: ASbGncsXiDJ3heTCFFTNO1bJYlSaE4+ugyEJT5RxYyB722qm+R3m5smMi1JpkO8neE4
	vqUmZpsSh/74z9FbpDsl9FJd35b04fQpujQ4sQ2nZCer8uxhboOI26cEorN7AqY1YS1FNrfqZo6
	pzMebwSAjgCRMBQYUGg7CEcXDULperkRUggP7O+787f5lQcpKSUalRV5NYpHp+DIpPpB5rPQtrm
	Vx/V/0M0DLQrKpR+oKMCVvr+6XgVLTvRfQBPJEYq60WVcZ/Fxg+tKT2hEFmdKXExYAmkfusR0dl
	JXq5+zRi4pWVeSHAKAA2FQxT8twIHChX70VrX19U0gBc
X-Google-Smtp-Source: AGHT+IF7R+mRJ52m7EjIf/xo0uMk4ZpsDz2lbAUp9Wv5sTZ1Ky5eXYHWutgNK2q8pDOyIMwAv7YKBg==
X-Received: by 2002:a05:6402:13d4:b0:5de:aa54:dc30 with SMTP id 4fb4d7f45d1cf-5f0b3b659c0mr12059492a12.5.1744124132384;
        Tue, 08 Apr 2025 07:55:32 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087ed1c68sm7905678a12.17.2025.04.08.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:55:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Apr 2025 16:55:27 +0200
Subject: [PATCH 1/3] coccinelle: meson: rename variables to be more
 specific
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-505-wire-up-sparse-via-meson-v1-1-17476e5cea3f@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=J8O9rrams01Csgw/7vq5iZTBem3U6Zt34kMbZrSDvlE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf1OOIifZKhLpH5g1OS+oqnQz99S5M7ItT6h
 nDX5r/5axYnS4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn9TjiAAoJED7VnySO
 Rox/2lQL/3zNk57q09MiudMpOKuIEWkt6Qm8yKATeneAsnneBNUiP25kNfkUUFtb4Elc/fises4
 tHlxUMNomwEpfgtDQfymbviNfuEzaVCjwIA6VscbfY07uTUZuKAkpEkGnR1AXvhbesCJqH6Ym0y
 LLtZazo94ZijSmCCPV7EdurrF8T/KVHuDhQ52h8wCnEnMEnz+UVxdK/cp3Br5SAzfJX1dU9BeXp
 m3o13MOZ0L97eGGfIiTFf5dgpzv73Wyj9XMir4Ytyv2ByOVDL5wwEs6PGJvlFkyVZwd9+jmYwdW
 2cgHuE+sIgs4cMumtaJH/6QCHgimUQmAVP/IEZIDxdFRUq8EHUuvkFFaMKjlMwL2lPvgLoPD7ru
 bfp8eAM6MMCM5SpOTSWb6X9Ir+OQHeehhBJSXuAV3sMx5y4yfOeaydj8elvQotkaAvfKRlhyCI/
 w73QXZ2uBmDIkML8H6Pc6UC+936LUWgInhlzLC2kGmgbbqOfwNZGF6eLrQwyOfqZ9rbuEJ7qRS6
 iM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In meson, included subdirs export their variables to top level meson
builds. In 'contrib/coccinelle/meson.build', we define two such
variables `sources` and `headers`. While these variables are specific to
the checks in the 'contrib/coccinelle/' directory, they also pollute the
top level 'meson.build'.

Rename them to be more specific, this ensures that they aren't
mistakenly used in the upper levels and avoid variable name collisions.

While here, change the empty list denotation to be consistent with other
places.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index ea054c924f..03ce52d752 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -55,18 +55,18 @@ concatenated_rules = custom_target(
   capture: true,
 )
 
-sources = [ ]
+coccinelle_sources = []
 foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
-  sources += source
+  coccinelle_sources += source
 endforeach
 
-headers = [ ]
+coccinelle_headers = []
 foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
-  headers += meson.project_source_root() / header
+  coccinelle_headers += meson.project_source_root() / header
 endforeach
 
 patches = [ ]
-foreach source : sources
+foreach source : coccinelle_sources
   patches += custom_target(
     command: [
       spatch,
@@ -78,7 +78,7 @@ foreach source : sources
     input: meson.project_source_root() / source,
     output: source.underscorify() + '.patch',
     capture: true,
-    depend_files: headers,
+    depend_files: coccinelle_headers,
   )
 endforeach
 

-- 
2.48.1

