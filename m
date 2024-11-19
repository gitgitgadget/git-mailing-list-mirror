Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192A149DFA
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047021; cv=none; b=Aq7PEITZxXrASXZDATQ4ePdbNJTPSgjxC3JYkVjJh//F48Q0RtwkeBeA8tVqm0E9ujANe8eKGG6hi+Rntp8OIm/8sWOzzi/MBd00fD3YZqVeE0MX3SfmIPGDV6/3oxWMYHLiuVek0IbSQ0fNzfBuCirSUeJIFMgvQj9ce3wahH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047021; c=relaxed/simple;
	bh=uBul7BvKAgI1tJs5KsCcczvnjH3TGzgIOD3eSGQzkTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJKwQUpHzyk+S4FJqql2gJm07DtXpzQ4OLbvEQGt/pNv88GIOMWnqgaenp8H5xEUJzn5U7UE4RRkMkSOgc34OwG9tsLFReJQv3OWSU3uWG52igqLlA5us/+5ZdqGWyclIRlmYMjdnL3iKdM/vyji5N5EJCfktzzbokpXi0fyysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPQSkMol; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPQSkMol"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e381c19246fso2229104276.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 12:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732047019; x=1732651819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VQkINLRxIgOil2cAoZ7DLWSHvg10wsTutohKnByh+w=;
        b=FPQSkMolFW/FQrNg/QQbo+ZhVolSp7Y66BlJSKchdt35PRfsaDatUXdJXjC80dYlbi
         epLXBlCFr+GZqoOSYXDWZztpCaiCla5paHETqVMIGjM0i3lRCLruqq3NVyfjMawXwaZg
         j2M9UKQHiIINESteLmj8GbudvD2Qz3srNnoS/QxNo5wbyxpdiEqTfodytj8U+t/rMNis
         w2k6b+SbG+AvTO9B+QsVocR4VQ2u1KsQNL6Kpa3vpPGSHk1vCpo2UjkgGBSunQEB/bAa
         mdkG+wxLlRukqiDXt051qT1qO7eYpWFsWHhplpeT+uG2r2PJgus+wzTpGURqeF+sjMVv
         k2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732047019; x=1732651819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VQkINLRxIgOil2cAoZ7DLWSHvg10wsTutohKnByh+w=;
        b=lYIx39ssAAWcue2mbgJ3b4+4zS7XGhJDjNk2wAoL7ogQjZxZXlVfBfoVr7QX8vZvj6
         /GPoPqBEMEN6sMAD5I/mFhu8feQLRFYT+ExwAqWTTeY8Bb/AAOIeLtBTeF8cXWh8XrtI
         WMzp9rZ0uxvPwnFVpOuOGv9D/bgvtVUNBBIy9oywGTySRMcpbDQrUxjX6UMNgYglhMnK
         ogLDuyxFLdJ9KN13lqynUb5n62AAT9YSAaYAMH6f1NRpPwDbBPXE8vv7TW0ihtc7/m2B
         StceKDu0SPz+KopzROPzAVX6z/7cWYJ5MhPQXaiCjNniB+1L2DLDJjSYIUKcw37Au7+p
         om6g==
X-Gm-Message-State: AOJu0YyYx/9M8YHg4MnpgHBVrAmnxxNasI9TO8QzBvgH877CvbyhVHhI
	l4ZDUzzgyMQmtly4fWgNW5oCdhhT0R/JTXjFb84sAaGAZ2x9M02oMDxEr0KQ6Yjoaf5EmPPuQIb
	ZoQfyxhYHt43onAII9gytwqVYJ6vv6d8q2QYy3xNI2DeIwpDNQmp3l8oIZmp5B7DocghYJ7K14y
	16Ucz59lp/BSn1aHfzJKyVUmmvFUTWXFQd8gBzFlwa9A7ry2NvYzz4BEtNN2YuZa1STg==
X-Google-Smtp-Source: AGHT+IGPKVu2nZ+5zBGa+qUAsxW9MsCmzbqUmUtnNZHvFFin9vEzBzj5xRss44W+Vym/i5F2NBND9p2VsifbXxfNAwZk
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:51a0:16cb:9d09:2786])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:40d:0:b0:e30:cee4:1922 with SMTP
 id 3f1490d57ef6-e382638ecc8mr287191276.7.1732047018502; Tue, 19 Nov 2024
 12:10:18 -0800 (PST)
