Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726449505E
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440131; cv=none; b=J7pxsKVc6YlU2azxMTWKTIAcqRtotOEdCchwpSz3fwEB5H9urejST6zKnhteKRlrNWOkPTo5WkKS56JRqpqPrg5ohYhE2/RyRIFsG73DqCYXaOhj3X6M6G8qwfecGToP4JnBC15Z97+LBlMY236lv/GOnUI2GHtGcwuopkYLp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440131; c=relaxed/simple;
	bh=Dq2iDK8JXQUqjgy6UrDTM327ps5aVj47G1dizV4nhSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpC6X++X1p31hnhKvj6OE7f5naHtpFNMMufCIYWQXeHeUmvVppwYkpA2d+cJs0Q7qruimh32huXzMZrKMNI7p+wf78+//37C9Xjvx8m45lTYUcJSsBKsFaJZt/naslHIgKsrvPAfbDwW/9DQSQqk/do+ZQb7jd5qiMD/P13npyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=XvWKI7qQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="XvWKI7qQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48441a2ba14so2145042f8f.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788440127; x=1789044927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vjIldN0C15vqVR8fxORZIWMx5cmlV7Mpp86SnLPRrg=;
        b=XvWKI7qQR1TrK3UR3eZg38juxlgmSX6Vvghbi9FrK7p65wp6vVMbUA92KQg4tHvUMe
         DQ8bjrU23b6l1iVWRS2yk1a99pnhYJxeOKlTjJbGOSxk50TEuAYQVjm+bGU9wyn8UAyX
         gLVx1s2MR1rBHPRgqIJrRfJGkz1EHDpO6UUNIAfMYHpZgz2G9HP80SbvZSDLfqcRLuo4
         04xKjFrU7AKehOQMwZO8dKcjE14KgJr5MPazztQvse3GsXlCbzRjEqZrsfS0oZ66E1LV
         Ot68qc7nBrjO4y/vPlgVErFe2jkcMeyh5nobHghK+MxKVzNFA4an/VQ391Z4ElJQiDwH
         glHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440127; x=1789044927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4vjIldN0C15vqVR8fxORZIWMx5cmlV7Mpp86SnLPRrg=;
        b=JyzCFigFcO+z3Ya6Cg+IG4XDMWP67orHfCkJYY0liTVsyyAfcRBxLYbiKzLKUKE+gN
         2HSRELJznxPBjkxXyCMDgY9XpDfkJHrQyeUAmwA5T2owhvKAmw2uHcSQA8f6mvQ19Nhv
         ENUcj/FSoQ2Ft2nGlR3nBMGXFyJAO1YnBVyLgS82xP1Yb55thzlQO1BLHBN7W1NfroE0
         n7nNj/XKZRhfumpt0XDqnvY9Xg7+8H5rar0my4jwX0ntSAQ5s7TxiEnt7/XIpFWBZmZh
         dc4R1QVLPgKbmDZFJ2Eq9RNRzw7Xk1bY6iC71h0Bu+4GK0YjhocACZo/XN5ckMGarmtO
         Q+Ug==
X-Gm-Message-State: AFuF++n5buZWfW8oxJhi+1hOSemRoTD+DLGSHKluYfgip9tvGtQow5Lb
	iPlW1E+DSKPY5eeTHx1yDZk+gez3nQmeNUyUJvRkR/WfXC32/0zk79vEeW/Psq2rOqiRwaR8+Is
	VmSNbRO+/pw==
