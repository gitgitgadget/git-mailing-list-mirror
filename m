Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179471EB193
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691041; cv=none; b=ilaw4U/DoUgYmOLkJcKLEZ1k/1/D4hzrGuFqOBw6mJkRQ4MHGZNwFUkGeUxA7Os65HzgadZ0UN/c1TKG3mBlPj84jZ/gSJE5FE0SvGwJyqmYTWupbwB83/ka6YxaaBU2GDe3brlHdV55qf3mRUeiDbXTYHFgwqeGxczsbh2SpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691041; c=relaxed/simple;
	bh=geQgd4nYBnxYXdaxGm8JTDt/dtnGyHzUeO14Q/yAIgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FthFR5wenYCt8nsiIvfTAz5UWHioxxlR7vQngR6Hbb5NHIMJQPpLG0yrOpnvTdU4ViWIAqHoxO2ZhGBu4Y21AwtKKVhdtP7ssI0BL3LMZMxU9iYl+90pcHjg4XDFEWTdGnFzdngvuM1PNBZB0DUNux35rKnkVgKIUMZaLr50eJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HKT7MRZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0VV878c; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HKT7MRZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0VV878c"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 582261D00150;
	Tue,  2 Dec 2025 10:57:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 02 Dec 2025 10:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764691038;
	 x=1764777438; bh=ipGSUUR/R/eT/Xar76lYdkHniCp9JIJ5l3YNgekM78c=; b=
	HKT7MRZ7ygwDVxK07S3M9lzD2c0hw6kUJkiQ1OIzkOLoABu6UdHdQkJxzl6OE2uH
	exYU88WoOTsWffDmCxCOXWVYAl/w+PPAa0dx0NClPXjKUXNqFevI8Heg2fLWYXMx
	5sq4CFmSeXuZD2SqYouiXJsg87Y7dGLbjh1Z5YuHE7yk5YyRay21vMcLQrR9+Yyz
	9uarWPqQgDtRhLs+4PUlPO3IrF45sgvneORPgxuQqQXCXs079tEoOHw78VpURe9l
	ctKyNu0Anh1fc4TTdEQuw8gi0oUtBb27v5FTv5ChszXCJCkmZDUt8BZVMIB0+kUq
	KtnytBceGAIWX/kULpj4Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764691038; x=
	1764777438; bh=ipGSUUR/R/eT/Xar76lYdkHniCp9JIJ5l3YNgekM78c=; b=H
	0VV878c9f67zT6j84saN60f2xiYFPcOzBTZLkZGYti75CJL0gssadowD8Z0NCS8A
	yQ9mk2mDeF40hjp0h8t3wI5hesX3Z0pLsfQUs4M/8wyqnOvRR4n8o10GILzQSSeE
	SHhQTUhxKI/cXH5eDEZK/+s4k/DQiY/3L0lWsD2+KxihjgBe8NYmozJhru8hKojg
	iljK0Ozl3Q9BLp9rtd+/LWTrAF/uzqhfltM4zv+dQWPF5VD4VurgoMxfkCpgm5+U
	f174ZVGoo3ORYqjO+2gZ3/WnkvCa8F9XRTGsohpOfOFe1A4aP0jmNIaF9X1oA+cQ
	16M8o/1Hm/Cjys9YMXJuw==
X-ME-Sender: <xms:XQwvaZzAor5F7bqigXXv6BMa0jn3ohZT4iveY8fpHefpF6YB6VzS8Zg>
    <xme:XQwvaZcgcXBxCd7RcbhwSI3odNxH8h4yxvzgwP3Qhc7625Fqv6teOUwVh35Lqzc8a
    h1nMWcD4F2uW-fhcQmbJsUs7n5tzcBHeLZ35UZx1gpmarAdEfAdBQ>
X-ME-Received: <xmr:XQwvaVLTgKielbZ3_Y2gUFHmaFAmVsgJXKxj01tKOiIoGw8H3Z08EuLQ8Zz8lXkOzyEzSI9XjbKcActONOzmqfW5Q1m8OPe2_64AIbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkof
    gjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhje
    ekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:XQwvaaEjFFLXi2H5nAsoTCbQnTRCLqHigieNq2fOEMUCIVQca054Ew>
    <xmx:XQwvafq8mR4dBJlj5-OW3l9qMxqwz03vXAdLDAtyhahz3hrthLzb3A>
    <xmx:XQwvaTTFSgVcbyBxsq3aP1RBZLRfPmpJzLvDw6fiMf5a8ERm9bf8mQ>
    <xmx:XQwvacOmxAOAR97cZiNpCpYfGGSYm6kIAVy9T_BvaMqoy-C0jlGFtQ>
    <xmx:XgwvaUU6LD2Cnel-teTicJSOcswCV8D4gbdR9NecCIzJsAfzzjT4Z4vh>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 10:57:16 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2] branch: advice using git-help(1) instead of man(1)
