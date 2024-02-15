Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0869D39
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992991; cv=none; b=nidPK/D3MNrq7t12E54IlHDCYFDgsPS9n4VY4LXgumWK+tf6/ospf7qmEX5eWq95R2MBHh7f/Heo+c7bcfTJVjH+xvPtCAd4XiT8jaw/3rqnHeLUIAVl7gv+uFwPqqysipciNPxG05Wh5D6CJg7OT8PVOxscapjsZMHJATYB9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992991; c=relaxed/simple;
	bh=8pHLxVwWfAKIVN+fYTYk15Ex0JhwyVUgbaNDr/IqWH8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ush9usFUZA3REX1EP0KiCaoHZ4GNyG6ComcOsGkjT7EB+xov1psJVW3kXIzSLI1HcAwLSU9KkrPdKMlxRsNWmYELJji/4twqtsQ+cJ2qV28E2mLLREaKmPT/DuvoFmDBQqgf1HFcKHnOhpWqq3KNXbFy06jrzZMfIALVCY0YUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeOHjSP9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeOHjSP9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337d05b8942so442492f8f.3
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992987; x=1708597787; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e61PsnXiBlPenJ5EHXw7RgYMWWV8uQLSlMKi3SdABuM=;
        b=NeOHjSP9TFMGEHs29jF6/1/PzB7wrlA2EgsvJLBKNyvOtLO03YdfzmpdQ1lm9EOl/6
         fllUzhcqR8Qq4de9P8UylfHXXMgYZibLndZTVyxLcWqrWwESnRGfxdYgZYjUzO5mUf4h
         6ONzxTUnNzWhop60fLPCkx19LqxuHZyRDBuG8bNV5KIsZG+ewbJMKhyXGDXwvn65nmpq
         0FHKqTaovTlP94K93Z/D39XjpUTai7MOZOTmAQ0oLa0R344a4OZugaWkDWWllKuNJcHP
         t0zCTqCnwDBBeIZHICC4E3bFvXvWhZeNaep8sSa1z0uuN1wHF6DgVF1b7tbQ3eYfC5FA
         97gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992987; x=1708597787;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e61PsnXiBlPenJ5EHXw7RgYMWWV8uQLSlMKi3SdABuM=;
        b=bWguG4rqrCfz+wqVh3XqFFSxZ/KVUsHEXxv0U65q/36nN8GwHHOjcAV2rcQKXzfUSQ
         7qGbPkPvgAGAtozE8sUvzdfN4h7idgTHBSGOk5Gcj7jAyzL2tQ7siluXHVNDa84P0m4r
         tyuo3N+GFxCbjgpjBSX/EXxkWfsQJxO3rTBArMZRp658JJR/gXU9Vv10dFjlfi4mXCjW
         xKecwrx/lo+udGQjSZMNoVqfS+qAS0nK5w6PXK9YdvOhSUPijMVnkVB6QBVqe1xhYzhv
         eQj28y+76vihTtuKH7zhAkyqu7UoMWaHk1ZIQ9ZwOl2+Qj4/8lu+pKh4OUCYtFb0NAFC
         4Bjg==
X-Gm-Message-State: AOJu0Yz94atLD687S5UlLdBZoR6tQsgKQJxHWK9nkv2OpMUTn2nGvFYj
	RaK+ug5g4pQn9r71JtUx/ho7gwhDW9Pi1r8gTMblDSiC6gMUIx9ETAfV/aMA
X-Google-Smtp-Source: AGHT+IENKmCOV/A759SaBrhFtxwREKpCqs0ENMiwbA6FLB1gqraNZF0k3Xo2ULrQsP2xhSfny0/SzQ==
X-Received: by 2002:adf:f50d:0:b0:33b:4649:a1e0 with SMTP id q13-20020adff50d000000b0033b4649a1e0mr1010265wro.15.1707992986673;
        Thu, 15 Feb 2024 02:29:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs22-20020a056000071600b0033cfb525bf4sm1377408wrb.82.2024.02.15.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:29:46 -0800 (PST)
Message-ID: <02aee716a0ed83bef55eadc04ed5d8f9c0ac2c03.1707992978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
From: "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 10:29:37 +0000
Subject: [PATCH 6/7] fsmonitor: update doc for Linux
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Glen Choo [ ]" <chooglen@google.com>,
    "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
    "Taylor Blau [ ]" <me@ttaylorr.com>,
    marzi <m.ispare63@gmail.com>,
    Eric DeCosta <edecosta@mathworks.com>

From: Eric DeCosta <edecosta@mathworks.com>

Update the documentation for Linux.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Documentation/config/fsmonitor--daemon.txt |  4 ++--
 Documentation/git-fsmonitor--daemon.txt    | 26 ++++++++++++++--------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
index 671f9b94628..4ca92536286 100644
--- a/Documentation/config/fsmonitor--daemon.txt
+++ b/Documentation/config/fsmonitor--daemon.txt
@@ -4,8 +4,8 @@ fsmonitor.allowRemote::
     behavior.  Only respected when `core.fsmonitor` is set to `true`.
 
 fsmonitor.socketDir::
-    This Mac OS-specific option, if set, specifies the directory in
+    Mac OS and Linux-specific option. If set, specifies the directory in
     which to create the Unix domain socket used for communication
     between the fsmonitor daemon and various Git commands. The directory must
-    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
+    reside on a native filesystem.  Only respected when `core.fsmonitor`
     is set to `true`.
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index 8585d19f4d8..ebdc4aec3c0 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -76,23 +76,31 @@ repositories; this may be overridden by setting `fsmonitor.allowRemote` to
 correctly with all network-mounted repositories, so such use is considered
 experimental.
 
-On Mac OS, the inter-process communication (IPC) between various Git
+On Linux and Mac OS, the inter-process communication (IPC) between various Git
 commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
-special type of file -- which is supported by native Mac OS filesystems,
-but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
-may or may not have the needed support; the fsmonitor daemon is not guaranteed
-to work with these filesystems and such use is considered experimental.
+special type of file -- which is supported by many native Linux and Mac OS
+filesystems, but not on network-mounted filesystems, NTFS, or FAT32.  Other
+filesystems may or may not have the needed support; the fsmonitor daemon is not
+guaranteed to work with these filesystems and such use is considered
+experimental.
 
 By default, the socket is created in the `.git` directory.  However, if the
 `.git` directory is on a network-mounted filesystem, it will instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
-network-mounted filesystem, in which case you must set the configuration
-variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
+network-mounted filesystem in which case you must set the configuration
+variable `fsmonitor.socketDir` to the path of a directory on a native
 filesystem in which to create the socket file.
 
 If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
-is on a native Mac OS file filesystem the fsmonitor daemon will report an
-error that will cause the daemon and the currently running command to exit.
+is on a native Linux or Mac OS filesystem the fsmonitor daemon will report
+an error that will cause the daemon to exit and the currently running command
+to issue a warning.
+
+On Linux, the fsmonitor daemon registers a watch for each directory in the
+repository.  The default per-user limit for the number of watches on most Linux
+systems is 8192.  This may not be sufficient for large repositories or if
+multiple instances of the fsmonitor daemon are running.
+See https://watchexec.github.io/docs/inotify-limits.html[Linux inotify limits] for more information.
 
 CONFIGURATION
 -------------
-- 
gitgitgadget

