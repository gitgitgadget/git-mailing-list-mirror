Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B23A1DA
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532019; cv=none; b=IrEPp3TaBJaq/R04rNvIcjdwrrxVLSoCJSAjMEMN/ZC8KWB8UOlcY13yHEs/jayQyYh13PFKQO8XEeQaWJqkNAWJnvfaUIwWqgjoUzrA8Dw76p0sAH+mS4aDs8NkLLVC+Hi+iMNfsEA00o2ymyAhtHc7SGXpu4byo8O8CO6Nx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532019; c=relaxed/simple;
	bh=DCy+hRt/9dE9go/BdQo/4LLaHnPzq320wyoUxFXZ/so=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AfLaHKCpwG/57ZOCSRD4IdyPIXabKc2T2BpeTG0Qk30Zu4SEZ4FZr3/J8Bfj7Ra95sfR8RYc8UiFrh/aDFGjKbAo6f9cXxAERj6gMvVkTLU3LDejBdjHJp7aBhl/Bk3MvdEBqClmwTpHkh9+bDXvORDrQ+ZGyNgvccNkfo7LEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bwSXHw2D; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bwSXHw2D"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70943713472so2423045a34.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722532016; x=1723136816; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oD2BoUTJp+LLszTusJQM2tKPAPkgfLTEoomHkTFHkto=;
        b=bwSXHw2DarGapxYWqoEEueu/8+5Q7sAaeMmU41+Kaq/+5sAm7kz4J5Dn1UctuF75Rg
         KXKGFfSlmEYZzf3ggu3lpAfVku35D2KYF2DvMzWbkV+nskKOycz9D6DKTwQjmHwPX+EU
         LWy7eEEBs6wKlA3ANFErw4v+rPI+TqjQgSgHGvVKuCIoxjJBCzx8I7myt08vcodPr6I2
         vZ9Rt/Ls0VuTeA8cBQtWIIt+jyHjkj+U9Xw7NW1xgPcb1qLgr3e6Trpcyry4tBJwgIBQ
         4uldwIh8qaXmPONKqr5HpFY4In2qOZ4sHqifmAN1ics8vDYC375r1qwgUtfwCrcLOUTx
         yCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722532016; x=1723136816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oD2BoUTJp+LLszTusJQM2tKPAPkgfLTEoomHkTFHkto=;
        b=eJ4/e6V4W2DLTXHWe4QGU7bxhyZkiZUcsGl0hqG7HwkF24ShL07IIlQx+LCADg/hIP
         oEM/Yyd0c3Shp+JeLGKgxr+YIQ6TAwSNocIjOa4ev0yGZlinoi/5I9zlsGcjFFiyarVE
         CwzMigIFKCoueV8UMIOKeq9IAtmjem1yAbpfqKdRKMuVZ2LRZM3DxYMjKN9jbFNgAHhj
         1bqlm4neqVpZTcU47fvxiGBvsxmegG9uCiM8SI2pt5u7e3+YBSY11zfhQUglKl34fC9h
         3EfyEbMzAMKEIS3Z+2PlRfsGMWjTgYhh7Z6q25wbvvqULE4BEP7/VhH91GbiRoLft2NZ
         4kQw==
X-Gm-Message-State: AOJu0YycKh0HYTzp4/AwWxEqV06Emu2pZvSe6hIMeN/cC5z6YDo4FCYM
	evYu+siab14N5FqSk+wWRt7UIB7klBCoZr1TY6ES9M20P5khzah7Fr4ZUClmMNPX9vT5E+ehMAR
	d
X-Google-Smtp-Source: AGHT+IHpWFfQgfblzG0Q7lnLs4oTDhdPWTndNVfHN6+vmpSmO73imtQrl//tivF9GWs3xGf0Ykyitw==
X-Received: by 2002:a05:6830:3805:b0:708:d84d:f62a with SMTP id 46e09a7af769-709b9964022mr992354a34.22.1722532016166;
        Thu, 01 Aug 2024 10:06:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689b3ddba97sm96277b3.124.2024.08.01.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:06:55 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:06:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Han Jiang <jhcarl0814@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] config.c: avoid segfault with --fixed-value and valueless
 config
Message-ID: <c78bacfa8fb274fbb48f259b13f4f30253932f69.1722532013.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When using `--fixed-value` with a key whose value is left empty (implied
as being "true"), 'git config' may crash when invoked like either of:

    $ git config set --file=config --value=value --fixed-value \
        section.key pattern
    $ git config --file=config --fixed-value section.key value pattern

The original bugreport[1] bisects to 00bbdde141 (builtin/config:
introduce "set" subcommand, 2024-05-06), which is a red-herring, since
the original bugreport uses the new 'git config set' invocation.

The behavior likely bisects back to c90702a1f6 (config: plumb
--fixed-value into config API, 2020-11-25), which introduces the new
--fixed-value option in the first place.

Looking at the relevant frame from a failed process's coredump, the
crash appears in config.c::matches() like so:

    (gdb) up
    #1  0x000055b3e8b06022 in matches (key=0x55b3ea894360 "section.key", value=0x0,
        store=0x7ffe99076eb0) at config.c:2884
    2884			return !strcmp(store->fixed_value, value);

where we are trying to compare the `--fixed-value` argument to `value`,
which is NULL.

Avoid attempting to match `--fixed-value` for configuration keys with no
explicit value. A future patch could consider the empty value to mean
"true", "yes", "on", etc. when invoked with `--type=bool`, but let's
punt on that for now in the name of avoiding the segfault.

[1]: https://lore.kernel.org/git/CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com/

Reported-by: Han Jiang <jhcarl0814@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c          | 2 +-
 t/t1300-config.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 6421894614..05f369ec0d 100644
--- a/config.c
+++ b/config.c
@@ -2914,7 +2914,7 @@ static int matches(const char *key, const char *value,
 {
 	if (strcmp(key, store->key))
 		return 0; /* not ours */
-	if (store->fixed_value)
+	if (store->fixed_value && value)
 		return !strcmp(store->fixed_value, value);
 	if (!store->value_pattern)
 		return 1; /* always matches */
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9de2d95f06..f13277c8f3 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2704,6 +2704,15 @@ test_expect_success '--get and --get-all with --fixed-value' '
 	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
 '
 
+test_expect_success '--fixed-value with value-less configuration' '
+	test_when_finished rm -f config &&
+	cat >config <<-\EOF &&
+	[section]
+		key
+	EOF
+	git config --file=config --fixed-value section.key value pattern
+'
+
 test_expect_success 'includeIf.hasconfig:remote.*.url' '
 	git init hasremoteurlTest &&
 	test_when_finished "rm -rf hasremoteurlTest" &&
-- 
2.46.0.dirty
