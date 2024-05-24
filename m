Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB9C12E5E
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536074; cv=none; b=KvpQD9O+JDKaRDDroDEPDws6XOTAfmJUpp6ohYl+tjviSC6aOb6kUO9hIm4sYF5GUZUCliTbbIKKN+bicsrSUls0gr2msehwPhal/wA9gClDOVGoybKPar5tDMUT0wBs5wjxdN70KrgXyZYdRb0aMJ/F8O79OkGNmZkfXtQxUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536074; c=relaxed/simple;
	bh=PJvtKfLMFKRXxMYXIsU4d1eLp+QyOSaS6BdieMAUKLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNisnWjSqaykTYQDqZtW6Rw0bm9md01Xuunq8/KGstDtKbAgL1mBCkMvfliJvinB//sTt+JMaQQTZ3SXntE734335VhVbWudLgWjf+W/o1sBCwrERd83qPq19yaZHVeEPo60t7YOaoiHWXb8zX9USGFQuu5oHIMjZXVzxlJgSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTLKBqJm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTLKBqJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AotnOA3dFJRsRAdtubd8p/AXYapmtCEf7HP+7OF2O4s=;
	b=hTLKBqJm0o62ITN9tiCHYHGwfxdIN/vg83MKIrrIcsdhi6mAAA+Y8S5MmTjUTEUD0iqHq8
	PC/1oJ5Ll2nGgu1LsbJ2Lv4l83aiJLdQxo7DrGddtOzQlpbycOAqKLbjLL0a5WZhgZSEzz
	5RkdSg9VOhANcW4gnh82huBVnazCoiU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-3C6k5hzFPQWpYwOV4kW1iw-1; Fri, 24 May 2024 03:34:29 -0400
X-MC-Unique: 3C6k5hzFPQWpYwOV4kW1iw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab9e01225eso9915406d6.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 00:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536069; x=1717140869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AotnOA3dFJRsRAdtubd8p/AXYapmtCEf7HP+7OF2O4s=;
        b=X2xBrygqPDT5cUBqN+OH6DzV+3UZrrPck8wI9qveMZwMXLa8w06A2hwSw9WZYlvjxh
         NR6OG7TtRk61J6dWIEILI/IHWbawvhTre9rBL+VtSZ9ZxcrRQ/TtIsCGN8Kz3dTojcVA
         NcDWIjPfsYSnjXPIUTkl+BQbw4nFbATwyXDIH3AId27C2wg+7/CBZb1GMGeHq4Stl1DJ
         EN1iklPJvQtm46ac0SNv5hOhd3sxqi+J4fW82RD1Rlt1NNMIcOCiFvBxe5lLTstXHWRY
         aVxw8aSaU1yj/kg7+MJeF5kA/Og2Gev9RDN7uVNAzaWlL0Qs7ouzJPoCIsSPPptX42oS
         WzDg==
X-Gm-Message-State: AOJu0YzyCVBVzLQjAF+3xlNzdA3+bgfCKqpd2XLMSgDUItPny7YJirRa
	8jIuLvfFf7QckO8jzyUh436xmWs2iEHUbQbCdHoTMawScv1c/eAgKPkLBi+LW3KgnmzzySCxD2S
	Zp/Yj5h4k1iLpO/4KNKn774cO76ItxosxSL6W1PnTHL4+TIH0coEGetDfoy57hbzxNSrNRvjaqj
	e/8LKCHBrdQbmGcFHtWIuysPK/WR+1cvgANA==
X-Received: by 2002:a05:6214:625:b0:6a1:6081:6879 with SMTP id 6a1803df08f44-6ab8f5578f4mr76068896d6.17.1716536068922;
        Fri, 24 May 2024 00:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYVv32s/F0JPZ6CeDJD81G9R/PY03r7hnrCHi3XHnX8P6Ba/t3Wy9IhNPKYdfnkRaZCWTxg==
X-Received: by 2002:a05:6214:625:b0:6a1:6081:6879 with SMTP id 6a1803df08f44-6ab8f5578f4mr76068616d6.17.1716536068413;
        Fri, 24 May 2024 00:34:28 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac0710865fsm4893356d6.71.2024.05.24.00.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:34:27 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v4 2/3] Documentation: alias: add notes on shell expansion
Date: Fri, 24 May 2024 17:32:43 +1000
Message-ID: <20240524073411.1355958-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524073411.1355958-1-iwienand@redhat.com>
References: <20240523043806.1223032-1-iwienand@redhat.com>
 <20240524073411.1355958-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing inline shell for shell-expansion aliases (i.e. prefixed
with "!"), there are some caveats around argument parsing to be aware
of.  This series of notes attempts to explain what is happening more
clearly.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 Documentation/config/alias.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 40851ef429..51fa876c91 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -27,3 +27,24 @@ it will be treated as a shell command.  For example, defining
   repository, which may not necessarily be the current directory.
 * `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
   from the original current directory. See linkgit:git-rev-parse[1].
+* If the shell alias is the full path to a binary, it will be executed
+  directly with any arguments.
+* If the alias contains any whitespace or reserved characters, it will
+  be considered an inline script and run as an argument to `sh -c`.
+* When running as a script, Git appends "$@" to the alias shell
+  command when arguments are present.  If there are no arguments,
+  `"$@"` will not be appended.
+** This may initially be confusing if your alias script references
+   argument variables, or is otherwise not expecting the presence of
+   `"$@"`.  For example: `alias.echo = "!echo $1"` when run as `git
+   echo arg` will actually execute `sh -c "echo $1 $@" "echo $1"
+   "arg"` resulting in output `arg arg`.  An alias `alias.for = "!for
+   i in 1 2 3; do echo $i; done"` will fail if any arguments are
+   specified to `git for` as the appended `"$@"` will create invalid
+   shell syntax.
+** A convenient way to deal with this is to write your script
+   operations in an inline function that is then called with any
+   arguments from the command-line.  For example `alias.echo = "!e() {
+   echo $* ; }; e" will work as expected, with the function `e`
+   receiving any arugments from the command-line.
+** Setting `GIT_TRACE=1` can help debug the command being run.
-- 
2.45.1

