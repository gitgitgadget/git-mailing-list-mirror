Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB522155E
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024711; cv=none; b=IVmDCcp2uR2VjXqLWJksZ5P0ZwoAhjDRHLeQzw/ZhhMm8ESpSX9WEcnqtQWvForiytKBtxZ1sWHdJ3OfI7lsvIwxynlHNqKOuM1joCep8pTQ6WYdQC7TV/m4KGeOxGSgJbLFoJOxxEIN+6PEJ4cjO/iwgDz1W+ILGrn4KHz1abA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024711; c=relaxed/simple;
	bh=tVry4L9yPp7bODhkjKO4TkXooQufXI3cLxITL1kzUyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozLIb7PbzDlV4G9U4thgMGzoBjlAXbcjtSEZAKXthDigPBuv++P1IaOWGLO9XMxzXsqbs9vDAWbtMaAu0DYNU9WASvv+zXQRGTVYNs89RiRJcDAhy4WtVPV1pozwnAOhGjvGmgFFJjIWgLBfEFJFq2BZUSiKQHNdw9P7Be58qaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJzNbeKb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJzNbeKb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so8548238a12.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024708; x=1744629508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/g/CN4HEDyqKDNku42MXa0gdCaMuoSoxQB2+I25V2o=;
        b=iJzNbeKbsXsK21hV6GXnQlOQMA3FvvYA0asZaLhHfjAvbw/QCMVff6oMY4GH2DjzQY
         nBtI0ets2s1Fth5Di4ezfuQjJXHwpFFZrhXKWZrqwn5sPq6KZI/GKcR4RaqhVTDK1gpm
         GbMycYKuqxTjpeCWSjXKuopsASMEPLgyDPDmgLRim/XV+bTV/G+g0SxBu81m73AULfxn
         dr6nj48skN5syaCju+4IHHIHqcLItAYvzSJ5F3HZKw8mcnoZk35kLoZCcycE7ShgLRRQ
         znfxlf5RwVntlcP/Qo0QcX1iPPVAqQOVD+BQwcPqbvJdcqeFk6EzWR22q6a6tukOKAFR
         vNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024708; x=1744629508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/g/CN4HEDyqKDNku42MXa0gdCaMuoSoxQB2+I25V2o=;
        b=JvAaD0oPIOU85zL/d2rZ+yUzp2aTkx8BLr/8tqQXq2Uhu8q1Wr6ZFY+uyk0xfNgoLq
         SIH8GCDf5zgmpAi2SzuDBxiH6gYJju4cJEiC7oDa1viShi+AgZ2Inclb/X+l7iApt12D
         4b0RkrWY57pWYJHl6K//+rb5P16pj81GxR/LCyr3izBEpw2lbw4cWPrr8qZXW7f9b4VC
         7uBUrBMCMxKnt61oWwyCJDPSU2BTc0d9buGomuxHqytjJmo05fieHCWJNxKkg3rDysl+
         zmBlH8OwfYFvKTKJj/LXiutUixa30BuY9MTmD+t4SkPv1AydE5yyCBH0kEPQege9L1m4
         1sEg==
X-Gm-Message-State: AOJu0Yx/tQ77A6rKok12QGCKfCLImVmTK4d6JaIO4+eRuQaW0C1VxXV0
	b2eOt0uZWrvrt4PLSMXl9X4jfU+/aTiJEpGxaZg+Kq4skcidqlk=
X-Gm-Gg: ASbGnctptckMkdMeYNl2pPOgyy5FKPaOa9RZqO1qQiDNXf7nvfk3DREKzAse54oDM7r
	yAtV8hYDViKMLaJPn5VU1auedkHTHIZDJjTnr7sU/+5kItNPF/sg+GoEab7lDOGvZpWrbH2eKnW
	R4R6Lo0V0Ka5qrTpDeTYlRGrPSUqX6k6xRGbDK3/bcffigX9IR8FaWBkOOlUPiqE+HLFITBHHCK
	2F9+aJseovDAs1Y0hy0M4zfoYRMHA2TU14ZP7ZvHbtjUGPco7SCNKFbx5qHaYjbOHrX7ypy1Z+F
	U1lD+uEac+Fhl9MWPlSUDHRGkrkJrk9MvDNIBOW6TM9wNl3M7HfX4NCCkoK5mI55jRK/Cak5HE1
	XK5xt7XIlJOhhX5NItpBJRENGZiiHAJk7HNcNWaCodJja/eLj6nbZ47SOjMBAJdRDjOODcLR9lK
	z4l9oj8gUG/ewMjBaiKt19Jqw=
X-Google-Smtp-Source: AGHT+IEKzDZoF048LXonSTLuDabidTvsSU7g7S77zcJsDse4ZLD+Meqj8etljcAKeM0oNzAZ09orGw==
X-Received: by 2002:a05:6402:1d55:b0:5ec:cc79:84f5 with SMTP id 4fb4d7f45d1cf-5f0db80c09dmr6349690a12.7.1744024708108;
        Mon, 07 Apr 2025 04:18:28 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084f17sm6613826a12.61.2025.04.07.04.18.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 04:18:27 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v2 0/3] t9811: Improve test coverage and clarity
Date: Mon,  7 Apr 2025 13:18:21 +0200
Message-Id: <20250407111824.46518-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z_OEAxJENE_mGkVa@pks.im>
References: <Z_OEAxJENE_mGkVa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to expose more testing outputs, we remove the piping of `git tag` 
outputs in order to expose the exit codes. In addition, we remove `-q` 
tags on instances of `grep` to ensure clarity. We also replace `grep` 
with `test_grep` to provide helpful debug output in case of test failure.

changes in v2:
--------------

- patch #2 and #3 have been added to reduce confusion caused by the 
  implications of `grep` followed by `grep -q`, and increase debug 
  output.
  

 t/t9811-git-p4-label-import.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)

