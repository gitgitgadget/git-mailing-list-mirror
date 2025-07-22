Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66F280338
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208130; cv=none; b=qfNTBu4Ayr+UTsNgXW2DQNwZl3A++AiE6IPKn7SguC9nWX+yehncrc4KIX5CklA83d1y/I1zF+5i8S+BZM75MxAvodp6L9Hl0gu9Uu+gNzN0WBI+zaBE+203+nYHG7s4gKVTWw2FIjv3uhzirgX83bqdEGgLg3IZcKANiNxOd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208130; c=relaxed/simple;
	bh=m47H/UPEOtFTrxp+1M2jWy955TWLIyvr6ojJ0QlVkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehjzHPRDOpct5H6tpar+FpMGp+k1CfupTOoesnvyIsB5/QP3UEuMujnYI3FAipMPmZh8ZhIWh1TfrlJ4WOZmnLwAU5CxRYBKQTrpl3s/SdlQuOL3J9KXYVbPxoEUGLof0LNRmcmFzg3qoVFs+imVG19NUHbw5QJrSBAF1x/x96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTnFGy5K; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTnFGy5K"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-41cbc8da42aso3199600b6e.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753208128; x=1753812928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtbLMijDgxKErVJV+YW+SkeiYl7BHEDzYNVhsNnwJqQ=;
        b=MTnFGy5KHJzOBS2GwSGsA3sa9RdncSwwpx31LJsftmFzBWDQN7JaJqHPiVg5bydx25
         DHya5uxYsYomPTCWhLZvHrvgx3+DJm7kTRczmob7gXE+MQBNB8etj8qu0IVgb4bbZ5gN
         urUMaYS1BudkmZS+IT730YwbE9nbJkyHCfxxReZ95dTEZSgyycB0rsgtfqGf0iGo/laC
         HDx0vDdKpj3npIQz60z+kWQAjPz/lzEq2tLsMV4HhAXjv5GZl5GQhVviC0+/YXHAd9UL
         WuZYqJLHMF+7szm6VnRxTt4PASENnHV1Wrv90i1FJKdGEqnnkBPldGoO9QvgG+n6ScIy
         MS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208128; x=1753812928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtbLMijDgxKErVJV+YW+SkeiYl7BHEDzYNVhsNnwJqQ=;
        b=DVYtvcOA4iJdCY0QkJrsAuGAYma25r/1gA69tJzE0vaWShjrhM0NuK2VHC57JSzT4T
         7U5iNt1Zs0digqt6WE7qWN+vnCAVvTesDrcZhF8gHWgc54OO0e2NCIO3sGlHsJFbxaP4
         UoqPL9rgx/SaQaZW40Ve+qVv7s3lmi7jwsNrZg3Wm3rK7UO6oR8jVguEjEuHnD1xcfRa
         G6k13Vw2XSLZgtjSC7mHx+phLkh7PyaDMyzVbIEfkyT3p85lJvq0j3FEUHEwDS9Fn0er
         Rtd1Gdg4+sU0oxd5mQ5+NEL2eoM995TSnLAuLhACD0BKUNnNYSxZ/juqVGFZhySoKluZ
         Tl8g==
X-Gm-Message-State: AOJu0Ywy4SOSOJsGqKCHat5i72gAIzTon7buytydKOKMqkfs2CRjziyz
	zrQldh5kn46nPvUdAhDAuKwZweouOyPxxXEViHhGCSxTO8AgFRgqz7U/Rjy1Kw==
X-Gm-Gg: ASbGnctghE8dgpGlRumG7HipZRyxYL1uC1DvK7Bpqdw3+qV7UT0xen5mamn7w/xVhuV
	g93WAU0/YiAh76CY4DYLgO8l3wRNlo+37naMu1MUqx0/6P9rP8ruCu8/6cXHyXamF++5MDAe40D
	TkpMAr38xxsjmv9jUI41ExDadWY0kZtWiMBjpeHZEqkT3o6o6iVZ9Tcksg/rvHcRdvqqU/+X76K
	eYO6vNWr5nT1enxf7dxZ4NbwHLZtweNUDzJOjPPIfcX0URCocg4BNxPSzGH0IWGoEHasgcj5to4
	UYbsnbVTUhKme7JtGy4ZjXlHCtQHQ4OrJB3IE3H92kvNrC2wbQYtJhHMBTpGthYU2pSnfWB+WWQ
	KfDhH723InqVOCMTVBVTHMe5md6oTGg==
X-Google-Smtp-Source: AGHT+IHCCJeF3aK1qWcMi4Pa+1i13BxulrhbY2M3yvwo9qcpqJ7Tz89+0KO1xcQhbII3X8GpU2OmtQ==
X-Received: by 2002:a05:6808:218d:b0:40a:561a:9e8c with SMTP id 5614622812f47-426c4dca7d3mr267442b6e.3.1753208127826;
        Tue, 22 Jul 2025 11:15:27 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd498c218sm2914153b6e.29.2025.07.22.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:15:27 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] builtin: unmark git-switch and git-restore as experimental
Date: Tue, 22 Jul 2025 13:08:18 -0500
Message-ID: <20250722180818.1043014-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.50.1.214.ga30f80fde9
In-Reply-To: <20250722180818.1043014-1-jltobler@gmail.com>
References: <20250722180818.1043014-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 4e43b7ff (Declare both git-switch and git-restore experimental,
2019-04-25), the newly introduced git-switch(1) and git-restore(1)
commands were marked as experimental. This was done to provide time to
make breaking changes to the interface. It has now been over six years
since these commands were implemented and there has not been much change
that would warrant these commands remaining experimental.

A previous series[1] from about a year ago, also proposed removing the
experimental marker for these commands. One point of hesitation
pertained to an unaddressed suggestion[2] to change the `-c` and `-m`
short flags in git-switch(1) to allow them to be used for different
operations that may be a better fit. In the preceding patch, the `-m`
short flag is dropped following this suggestion. For the `-c` short flag
though, the operation to create a new branch is common enough to warrant
a short flag. Given how common this option is, changing it would be
disruptive to users and, absent a substantially better choice, is
difficult to justify changing.

Outside of these suggested option changes, there does not appear to be
any other discussion that would warrant breaking changes to these
commands. This likely signals that the foundations of these commands are
in a decent state. Furthermore, by removing the experimental marker, the
stability and maturity of these commands is clarified making it easier
for users to adopt and recommend.

Update the documentation for git-switch(1) and git-restore(1) to remove
the experimental label.

[1]: https://lore.kernel.org/git/20240220092957.1296283-2-matttbe@kernel.org/
[2]: https://lore.kernel.org/git/877dkdwgfe.fsf@evledraar.gmail.com/

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-restore.adoc | 2 --
 Documentation/git-switch.adoc  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
index 96de9bb5ed7..903e8c4618a 100644
--- a/Documentation/git-restore.adoc
+++ b/Documentation/git-restore.adoc
@@ -28,8 +28,6 @@ otherwise from the index. Use `--source` to restore from a different commit.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
-THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
-
 OPTIONS
 -------
 `-s <tree>`::
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 7b24450f841..1d46010292d 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -29,8 +29,6 @@ Switching branches does not require a clean index and working tree
 however if the operation leads to loss of local changes, unless told
 otherwise with `--discard-changes` or `--merge`.
 
-THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
-
 OPTIONS
 -------
 _<branch>_::
-- 
2.50.1.214.ga30f80fde9

