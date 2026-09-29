Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78233BBC0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660857; cv=none; b=nnXnUTpHFjo/FQ0NDe1YP50Ztz/YzITzXzB7c/vss8gUCPJrWWPkG9XajzfeQDUPJKTTNeL6J2NjOYDhXiW2E1u56c7o9U/9lb8yq8Zdum1psqsxC19bd+8uXVE0KuF3J+BbaUNSzbu7BB9PCTsMJZ8dHIPRddce223xQJAex9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660857; c=relaxed/simple;
	bh=U4BH59nYyKz0PhuZz9fckxU3ojhNtPMyhAPY+Or00Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mC1sofligD42+3h9DnkBxn9ld3L8rzw35VI47desrxSYXy9aaeO8d7WLuv0wSjfZDucz2EYUEm5VkcRHn4jfvgAxtcSYgJC47zmYxj/4A2ewZg5xuIwVN0tR5YLecN8kMfOdfcDSfqX/D6ASYn5OixgUUyoHcsh8XSMylcmUAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=IJ3plo5p; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="IJ3plo5p"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341fe27b718so3717012eec.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790660855; x=1791265655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/JHYgUghyZ+4Kr0UVPxrRJqP/pBpuWAwejW+r2OOiw=;
        b=IJ3plo5pWajzXt4od8rDhJyk0vh2TjhazQzM7nSV3zFG1UU9tmwLnu+VlkC7HB7bbF
         VzkIMzBkqni5qD1fouZxD93HqP+SPRJpba7g6+FnKoMfaa3w7VKRXn7C6UJy+3c2DMX4
         +A0q9plEICiGVx3c8UEKnTRewGoG94FcLRTuh5Iu/uk89h45S2x5HT/UkdXtGuVkKAl/
         VA84OwCai+h0kSypYrE57Hn7nRc2g7kcXhFAi8y1PSn1beYpDn+kj+J9M1np2q+HxOut
         WnAOVgDPbOiVedxicNzXiUQ+T/t7FKH+qEEzkC3KCJMraEifxfTStaeooBZZApe9HA1z
         DT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660855; x=1791265655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/JHYgUghyZ+4Kr0UVPxrRJqP/pBpuWAwejW+r2OOiw=;
        b=AN7xq1nXw0TbbtlRrcVHNJ5AoqDJPo0/C0KhuySV2jMoAUbH/mbrsCwqEvmJsIqp6X
         nfct0OveVXTcnD76tBBv2dxmxzMOV+V+LIYYefj8uzScPGPYMwSDI0FTwKLfVFw+g8vj
         Y4XNEdXrfxE3DYD7hDhJLxJ+qbyyTV/8t0gDGBCmb5C/AFU0dqUntVwlYy+XuZd3DBwX
         Ji1euO9kFPeTawot8pRsaYPEJ65TP6y7hhCaCrNur2iCL/8QvGqHhJHYfdgm9xUpr/Xs
         4U3ZB3aRzoY3kWnI0CsBpVaqnMymTyv41Hk/I8aHlhZ1ey4iaxFkEWK5AqGmDtgmlHD3
         jxRA==
X-Gm-Message-State: AFq9FYKyerPwmlSUb1EfR3Unyi2QED+3IiY4iIcuOM5VoQmk4efVVZMo
	C/mTLCXTi18p6ZgEq60ecy5K+l47sPP3GuuZLm0Q9tTi0Xh6KvWASDxTNcIqyQF7ue4=
X-Gm-Gg: AYBFou3n/5gqrA8PZi2RiWAjju7aYsnuwPDXFLEK+1IdQPlJfzFiuxdtgo66ahVsaja
	YeJMHac4ZlPRBqKwqLLsm0oaTegewZkK/FbpFZFcotGxyVoavsAlmo4BGMWLYpz0JbZFCbp8Cmc
	xh5pfD885u411Vd39pHrfBvsDxsTgvONklZhwLbsVrD5BiLuc/ICxaTnUVD01TCkhczpXhwUTch
	p8tqExv2l7Zec5tBjJCRrhgC7ETYcjiZGVZbQjMmwvu+EV3ZAIMulF1AOloDWyoHKe3EySX2A0a
	HbPpkR1xGC2DiYS0jZrkUpEuUjptKM44VPcPjBa1GgUiv6pcnMapHpXf/P2cU0Bk7dTbN42/bz8
	TFdxcJp4w8BgzY+oApJCQ6+gbwJf1cMvp/g+KNKKUlhfATU4irctMJe9m6XfPZ/fwuqj4YLw3d9
	n1OMKDaR2vI1efXxREIwTk5Ml7a1JK50TsZhCJuJf8+sFEsFnLlQ5IOgpWaI3SlXztvTCrj336P
	QehYzmqMjObJJop2GC19vor3chyD8cECg1fpDY=
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr12117814eec.8.1790660855207;
        Mon, 28 Sep 2026 22:47:35 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34571658054sm14172751eec.8.2026.09.28.22.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 22:47:34 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Mon, 28 Sep 2026 23:47:12 -0600
Subject: [PATCH v5 1/2] git-contacts: allow inputting patch via stdin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-git-contacts-stdin-v5-1-e9becaebc47e@brighamcampbell.com>
References: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
In-Reply-To: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=U4BH59nYyKz0PhuZz9fckxU3ojhNtPMyhAPY+Or00Jo=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9bugI+THt/TcZFbcXrecqntNXbaP/bodof8+Rp01cIga
 s7Pp2sedZSyMIhxMciKKbKo3JqlfnGy9aODEfwTYOawMoEMYeDiFICJlPAxMqwJ4OlWcRe+rDjt
 TaloV4NU5ffjv/hfOW+tc9d/3yf44QLD/4JeYwXuyYosIossP+q0qJhOEHjty2tu8GBO+ywnbyk
 uFgA=
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make git-contacts accept patch contents via stdin for better
interoperability with other utilities. Read from stdin when the user
passes `-` at least once:

$ git contacts - <patch

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 contrib/contacts/git-contacts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..df7b920d9e 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -162,9 +162,11 @@ if (!@ARGV) {
 	die "No input revisions or patch files\n";
 }
 
-my (@files, @rev_args);
+my ($read_from_stdin, @files, @rev_args);
 for (@ARGV) {
-	if (-e) {
+	if ($_ eq '-') {
+		$read_from_stdin = 1;
+	} elsif (-e) {
 		push @files, $_;
 	} else {
 		push @rev_args, $_;
@@ -172,6 +174,9 @@ for (@ARGV) {
 }
 
 my %sources;
+if ($read_from_stdin) {
+	scan_patches(\%sources, undef, \*STDIN);
+}
 for (@files) {
 	scan_patch_file(\%sources, $_);
 }

-- 
2.55.0

