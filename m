Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71692DCC01
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777136; cv=none; b=nqbq2bNl8T6aLZOBirCFW7QbjCrivRixBZc39Qxrvd6vtdosefqlCturNd1acviBmR+DT9S7zqgdjNBYgVcqlcJcfzuTKEf0yO27gKzh3DxrEDvX3/1Cj98GqdlrrDejweYC77SC3MsUXffYz8NNJ9lUT0WMTQIkTry5ZoyFGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777136; c=relaxed/simple;
	bh=pXxAIrCSVEZzEEbxYP7wiLf6TQAP1GIx0VPw5w+KaP0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=By+2u9U3s1Gzo7cp4OTT4mP2J3t3vyxn8N/CSK8PKonUr8srs0v3X6QpZek3IStjRbQllJmmTlGsPPcsc91bpVE0bqAmd7SQAFBDceg5q7IR2vuhZItJii2xbBQ43WLMtTrFwoVRI65S1E7EqxnwsoP9Cc8z6brDA0aRIqSi4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcKmlimd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcKmlimd"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so3523637a12.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777133; x=1760381933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etEmuT9G9w3pEwnHJL2VrVF6GNeczEslm+a97cCFe0E=;
        b=VcKmlimddVD570jd1dYUF/yo0AxIWoBksXU5GT2v1KUsAEToK205InHdPFHr84nL2P
         C1B+GVwHQRiUsodZHTAzw0QLdBcdYs1wQ8GOCd1IBK2z3Y/AcFIU06glbjR9zokOWjZl
         M+Sa57FTNM27H3g8/hx8cV00e3aCZqc6/OspMesWQv+0AK/I8sgErScPXXVBxrsYiriD
         rw3CN+C/8U517RJ79EDBITXFvfaNodj6JDrNlJrL7liKhExuhqSYbRrS4CSQm6hpnoWv
         /+eMz8DbtPHXZDIYjgF2wbJKZpZ2SahflQTM6Pm33KRjkSOru5Q6wo+ChIkv+VMag8Fp
         sd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777133; x=1760381933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etEmuT9G9w3pEwnHJL2VrVF6GNeczEslm+a97cCFe0E=;
        b=cznvwPV/XSCZn27xbe0ahtMyRxafwLmr9cD9epCsN52y7EutSxxac73kfyCwHGrJqV
         5Cm72dobEkLTJHmeRFoN/MKidqWaiZNp8UqoIW8Wd//LWxWGFiQ8nM22sLVqHh5CAlC9
         qTH/KnGYnJQZDTnCkavahnK8JpDqJph0+Qd337tD3uaVnKCswJzxWM5I877Uasn+i0Dl
         hqttY/XWetKzSBKtQXo8TjL8R8GrEwmgIU24moOTTdSs+TeWAj9i1BjopGC7FroBnC0S
         nF9UafJLB3tyUB5SnG9Ub22pz8o76m1tfNEu22AElkgJGKmRqffKmDFDh6/wNcbUajmz
         0f3g==
X-Gm-Message-State: AOJu0YyDrMV4yzR/4bqxWQtNppd7LrYZAo3x98oKyxChsD4u37ytfFIk
	EY9yTsA6dZiBVG6gjm3gRiA0ctWWB/BSycvi6CESRG8mVAc4bS3B7YOZWbMQ/w==
X-Gm-Gg: ASbGncthChar7hMWM0f/ORpQJMjrrMJES9hgp8PlLT3Lk8zLSVB42tz/ayn5Nse2g+1
	Pfg5EShIMoEomPW2YdxGoTUP9SqQrFFBrYSDPPpya2lCRwiDDBLkGP3kCH0AURCCYEPSh0t/xsW
	9fK4q8TauZagEjSLc4uw/nVyh2zw30h6IrcS0hisuiIfxfG6Lkv7J+HBButCtUiPxzkJElFdWoN
	vMCaTldh5YAB/cjCXNxwo42rloobuaezmIyHaomsoPtizlADL/aj/B9yM4NEiLtwTXw3dtQhI7T
	Ee+TSi7uV8q7UoVrI4320MNeUB+t7Fy+4ZrMonvjdwRHyVtJ5Rdy4vcT8NZfhSPGrKdmPZ5Y97f
	EXntf+Q4hXMsV+ivOn8UJbgrqwubyRoVGkUob3W2Z4ssA7byjOAccmWeX1cdE
X-Google-Smtp-Source: AGHT+IEhCcCOe7CpgSztacWz29wccmXTnl9DCZEpM6qmZ9JJjueO7pWOtacANFjnVxLrmjM2ylsfMg==
X-Received: by 2002:a17:903:3c6e:b0:286:74e3:3889 with SMTP id d9443c01a7336-28e9a649b8dmr166782565ad.55.1759777133462;
        Mon, 06 Oct 2025 11:58:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d12b4d8sm140401255ad.54.2025.10.06.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:58:52 -0700 (PDT)
Message-Id: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 18:58:46 +0000
Subject: [PATCH v5 0/5] doc: git-push: clarify DESCRIPTION section
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>

