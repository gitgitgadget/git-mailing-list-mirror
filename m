Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7A17C
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733011268; cv=none; b=BrNuJln9hD9ttyeOS4ahpJhePdJSJVhuXUmQWGsTrrkVqV9g7bOwHA4zjQ52NrNkdSn/h9Hlu/sGaFlA0slF4XZzRUCXBhcJLI0kyQl5jY/fE4TsPG2O/HKd68GbOhcrKB9IRejc1AIEAmsCHKomFbn2+mzfeNJV0zDeqdy+ZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733011268; c=relaxed/simple;
	bh=uoRL0aLYseYZ7NpTLhXhVkayCl+TtjhT3NK/Nz+ZRuY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bj9Rx9yXhAXpzmrr+n/90PDPgwWKL4iNUmlT9pl2O7Nz1Eyci24Ou+1MwP9lzZR7CvugELLiPc/RusucVtyR+jvlWBNMfX6dMdhxw/dtT7fsBQXEB2RK3yOiW32kggOulR/bQfkRi4PKWyQboUtSYvhU2EfUfSiVu1haBSOkt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0HMY+P25; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0HMY+P25"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef1921383bso30633357b3.3
        for <git@vger.kernel.org>; Sat, 30 Nov 2024 16:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1733011265; x=1733616065; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=da3Hp5E3r8emfXELm2gWlH4OaV3/jK9BBVEtI5OU1+c=;
        b=0HMY+P25RPftW9482rfW5klXBAD+uz6r4KeJb5nMrvk6frOZQEvrF9gQugrnGP6FC6
         RmItoEjtx9koZmkWkh6ZnR8MdkkdFHN/4vI+LBXvXURNeay9zU3Jwxrq32L6g3R67VWm
         SMeJxQFOR5cK6ucs78jKbosNqL9mhXXt+Btjrrnj2I7eFdRf97HqikpqKdXFAVVN+cxC
         DC5wR8ZSko4/1098fpnidzmg5PPDFbqwsGmsNPQTaQF1cl5fshl2AvPdBOx/xAWgwNw6
         s3vTUy84HXoElC1+R7bVo7yDN46XebXtPEO6MXcTL2ICeIRFHDgrq17gjtgx4H5ky7Dv
         pvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733011265; x=1733616065;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da3Hp5E3r8emfXELm2gWlH4OaV3/jK9BBVEtI5OU1+c=;
        b=mLPSMq2Wp5WOrdOm3ad99XCKWB26t1jA/rQN1k7bIi9G/Dp/mp2LZnMyUIWzvRQ4Y7
         1lDMZkCOjVytUGe2SKzYCD8+SRsk10DMV9fjsmqBvohUtnp/aZPCSpmevK+PcZncct7d
         KQzzEtqHIqpI7YKcQvFW3w0ZOtSW33qHvxMpA5FMcC/d6BVARvQsnZtyuoXRkfqp6OUi
         Y0HA3EPHaYxTlOpuSmdyiE0szW97PB9WcHDHYBcac303HsGTyX7D0mUnXj6GPoAVUEAI
         Dwcx9J/ekte24gXVuJphfOjZIEX9tnXqoTX0+ku95opzy/dzmje6KMga7i5KB0YqudFF
         fhXQ==
X-Gm-Message-State: AOJu0YzEaJ/vtoQ4bURpVvAM9Anlx97dmS2rGziZq1xa7xUeDge3aCSt
	y14nFrF9m2KEfSwywoGt4OO/0unjh52unIdwTNfFxFG1cys7b0K9D1j+rapxVZS8lbpwIA4kOnK
	A
X-Gm-Gg: ASbGncsLnu0siO6WV/L9lbSDTTx3fiEHzKjqBZQ6xjfx0sw98zTyyd+z/hmlv1WbgeD
	dMQx4VseoR3RGOYZRXGcmygADgIC7mbKBRamMrfpJhebbJcudE+8B2vM38p9wXQP4KS4Tdsnwlj
	cVXJsU3xTRTLUVM42ne3bWtYFJdaAvzm+dxNPkfuJ4svbmdfWIDLo78K/JoNzvVDPZaZ05WrJH/
	9RKfZIWnsOX8ETu90QuXtBVZ3ves9Vmt/l2tOeJ9a3IB8IQqHo2q2VMIK8VyuZ3a84ptiiOyPNi
	LLwK7zPNJ0npP41lcAmaew==
