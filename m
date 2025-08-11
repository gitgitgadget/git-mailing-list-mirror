Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD58248B
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913328; cv=none; b=QfVPiYyw6Mqd9kuZ/4PTZ769QoaGVseGbDn0fenlHRyI1L9ndewWBqHhYpB+T3EY/0LDi8c1dYOS0YPeTH8198j8VUy4fYrwdnqAnUfdWfJpflMNVw3LXSMhQQeVl5RZMZPHSloRJV13nzsy6dFtucDRYN1wP9vJKqrxJyFWb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913328; c=relaxed/simple;
	bh=qL0o1MBgKjB0qcUcyHNdmToiygvFTpTQOOsJ0Oiw7yY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pCt+ibzTt9+Af6J/4KqmU4QG5OIgWloCCbDKTtEDCX5kEWUN7hLRS6xZTekDN/VtvjNv1vRMOPvi+qkyBM4SLYyXqdwLMcDKqlfQy1LLoCLyuSat0T35C8+COdgy+GyiNSU67c124zw7m5zFXsRPdM5BLwvdvRrTX/m5X7cs4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQjEoWtM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQjEoWtM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459ddf9019cso13188465e9.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 04:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754913325; x=1755518125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmaJYRBQarzJvEKIrNEbevX7oQrhSRBq3TIODmgQSWs=;
        b=dQjEoWtMHness7DQia3yWk+xS52QMOSrY12Y3NZxZ4BRAjw5nZGKAjetS5TYqBYN3Q
         HGYVQo1j64T/DrXfiwTd3lvuFOAqRoF8rlPzHsN1pGyNHTBV9U2MRNKzlJ8Z4eXA7/V/
         +2k8KLH3f9Be4+f4paOnvYISi1TZi/58PgF8HQNalXTAzMwDYKr06wJJVVkxwZ6kPO6g
         I9WKOx0skZc8F+HS94+GiD6Hs632WuWz793AZqKdXujsLTTOh8dcW3W8Pq7oMZOq0dVh
         EGBUPf6sX+I31rXMhILgemI+J8j3I+x9QJgAahMtm08AlHEuXiVieB/55MtFF36RvFCd
         h2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754913325; x=1755518125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmaJYRBQarzJvEKIrNEbevX7oQrhSRBq3TIODmgQSWs=;
        b=uB3xb056xPhc/HDyypAOBxOdZebH6QyMG3fyJLF0EevcaIggaOrXepbQrMb5f7bYmC
         PkVNdDuP3LxyCoW1G1SPoDsM4Rd7QYUutyktURnYsLseOZ6WsaAmBFdOQpKoGSuxrRd9
         Uw89h7xUIYLZjdo+ISmIXBndXlhKMwhvOTIZ24tT37VNNE237ufjVdO1G9pCd1/xoUwD
         /SKRarsioFKIDp4kGnBNz5iGByPxSsPj2+Bt2Xi6+w3sp9QZ/C3GcRqwFe4j05Nez+Jb
         THI831nQVL/Gl4V5dAxbH2VPo8VxX9qWo/XTozqZDUflIhum1EKTb8Cfw8SAdOmAPBTA
         R8Aw==
X-Gm-Message-State: AOJu0YzcaJCpGiZRww29rsXAo2PdsBTuSOCUbBN87lnZb4Tnh9KNdwlz
	BiMFJOkwmkDaRpiTBwAUkL2hMKHA6iI3+vh54k8uHOsKISYNX9t36in7YcKwAQ==
X-Gm-Gg: ASbGncv+jOMsq0yc4KXreLE57oqO6yo3Z5tWVb2E+ewXbq9GLOdubrasmKgYHkQyzJP
	LobENQyRa4hEPCMM5xlRswfg4vEVeqMigMMnynNPUmukQNxuHKZyzHihVd+J1EnSDfAP5QwTRPV
	24rtT8Y7+FQt1ctlkWEdY/1ORNkMu7naPak8vKbiROsSS0B87RQ5d+U9GfEwT4kNY1FYgKPMjgU
	YpN+0vqfClaL1Bkw7AGdd8yl48MdeEZJXWRrIZQEM4VmkpFppbe6h0O7E2FoBTSfuDRzAy4dROX
	H0P0FkxpaqI5k67Y1H0nSaXju6befuTalL3OWjXrY8zO/8vbjcxJr9GCZTe8OaG7PfrAMNoLDCZ
	6Pt0Jqo5E5xQ3N4zZ88MPbg0=
