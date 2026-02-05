Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4D3AA1B8
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296438; cv=none; b=r9Lh5I5jMw+YIhwM6VzheiKYmy5/+SuJufH0MsINQJb3vcjulRhZx2JSOhnDaI2+vzqs2T1svkYOVa2OW7AishmAgb2s4zZVHkwbBonfTjbFgHqmFX+d2JZFPC6gezH7QDYXMBq7TRyJ5g73pcrvn844cwLQ0LF6Eb5dr9jx3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296438; c=relaxed/simple;
	bh=VZ7q15GHaCAT9fHh4bfx+AKEjQqQ0eNlV1l8RK5CRGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwOJz18faNz2mhgyfXs6P4JvHsTzknMI7UxBtkD5EK02oOiKtuA7cpI6fz2tDLNTZbl0nW5CkLY3w4vOMFaBEVYUu2x3NL0hr0mUSsL5oEUD8BTgS7vgxeGD8yMBKv2i/3dNOTtfh4EBQpt3TqW0QraYNE2fkY8M9KMaH7d6t9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEcBBwuR; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEcBBwuR"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649f0025965so63049d50.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296437; x=1770901237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWc0s3WtCkayp3K09+GIEqI39qlKZJ0QRiI5sukKRQI=;
        b=KEcBBwuRrZQb+AeghqkbAw9l0Ay8QY0zwQjylG6kgT5ZvFN3Sp5QtZTLIZN2Ft0COr
         WR+cLJnh0F68lig9ISIKvYoevXevcnjCgMXCZOB+WO6Zm7TeATZwEH+GlISXM65ttQNH
         7YPdE/dAcM0zGSg8pP5o40Ip/rvvuqnynQLnlis8CyiBa44OMWa6/NhHCzUtb7yv0KKX
         A9i55TCy07GxQCO1q1CT88wgLnEypHpe151PL1f/2rmFBaHbITeqIbJZB/BFdu1M9ZDV
         cy/8r4wY4R5aZBNmDdiI3m1LvTj8cVcvSNuMOwyQpmVHMaCQyo2JZJ+S6FIT01pKT0+N
         /gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296437; x=1770901237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JWc0s3WtCkayp3K09+GIEqI39qlKZJ0QRiI5sukKRQI=;
        b=NOlZuV1a9HXappvk6jO7nalCDD+hz99Fr2UfwCU0/d45DYbx1vCaW09qytxCb6ta4j
         4NGGIgh8RN5/gqZ5vdW87wdMqIhg6qihGSAGWmVxxv8Sl5qAT94gLS7UhxnXYxbqVKNF
         4dU8jkUMr5XNwMgOUKU7MOl0Eiznt3xRG0Dcpd3ReGcMLEWLF0QYbf2dvls4xUN22Yv5
         jsh9Cv2doOB/WOLczsxRB+hozL/oceXHxWKRNlmwbAnAhNuMk8weeEqg5phPFO2JyFEe
         Cf09PO+ZAbC5EQWVNX6vMDbwoLK2/br4voIgMjdhtDj3WoRY/IzdaD9laQ6gh5WsCN+a
         qHYg==
X-Gm-Message-State: AOJu0YzFViuaOzcdKuFAqcIS+QbmCz2f7B/AbWA1cnpWvv/nm7Wp2Ia/
	J0C3sz42H4+TsNlubGG+LHf1vN670QyDZCGuDcVAcH73gl3R5c7uz4O8Aj5/cBIB
X-Gm-Gg: AZuq6aKWUVWEsriob9ayKDKKwoJ7bwNXNlWtNtgb41cCz5pS3WvUk3EG+NCHe4p/8h7
	n1hXUpzYqaVYt+4TwUe9LZlKiXCEaPfhxWFd2vAkRGz9Zt6JR5tjBA0jCKMw6Iuq0xUaiENu10H
	eJaBqJU7eRw+23MTCxUVunNBIdaWtRsxGyTPW1wh0y/lmkjzCLsGdoWrxFYJiHge/R5F15LA2VU
	9X8WqpIVqgGaPKVIRyBW8vPXE9tuPeg1ZhoOpyB7rKqYHq0uFOjs58stFz8cWU4W1vd2ts2nenR
	/u+Vpde/k/kU2MYWuVbZ2KTgdvxZh6ahxpzrdFhI9vCFCDaoiSA0FVPGNqvXsUeRwBePC5/EnmE
	mhCE4M3OSmcklYNAnA6mhpHYfmRW0m6pqXVc+QlnSW4t5BcGDnV7vrU0vh9DbEukDz/Tc6s8faR
	mdApD7QFWPy0vCujfKbKNYd8IoMS/pytqX2Wzui++lHL6WhpwvezEsRTuBuveEby1CLGc+e4R69
	nXJQsmp8N5MVRb7jyykS0snd0BMJq5ecQo9vp7jhUp0uZzhbPQLfJUVlICtlYckCH3bx0CnR/0=
