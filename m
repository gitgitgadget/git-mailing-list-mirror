Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616891E9B2D
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674985; cv=none; b=vGMfkEOW6nnta2pKE5VfjHaOTjFNH19YR/BKsaBQ/tiYEHIpNnLBBa2ncK8VRpIPMTlujE4vlh/puUb8xOAZt1tP+eRkz1tHU68AfveptgMviL+3itsLNyOqqJYdcmRoWGgxKE3bDuSUcXy5vn/EEr+ZHI6pLDv779BOVMHx16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674985; c=relaxed/simple;
	bh=r5l17+0NcpNpK+4tQPJJ9Pe+bEHyJ7RdWLfZmNaes+M=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YR9wPmPExGNe1X/BSUV5a34k2tyS1IkFTGaRq3/k2fl//XwLzJXxB8RY+1Qvj9EzQ1fC1EcD6oIHq2FLbESCJA9kJDv3ey46ib85VifxEuQm4p3KbFL1FsaaMFnFBuK2Z2GTyMvy6wg+3hNjxTGNCGYbVw1MUPi3csD9f6zWDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcA9Za/j; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcA9Za/j"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459e794b331so15369665e9.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754674981; x=1755279781; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qx4+7Cre9QmYrXeXTdOarI85GvRo97uk2g7BYSSqQoM=;
        b=OcA9Za/jgxsYCY7HwQNT+Vr6DQecVlEbtUtByg6yEp2DVXVxxfGZSRZI3RzAgHCTtV
         kYOlZAgkrEOE92QmTWEtBnirI2TRnN4ViKA4pMREPnWEJLj59ENx9JohQawzuNuxNadU
         in4lxL3qFxQY+8F/uuRWVmNQJrE8K48Igo2LUBwoJ5f44n3xcYbslLFEgtI+GAmIROTF
         DY3Q67V4cxOXqbS0bSS9/yLdrKOBvpJAurMo+Z+/ZYBCzXzaIvaPx+1t2yEStJM2ahQ4
         92aEOFZzpDaxNfp98wGdm1KnUXI7mnTRwE6g22c0hM4evYrlGWHwTdZaQKCmg6jG+R9e
         NRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754674981; x=1755279781;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qx4+7Cre9QmYrXeXTdOarI85GvRo97uk2g7BYSSqQoM=;
        b=Lr7iezxZzyeSF3jbvwt2EnI8NT938mIl9KEvYARrWf4HIVpW8poRgKkr6yPFQ5fdM2
         E/P2FN4U+ugAUmC/7S5pFc/pEfrOTBiQgNYwWccezJ2J7e0sZ7XvjZSSTc5HN+AjKX7N
         Eq7qwtPZkL8vOEesXc4KHkhVGRGNE+oMyuBGNmpCl0Im0KW4jeryjcY0YjKSbmzmdqh9
         keig0ohgEODoNsEIfN/8umYHWOqR8ObQizgE3RzzfZhB/pwCgaJXBKimtkxj4cyVeMHQ
         kIJKeNvrL9Itc0R379GH71qHsqs8+8Eh3VL9oA92UipEIEdcjIqApVg55Zygzp5PSKCZ
         MSPg==
X-Gm-Message-State: AOJu0YxWVi0/cE8v0EkEz+NEShEGrapkY1qail9lomARU/nzRjdQZom0
	B5mRou6jnepuKsloJCxXguAne2fSdtYnAP4ZC6TXETT69Iz7yFEwE03Er2W+NA==
X-Gm-Gg: ASbGncvUONWhFuHStS3M/eCKeZ1SA5qVz7WTraa7Eigb4VHGVmQfT1ZI42QILkzRjCB
	ASPNaPzEp7vp8YHH4DhzLwzA6oWRus4FL04GrPoDLn8Sz3u+vt2y/2rVi4x8FCno1Aa8m5NGoh7
	ENV00yPMqCwKw/pPnDKB97Zyuo740DSoWgMN1qb0FfWw5j+0yUCxONIhnY7w0yhY5+uXSs0+Dfn
	GzClXFrS8DKTJvkRqYW+q0Enj/ihHWZxS/afnbGXKZKUHwMsdPMpSEXpw4H3US+m9kdRb6IzTwQ
	rurQwWsrsAH83nz4xA6tLp9ehA5iIhlLb0ovYY+WfOOW86xlqDDovNiNJ8RgDAU+ldKhs1tTa7h
	BsAX/M0ErC4xB7hbeCa9a7QI=
X-Google-Smtp-Source: AGHT+IEFBAs4UxkXJESKlQmUWJ29NWzw4tCuLU+P14tVtuQNp11re9jr93qGWhv1FSy1vVIXihXF8Q==
X-Received: by 2002:a05:600c:b99:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-459f4eaa292mr28443625e9.6.1754674980960;
        Fri, 08 Aug 2025 10:43:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e075047fsm101554255e9.1.2025.08.08.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:43:00 -0700 (PDT)
Message-Id: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
From: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 17:42:59 +0000
Subject: [PATCH] git-jump: make `diff` work with filenames containing spaces
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
Cc: Greg Hurrell <greg.hurrell@datadoghq.com>,
    Greg Hurrell <greg.hurrell@datadoghq.com>

From: Greg Hurrell <greg.hurrell@datadoghq.com>

In diff.c, we output a trailing "\t" at the end of any filename that
contains a space:

    case DIFF_SYMBOL_FILEPAIR_PLUS:
            meta = diff_get_color_opt(o, DIFF_METAINFO);
            reset = diff_get_color_opt(o, DIFF_RESET);
            fprintf(o->file, "%s%s+++ %s%s%s\n", diff_line_prefix(o), meta,
                    line, reset,
                    strchr(line, ' ') ? "\t" : "");
            break;

That is, for a file "foo.txt" we'll emit:

    +++ a/foo.txt

but for "foo bar.txt" we'll emit:

    +++ a/foo bar.txt\t

This in turn leads us to produce a quickfix format like this:

    foo bar.txt\t:1:1:contents

Because no "foo bar.txt\t" file actually exists on disk, opening it in
Vim will just land the user in an empty buffer.

This commit takes the simple approach of unconditionally stripping any
trailing tab. Consider the following three examples:

1. For file "foo bar", Git will emit "foo bar\t".
2. For file "foo\t", Git will emit "foo\t".
3. For file "foo bar\t", Git will emit "foo bar\t\t".

Before this commit, `git-jump` correctly handled only case "2".

After this commit, `git-jump` correctly handles cases "1" and "3". In
reality, "1" is the only case people are going to run into with any
regularity, and the other two are extreme edge cases.

The argument here is that stripping the "\t" unconditionally gives us a
minimal change, and it addresses the common case without bringing in
complexity for the uncommon ones. If anybody ever complains about case
"2" no longer working for them, we can do the more complicated thing and
only strip the "\t" if the filename contains a space.

Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
---
    git-jump: make diff work with filenames containing spaces

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1950%2Fwincent%2Fstrip-trailing-tab-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1950/wincent/strip-trailing-tab-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1950

 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 3f696759617..8d1d5d79a69 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -44,7 +44,7 @@ open_editor() {
 mode_diff() {
 	git diff --no-prefix --relative "$@" |
 	perl -ne '
-	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
+	if (m{^\+\+\+ (.*?)\t?$}) { $file = $1 eq "/dev/null" ? undef : $1; next }
 	defined($file) or next;
 	if (m/^@@ .*?\+(\d+)/) { $line = $1; next }
 	defined($line) or next;

base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
-- 
gitgitgadget