X-Google-Smtp-Source: AGHT+IFxDkevAlm8x5su5MFdzVdO2Aap0ipwkAd81gCcg0RoJyznKBYitMRR1FqcbbQfqtAGy77q+Q==
X-Received: by 2002:a05:600c:354d:b0:458:a7b6:c683 with SMTP id 5b1f17b1804b1-459f4ea20d9mr97005035e9.1.1754913325087;
        Mon, 11 Aug 2025 04:55:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm41167984f8f.34.2025.08.11.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:55:24 -0700 (PDT)
Message-Id: <pull.1950.v2.git.1754913323810.gitgitgadget@gmail.com>
In-Reply-To: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
From: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 11:55:23 +0000
Subject: [PATCH v2] git-jump: make `diff` work with filenames containing
 spaces
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Greg Hurrell <greg.hurrell@datadoghq.com>,
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

That is, for a file "foo.txt", `git diff --no-prefix` will emit:

    +++ foo.txt

but for "foo bar.txt" it will emit:

    +++ foo bar.txt\t

This in turn leads `git-jump` to produce a quickfix format like this:

    foo bar.txt\t:1:1:contents

Because no "foo bar.txt\t" file actually exists on disk, opening it in
Vim will just land the user in an empty buffer.

This commit takes the simple approach of unconditionally stripping any
trailing tab. Consider the following three examples:

1. For file "foo", Git will emit "foo".
2. For file "foo bar", Git will emit "foo bar\t".
3. For file "foo\t", Git will emit "\"foo\t\"".
4. For file "foo bar\t", Git will emit "\"foo bar\t\"".

Before this commit, `git-jump` correctly handled only case "1".

After this commit, `git-jump` correctly handles cases "1" and "2". In
reality, these are the only cases people are going to run into with any
regularity, and the other two are rare edge cases, which probably aren't
worth the effort to support unless somebody actually complains about
them.

Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
---
    git-jump: make diff work with filenames containing spaces
    
    Changed since v1:
    
     * No code changes, but reworded commit message to include examples of
       quoted paths.
    
    Turns out that quoted paths never worked, so this commit isn't "robbing
    Peter to pay Paul", but rather, "giving something to Paul for free
    (Peter, sadly, is still out of luck)".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1950%2Fwincent%2Fstrip-trailing-tab-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1950/wincent/strip-trailing-tab-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1950

Range-diff vs v1:

 1:  afe01c156e5 ! 1:  03fa9ac1ab2 git-jump: make `diff` work with filenames containing spaces
     @@ Commit message
                              strchr(line, ' ') ? "\t" : "");
                      break;
      
     -    That is, for a file "foo.txt" we'll emit:
     +    That is, for a file "foo.txt", `git diff --no-prefix` will emit:
      
     -        +++ a/foo.txt
     +        +++ foo.txt
      
     -    but for "foo bar.txt" we'll emit:
     +    but for "foo bar.txt" it will emit:
      
     -        +++ a/foo bar.txt\t
     +        +++ foo bar.txt\t
      
     -    This in turn leads us to produce a quickfix format like this:
     +    This in turn leads `git-jump` to produce a quickfix format like this:
      
              foo bar.txt\t:1:1:contents
      
     @@ Commit message
          This commit takes the simple approach of unconditionally stripping any
          trailing tab. Consider the following three examples:
      
     -    1. For file "foo bar", Git will emit "foo bar\t".
     -    2. For file "foo\t", Git will emit "foo\t".
     -    3. For file "foo bar\t", Git will emit "foo bar\t\t".
     +    1. For file "foo", Git will emit "foo".
     +    2. For file "foo bar", Git will emit "foo bar\t".
     +    3. For file "foo\t", Git will emit "\"foo\t\"".
     +    4. For file "foo bar\t", Git will emit "\"foo bar\t\"".
      
     -    Before this commit, `git-jump` correctly handled only case "2".
     +    Before this commit, `git-jump` correctly handled only case "1".
      
     -    After this commit, `git-jump` correctly handles cases "1" and "3". In
     -    reality, "1" is the only case people are going to run into with any
     -    regularity, and the other two are extreme edge cases.
     -
     -    The argument here is that stripping the "\t" unconditionally gives us a
     -    minimal change, and it addresses the common case without bringing in
     -    complexity for the uncommon ones. If anybody ever complains about case
     -    "2" no longer working for them, we can do the more complicated thing and
     -    only strip the "\t" if the filename contains a space.
     +    After this commit, `git-jump` correctly handles cases "1" and "2". In
     +    reality, these are the only cases people are going to run into with any
     +    regularity, and the other two are rare edge cases, which probably aren't
     +    worth the effort to support unless somebody actually complains about
     +    them.
      
          Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
      


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
