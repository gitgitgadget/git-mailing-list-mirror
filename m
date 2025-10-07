Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE12DD5E2
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840245; cv=none; b=Hwx5PZwQRdApfkcS/EvMShuIpwGTopTGBa0rEuZVoBDqBi4bML8OXXLABcURFpBnVib0op+GFucX24me0xWQINf6iPgjg7SxSD7XX0qFudbynFK7T+E8epc5dhcXAOdsdlvTNH41z3hf0iS5mY60KSKYqr1JNCgAajZSwqGpp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840245; c=relaxed/simple;
	bh=XzQaCk5w5yOoObvTllXHgQk46dqHj/hoqEma6RU9EMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZP/0PuYwmyAGsWdjYbepcdc0pXghWYIg2WGMrGj3tSQYhzz1C2ThnS1CF7S9nHBZTAPLIEnfkpzsly9YbhXo3ZAuvNqJj3ouDdq1UpSrnUAm+J9ZJvb6J/BDSvrgWa+DUBHfPmbebw5Xx09QnY7bPrz2MeE4Znwawu3Xw7rm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2nWQIBW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2nWQIBW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so66961715e9.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759840242; x=1760445042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBSPgj0+PenjHJAMsDZNTHH6HgDap6qE8KFSmT3eZJ8=;
        b=K2nWQIBWF7ePfukXCH35rrDy/wYAQfTs4PsPMIVgQq562/T8zTaZ0Xy9qjmrAGTKMU
         oWJ0vxI2bVV32DqaB0/0HX0TLaN94FB2qa0kVRQDpZma/5RY/zrdILTKNXbj3T051esb
         UiBC2caV77+NFl5rTjD8x9xSd9RLZvyV7C6oJSA0UlallG0iouVgGYSljXWeeLBBOwmD
         Dvl6Qj/imF89i+ffLMMugtXZpXC4FJMyFqhppA2jN3rmuu6l1LwuLNaBPC4xF2l74xNJ
         pJbvPGHL0HMYJcaEScpioXm+Gb9FbOcyG6LxQz/QDPARSbzLrgxNkZPh+A04MMw7od/k
         BmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840242; x=1760445042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBSPgj0+PenjHJAMsDZNTHH6HgDap6qE8KFSmT3eZJ8=;
        b=czCn3XzxcmUR1U6SNfZJr+DfwxpoquLTWNQ3/ILsy/Ha+A/q+DCdLh/xLX/Yo3hay+
         2N9ttTbtvXa1LcyX4bQBw8wWcYQhvvCldIN76LL8fkiAwC78ms+RMDMo9pIevmvOFlE9
         06y5DwbyPGRqnX3S1hzDZtS1uj8A9vWPVxxqyZ/A8ZDK0P0JeEpERkE6IKKu4LtYl75t
         vNp8NqUCUDqR3JGuyh4AJXnXLlvl+4bZo0EIZP2G/6VZhdVTrH+xHr0AeUwgdm79sdHX
         ttDrOkSmWpXBpwuAhTsfY9pSAt90LdFIujJ+6RH68G/VxTA6Y6dn3wMg6ifPkuQDx4gn
         c9Ew==
X-Gm-Message-State: AOJu0YydLOBXHUm6lqdc+0tT0h0UZIOQnOlpLgA5XNGz0OEBBZriQaDT
	YVZ1FgmJLNydBMC6TF6q1kimxfeQw+rwFemWP2OzmjnbCQO5Tf3/VDa2FAGaXhaI
X-Gm-Gg: ASbGnctXgzBpccvftA1hEXZLIIFrOaPNCl0M0xv9jcL0cfY05NL55Vw4wDcWsGnEoFY
	A21TJDpSNHdkf3/++zozqnvzEdofp+wXUd6b0Yv78clK6aFSWbnzIE5ygo9TqJP7gxa3kMCZSdH
	4bKgtms0AMxPwi5ou8ZABefyUSeNhRew2WfEaQPehV0xD8SLEdDZ06g+l4m0DRBRQ0sbLSsesZ9
	XDpYi/3hLv190N5cvqz1V2XDDiLFuoi/eDQm2rUtLE9KoUflxT9tQmT2H6sWj/qNDmko/AH+i+4
	lmXVJOaHyucFy7CEtBTyD+gMefgxGgA7scPWOH7Rl9fAxRCrdo8zTFVseIcOc5eLQeELpd4JiJL
	9+vsmNjHvvbUPyYDDCw7SRUGwRBQZSdBGgHIXtdRbnwcA9G8KsuNgqY6CsOVRuyb1x8ndegWnLQ
	==
X-Google-Smtp-Source: AGHT+IHgBJlxoSwG9AdjDHD+LyEVYrxt9BJ6XYVvCYEIH8JmsXiZuWGD/tenu9OSCKt/2V60swTY2g==
X-Received: by 2002:a05:600c:4e92:b0:46e:448a:1235 with SMTP id 5b1f17b1804b1-46e7110f1bemr139865875e9.16.1759840241573;
        Tue, 07 Oct 2025 05:30:41 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm25476185f8f.43.2025.10.07.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:30:41 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
Date: Tue,  7 Oct 2025 14:29:55 +0200
Message-ID: <20251007122958.1089680-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251007122958.1089680-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the 'GPG' prereq is lazily tested, `mkdir "$GNUPGHOME"` could
fail if the "$GNUPGHOME" directory already exists. This can happen if
the 'GPGSM' prereq has been lazily tested before as it uses
`mkdir -p "$GNUPGHOME"`.

To allow the GPGSM prereq to appear before the GPG prereq in some
test scripts, let's use `mkdir -p "$GNUPGHOME"` when the 'GPG' prereq
is lazily tested too.

This will be useful in a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 937b876bd0..743985efab 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -38,7 +38,7 @@ test_lazy_prereq GPG '
 		# To export ownertrust:
 		#	gpg --homedir /tmp/gpghome --export-ownertrust \
 		#		> lib-gpg/ownertrust
-		mkdir "$GNUPGHOME" &&
+		mkdir -p "$GNUPGHOME" &&
 		chmod 0700 "$GNUPGHOME" &&
 		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
-- 
2.51.0.438.g6987fc0bae