X-Gm-Gg: AYBFou1dwf1LQCXiw6BwkI7zeDj82UnFSXe5rIZsVevjLiN1ckwK+KinDYnFYENe8d2
	il16XogsTSjs7zclHaEgVb67dQJubD22vL75sESV96C4raTRsNO6qr+vTTltDWgmZILGPAfEZOf
	a81fSSi7vMTMgwtH9HQmKJQGswqO8JJFgkMz8R7whDzTNwBbzg/k/Hz/GHV4+JtNZFaduCmov5l
	lTGEf5IvgIAXmD/bVewd/fgJ9UtW+HbCEWxES1nnToBp7gfAWRh5wEmUK5OqSxHej44TwvXvkna
	/A+fl0lCIkxcJZPrD7Qdz/gs/c5a6nYp02CQ26lHh8HHcG0aeuiz2HBDI6zEFzRiffK0zw7idMR
	iA4Tl+uFYqxLRJe9ARezZko8+M6qH98j6TsdUGWUbplq6Rpa1Z89MO9IcPPr/cH1nFXxHpqQqrv
	UfMS31RIXqKXbEzzjGetxOGLNJ5Q4E3DE6cD6PXji0gE0pw0MHowBW29p2jXRPo3xOMcvd
X-Received: by 2002:a05:6000:4555:b0:485:847f:fd90 with SMTP id ffacd0b85a97d-4858480018dmr3367552f8f.3.1788440126869;
        Thu, 03 Sep 2026 05:55:26 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeae34sm14684502f8f.32.2026.09.03.05.55.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:55:26 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>
Subject: [PATCH 2/2] doc: cherry-pick: note --no-commit skips CHERRY_PICK_HEAD
Date: Thu,  3 Sep 2026 15:55:24 +0300
Message-ID: <20260903125524.67889-2-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903125524.67889-1-f@lex.la>
References: <20260903125524.67889-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list of what happens when a change is hard to apply states without
qualification that CHERRY_PICK_HEAD is set.  Under --no-commit it is
not: d7e5c0cbfb (Introduce CHERRY_PICK_HEAD, 2011-02-19) skips the ref
on purpose there, expecting the user to pick further commits and edit
the result before committing.

The option's own description says nothing about the ref or about
authorship.  "git commit" reads the author of a cherry-pick from
CHERRY_PICK_HEAD, so a commit made after "cherry-pick --no-commit"
records your own identity as the author.  Picking a single commit this
way still leaves its log message in MERGE_MSG, so the result reads
like a faithful pick apart from the author.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    The trap is sharpest in the use this option's own description
    recommends.  Picking several commits in a row leaves one commit that
    carries the last picked commit's message over the combined effect of
    all of them, under the committer's authorship, with nothing on screen
    to say so.  The added text scopes the "git commit -c" remedy to the
    single-commit case, since after several picks there is no one original
    author to restore.
    
    One more thing worth knowing when following that advice: if the picks
    were made with -x, the "(cherry picked from commit ...)" line lives in
    MERGE_MSG, and "git commit -c <commit>" replaces the message with the
    original commit's and drops the annotation.
    
    I left git-revert.adoc alone on purpose.  "revert --no-commit" does
    write REVERT_HEAD (t3507), so the two commands are asymmetric here, but
    a revert's authorship belongs to the reverter either way, so there is
    no equivalent consequence to document there.  Documentation/revisions.adoc
    describes CHERRY_PICK_HEAD without the --no-commit qualification as
    well; I can send that as a follow-up if it is wanted.

 Documentation/git-cherry-pick.adoc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index 42b41923d5..d352e7e956 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -25,7 +25,8 @@ happens:
 1. The current branch and `HEAD` pointer stay at the last commit
    successfully made.
 2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
-   introduced the change that is difficult to apply.
+   introduced the change that is difficult to apply, unless the
+   `--no-commit` option was given.
 3. Paths in which the change applied cleanly are updated both
    in the index file and in your working tree.
 4. For conflicting paths, the index file records up to three
@@ -101,6 +102,11 @@ OPTIONS
 +
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
++
+Because `CHERRY_PICK_HEAD` is not recorded, the commit you make
+afterwards records you as its author.  When a single commit is picked
+this way, `git commit -c <commit>` keeps the original authorship and
+log message.
 
 -s::
 --signoff::
-- 
2.55.0

