Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FA3F485E
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841575; cv=none; b=CHA1xDH2rW7d5asG6B5ZonCDnuaL69bNAE9Oyk83WCNoP21xNd07WIFEgovoRFLzhMTe7vafE6TAF8M7aAg852EpRajUGZwpfTnRbuSDCW7joHMUMRxM6bg5VmIoyPiRna7+ZuAffkzKLYud51DjKRtN2mC6LNmHp7/VyhkfgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841575; c=relaxed/simple;
	bh=TjmJ4GPoG/xrIih1ZMRdzfP939QYvZkORr3xGoE1hD4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=BMcNx/EXmj3kd1tktguJEA+ydUWROw+KETyWAo12a8Vpy/tTqd7e/+veIWTMF+h/rMLULdgbb36MtudYgrhySNGw44AL25hzpMiqPMJBZO9A+NlIfMGOXQhrqDkLvc7b+hyqTpol6A3du+soREvKiRnKj9lsjAX0q7y9nER8nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwzSuFB+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwzSuFB+"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso379779a34.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784841573; x=1785446373; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H9tHt8Xd5cXN6zE1wFqYB5USmNJVIQXaw879jDvuJlw=;
        b=kwzSuFB+29ViibJTZZ3slGx+VtBH4lYqdX9yn1ITQnPmzyLIpOBbEXtSn4sVNrQrIp
         Rzg88r5hMjVK3HmmROo8gp8UJeQ5c0Cu+mTVod7z9PNKOPVNN29HhxFhBXRicXanjD78
         6UGjbl/KvCRFI8dcJ8SwQfcIZ0ally7yReIbxxBCvtmE4roikCZaHeTxmjfI9w1q/zIx
         FF1ndruC1Y4XYL2EfejBXNlCKSaTlsWLOaAnPRSLD/YuIsqV86PIGq+JuPuFyMe/VFJX
         LDAd4wuUvloqIY6JeQIhqlDHbcUPki4ZBpM3MO4sVfDR/IOYgtJVzbUBxRYIPPwVX22d
         IZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784841573; x=1785446373;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9tHt8Xd5cXN6zE1wFqYB5USmNJVIQXaw879jDvuJlw=;
        b=LE8273YA6WR0HEpyGspkRShdr57fm757hRdnGtf6mn2CZVB8AN7VtTpvXRVG9ceZOc
         /SoIP979U/CnNrfEaMkBk2QeQfEa4MKZ1bSnwQ4DE/DvGyehttqiNyasR9Okp+I0M11K
         nEFvT9uKny/obNzRsokt4YjQ7Ty3jk+zliBT9iGaSSRDmMHO0/io9wgA5MLbfPJoNSzW
         7R+1W+ZCO8C8+oAOxX9ZRUEMZV6YAg9y15T7ERD0OFZVW84ID5iU+WsC7CVY1tvFkFo+
         dKrII3HvEPizzKzaI6p9Q5A3yY4X3YmzuiNPs5Q+CDbw4VKwjFfZJtwT7ymscx6Crv0j
         jmow==
X-Gm-Message-State: AOJu0YwXSs9dF5kSRzRl6jGSY64nGmOoFWZWY5LolTmjt2XudBsaCpws
	yFocxbjGvqv7IL/3bRAiRRtDe8kUXV84wa6NvzMZhxtXb4JKR7xa/IWpnSdtHA==
X-Gm-Gg: AR+sD11GtVL7od1UjJCIHmtsCzFzewD3DYVC1d67PkfvFlR9PjK1L7QGgRdbFkuANvo
	yzZ27tLLkwr3jvAmmumny5DEV5QC8l715qtH1lxDG2QCPIFef2vVdIs9fqQtugUFff4VMqEHIrb
	VQBLZnyHWeUB+8uXp/yFviWHGIHaLDjRxgfCxyYB8OMf0BtcQdRRkU5etPVUDJqetaRjBxYaRGf
	f8vRlBo6ogIuJ9Mo++AIy8JlcxVQ1GxtV9leYEVQJf091m8GIUNjZYqq8bcM439OhUlHAQUBSnf
	Um9b+TqGESOkcSld+CYTLm2s0QD7LlbSfxvUH2EV+Tp8xjnMdbxaRAuzw9uhXEAZvLhlbZb0lAO
	3kyjyWbfHbLQYj8WuOEGAwBOLlVjjjXnF/Z35oCLxL0fa2XP3GwhtbyQsM57mfOOs0VHiktMjrW
	enKSExwQ==
X-Received: by 2002:a05:6820:1621:b0:6a1:22cd:8ffd with SMTP id 006d021491bc7-6aad40ef8c5mr2216372eaf.34.1784841572840;
        Thu, 23 Jul 2026 14:19:32 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.167])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aae63bc398sm182122eaf.9.2026.07.23.14.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:19:31 -0700 (PDT)
Message-Id: <697b4b55c37053e2038a5d108987fed39f4b765a.1784841567.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
	<pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 21:19:23 +0000
Subject: [PATCH v2 1/4] doc: convert git-imap-send synopsis and options to new
 style
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

Convert git-imap-send from [verse]/single-quote style to the modern
synopsis-block style:

- Replace [verse] with [synopsis] in SYNOPSIS block
- Backtick-quote all OPTIONS terms
- Backtick-quote all config keys in config/imap.adoc
- Backtick-quote bare config key references in prose

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/imap.adoc   |  2 +-
 Documentation/git-imap-send.adoc | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index cb8f5e2700..6b97776bc3 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -41,7 +41,7 @@
 `imap.authMethod`::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
-	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
+	than 7.34.0, or if you're running `git-imap-send` with the `--no-curl`
 	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
 	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 538b91afc0..1814d94491 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -24,9 +24,9 @@ that order.
 
 Typical usage is something like:
 
-------
+----
 $ git format-patch --signoff --stdout --attach origin | git imap-send
-------
+----
 
 
 OPTIONS
@@ -138,13 +138,13 @@ have set up) may not be verified correctly.
 
 Using Gmail's IMAP interface:
 
----------
+----
 [imap]
     folder = "[Gmail]/Drafts"
     host = imaps://imap.gmail.com
     user = user@gmail.com
     port = 993
----------
+----
 
 Gmail does not allow using your regular password for `git imap-send`.
 If you have multi-factor authentication set up on your Gmail account, you
@@ -167,32 +167,34 @@ than using app-specific passwords, and also does not enforce the need of
 having multi-factor authentication. You will have to use an OAuth2.0
 access token in place of your password when using this authentication.
 
----------
+----
 [imap]
     folder = "[Gmail]/Drafts"
     host = imaps://imap.gmail.com
     user = user@gmail.com
     port = 993
     authmethod = OAUTHBEARER
----------
+----
 
 Using Outlook's IMAP interface:
 
 Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
 supports only `XOAUTH2` as the mechanism.
 
----------
+----
 [imap]
     folder = "Drafts"
     host = imaps://outlook.office365.com
     user = user@outlook.com
     port = 993
     authmethod = XOAUTH2
----------
+----
 
 Once the commits are ready to be sent, run the following command:
 
-  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
+----
+$ git format-patch --cover-letter -M --stdout origin/master | git imap-send
+----
 
 Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
@@ -217,7 +219,7 @@ users may wish to visit this web page for more information:
 
 SEE ALSO
 --------
-linkgit:git-format-patch[1], linkgit:git-send-email[1], mbox(5)
+linkgit:git-format-patch[1], linkgit:git-send-email[1], `mbox`(5)
 
 GIT
 ---
-- 
gitgitgadget