I surveyed 16 Git users about the git push man page. Here's a rewrite of the
DESCRIPTION section and the definition of <refspec> based on the feedback.
The goal is to clarify it while communicating the same information. The most
common piece of feedback was that folks didn't understand what the term
"ref" means. Most of the users who said they did not understand the term
"ref" have been using Git for 10+ years.

changes in v2:

 * The biggest change is to add a new UPSTREAM BRANCHES section to explain
   what an upstream is
 * Drop the "refspec" changes from this patch series, I've made revisions to
   them based on the comments here but I felt like this was getting too big.
 * Added some backticks `` that I'd missed, from Ben's review
 * From Junio's review, "The current branch must have a configured upstream
   with the same name, so this will fail when pushing a new branch" was not
   true, so replace it with a less detailed but hopefully true statement.
   After a very long conversation with Ben I realized that actually
   push.default=simple's behaviour is not really that simple (perhaps I
   should think of it as more "safe" than "simple", since "current" seems
   simpler), so it's more realistic to refer any questions to the
   CONFIGURATION section which describes the behaviour in more detail.
 * Rewrite all the commits to explain the problem they're trying to solve &
   thinking behind them in more detail. Let me know if I added too much /
   not enough detail.

changes in v3:

 * mention that git push also needs to send data in addition to updating the
   branch, from Junio's review
 * fix a newline, from Junio's review
 * un-rename urls-remotes.adoc, from Junio's review
 * mention pushRemote and git checkout in the UPSTREAM BRANCHES section and
   be clearer about what's meant by "the relationship between the current
   branch and the upstream", from Junio's review
 * fix AsciiDoc formatting issue, from Junio's review

changes in v4:

 * Add "the simplest way to push is git push <remote> <branch>" at the
   beginning since (as discussed) this is the form of git push that's
   easiest to explain.
 * Remove "as a safety measure" since (as discussed with Junio) the reason
   that git push sometimes requires you to set an upstream is very
   confusing, and "as a safety measure..." makes it sound more principled
   than it is. Also update the commit message to say that the previous
   explanation was not describing push.default=simple's behaviour
   accurately.
 * Reword "To decide which repository to push to..." because I felt like it
   was still phrased in a clunky way.
 * Make UPSTREAM BRANCHES and CONFIGURATION into actual links in the HTML
   docs
 * Fix formatting in UPSTREAM BRANCHES section, from Junio's review
 * Fix some commit message mistakes, from Junio's review

changes in v5:

 * remove a bad example of git branch --track, from Junio's review
 * fix some formatting issues, from Jean-Noël's review

Julia Evans (5):
  doc: git-push: clarify intro
  doc: add an UPSTREAM BRANCHES section to pull/push/fetch
  doc: git-push: clarify "where to push"
  doc: git-push: clarify "what to push"
  doc: git-push: Add explanation of `git push origin main`

 Documentation/git-push.adoc     | 46 +++++++++++++++++++--------------
 Documentation/urls-remotes.adoc | 42 ++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 20 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1964%2Fjvns%2Fclarify-push-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1964/jvns/clarify-push-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1964

Range-diff vs v4:

 1:  d3160fb0af = 1:  4811ce1c86 doc: git-push: clarify intro
 2:  69825d4634 ! 2:  10a9718421 doc: add an UPSTREAM BRANCHES section to pull/push/fetch
     @@ Documentation/urls-remotes.adoc: git push uses:
       ------------
       
       
     --
     --
     -+UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
     -+--------------------------------------
     ++[[UPSTREAM-BRANCHES]]
     ++UPSTREAM BRANCHES
     ++-----------------
      +
      +Branches in Git can optionally have an upstream remote branch.
      +Git defaults to using the upstream branch for remote operations, for example:
     @@ Documentation/urls-remotes.adoc: git push uses:
      +
      +The upstream is stored in `.git/config`, in the "remote" and "merge"
      +fields. For example, if `main`'s upstream is `origin/main`:
     -+
     -+	[branch "main"]
     -+	   remote = origin
     -+	   merge = refs/heads/main
     -+
     + 
     ++------------
     ++[branch "main"]
     ++   remote = origin
     ++   merge = refs/heads/main
     ++------------
     + 
      +You can set an upstream branch explicitly with
     -+`git push --set-upstream <remote> <branch>` or `git branch --track`,
     ++`git push --set-upstream <remote> <branch>`
      +but Git will often automatically set the upstream for you, for example:
      +
      +* When you clone a repository, Git will automatically set the upstream
 3:  244c35ef2b = 3:  336023fbf1 doc: git-push: clarify "where to push"
 4:  c1d4ea8d27 ! 4:  8e82c508f6 doc: git-push: clarify "what to push"
     @@ Documentation/git-push.adoc: a `git gc` command on the origin repository.
       
       include::transfer-data-leaks.adoc[]
       
     --CONFIGURATION
     -+CONFIGURATION[[CONFIGURATION]]
     ++[[CONFIGURATION]]
     + CONFIGURATION
       -------------
       
     - include::includes/cmd-config-section-all.adoc[]
 5:  9435f0ce8d = 5:  ddeb8ecabe doc: git-push: Add explanation of `git push origin main`

-- 
gitgitgadget