Date: Tue, 19 Nov 2024 12:10:15 -0800
In-Reply-To: <20241116032352.GA1782794@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241116032352.GA1782794@coredump.intra.peff.net>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119201016.22713-1-jonathantanmy@google.com>
Subject: [PATCH v2] index-pack: teach --promisor to forbid pack name
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Currently,

 - Running "index-pack --promisor" outside a repo segfaults.
 - It may be confusing to a user that running "index-pack --promisor"
   within a repo may make changes to the repo's object DB, especially
   since the packs indexed by the index-pack invocation may not even be
   related to the repo.

As discussed in [1] and [2], teaching --promisor to forbid a packfile
name solves both these problems. This combination of arguments requires
a repo (since we are writing the resulting .pack and .idx to it) and it
is clear that the files are related to the repo.

Currently, Git uses "index-pack --promisor" only when fetching into
a repo, so it could be argued that we should teach "index-pack" a
new argument (say, "--fetching-mode") instead of tying --promisor to
a generic argument like the packfile name. However, this --promisor
feature could conceivably be used whenever we have a packfile that is
known to come from the promisor remote (whether obtained through Git's
fetch protocol or through other means) so not using a new argument seems
reasonable - one could envision a user-made script obtaining a packfile
and then running "index-pack --promisor --stdin", for example. In fact,
it might be possible to relax the restriction further (say, by also
allowing --promisor when indexing a packfile that is in the object DB),
but relaxing the restriction is backwards-compatible so we can revisit
that later.

One thing to watch out for is the possibility of a future Git feature
that indexes a pack in the context of a repo, but does not necessarily
write the resulting pack to it (and does not necessarily desire to
make any changes to the object DB). One such feature would be fetch
quarantine, which might need the repo context in order to detect
hash collisions, but would also need to ensure that the object DB
is undisturbed in case the fetch fails for whatever reason, even if
the reason occurs only after the indexing is complete. It may not be
obvious to the implementer of such a feature that "index-pack" could
sometimes write packs other than the indexed pack to the object DB,
but there are already other ways that "fetch" could write to the object
DB (in particular, packfile URIs and bundle URIs), so hopefully the
implementation of this future feature would already include a test that
the object DB be undisturbed.

This change requires the change to t5300 by 1f52cdfacb (index-pack:
document and test the --promisor option, 2022-03-09) to be undone.
(--promisor is already tested indirectly, so we don't need the explicit
test here any more.)

[1] https://lore.kernel.org/git/20241114005652.GC1140565@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/20241119185345.GB15723@coredump.intra.peff.net/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on jt/repack-local-promisor.

Thanks, Peff, for the catch. Here's an updated patch, with an updated
commit message.
---
 Documentation/git-index-pack.txt | 2 ++
 builtin/index-pack.c             | 2 ++
 t/t5300-pack-object.sh           | 4 +---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 4be09e58e7..58dd5b5f0e 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -144,6 +144,8 @@ Also, if there are objects in the given pack that references non-promisor
 objects (in the repo), repacks those non-promisor objects into a promisor
 pack. This avoids a situation in which a repo has non-promisor objects that are
 accessible through promisor objects.
