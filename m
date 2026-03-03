Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB3390991
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552036; cv=none; b=gd5YbBKHEAm60f5+AQhZPbbrjnURn0TVQb08bb3aI0b+BowS03bqGUFG4JGoBwYKqFj/PybxcpBkakPAD9t6PcYY1zWuatmAsYczkl2BSrxKm1KIrNtzHOkNG5X+qR3U1vUIxuxksmkB8s0cvmW390+tSySjLPlYTF9Dv1ltCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552036; c=relaxed/simple;
	bh=71Rdse0Qp1mtEj9fdRfkw1pwianMxqEnxSXufkef2Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHhqBOQ7mqihZGPA6T8N2H8SHfKn0fPdjMIgWCKekw5Fm+GrKOFXsWZM41hq3F8x7qCGa1Upjn1PBzx6v2Q+DaUDT3wdXxui5Ql8KV49Wx/xKxs3Ent5CVvYIhl4aROizLUFLLo1agfAgQTL1ODjg8IzbdJF1XnbM4zYy+r28cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd/htmN7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd/htmN7"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79868cde1eeso62476617b3.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 07:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772552034; x=1773156834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odbywylCmgjISVRRR32g7Kj32ZYpP1PVQBNt+bMjzUs=;
        b=Qd/htmN7eepbO5xXLu1Mlgs0afdISCxcjmnnuYt/OIMhR29/Q2ScQtCXVpYoWoLjX1
         Qdq7SocifFeYl4sOh+p9sGiGhV6kcLA+DVBGrUv/y7Gd+ttw/2FOQ7ZjVJlVPsd5M1YC
         cKjX2qWxR6XxsWPGcBXtBpB4c7KtfeBl5a/Jy1muzWw7NNWZSc7gz2o0tVpDFfI4dBEZ
         E3LF7zMAtrjPa1r3YV3O5OKGNYryPAUZA6BfFnq3mqjCfscvOiMtiEmVmDH+TBNhA6TR
         c2Jg3e5F+7l972xXl5H/8F1lTV0bGqFbpi9ewF8yzrcOTRJ0+5KsN/kqUylYg2WzSV1x
         iv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552034; x=1773156834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=odbywylCmgjISVRRR32g7Kj32ZYpP1PVQBNt+bMjzUs=;
        b=FvR5CazO4lw55zHa44tr/e6RkAHc19hBlHeWqtanqsgawb5Kzw+cJ4k61MtePigDTN
         N4rt1ZYW4dUiGY1G6SEhwggMqOD4W5F9zz7gI/2VcR0qT4Dr1P9uycL9sB5WDAw/h0Ad
         Z4eAF9nh014jWAxBb0MLxOUSXaBvtAx1o/uWjqq3lf1zIgAwEJhUZtF4p7J798BaBIJ7
         j/hrWYjL132UeGnZIW/RCSaVvzEZRwjY/THxq62mCj+3F7tyINAIGqEmicFdTVfSAE9x
         XeaUH71ilXf0U58wYfdUYMaN7qYiykLLY6ixDfNSUKG/0C0v857eoZacXldVLmrtxD27
         ac/A==
X-Forwarded-Encrypted: i=1; AJvYcCXfWMpKaLYuUiKmQtAm8VbbeFUTVDFnz5+cNGXn6rJzHkeHkOisCGfHReCQD+2+Php7fyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzDfVv6Bj/bZuXTbVGGcZ9dhph05XVknXyMINZB5mdWMbi5bj
	r7sMup5tuv3m4a+Wk4oLLU1SlK+BnP1VGUXYIs2szJg2c730BeYrUtIjcAz7N0Fp
X-Gm-Gg: ATEYQzzH7xtRG8LPm2XTpU3XbjxoVwFKlhKepPfEnX4kHo78UlGpNWHBvloj6NACQQR
	sbCfCjgvK9JkIi9+FtSJEuNt4/E0/PgPN6m7AsbkeyHKpyftN0WdwEVCy2oVf7Bsi3cocpg7Gjo
	M5r6Q5cz/rElAcVJzqfxlNWlS83oINxiFuz9dA/9JTK6amosT8fWHxUNDV05fF5+WZi/8poDTLb
	AIAgj3lNzZ+eZ5PEDj2D7cdvzGvh7CxG6ft7edFkK+JgzwF8BQs2m8iTvYs1ecRPFZDJU9F6p+B
	52y3Tr48/UdIAAxJHgiKF/b7dvgi5DlWOZJgwgq4R0m2i4sGyabBhjRRKM6PoKmoCJeMba9b8VH
	QM8p+muiW8UvWTfx+dCqpEmGDFs9BkL28/nU4/9+j1CSb0laKTR19PC7wkc4tJgTwnKknVfhOsB
	HCNt4HVGbENkmUEPVLIm4BcCLusAGJMHkpL/UCMbJThz2CiAE+7YlF1tx25MllTVJAukvTQvjwa
	iampw2pVkterNSXSn31nmlIhuqvNdEFK48NZ++dQsOwdAtMBi3HsFbNO1MdCGHtzKYeZUXsElsm
	XvvTFIbZmAk=
X-Received: by 2002:a05:690c:93:b0:798:6619:f1b7 with SMTP id 00721157ae682-79885475afbmr145315147b3.8.1772552034385;
        Tue, 03 Mar 2026 07:33:54 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8feacsm64364057b3.11.2026.03.03.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:53 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v2 1/5] l10n: add .gitattributes to simplify location filtering