X-Google-Smtp-Source: AGHT+IGtqdLP1J/jg89SaaK7fuvRk2/rP6dxNGdrIFJVtUbeHUP5uolLLj+RG9E+ia1alSHhSy5CPw==
X-Received: by 2002:a81:d406:0:b0:6e2:1bba:ed4c with SMTP id 00721157ae682-6ef371fc4d6mr145388867b3.17.1733011265195;
        Sat, 30 Nov 2024 16:01:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ef4db6c0e7sm15229987b3.58.2024.11.30.16.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 16:01:04 -0800 (PST)
Date: Sat, 30 Nov 2024 19:01:03 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/repack.c: prune unreachable objects with
 `--expire-to`
Message-ID: <48438876fb42a889110e100a6c42ca84e93aac49.1733011259.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When invoked with '--expire-to', 'git repack' will move unreachable
objects beyond the grace period to a separate repository outside of the
main object store.

Later on, 'git repack' will remove any existing packs which were made
redundant by the 'repack' operation, before then pruning loose objects
which were packed. Ordinarily, unreachable objects which have expired
were already packed via some earlier 'repack' operation, and so are
removed from the main repository in the first step.

But if a repository has unreachable objects which:

  - have an mtime earlier than the --cruft-expiration period,
  - are loose, and
  - have never been packed

Then we'll create a pack containing those objects to store in the
repository specified by the '--expire-to' option, but never prune the
loose copies of those objects from the main repository. That's because
we don't have a pack in the main repository which contains those
objects, so prune_packed_objects() skips over them.

(As an aside, for repositories that have a large number of unreachable
objects which were never packed, and are old enough to be expired, this
can be quite painful. That's because even though we expect the repack to
prune those objects which were GC'd, we don't per the above).

Teach repack to add the repository specified by '--expire-to' as an
alternate of the main object store so that 'prune_packed_objects()' can
"see" the packed copy of those objects, and remove them appropriately.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c        | 15 +++++++++++++++
 t/t7704-repack-cruft.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84ae..57cab72dcf5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1553,6 +1553,21 @@ int cmd_repack(int argc,
 							&existing);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
+
+		if (expire_to && *expire_to) {
+			char *alt = dirname(xstrdup(expire_to));
+			size_t len = strlen(alt);
+
+			if (strip_suffix(alt, "pack", &len) &&
+			    is_dir_sep(alt[len - 1])) {
+				alt[len - 1] = '\0';
+
+				add_to_alternates_memory(alt);
+				reprepare_packed_git(the_repository);
+			}
+
+			free(alt);
+		}
 		prune_packed_objects(opts);
 
 		if (!keep_unreachable &&
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 5db9f4e10f7..ee1ffcdae3c 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -30,6 +30,12 @@ test_expect_success '--expire-to stores pruned objects (now)' '
 		git branch -D cruft &&
 		git reflog expire --all --expire=all &&
 
+		for obj in $(cat moved.want)
+		do
+			path="$objdir/$(test_oid_to_path $obj)" &&
+			test_path_is_file "$path" || return 1
+		done &&
+
 		git init --bare expired.git &&
 		git repack -d \
 			--cruft --cruft-expiration="now" \
@@ -38,6 +44,12 @@ test_expect_success '--expire-to stores pruned objects (now)' '
 		expired="$(ls expired.git/objects/pack/pack-*.idx)" &&
 		test_path_is_file "${expired%.idx}.mtimes" &&
 
+		for obj in $(cat moved.want)
+		do
+			path="$objdir/$(test_oid_to_path $obj)" &&
+			test_path_is_missing "$path" || return 1
+		done &&
+
 		# Since the `--cruft-expiration` is "now", the effective
 		# behavior is to move _all_ unreachable objects out to
 		# the location in `--expire-to`.

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
-- 
2.47.1.314.g48438876fb4.dirty