Date: Tue,  2 Dec 2025 16:56:51 +0100
Message-ID: <V2_advice_git-help.53@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <advice_git-help.64@msgid.xyz>
References: <advice_git-help.64@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

8fbd903e (branch: advise about ref syntax rules, 2024-03-05) added
an advice about checking git-check-ref-format(1) for the ref syntax
rules. The advice uses man(1). But git(1) is a multi-platform tool and
man(1) may not be available on some platforms. It might also be slightly
jarring to see a suggestion for running a command which is not from
the Git suite.

Let’s instead use git-help(1) in order to stay inside the land of
git(1). This also means that `help.format` (for `man`, `html` or other
formats) will be used if set.

Also change to using single quotes (') to quote the command since that
is more conventional.

While here let’s also update the test to use `{SQ}`, which is more
readable and easier to edit.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    Improve commit message by expanding on why we want git-help(1) over man(1)
    according to feedback from <xmqq345yjejo.fsf@gitster.g>.
    
    See this part:
    
    > But git(1) is a multi-platform tool and man(1) may not be available on
    > some platforms.
    
    This is according to the feedback from that email. But is that really true
    when e.g. Git For Windows bundles a Linux subsystem with Git Bash?

 branch.c          | 2 +-
 builtin/branch.c  | 2 +-
 t/t3200-branch.sh | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/branch.c b/branch.c
index 26be3583471..243db7d0fc0 100644
--- a/branch.c
+++ b/branch.c
@@ -375,7 +375,7 @@ int validate_branchname(const char *name, struct strbuf *ref)
 	if (check_branch_ref(ref, name)) {
 		int code = die_message(_("'%s' is not a valid branch name"), name);
 		advise_if_enabled(ADVICE_REF_SYNTAX,
-				  _("See `man git check-ref-format`"));
+				  _("See 'git help check-ref-format'"));
 		exit(code);
 	}
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 9fcf04bebb2..c577b5d20f2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -591,7 +591,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		else {
 			int code = die_message(_("invalid branch name: '%s'"), oldname);
 			advise_if_enabled(ADVICE_REF_SYNTAX,
-					  _("See `man git check-ref-format`"));
+					  _("See 'git help check-ref-format'"));
 			exit(code);
 		}
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f3e720dc10d..c58e505c43f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1707,9 +1707,9 @@ test_expect_success '--track overrides branch.autoSetupMerge' '
 '
 
 test_expect_success 'errors if given a bad branch name' '
-	cat <<-\EOF >expect &&
-	fatal: '\''foo..bar'\'' is not a valid branch name
-	hint: See `man git check-ref-format`
+	cat <<-EOF >expect &&
+	fatal: ${SQ}foo..bar${SQ} is not a valid branch name
+	hint: See ${SQ}git help check-ref-format${SQ}
 	hint: Disable this message with "git config set advice.refSyntax false"
 	EOF
 	test_must_fail git branch foo..bar >actual 2>&1 &&

Interdiff against v1:

Range-diff against v1:
1:  057269c683b ! 1:  8904bb016de branch: advice using git-help(1) instead of man(1)
    @@ Commit message
     
         8fbd903e (branch: advise about ref syntax rules, 2024-03-05) added
         an advice about checking git-check-ref-format(1) for the ref syntax
    -    rules. The advice uses man(1). It’s better to use Git’s own git-help(1)
    -    instead of an external command.
    +    rules. The advice uses man(1). But git(1) is a multi-platform tool and
    +    man(1) may not be available on some platforms. It might also be slightly
    +    jarring to see a suggestion for running a command which is not from
    +    the Git suite.
    +
    +    Let’s instead use git-help(1) in order to stay inside the land of
    +    git(1). This also means that `help.format` (for `man`, `html` or other
    +    formats) will be used if set.
     
         Also change to using single quotes (') to quote the command since that
         is more conventional.
    @@ Commit message
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +
    +    Improve commit message by expanding on why we want git-help(1) over man(1)
    +    according to feedback from <xmqq345yjejo.fsf@gitster.g>.
    +
    +    See this part:
    +
    +    > But git(1) is a multi-platform tool and man(1) may not be available on
    +    > some platforms.
    +
    +    This is according to the feedback from that email. But is that really true
    +    when e.g. Git For Windows bundles a Linux subsystem with Git Bash?
    +
      ## branch.c ##
     @@ branch.c: int validate_branchname(const char *name, struct strbuf *ref)
      	if (check_branch_ref(ref, name)) {

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.10.g08704017180

