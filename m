Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61462409130
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570281; cv=none; b=aRntqawMaDzt/drrD26ChOTYbmt9eriaka5mtYlsTQvArtPFLaB0qswvKvfyRtzX2iaA0J4levIp5H22QFSbfRuzc5QGg8+J1IHHx9Viz4rUpZUeW2O882hteD4NAPg19CTV1EnryxsioDRkJEXPogJnIsAGmOPv+0ailFZ+S0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570281; c=relaxed/simple;
	bh=qFQwykepKUAySNZ1YI5GQovyJOu6UCF9TfP94pBvN/U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jtX3CTXvEqMI2hgWhSzdRrCXBlyoeOYmzF7D4HKPsUhnqvR15XEvLTRT882xPKFszdYSrWObvR4sowAEZCg9R22Pp4vDTnJqsmv9x5/9scm4s+6NOdrgihC9aPGljpD9t/Sse2TG3puDB5wPwX/mQSpqKtyknZ95LhC++ZA9s+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaFDiCuv; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaFDiCuv"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304d7f31215so408392eec.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570280; x=1781175080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqP2fY6rKJzzpSTAcY1rBYkn75r3kiZh0R1UDn6hM00=;
        b=WaFDiCuvaZGkT+JjbI0Jgc9V79sjkVivN3RN0qjKqcMHYerc6NxxjXrGTgXYRI10zQ
         R+Y8wUt8Yu8FhP8HtkD1XXV3ueGmuz41GMBq1+Vd+8lUt5sF3Y4xYVxKF4Lcc0uoJ6/+
         bD0euGerMbgnbadxBp5//jwPrbL+x3xagSNQqCQ0qd3VXET3TerT4J9yd/bHvwlcUeCf
         lJuZInpFgzFiKqD9gPKMMgGkWnTIkQ/Ut2BhNMClDljPxDg2LTRp+PVHDJHIO5IuUSv3
         szzOvjVJ/3KwlgmywbLlTZHtAJD93pCgZxx/ygmZb4kR9krQHxCy8EmEIym3BEn06fya
         T5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570280; x=1781175080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqP2fY6rKJzzpSTAcY1rBYkn75r3kiZh0R1UDn6hM00=;
        b=FzMpDtocDIzJ7GOU6nkjxMtgBkrJIOTcQhgMXct0ACWrA8XFVP6g0baURE0py/jYLy
         s7idzP7VjHCV5icxOJW6dPGsxd5kdmqs8IyR4nnScMs4yTS3u9I7vxvflt5n34FUDDJG
         ZWGl6UbVJ+OyckH4rguMAyu4iwa0Vvqcn8HU8dVm4eHRjoWro74pbSLhNWKfI3OzFBjO
         H0BMguDB0iZXAro5HRWeM2/t2lR4uoGOSjRhaTpYaV6oW5FbFEzd50b7M1+aC+sIxlh7
         0sKeDak9/me5DjToSPDiL6R4Yw10C8N/jYo9oR34asrYJX5aANR9uVrHCcT990EolaiZ
         o/dQ==
X-Gm-Message-State: AOJu0YyiTrzmlls7TKi2baSducWZ1r1oQjgV1bjqjODB7Jiiuvfl5JVe
	xb2OYnGxaOnRXCMXzmgCk1SOmUuF/oOKTfCzty3+XoNnaaDjcS2WPoeB/OEMAQ==
X-Gm-Gg: Acq92OFQhYLSlrxRIeaCnfYpZtM3D73yp2GzD7TrDR4Sieosg75TiY3oTPufRYEBWnH
	f2LmGHyOzbEewfoRgpGsXsC2UTtW1ymiv/eFHvPXZMPdx08dw4OvHz8FGeW6rRZyQ7x9Nil1D3X
	wuh0U9il13SyW4fzr18JDrHXBsWl3gd10hR5j3vbCHtkvUQ1vvr+ngOpw8r8bhWPliS0q9toVes
	MpYGStZnsW4KtL0gjHSkA+qsVEIdBlpnLhNJA3TFNTrnFxJ78jOzy728lvyR26JUBF57YGfSJvH
	LA8nlsFS7G98Lh+q3K8GFb8M/F2C7VWfOcJ+bPJRgreDsSC6FN+Hc6pdxVvJxSHwyfqA9E4XmWn
	qn3KSP8BNkTMUoYAeadfOYrOxLYR8FvzQgJF6dvMJyLE6zB/CdxSjA3JjyHU/jQgUj4NN4zVAG+
	0iiwLuzmofdjOjEf4LmhIyOcWT7HGKB43XMHGIhA==
X-Received: by 2002:a05:7300:2391:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-3074fbc7eb5mr4006835eec.17.1780570279484;
        Thu, 04 Jun 2026 03:51:19 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm4814278eec.2.2026.06.04.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:51:18 -0700 (PDT)
Message-Id: <ddb75326cde9695f1eb7bbbe77175424e6b77004.1780570273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:51:08 +0000
Subject: [PATCH 3/7] pack-objects(check_pack_inflate()): use size_t instead of
 unsigned long
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`write_reuse_object()` learned to track its packed-object size as
`size_t` in 606c192380 (odb, packfile: use size_t for streaming
object sizes, 2026-05-08), but the comparison sink it feeds,
`check_pack_inflate()`, still takes the expected decompressed size
as `unsigned long`. The call site bridges the mismatch with
`cast_size_t_to_ulong()`, which on Windows turns a >4 GiB object
into an immediate die().

That function only uses `expect` once: as the right-hand side of a
`stream.total_out == expect` equality test against zlib's counter.
zlib's own `total_out` counter is `uLong` and is therefore still
32-bit-bound on Windows. Widening `expect` to `size_t` cannot fix that,
but it is a strict improvement nonetheless: instead of dying outright,
an oversized object now simply makes the equality fail and lets
`write_reuse_object()` fall back to `write_no_reuse_object()`, which
decompresses and re-deflates the content (and which the larger
pack-objects widening series targets separately).

Drop the `cast_size_t_to_ulong()` shim at the call site now that
the receiving parameter speaks the same type as `entry_size`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fe9fbecb30..975f04d699 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -453,7 +453,7 @@ static int check_pack_inflate(struct packed_git *p,
 		struct pack_window **w_curs,
 		off_t offset,
 		off_t len,
-		unsigned long expect)
+		size_t expect)
 {
 	git_zstream stream;
 	unsigned char fakebuf[4096], *in;
@@ -671,8 +671,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	datalen -= entry->in_pack_header_size;
 
 	if (!pack_to_stdout && p->index_version == 1 &&
-	    check_pack_inflate(p, &w_curs, offset, datalen,
-			       cast_size_t_to_ulong(entry_size))) {
+	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
 		error(_("corrupt packed object for %s"),
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
-- 
gitgitgadget

