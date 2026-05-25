Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D73559DF
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704920; cv=none; b=hhtl+XfqGT0wirF6kXbgvxTdSnDAsVooL8Lbzc+M+1hElA3CtZNpqATURELrA1O/qewgAvt99/fXdi0RsU+fYlxJaMpeTXSeMI+jiD1x8vXTN8m/ss5Cm9rit+C9evhV2kWhfLD6kancCFE8EWYtWZT3G6ZYmhJ2m5ziZMzVyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704920; c=relaxed/simple;
	bh=mYiNQ92+mp/rAPmFex8Vx8HNVb4E0ZUgUhTueyazUXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=AJ6tHqHwfU9FZiN4RyGcOig/+C4MXOXtS6s2r76Ak2c22ronZ11QkrA/EvhsJDhWeD3FRyMPP1jprDNL8ezJeczwbNaFbGODAou3lyJoeKzbx12mFlwvYTKXAPpfxHf/ki+Oa6f4MeVpvH+V7n2E7EEBLPRuGoo625kU82+n7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddcdzDpm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddcdzDpm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51306c36c3eso105268691cf.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704918; x=1780309718; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhVltt7QM0TwLWHahbrRlQBoJrEUlEDdh4kP8ZpMGfw=;
        b=ddcdzDpmFPH7VMGCGWUQWTAwqodVoMciEQl2bInczeoXqLuGulyNOiPQe0OY4R/F9b
         qwNEG9H4gjfZqrnOGNL0MmxtZwSIc+1C2xpYDwGDtX616w//uV4knrqmIbP+kLECsOAQ
         y1x0RfmgN5HxLjfHJeaYNdiDsfLQ34AWZHB+TmV6pOAYcpZwUjKGU5jhPtm9OwTyHGap
         gg/6EtGoriD9P7yoY9FU91dDwiZm/xP4bfff5Cw798SRHJJTCB9FSMPxiQq6yfpKqVbk
         LgLITloOIjKn4EceXH0q1bMUfH9kgzVT1zqsmHzAkyD78o5nM85ajv1Kx8nme46ECWcC
         pBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704918; x=1780309718;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhVltt7QM0TwLWHahbrRlQBoJrEUlEDdh4kP8ZpMGfw=;
        b=LTf4lIsUzpVpItyt9z6EtSCbcYg41HVYtZT9XnC9fb8AcZ89liASeKA09zZxmqCE6W
         0ekqnlLNJ1JRu9OLNgy7g/ere9YHMhwouQDSf5EsavgclC8H0r7ikQY4ukRxSXFPVCL5
         DH97qDKF9vzwx3BJwt9B+rbXhiegJlPaFu8B5jw+yj9HrBZ/Pz1XXnS2C2EGUPEztK80
         +Dk4AFinA9MyLXpeGbM9D35gQ1xiPJu/8JLUpvmSfrwCk3LF2cz7737FSle7+f6rc3Oj
         NiJ7v8kQ6OMheh6x6aKvNJfjJ/g5nDFw4fQLg2cUNeMZxSi6WzhmbACAzWGsi92aONvE
         QK7Q==
X-Gm-Message-State: AOJu0YyAr8KsrthBQaPXIE6/iLmoU+gGo9Yd3H/DIQ/yp98tuDcbkt+a
	QN/4I8Z6puK7vAbsO0mTRZAykyiXHHMrAA8rUxS6PcsH0eZlNMVcnXfUzIeGjUxH
X-Gm-Gg: Acq92OGdIAR1o8W9MHal0N34zE8Y7NDjWzvjz1prutvbH2+5hdaYLZj6Kew6MfhioGx
	qJhp9U6BNikNcqNrdA3Ci/B6uUp1JT1ETI68gYxsj8ohhsRgook/6ccLm4WcAhFTFuJYdT9M8fG
	Wy7SylEo7FCn94qcltV6ZxpQtCPZmfoE3Qke4qXwgf7EgP9Y7RrX25ClfnZHrq7/NI3J9Zq0l5H
	H8vg+SYl3B2pM7ODpGJqI5hwvuJkhvht59xm0VCt6i4+rO2KVlPJFigKaBR+lHRgZ/IC12N7e7n
	t9Q91Pjw/Q20IcMhhOh5gMuP+cxiELAHmbcuidNeab9j7z0y42W5DTYo96pe5VxIThMrlrqQX9J
	yyMsrP0V0S+vgsiRAbcxYxB+9NlwxKTkFwVztdaOdZy3eqRRDZw7wumeL7FwrUTIAd1rW8f/la0
	T9rL4BUgqCf1rfDfqxqbFaizVbLPez3U5W6VI/
