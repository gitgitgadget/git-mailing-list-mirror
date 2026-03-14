Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419235505F
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499116; cv=none; b=oPpxoRAik4E9BtL8Z30IfKHEi8JjPDWS2QArsA2FctOtKrYhNldb+tjAZVPQR3c7QrKaV5LCYgzfaOzWNP/5msL/DoJdsawi/u7EWL3ZXIigw/uD08CmJ8EOhs3qOCkN4IRCUTKH3zPekFg1arAe8ge6aC5UlTDC7kzDY7Yl2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499116; c=relaxed/simple;
	bh=zugSQ25P4ihQC4JLJ/vwVFvFfOVkiLeQlDpnnNdB+1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTa06rO81+WCKYOHGNfbW6gAZiM1JlrAQ62JHs48r9mV8vRUQCVPBggl3Ml3nDPVviE5+kGAjtEGf+eFtCJgyYBC58MlMtN7P1y0EshbqZuCD5WorE+vIQgJWQaNm+tjFhc+Tu2lB9Dw0OtxGPNFG5JYq4ozksXqOSKHpMNdjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBr/yQvK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBr/yQvK"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7986e538decso25725037b3.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773499113; x=1774103913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=065YaBVENc+3lL5r/+mRgihkDfustj0bbvAosgdomdw=;
        b=JBr/yQvKRaE4jgtCDxhDJS65AOosCcY2U/b07i7yZm7wf0mBkIQVW6/LtxqJkeCCfm
         GRxrsNZxHhKtxYXyRNLGloI2lZwcd5VU2AsE+ULZ0qRRp5nGaJquRR8Ky1XyI6On4PzY
         NO+srVDqE6QNp+F8IUX6/PaDayCcjQ6WQymBDIfUE/4JI7RCokBOoYpw7rC6lCjqpFhs
         RRwU7MNwN1x7wj/+qv3FQ6FAVLWx/2E9ok9jCUHhJA+l9Dn5iffq/XAtyMQQe/Sh+Bgv
         glT+/ADwS5qTZhvPm8OQpb5t13MHMu25t1UUv68L1yeyQPMLDulyXA/Esr94STnLPfQd
         MCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773499113; x=1774103913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=065YaBVENc+3lL5r/+mRgihkDfustj0bbvAosgdomdw=;
        b=nnCQggcAboxQX6xemHGz8ls/UD1f/A0WLA1AJnRaLjy6YhnMLvcrS6O2TUikU9C5lA
         XKhKE9v6UXkK40dYO9RI33vxp0/lrKDD9qy4XbdTmpCaoe7/+/tVVYsxXLkJQTEooR76
         Lv2uYlOnCN42fBXs0pPh4BV8XhpjHCv5YLD688OpkwqLmJs0v2UKezvmSZj/7lRR5yPg
         gEUSLWQx0XUcm07NgGASN+SfAAUQ4VYHTaUcr7Knt7AwvwAALUnsLJ9bi0/ffVP3RH48
         3QrBPwo2AzAlEfyjppcYH4XESoZqvKzQv+VzaSsFmxtrO5acRAVkNKltbK/fPf0uk/Al
         3RIw==
X-Forwarded-Encrypted: i=1; AJvYcCVpYB8n04xDUZQpdkkWGeHc5rQkzMyD5v26Sz4CqeWIgPY45HJ2/GLDzZ4W5bjWF2lGRqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOHjxp4KU/5vMnFL2KwDBGljAY20Eo2PMuJTeI2opKYhs8Z3V
	2gfQVDP2TeVHqTcyPKOJj37aCDqPMHkRSE0W7Y6jOQyCq42wcF+VFsX8
X-Gm-Gg: ATEYQzyX+xLxlLBgLyOEWSVSl5rntAFlerc2C5UTf5nocOkAOkzK+hYuY/JCDpSUnhP
	uZIraOmpmnLcWqZhjTDCTDWvxDghIbEuxSz9n2K04joRkBOC0Xs31fF1gpKW6mbh4uIRyx1sHEU
	MiZr09pOEzjTEosr6sey/rDdy1ZQ9bO/vZzjfXRWrD5Zz154rKGJQr38roxKWkVIVxNzMm9oih4
	wtTVLJA/Wmi3HJnFlbhgnfsKkzuLa4R8Nwsm+yb43W/BG4xpx2jUtHMGuxFXS0xEU9/HwI/5Hmp
	t5Bk4wlkuqruYH3p179kWtJSIXHigLxbN+A1ZVwJpUv1lwR5a4R8+Hl1UaS9WNQfCRVTTqPSrSX
	xppvbJ7/qrdsGTMGBH1KvFwMgXNBc2TDb5oKbBF6EZfQJ5/msOaYx4ckwaK0/j6OL17TvWOCFMY
	h+GWmyDc2q3MfqJ5aD31WJoHmzTAWAMgDZQdsdnLU6JP+JAmwOQ3Dh/fLU4HvF10cktWyFj6Kuc
	2bVGyE0Vn/i6phJknEW5bwzXmqkUQZORH2BJ//usN99FOY7uruJTrBPwN3BAh9ZSCcIcXH0UNX/
	/lSznEnSrss=
X-Received: by 2002:a05:690c:13:b0:798:6756:31cd with SMTP id 00721157ae682-79a1c1dd661mr76077667b3.53.1773499113231;
        Sat, 14 Mar 2026 07:38:33 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f0846csm65264207b3.39.2026.03.14.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 07:38:32 -0700 (PDT)
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
Subject: [PATCH v3 1/5] l10n: add .gitattributes to simplify location filtering
Date: Sat, 14 Mar 2026 22:38:10 +0800
Message-ID: <0c00f09918d94995b4f990679d598adcab0d6f2d.1773497547.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1773497547.git.worldhello.net@gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com> <cover.1773497547.git.worldhello.net@gmail.com>
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
- Files that are already location-less but whose formatting (e.g., line
  wrapping style) differs from the output of msgcat processing

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
index 0000000000..7b4c1cd9df
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
+# Do not apply these filters to all `*.po` files via a wildcard. For legacy,
+# unmaintained PO files, that would cause discrepancies between the filtered
+# blob in the index and the unfiltered file in the working tree.
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
index ec08aa24ad..e358371255 100644
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
+To save a location-less "po/XX.po" automatically in the repository,
+follow these steps:
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
+line numbers from location comments. To set this up, run the following command:
+
+```shell
+git config --global filter.gettext-no-file-no-location.clean \
+           "msgcat --no-location -"
+```
+
+Some languages use the "gettext-no-location" clean filter, which preserves
+filenames but not line numbers. For these, install gettext version 0.20 or
+higher and set up the driver as follows:
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

