Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3822DECC2
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777143; cv=none; b=WmeVDWdkrhos1KK5CDphNhNNAPewAtYGyQPaZQ3lwZrXyv+QQK/1JJePnGnSGxwZSJFWphnNKihichvuifYiwzv2S+kKdvFhdTFVKt3bbRpSCQmyEcEkrlz4oOZSjbBeg6F9F2nkRvd/DQZXknasGiriV/ehaULQRyRYLxiz+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777143; c=relaxed/simple;
	bh=GGIObNKI/RS9LBl1WKBUo5Yyyj2QQ4fHR+w71tbXq6c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rFVeSCissfQAggsHKZ1yHU0JjHp2+xNYv0GQeqiQR4sUcX0dFJudQXMfXdY7Db++1tzR988BxZ++KatHGFQiwwfsgbgLTe5lMAgmaHOa+gjWCeKt2HNkqKjt0AuXWMSywwIXi/Bwp4l7O5CTjhFSPqg77DCxPO84E1OTSRALo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs+Qv3aQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs+Qv3aQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5506b28c98so3722265a12.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777140; x=1760381940; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T/Kj3KS1nAOtOn77asYj8R8HE5EJkCyFjDCFReWyqo=;
        b=Hs+Qv3aQDXqAUyp4i1VrvKDy9HtoF3lU4ieXRIvJj03hj/rWH5IOtXfnu5H1BxnN8q
         H+kOcTUEfQ2kH/GM/240QwjoPopTML6m+Nw9CrPv1VfrVQDZwlMVK2Q2dCwACmzXpIvQ
         U3kdRMluTD67HeiOtTAWK2dP65A9A4yJK6uHdq+wPips73Ry3pSt8/j1OE40Ofr67r5n
         K2TTddxtDDpaGXhH55m3pSjWd0PD9ZDgTEpkbQEqIe9eRkCAQP8M57kpta27M1A9c4mK
         RiwWuEvHSD4OtwBVJShONl97b0BNN/esKhyelljw4g6xdG+hWaZBuosIpdrSlOJu/4PP
         itaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777140; x=1760381940;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T/Kj3KS1nAOtOn77asYj8R8HE5EJkCyFjDCFReWyqo=;
        b=FKTAh+DKUowslcPP+16sbVZ7ufq8r7ST36epNeRxACfwfvd4RBxukWk+PSU3vqK06i
         l0c9tTk5TpqtuBMtmhoaUtf9t3YFuX+oWS2ZH9WAZTNA8fA3V+u8daIM+ssCFyljVQEF
         FGYfsPaMwC9uLKNE51uouimJFgUVu6Y1G5zunF+M0wra5i2HOI8xu/cXHG5t93PbDeHZ
         47FQVL/bOKWkYrnQ2u/cU1KKa1/UMyKd1QPmSZUjMtW+oiJD4XYz6qdunx0dWxjs/dbc
         +KPOyIwrPNhCNg+ImZw+4Z8Fb13tItWcUox1wIQOobUPRgVEt+rZ5LIw9CVHh/Yx4ynJ
         CSKA==
X-Gm-Message-State: AOJu0YzqD2hq/8LHUBC3FEQT5X2w/4RKF+rDNLO25M2nKdg05dvYSKdl
	y02vvr4+WyMnp2Ch6MfykQ+NYcVkraAR/vCUZUm1aZx8K4ObhXA5LvS6X6VXDV1u
X-Gm-Gg: ASbGncukUMvQUGzX1lkCzwsJseno+L6SVcyOs0fDoWDHpKLGwiZDDqrOfF7hzSvXnYs
	6pvSsD5+IQ8tF3RQMWBlzHtbSURC1DYNmO7kjUU5H1O7/WY/AXsFhi3js3KnI5nV8wkvTZGi1ra
	hktKti6tu/52g18oTSonM4BDwUU6T+Jk7RGF094IW8e9b3fQThGdeKZ6s8vsn9iCRegbVxVEQhK
	Vyae999mskvDOVpdp3Ra1Lwjv/8qUiw/ap4EUo8ue4rZc3Z9zxBe2w5qWqA85/9cFOnh8NI0Rbx
	J4ntBb3dTDl9Px/MmSeFManU/9lD5LkSZsT1DApVLW1edYLUzB07U2Gfmd8uGqBGezicj5L46uj
	EnTP0K7XfpqibcxAgL/Mk2lZySEdiXZhzFTF/bw0fQLO0dEGWVOFv7aiS329t