X-Received: by 2002:a05:690e:b8b:b0:641:f5bc:68de with SMTP id 956f58d0204a3-649db4bafcfmr5084799d50.75.1770296436516;
        Thu, 05 Feb 2026 05:00:36 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc49692bsm5263152d50.5.2026.02.05.05.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:00:36 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC PATCH 1/2] l10n: add .gitattributes to simplify location filtering
Date: Thu,  5 Feb 2026 21:00:27 +0800
Message-ID: <00d6cbf44f88fbd402375a2d41d7f9059d339e5d.1770296405.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simplify the location filtering process for l10n contributors when
committing po/XX.po files, add the filter attributes for .po files to
the repository. This ensures all contributors automatically get the
same filter configuration without manual setup in .git/info/attributes.

Contributors still need to manually define the filter drivers using
git-config as documented in po/README.md.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/.gitattributes | 37 +++++++++++++++++++++++++++++++++++++
 po/README.md      | 19 +++++++++++--------
 2 files changed, 48 insertions(+), 8 deletions(-)
 create mode 100644 po/.gitattributes

diff --git a/po/.gitattributes b/po/.gitattributes
new file mode 100644
index 0000000000..1a83c8027c
--- /dev/null
+++ b/po/.gitattributes
@@ -0,0 +1,37 @@
+# Git Attributes for PO Files
+#
+# This file configures Git filters to automatically strip location information
+# from PO files when committing, producing cleaner diffs and saving repository
+# space.
+#
+# Two filter types are used:
+# 1. gettext-no-file-no-location: Strips both filenames and line numbers
+#    (e.g., removes "#: main.c:123" entirely)
+# 2. gettext-no-location: Preserves filenames but removes line numbers, which
+#    requires gettext 0.20 or higher
+#    (e.g., "#: main.c:123" becomes "#: main.c")
+#
+# See `po/README.md` for instructions on setting up the required filter drivers.
+
+# Default: Strip both filenames and locations for all .po files
+*.po	filter=gettext-no-file-no-location
+
+# Explicitly documented languages using the default filter
+# (These inherit the *.po rule above but are listed here for documentation)
+bg.po	filter=gettext-no-file-no-location
+de.po	filter=gettext-no-file-no-location
+es.po	filter=gettext-no-file-no-location
+fr.po	filter=gettext-no-file-no-location
+ga.po	filter=gettext-no-file-no-location
+ru.po	filter=gettext-no-file-no-location
+sv.po	filter=gettext-no-file-no-location
+tr.po	filter=gettext-no-file-no-location
+uk.po	filter=gettext-no-file-no-location
+vi.po	filter=gettext-no-file-no-location
+
+# Languages that preserve filenames but strip line numbers
+# (These override the *.po rule above with a different filter)
+ca.po	filter=gettext-no-location
+id.po	filter=gettext-no-location
+zh_CN.po	filter=gettext-no-location
+zh_TW.po	filter=gettext-no-location
diff --git a/po/README.md b/po/README.md
index ec08aa24ad..ad7f72ba83 100644
--- a/po/README.md
+++ b/po/README.md
@@ -166,23 +166,26 @@ and make a user-friendly patch for review.
 To save a location-less "po/XX.po" automatically in repository, you
 can:
 
-First define a new attribute for "po/XX.po" by appending the following
-line in ".git/info/attributes":
+First, check which filter is configured for your "po/XX.po" file:
 
 ```
-/po/XX.po filter=gettext-no-location
+git check-attr filter po/XX.po
 ```
 
-Then define the driver for the "gettext-no-location" clean filter to
-strip out both filenames and locations from the contents as follows:
+The filter configuration is defined in the "po/.gitattributes" file.
+
+Then define the driver for the filter. Most languages use the
+"gettext-no-file-no-location" clean filter, which strips out both filenames and
+locations from the comments. To set this up, run the following command:
 
 ```shell
-git config --global filter.gettext-no-location.clean \
+git config --global filter.gettext-no-file-no-location.clean \
            "msgcat --no-location -"
 ```
 
-For users who have gettext version 0.20 or higher, it is also possible
-to define a clean filter to preserve filenames but not locations:
+Some languages use the "gettext-no-location" clean filter, which preserves
+filenames but not locations. For these, install gettext version 0.20 or higher
+and setup the driver as below:
 
 ```shell
 git config --global filter.gettext-no-location.clean \
-- 
2.51.0.rc2