Date: Tue,  3 Mar 2026 23:33:28 +0800
Message-ID: <ed04d37535991a1b0e27dc5bc20ec29942e8299e.1772551123.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1772551123.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1772551123.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To simplify the location filtering process for l10n contributors when
committing po/XX.po files, add the filter attributes for selected PO
files to the repository. This ensures all contributors automatically
get the same filter configuration without manual setup in
.git/info/attributes.

The filter attribute is only applied to specific PO files that have
been properly prepared. Files without the filter attribute fall into
two categories:

- Legacy files that lack maintenance and still contain location
  comments that have not been cleaned up
- Files whose formatting (such as line wrapping) differs from the
  output of msgcat processing

To avoid discrepancies between the filtered blob in the index and the
unfiltered working tree for these files, the filter attribute is not
applied to them.

Contributors still need to manually define the filter drivers using
git-config as documented in po/README.md.

Additionally, po/README.md has been reorganized: the content of handling
location-less PO file content has been moved from the "Updating a XX.po
file" section to a separate "Preparing a XX.po file for commit" section.
This prevents AI agents from introducing unrelated operations when
updating PO files.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/.gitattributes | 36 ++++++++++++++++++++++++
 po/README.md      | 70 +++++++++++++++++++++++++----------------------
 2 files changed, 74 insertions(+), 32 deletions(-)
 create mode 100644 po/.gitattributes

diff --git a/po/.gitattributes b/po/.gitattributes
new file mode 100644
index 0000000000..7100b7050e
--- /dev/null
+++ b/po/.gitattributes
@@ -0,0 +1,36 @@
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
+# Do not configure default attributes for `*.po` files, as this would cause
+# differences between the filtered blob stored in the index and the unfiltered
+# working tree version for legacy, unmaintained PO files.
+
+# Languages that strip both filenames and line numbers
+bg.po	filter=gettext-no-file-no-location
+de.po	filter=gettext-no-file-no-location
+#es.po	filter=gettext-no-file-no-location
+fr.po	filter=gettext-no-file-no-location
+#ga.po	filter=gettext-no-file-no-location
+#ru.po	filter=gettext-no-file-no-location
+sv.po	filter=gettext-no-file-no-location
+tr.po	filter=gettext-no-file-no-location
+uk.po	filter=gettext-no-file-no-location
+vi.po	filter=gettext-no-file-no-location
+
+# Languages that preserve filenames but strip line numbers
+#ca.po	filter=gettext-no-location
+id.po	filter=gettext-no-location
+zh_CN.po	filter=gettext-no-location
+zh_TW.po	filter=gettext-no-location
diff --git a/po/README.md b/po/README.md
index ec08aa24ad..79757d4c21 100644
--- a/po/README.md
+++ b/po/README.md
@@ -159,38 +159,6 @@ It will:
   and these location lines will help translation tools to locate
   translation context easily.
 
-Once you are done testing the translation (see below), it's better
-to commit a location-less "po/XX.po" file to save repository space
-and make a user-friendly patch for review.
-
-To save a location-less "po/XX.po" automatically in repository, you
-can:
-
-First define a new attribute for "po/XX.po" by appending the following
-line in ".git/info/attributes":
-
-```
-/po/XX.po filter=gettext-no-location
-```
-
-Then define the driver for the "gettext-no-location" clean filter to
-strip out both filenames and locations from the contents as follows:
-
-```shell
-git config --global filter.gettext-no-location.clean \
-           "msgcat --no-location -"
-```
-
-For users who have gettext version 0.20 or higher, it is also possible
-to define a clean filter to preserve filenames but not locations:
-
-```shell
-git config --global filter.gettext-no-location.clean \
-           "msgcat --add-location=file -"
-```
-
-You're now ready to ask the l10n coordinator to pull from you.
-
 
 ## Fuzzy translation
 
@@ -229,6 +197,44 @@ git-po-helper check-commits <rev-list-opts>
 ```
 
 
+## Preparing a "XX.po" file for commit
+
+Once you are done testing the translation, it's better to commit a
+location-less "po/XX.po" file to save repository space and make a
+user-friendly patch for review.
+
+To save a location-less "po/XX.po" automatically in repository, you
+can:
+
+First, check which filter is configured for your "po/XX.po" file:
+
+```
+git check-attr filter po/XX.po
+```
+
+The filter configuration is defined in the "po/.gitattributes" file.
+
+Then define the driver for the filter. Most languages use the
+"gettext-no-file-no-location" clean filter, which strips out both filenames and
+locations from the comments. To set this up, run the following command:
+
+```shell
+git config --global filter.gettext-no-file-no-location.clean \
+           "msgcat --no-location -"
+```
+
+Some languages use the "gettext-no-location" clean filter, which preserves
+filenames but not locations. For these, install gettext version 0.20 or higher
+and setup the driver as below:
+
+```shell
+git config --global filter.gettext-no-location.clean \
+           "msgcat --add-location=file -"
+```
+
+You're now ready to ask the l10n coordinator to pull from you.
+
+
 ## Marking strings for translation
 
 (This is done by the core developers).
-- 
2.53.0.rc2.20.g532543fa46