X-Google-Smtp-Source: AGHT+IHma5cHrTjeN/WfFkcV4PjnbJ80ScEBA87qLh7Q/SQjJBNDqgWL2IWeA85U1xu5OzjIIgDgxQ==
X-Received: by 2002:a17:902:d54d:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-28e9a62036fmr158963515ad.45.1759777140275;
        Mon, 06 Oct 2025 11:59:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87e7sm141202555ad.82.2025.10.06.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:58:59 -0700 (PDT)
Message-Id: <8e82c508f6104d763fa05b74ebf8316010265ff0.1759777131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 18:58:50 +0000
Subject: [PATCH v5 4/5] doc: git-push: clarify "what to push"
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
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: 6 users says they found the "what to push"
paragraphs confusing, for many different reasons, including:

* what does "..." in <refspec>... mean?
* "consult XXX configuration" is hard to parse
* it refers to the `git-config` man page even though the config
  information for `git push` is included in this man page under
  CONFIGURATION
* the default ("push to a branch with the same name") is what they use
  99% of the time, they would have expected it to appear earlier instead
  of at the very end
* not understanding what the term "upstream" means in Git
  ("are branches tracked by some system besides their names?"")

Also, the current explanation of `push.default=simple` ("the
current branch is pushed to the corresponding upstream branch, but
as a safety measure, the push is aborted if the upstream branch
does not have the same  name as the local one.") is not accurate:
`push.default=simple` does not always require you to set a corresponding
upstream branch.

Address all of these by

* using a numbered "in order of precedence" list
* giving a more accurate explanation of how `push.default=simple` works
* giving a little bit of context around "upstream branch": it's
  something that you may have to set explicitly
* referring to the new UPSTREAM BRANCHES section

The default behaviour is still discussed pretty late but it should be
easier to skim now to get to the relevant information.

In "`git push` may fail if...",  I'm intentionally being vague about
what exactly `git push` does, because (as discussed on the mailing list)
the behaviour of `push.default=simple` is very confusing, perhaps broken,
and certainly not worth trying to explain in an introductory context.
`push.default.simple` sometimes requires you to set an upstream and
sometimes doesn't and the exact conditions under which it does/doesn't
are hard to describe.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index acdf25e5cd..aa01efcc0a 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -26,18 +26,20 @@ that isn't already on the remote.
 The `<repository>` argument defaults to the upstream for the current branch,
 or `origin` if there's no configured upstream.
 
-When the command line does not specify what to push with `<refspec>...`
-arguments or `--all`, `--mirror`, `--tags` options, the command finds
-the default `<refspec>` by consulting `remote.*.push` configuration,
-and if it is not found, honors `push.default` configuration to decide
-what to push (See linkgit:git-config[1] for the meaning of `push.default`).
-
-When neither the command-line nor the configuration specifies what to
-push, the default behavior is used, which corresponds to the `simple`
-value for `push.default`: the current branch is pushed to the
-corresponding upstream branch, but as a safety measure, the push is
-aborted if the upstream branch does not have the same name as the
-local one.
+To decide which branches, tags, or other refs to push, Git uses
+(in order of precedence):
+
+1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
+   or the `--all`, `--mirror`, or `--tags` options
+2. The `remote.*.push` configuration for the repository being pushed to
+3. The `push.default` configuration. The default is `push.default=simple`,
+   which will push to a branch with the same name as the current branch.
+   See the <<CONFIGURATION,CONFIGURATION>> section below for more on `push.default`.
+
+`git push` may fail if you haven't set an upstream for the current branch,
+depending on what `push.default` is set to.
+See the <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> section below for more
+on how to set and use upstreams.
 
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
@@ -696,6 +698,7 @@ a `git gc` command on the origin repository.
 
 include::transfer-data-leaks.adoc[]
 
+[[CONFIGURATION]]
 CONFIGURATION
 -------------
 
-- 
gitgitgadget