++
+Requires <pack-file> to not be specified.
 
 NOTES
 -----
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 08b340552f..05758a2f3e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1970,6 +1970,8 @@ int cmd_index_pack(int argc,
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
+	if (promisor_msg && pack_name)
+		die(_("--promisor cannot be used with a pack name"));
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aff164ddf8..c53f355e48 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -332,10 +332,8 @@ test_expect_success 'build pack index for an existing pack' '
 	git index-pack -o tmp.idx test-3.pack &&
 	cmp tmp.idx test-1-${packname_1}.idx &&
 
-	git index-pack --promisor=message test-3.pack &&
+	git index-pack test-3.pack &&
 	cmp test-3.idx test-1-${packname_1}.idx &&
-	echo message >expect &&
-	test_cmp expect test-3.promisor &&
 
 	cat test-2-${packname_2}.pack >test-3.pack &&
 	git index-pack -o tmp.idx test-2-${packname_2}.pack &&

Range-diff against v1:
1:  b5a0012531 ! 1:  226a627c25 index-pack: teach --promisor to require --stdin
    @@ Metadata
     Author: Jonathan Tan <jonathantanmy@google.com>
     
      ## Commit message ##
    -    index-pack: teach --promisor to require --stdin
    +    index-pack: teach --promisor to forbid pack name
     
         Currently,
     
    @@ Commit message
            since the packs indexed by the index-pack invocation may not even be
            related to the repo.
     
    -    As discussed in [1], teaching --promisor to require --stdin and forbid a
    -    packfile name solves both these problems. This combination of arguments
    -    requires a repo (since we are writing the resulting .pack and .idx to
    -    it) and it is clear that the files are related to the repo.
    +    As discussed in [1] and [2], teaching --promisor to forbid a packfile
    +    name solves both these problems. This combination of arguments requires
    +    a repo (since we are writing the resulting .pack and .idx to it) and it
    +    is clear that the files are related to the repo.
     
         Currently, Git uses "index-pack --promisor" only when fetching into
    -    a repo, so it could be argued that we should teach "index-pack" a new
    -    argument (say, "--fetching-mode") instead of tying --promisor to a
    -    generic argument like "--stdin". However, this --promisor feature could
    -    conceivably be used whenever we have a packfile that is known to come
    -    from the promisor remote (whether obtained through Git's fetch protocol
    -    or through other means) so it seems reasonable to use --stdin here -
    -    one could envision a user-made script obtaining a packfile and then
    -    running "index-pack --promisor --stdin", for example. In fact, it might
    -    be possible to relax the restriction further (say, by also allowing
    -    --promisor when indexing a packfile that is in the object DB), but
    -    relaxing the restriction is backwards-compatible so we can revisit that
    -    later.
    +    a repo, so it could be argued that we should teach "index-pack" a
    +    new argument (say, "--fetching-mode") instead of tying --promisor to
    +    a generic argument like the packfile name. However, this --promisor
    +    feature could conceivably be used whenever we have a packfile that is
    +    known to come from the promisor remote (whether obtained through Git's
    +    fetch protocol or through other means) so not using a new argument seems
    +    reasonable - one could envision a user-made script obtaining a packfile
    +    and then running "index-pack --promisor --stdin", for example. In fact,
    +    it might be possible to relax the restriction further (say, by also
    +    allowing --promisor when indexing a packfile that is in the object DB),
    +    but relaxing the restriction is backwards-compatible so we can revisit
    +    that later.
     
         One thing to watch out for is the possibility of a future Git feature
         that indexes a pack in the context of a repo, but does not necessarily
    @@ Commit message
         test here any more.)
     
         [1] https://lore.kernel.org/git/20241114005652.GC1140565@coredump.intra.peff.net/
    +    [2] https://lore.kernel.org/git/20241119185345.GB15723@coredump.intra.peff.net/
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         ---
         This is on jt/repack-local-promisor.
     
    -    Looking into it further, I think that we also need to require no
    -    packfile name to be given (so that we are writing the file to the
    -    repository). Therefore, I've added that requirement both in the code and
    -    in the documentation.
    -
    -    I've tried to summarize our conversation in the commit message - if you
    -    notice anything missing or incorrect, feel free to let me know.
    +    Thanks, Peff, for the catch. Here's an updated patch, with an updated
    +    commit message.
     
      ## Documentation/git-index-pack.txt ##
     @@ Documentation/git-index-pack.txt: Also, if there are objects in the given pack that references non-promisor
    @@ Documentation/git-index-pack.txt: Also, if there are objects in the given pack t
      pack. This avoids a situation in which a repo has non-promisor objects that are
      accessible through promisor objects.
     ++
    -+Requires --stdin, and requires <pack-file> to not be specified.
    ++Requires <pack-file> to not be specified.
      
      NOTES
      -----
    @@ builtin/index-pack.c: int cmd_index_pack(int argc,
      		usage(index_pack_usage);
      	if (fix_thin_pack && !from_stdin)
      		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
    -+	if (promisor_msg && !from_stdin)
    -+		die(_("the option '%s' requires '%s'"), "--promisor", "--stdin");
     +	if (promisor_msg && pack_name)
     +		die(_("--promisor cannot be used with a pack name"));
      	if (from_stdin && !startup_info->have_repository)
-- 
2.47.0.338.g60cca15819-goog

