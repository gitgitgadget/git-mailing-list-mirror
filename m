Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CA265623
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534361; cv=none; b=LAC/C02C5+uHbYIZsmnHGwi73xDb1Qc+Xf7qg9gNH+7W3K06UktMnfYlkTHcuS4BHMHw0ox6eso+nAdiLLqeBghlQfACXNOL71UJRtSV5/trVS/TqBf6HOmZeVyKs9CMY5Li5qTgWNUmkPCe9BEWUpXLoO1t06aimCdR1prsFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534361; c=relaxed/simple;
	bh=+YcPan0slxL2/RwOzWFVtezci0IEh++vx1wHf49I+Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=j4Gezo4yzUcMnbawlYA+ouacUuxldxThV+UYudQFug9pXor5lq7/k/dxkNtDR7EfO2ucLq19+6DB48Hi3qtCdwPcbd9JVQTyra9g7p8/6qCCQPj+VCJOUq4EvvJRh9HbkVFATPHKZM/tc9MC45S3i+6sLUSrOWhGPtF+fWtd47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=gHtMzmbc; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="gHtMzmbc"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b5c61966d0so317888b6e.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1789534358; x=1790139158; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiVZViEGdMUYdehkh+qdyzVi9nqIb9mjLkwgzzFrb4Q=;
        b=gHtMzmbcrw0jk2kDz277ZpfgVK3rGYWusUrh5ioLwhQ3WhzDYCZ7JFcVDrxes9anPY
         9sXhNHlKN8+ArQpyeDnyNekyeBoKSDOht81Wvrx/YdvWGIpgbEwC31Fl2vKtvF3IV/xC
         ml6oSi5PTo8hgi5sJO/C6/bveo9XfkNSz6ZxAV6CfVk5bb6apnPVX3xlA68H6CX8yios
         KYzlgqjVrC/ReU+IvStidMyuPKcxqEKejlrSdzAZ0DIQQN6mJBHDsXBlzlcvdHo99NcZ
         AyIbx5SKZE6490KPBiv/yei/KAUVYR2D8I4SuVFFUzYQmls+hl/XbyUOhTtgxGOPKg6i
         L5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789534358; x=1790139158;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NiVZViEGdMUYdehkh+qdyzVi9nqIb9mjLkwgzzFrb4Q=;
        b=zDOjTClLS/pIJkmU0DgAwYwTTCpYNn+mYeklZmY7dlAyAnauAxxiKFVm5HPMGpBmkm
         kDNOaGbtI2m6cxf2ky2SGdjtEIX7rYdY4h1rw+jGq7Bs8ErniQs/XVAi4AUZzpML4XeK
         p1awHo9C0myiguUHJA8JPndhqMiMI0vY0prXH8gdYxAjAA5cqgxhImZFEG/+l/q8Zr++
         ML/kc9HSPo5Ys8j2g+dPI3Yiil4FkluHlbnl5jpb4uFqV0//DG1+u0CFFxhSGR45CG9q
         KY2Zk95qW8oL9huGpW52NRs+5v19r2+6dwrLz9XUg45a/pUEqGi9Uqqp9xA1+pGAdgIA
         nBgQ==
X-Gm-Message-State: AFuF++nk3/gKYEUG/iW2H3ogNTb+dxS7DaqCNdRI5O/zv0Pbdx03Yp3m
	7cDqoLV/vnZp4DE9KVRgEuNar2MHoIMgkC1r7KN1e5JavzDHuSdYi3F7PsPx92wNzPKTq0HRMxA
	MkcIR
X-Gm-Gg: AYBFou0figzLdTMTBYshOrPUNT8EDG0+AoJP/l2OhG+CWMhFgUuYXAx9bGZ6fWyR44h
	I4bk/Fo0AJMJQAVvKX2CEnwVYiDOL7sdA+uJ/tAQ/NjtVUpTJNmYA1jN+lupknd+ciyBEWQykVj
	vluyzzCP6ERIubxK4AEy8WUSj5/kS1w/aYjkZqyzEYWtjG2ZwigDxxma/tf/K9zjhoSY8Nua8oT
	jdDVspZtqMqOGQhTr+E79/sBIdeJ2K4menMdhfVZV7EFRyh+/6/FMy2A/8SpHtM34Z7sKCIkIIw
	NQfT5R7vGUnqiol21vlmY2LJwvCD9PzKkQe5kdnVrKP9nh3+dfq3YAWS7faFtslrdbAIF4T+bv0
	hVdvTE1kMN3VwXMlXlaIIs37WCKu2fu+nsngfDWqpg+5UMG3jyoY0USv5/YB3WQ0Xy1KVRGaMy5
	zkOpJE1x4cG/cuDkdtcpD9WABLFDcAh4yZ5vn6khUfONeEZXRsfS+xLa5UtuLd9MlZQyy6K2fDq
	jACjweMbEIEleZnDqqhxlGflgMKit2I13zSHgY=
