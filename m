Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BD33DED5
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524151; cv=none; b=oDGY+yRosjOUVYmQttHz0DK2jMNS2n7Rw9mVcohWPITAGFiphEda9M0ADnVN1d3l98Ze0zt85XzNySMlqnWTQzkKp2CEHEVd4FcGnqfc8f5VEe94dkTp8vh42tzFFTDfdkWSvRoijgnyznsVWzkqUzALEnCt6cWG3ORbYTcZymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524151; c=relaxed/simple;
	bh=BQfmcJeySLLG0dIV2D3hle9avr9jzrRNsQfpav1Rpwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQ4vfOmDOp3WOPqOAAblZgEpcrRVRIY7uCXaYiza2LfSkA/cu0fGh8+Vnnr4L7+VNho7tkg4YsAmx4bJKrYaR37yXbsxkrsoF1oqkdd+Sz+DPHzH+29A6ojXRlUoRfZMc5NSWIYchlenG4GTir90ww2rhDbuEzv3zraMTbGZI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkR60Vxi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkR60Vxi"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so520330f8f.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774524148; x=1775128948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNa1VQ62zMmVFVBlOhbCxB5pC9Hx0je5pNzJ7Xv1zuw=;
        b=fkR60Vxiqi4VPxnN6aKU+oAJyJSiGQ0fNuRdFJagYo2nI1fkaX0xxQyqFn7skWA11J
         UuF2JIesg4NYy4SaZqpe+QfN0yjtQlXJSXIEKuW3OsIV1ucJKyqpj/KZ+qN1wN+ZXp0t
         UPcmB5UZpE6lldC5OOObf6TiVmUVsEhkgUfxlzNIWkYzy4OxpSSXs7ZTLs02HQ82FkoB
         mpOQJtH/D2o+cZ2LZv2/Ft+tNGUZg/bjViScoGKNrgwsAP5XHJSxGEDkNVeKw1fcFjfS
         /CNpwAJNfQMmqnwiDvw1CEgDEP7OM7ZMAHnNGlbNIwX0aZ48WmxNjpChKjiqoQXODntY
         E9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774524148; x=1775128948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNa1VQ62zMmVFVBlOhbCxB5pC9Hx0je5pNzJ7Xv1zuw=;
        b=PqEpBuu2ksLmnY255mRzVyfzyjq937NalGNc8bmgj5Yz1SfBpT2La/ZZFxxG/tF9KY
         zRd6D4aFhKrPcJIoaKZaWmlmew4fhdrbqPTPN9+kLJELP3sBrXZKi8jEXp18Eyx/D8GV
         nwaaCJZxrnWz5Mryy7nA68MGlIIGIljZyOr1uInOiiDDS8c8PQzCSeppfOVAuZ3GZ8OL
         QsX2Szs/lcnSsWlP5Bm9DAy+YCuZ4NCvO2cPVvFgoWcpMurkezgZkkxVhjbBxDCQhXAv
         q4aBDCDQQVQTMOGpvPyQh+GrrZvcWR9qtv1OlyXOkhnL7OldUvvMqOwGzUJ/V/0lq/Tz
         rlIw==
X-Gm-Message-State: AOJu0YxybFlQO6fFvONrEGB+U4aL16fXvCrmtQNFSnIsPLB1+9BVSUEP
	QaoaNqaBG7i3ea3UfRHPITm9CwNW1jLxtR9aeoN5UX8ZpHxtMr7jp0/iEoS+nqstv9k=
X-Gm-Gg: ATEYQzyvhKrRhMODIZVydbfl/VJaZcrq07dnfVIbyj1mVA/VTeSBP4KHg4tBNNo3s4/
	USQI0aXJBEb/8eLVC9SSWsnxIDa//95vCzKkWR1ba9AJlOpQlMHTDcd5h2k4Zq5NiuRkOYWQLrz
	JpePeiaEd05+tTQ8m2YYmhR8FBRODLaafccYsXGJ3L+yO6zoNwJm3eoxp+zDBC55eL0qq3lUvEb
	86vStHwQEqpIeGP3xqeDWh/dE9v5sIe4sKxrHcmJ2tjtSooQeEuOKqmStniZodmWwQpzhtX5QWd
	pMlefXil5Y6YehwBiLXpkqPpmV46oaUyMPLizxKQPeOQmJANmhZa3xDsH9405L8RpZO6cCqYFcp
	oV4pp+din5kxQLnY3FZuGGViZUzKEGxRxxCxch9UiCBqsVFA287IEqjCKmyJHGnARwqxtOsjJIM
	Pbwcliep2lFMNQjQnbHNgYzAqzLrqE3FlbufuIsPwPGk4hFMafjbCRhqH7P2xAK/d8dThXHj3fs
	52ZqN7Uu4ibJFKj3hs=
X-Received: by 2002:a05:6000:2506:b0:43b:45d1:f44f with SMTP id ffacd0b85a97d-43b88a25a2dmr10828586f8f.41.1774524147311;
        Thu, 26 Mar 2026 04:22:27 -0700 (PDT)
Received: from alibaba.. ([98.97.79.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7372sm8694822f8f.34.2026.03.26.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:22:26 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	siddharthasthana31@gmail.com,
	ayu.chandekar@gmail.com,
	Zakariyah Ali <zakariyahali100@gmail.com>
Subject: [GSoC][PATCH] t2000: modernize path checks to use helper functions
Date: Thu, 26 Mar 2026 12:21:49 +0100
Message-ID: <20260326112149.53050-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bare 'test -f/-d' and 'test ! -h ... && test -f/-d'
assertions with their dedicated test_path_is_* helpers.

These helpers are better than the previous 'test' commands
because they produce clearer diagnostic output on failure.
For example, instead of a bare exit code, the helper outputs
'File path0 doesn't exist', which makes test failures
significantly easier to debug.

The replacements are:
- 'test -f' -> 'test_path_is_file'
- 'test -d' -> 'test_path_is_dir'
- 'test ! -h && test -f' -> 'test_path_is_file_not_symlink'
- 'test ! -h && test -d' -> 'test_path_is_dir_not_symlink'

Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
 t/t2000-conflict-when-checking-files-out.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index f18616ad2b..96bae6c53d 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -58,7 +58,9 @@ test_expect_success \
 
 test_expect_success \
     'git checkout-index conflicting paths.' \
-    'test -f path0 && test -d path1 && test -f path1/file1'
+    'test_path_is_file path0 &&
+     test_path_is_dir path1 &&
+     test_path_is_file path1/file1'
 
 test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	mkdir -p tar/get &&
@@ -127,9 +129,9 @@ test_debug 'show_files $tree2'
 
 test_expect_success \
     'checking out conflicting path with -f' \
-    'test ! -h path2 && test -d path2 &&
-     test ! -h path3 && test -d path3 &&
-     test ! -h path2/file0 && test -f path2/file0 &&
-     test ! -h path3/file1 && test -f path3/file1'
+    'test_path_is_dir_not_symlink path2 &&
+     test_path_is_dir_not_symlink path3 &&
+     test_path_is_file_not_symlink path2/file0 &&
+     test_path_is_file_not_symlink path3/file1'
 
 test_done
-- 
2.43.0