X-Received: by 2002:a05:622a:1f1a:b0:516:ea30:8756 with SMTP id d75a77b69052e-516ea308d3amr88295671cf.36.1779704918117;
        Mon, 25 May 2026 03:28:38 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.15.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b247c4sm89629191cf.7.2026.05.25.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:28:37 -0700 (PDT)
Message-Id: <d88824bf0918b1d9f70de700cc04593bea8145b5.1779704908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 10:28:27 +0000
Subject: [PATCH v2 6/6] doc: convert git-imap-send synopsis and options to new
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
 Documentation/config/imap.adoc   | 30 +++++++++++++++---------------
 Documentation/git-imap-send.adoc | 24 ++++++++++++------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 4682a6bd03..cb8f5e2700 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,44 +1,44 @@
-imap.folder::
+`imap.folder`::
 	The folder to drop the mails into, which is typically the Drafts
 	folder. For example: `INBOX.Drafts`, `INBOX/Drafts` or
 	`[Gmail]/Drafts`. The IMAP folder to interact with MUST be specified;
 	the value of this configuration variable is used as the fallback
 	default value when the `--folder` option is not given.
 
-imap.tunnel::
+`imap.tunnel`::
 	Command used to set up a tunnel to the IMAP server through which
 	commands will be piped instead of using a direct network connection
-	to the server. Required when imap.host is not set.
+	to the server. Required when `imap.host` is not set.
 
-imap.host::
+`imap.host`::
 	A URL identifying the server. Use an `imap://` prefix for non-secure
 	connections and an `imaps://` prefix for secure connections.
-	Ignored when imap.tunnel is set, but required otherwise.
+	Ignored when `imap.tunnel` is set, but required otherwise.
 
-imap.user::
+`imap.user`::
 	The username to use when logging in to the server.
 
-imap.pass::
+`imap.pass`::
 	The password to use when logging in to the server.
 
-imap.port::
+`imap.port`::
 	An integer port number to connect to on the server.
-	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
-	Ignored when imap.tunnel is set.
+	Defaults to 143 for `imap://` hosts and 993 for `imaps://` hosts.
+	Ignored when `imap.tunnel` is set.
 
-imap.sslverify::
+`imap.sslverify`::
 	A boolean to enable/disable verification of the server certificate
 	used by the SSL/TLS connection. Default is `true`. Ignored when
-	imap.tunnel is set.
+	`imap.tunnel` is set.
 
-imap.preformattedHTML::
+`imap.preformattedHTML`::
 	A boolean to enable/disable the use of html encoding when sending
-	a patch.  An html encoded patch will be bracketed with <pre>
+	a patch.  An html encoded patch will be bracketed with `<pre>`
 	and have a content type of text/html.  Ironically, enabling this
 	option causes Thunderbird to send the patch as a plain/text,
 	format=fixed email.  Default is `false`.
 
-imap.authMethod::
+`imap.authMethod`::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 278e5ccd36..538b91afc0 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -8,9 +8,9 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 
 SYNOPSIS
 --------
-[verse]
-'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
-'git imap-send' --list
+[synopsis]
+git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+git imap-send --list
 
 
 DESCRIPTION
@@ -32,30 +32,30 @@ $ git format-patch --signoff --stdout --attach origin | git imap-send
 OPTIONS
 -------
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet.
 
--f <folder>::
---folder=<folder>::
+`-f <folder>`::
+`--folder=<folder>`::
 	Specify the folder in which the emails have to saved.
 	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
 
---curl::
+`--curl`::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
 	option set.
 
---no-curl::
+`--no-curl`::
 	Talk to the IMAP server using git's own IMAP routines instead of
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
 
---list::
+`--list`::
 	Run the IMAP LIST command to output a list of all the folders present.
 
 CONFIGURATION
-- 
gitgitgadget