X-Received: by 2002:a05:6808:1201:b0:4b9:e5fa:8903 with SMTP id 5614622812f47-4ca4b7385a8mr1431080b6e.22.1789534358435;
        Tue, 15 Sep 2026 21:52:38 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ca2377ac00sm1581208b6e.8.2026.09.15.21.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:52:37 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Tue, 15 Sep 2026 22:52:23 -0600
Subject: [PATCH v2] git-contacts: allow inputting patch via stdin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0K6tqathlBX3sOwaIcBxkBLOpVoC
 HcXcO/yJe+/vwjGRMjiViwi4UxMMWxgToWA3oUOJTUbC6NMqay+yo6yhBiyg8ySc0NBaqyMtRe
 F2nqxDaeELb2P6KP+Mb/8EyHvpd3oiXNMn+N11rv392DWUkvroDQVlm1j1N0n6no3ghsnj8Nwh
 jiKel3XL7fC9ozQAAAA
X-Change-ID: 20260914-git-contacts-stdin-1e829930e19b
In-Reply-To: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>
Cc: Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2488;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=+YcPan0slxL2/RwOzWFVtezci0IEh++vx1wHf49I+Ks=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9YqhUkpXq328vkdxp+MV0WfdW5sm6W933ySJutKgx3fz
 Pq3+CZ2lLIwiHExyIopsqjcmqV+cbL1o4MR/BNg5rAygQxh4OIUgIkcaWRkmJAlEjZTYVdKivx9
 Twfx3Z4LXk/T+3qP7fNnT0OhqnvpBYwMB1cr/t6QdrBYOCmT8/DCC/uj1+7aUr3qwiyNZXmn9p/
 s4gEA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make git-contacts accept patch contents via stdin for better
interoperability with other utilities. Read from stdin under the
following circumstances:

* stdin is not a terminal
* argv is empty

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
I authored this patch as the first of a two-patch series to enable b4 to
automatically determine patch recipients. The second patch modifies
.b4-config to wire everything up. I discovered, however, that the latest
version of b4 doesn't pass the mbox "Fixes " header as it should. A fix
is queued for the next release of b4.

The second patch of this series will therefore have to wait until the b4
fix lands in the latest version, so I'm splitting up this series of
patches to git. This patch is useful and warranted even by itself.

Link: https://lore.kernel.org/tools/20260914-mbox-from-auto-to-cc-v1-1-fbf0c3fbd460@brighamcampbell.com
---
Changes in v2 (Thanks for your careful review, Junio):
- Minor variable cleanup / un-spaghettification
- Include update to usage comment
- Remove Cc trailers from commit message
- Link to v1: https://patch.msgid.link/20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com
---
 contrib/contacts/git-contacts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..03d03135d6 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -4,6 +4,7 @@
 # git-send-email --cc-cmd option, and in other situations.
 #
 # Usage: git contacts <file | rev-list option> ...
+#        git contacts < <patch>
 
 use strict;
 use warnings;
@@ -158,11 +159,15 @@ sub mailmap_contacts {
 	return \%mapped;
 }
 
+my (@files, @rev_args, $read_from_stdin);
+
 if (!@ARGV) {
-	die "No input revisions or patch files\n";
+	if (-t STDIN) {
+		die "No input revisions or patch files\n";
+	}
+	$read_from_stdin = 1;
 }
 
-my (@files, @rev_args);
 for (@ARGV) {
 	if (-e) {
 		push @files, $_;
@@ -178,6 +183,9 @@ for (@files) {
 if (@rev_args) {
 	scan_rev_args(\%sources, \@rev_args)
 }
+if ($read_from_stdin) {
+	scan_patches(\%sources, undef, \*STDIN);
+}
 
 my $toplevel = `git rev-parse --show-toplevel`;
 chomp $toplevel;

---
base-commit: f0ef1b96a076d08dc972a8d2cb0d1cfd60931eb6
change-id: 20260914-git-contacts-stdin-1e829930e19b

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

