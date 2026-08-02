Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4126A0B9
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785700679; cv=none; b=QxDVqroBtdVbzCc5EtP6IVGfIcueiSO3bPogyxaUw0NtTF8+hekrmxMwIcGeD2ZmrsTMbAWcX6s7uewYAYd/51fSepEUigjkVzScVccR5WOzF7XKv7G8S/t9/0pAB/BXRXB+w6zyX/dlHX/Ak5OvxxfkiygDOri5NVQGArULqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785700679; c=relaxed/simple;
	bh=q4IwiguMsHrC8UgDtwQbQNBsajaK4lWEo0/bVaM6LeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESORTz+4Ixnf0m7sQOhAr8iJARmT5CwwIBVMLSXvc0SIMvaRFeO3xPD9dJzjXrsQvyQRT8HD6pMeJAkmuuikZUlNUTs4kBpBQeXgfbHj61t1FH9nxumQ4khK9Te4YB+SMf4EjeTP38m5pjsFLGvbUIwQ72Ayr6wgQh0ohrR6R5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lfLD6hX1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T1a1qLB3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lfLD6hX1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T1a1qLB3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id BB7821D000B3;
	Sun,  2 Aug 2026 15:57:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 02 Aug 2026 15:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785700676;
	 x=1785787076; bh=3tgC9uw8jJ5Pwx76whWrG9b/fgs9AhNOEvBSji9M8Zs=; b=
	lfLD6hX1m72tBLQx72Te8lOoHhSil9FIkzOtkF/kgdDgLFxxjsB0rJB4Xi+h0BTC
	WTbqPuju4QphxNs0bDG1g86phvPPx5DtA9MttdrV0Wi5S8WsKsqlGkHWfYAmvjga
	i/izlhJoesFS5z5BqSoeVKnOGViZCOKblqeatZp+jUz6KaiNBiLF9pyLO60wFjpm
	NSkkbnnEr/hqoJWSTOM16ZrB/ioCcOygf7IKAtJhSARLn9ZYLMMAC21RyAfKHuca
	f9PDzmLzTBHCPT0G0IQnytqG8L29e5OyjvheaDXgSKCwsk33rlpJOp9ClAeRErq5
	uWrR9izF7S0kBideAAaRBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785700676; x=
	1785787076; bh=3tgC9uw8jJ5Pwx76whWrG9b/fgs9AhNOEvBSji9M8Zs=; b=T
	1a1qLB3sYH6hJrf3or+kNsiHLVXssPIi+FS4fCSDKJ2MZvr4MrtlQlZOXfQZnckN
	l/ZoVO+IDQ5AQiu4mRKJLjx9WE6szeeMTdZAozYrX2cyJdbaFr/zTseZmOry3RWz
	uXWoRGWP8yhrIGWp2oE9K54WGwYCWv1IqZ/lFJ9ek0EMg1oo08mzjnoRqEnbkjuu
	R7K0ACtt/3yglRC0DmVwL1bZ+E16V+/SK12ESOVu+Lp3wxBhAqU0BLo03nX/dzsf
	+unGE9HeZJLl3DgZj+0gCTAoXUmid1dtNWSQdXwmOrt0k5iTYsYkxqOjO5prd9vE
	k+OS/4HUKCV9ZQJ55b/XA==
X-ME-Sender: <xms:RKFvannyGx-d05pHDorfjrr7YaPnotDb-p5IHNUdfBwWRT8YyObZ1vw>
    <xme:RKFvaiTrHIKGpKRD03epzPvrTKaS1TLtEVcqAt4dvADSsesnrOIU0srDq6Idvvgos
    PP_WQYZ87HfwaRLsO0kuRvfThc9tkXDxwGf-oaoC_M4UP8_49qcyg>
X-ME-Received: <xmr:RKFvarB-QJNcUJ7wLoTb75SuAGa5fXQm35I4T-PFPmXGP3EI8pgHxqLR6ShBoIFFwhKJvKm_hcw5qVCtPwfaS2kYagYwgkJMZPSOUv0JqBXHcTJi8vjytxg>
X-ME-Proxy-Cause: dmFkZTF2eu+QHoCmoKLOQKbaZWue9jCyIduUf1IKhll9/bCu5fTgIvrnQ4Z6pLVe49Gen1
    Cn2QXNWVdV3kDxxX5GjBWLwsKlwbrgkPoi23kswgilUba9fTy0Ek4Mr2FClQC/0Iqeg3AD
    V9mB/J1O/cbqFOl9ReLp2+6rNlN++DGucD4EGfy7zB/X/2mtMU2oJ5YK6wTfo05mi9X/Kk
    6ZCu+sEs8/43iWTeCEbVqkn6rciXdpEkp32Yp2wiQT00t94oaL+LaepaaqKkla0QQ842xF
    TwnWtvkXwQtU+63ylQdIkcUTJt0OSQp9YiJtH4cvTqPr/7la9b0y71X80xq6+bOfXPubds
    /+Oa4V0vSDTDGyiSgLRwfZihZvyogvLfjs2AJ11fkwKFvpAsIdkmW+fmVlqvNs9H9GOj38
    U5jlD+3uvuYVZcY5WwIGH7ZZ+qSLIY7WWHqpWMPtD8dQgdq14GLxgezAzqhrh+2BWgcZ7w
    Jc+EFC26tsZPP+PKFKiYO3kLbB7fAzY62rOQJS1nWuCqMqVRiEU+WB5RPrmvmAd86uvuum
    T6MHI7YTnfIKkLLLDcapNEhLAkHCzKdDS1SKCCh789Vwk7H2CvECADLMptsCjym3s8t0TA
    D9a2QfyMtoP/D/B1gm4I+PwOkTwpyR43J+j6nRnxyHz/IKm+vQPTlR/K9yaw
X-ME-Proxy: <xmx:RKFvapSUUvdV00WA9E98KEFLBapp2mjVFClMkw1G58QQOxeY9JKXKw>
    <xmx:RKFvapq2dzrQ1k-0NL4X8f-_osEmdMW2k239dRT_IN9aV3bDli5ZAQ>
    <xmx:RKFvaryckF8JXzwkFE4lFXsueSOUB0nKhzNSYvrGBVGXH9gAUR5u8A>
    <xmx:RKFvauKthpCYZ8MTn3fvqoohc74YS-Zf3uMMzTk91QoJgePMuHRwRw>
    <xmx:RKFvavANA0E3NgjopFQ0VnLcQdqdCAS_ys7Eu0IXmRRVWugNxtzbugDU>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 15:57:55 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>
Subject: [PATCH] trailers: stop recognizing URLs as trailers
Date: Sun,  2 Aug 2026 21:57:17 +0200
Message-ID: <URLs_not_trailers.b13@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <20260609004340.GF358144@coredump.intra.peff.net>
References: <20260609004340.GF358144@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

An HTTPS URL starts with an alphanumeric scheme followed by a colon.
That means that they will be recognized as trailers in a trailer block.
That turns out to be a problem in practice. Let’s stop recognizing these
as trailers by failing the trailer parsing when we:

1. find the separator;
2. the separator and the next two characters form `://`; and
3. we haven’t parsed any whitespace yet.

The simplest example of how this can be a problem is for people who do
not use trailers but may leave URLs at the end of the commit message.
Now, while these authors might not use trailers themselves, other
authors may have used trailers and this metadata confusion can become a
problem once someone tries to extract that metadata (and non-metadata).

Let’s now look at some examples in the Linux Kernel[1] to see how this
is a problem in practice.

There are commits which contain intended non-trailer lines which start
with URLs. These are comments. Example with just the trailers:[2]

    Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
    [bhelgaas: squash fixes:
    https://lore.kernel.org/r/20260108013956.14351-2-bagasdotme@gmail.com
    https://lore.kernel.org/r/20260108013956.14351-3-bagasdotme@gmail.com]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    Link: https://patch.msgid.link/20251210132907.58799-4-xueshuai@linux.alibaba.com

Those `[]` pairs delimit the “squash fixes” comment.

Now, any of these two commands:

     git log --format='%(trailers:only)' -1 <commit>
     git log -1 --format=%B <commit> |
         git interpret-trailers --only-trailers

Will both wrongly (according to the surmised user intent) include these
two URL lines as trailers and also mangle the URLs, e.g.:

    https: //lore.kernel.org/r/20260108013956.14351-2-bagasdotme@gmail.com

Because the `--only-trailers` mode (or `only` for the git-log(1) format)
normalizes the output to a colon and a space.

Another example is linewrapping mistakes; a `Link` trailer with a
URL where the URL ended up on the next line, presumably because the
user’s editor linewrapped the “too long” line. Example with just the
trailers:[3]

    Link: https://patch.msgid.link/20260216-work-xattr-socket-v1-4-c2efa4f74cb7@kernel.org
    Link:
    https://lore.kernel.org/3cnmtqmakpbb2uwhenrj7kdqu3uefykiykjllgfbtpkiwhaa4s@sghkevv7jned [1]
    Acked-by: Darrick J. Wong <djwong@kernel.org>
    Reviewed-by: Jan Kara <jack@suse.cz>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

Now, this intended trailer is already ruined, but interpreting the URL
as a standalone trailer only compounds the mistake.

Yet another example is the trailer machinery normalizing the trailer
block before application, resulting in a `https` trailer key in the
commit message itself. Example with just the trailers:[4]

    https: //sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%40hitachienergy.com
    Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
    Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
    Link: https://patch.msgid.link/20260507155332.3452319-1-holger.brunck@hitachienergy.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

We have a helpful `Link` that points to the original patch.[5] Following
it we can see that that `https` trailer was indeed a URL
originally (again just the trailer block here):

    https://sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%40hitachienergy.com
    Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
    Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

So how did it end up as a `https` trailer? My theory is that the trailer
block was normalized on patch application, causing a URL comment to be
wrongly normalized and cemented in the commit message as a trailer.[6]

† 1: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
† 2: commit 8236fc613d44e59f6736d6c3e9efffaf26ab7f00
† 3: commit 5bd97f5c5f241a5610c4412d1b93995a26241f81
† 4: commit 496c0c4c53bbe1bad97e82cd12103df61a6e459d
† 5: https://patch.msgid.link/20260507155332.3452319-1-holger.brunck@hitachienergy.com
† 6: There are only four commits in the Linux Kernel of this kind, and
     three of them have the same recurring person in the signoff chain.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: trailers-no-urls
    
    Topic summary: Stop recognizing URLs in trailer blocks as trailers.
    
    Note to the maintainer: this is based on `master` with topic
    kh/doc-trailers merged into it.
    
    I used Peff’s suggestion from the previous email. I just shortened the
    comment, added the parentheses (://) and added the condition that
    whitespace has not been found for the case I discussed of someone writing
    out `<key>: //` (note the space). (Or for that matter: `<key> ://`.) I
    can’t imagine that that is a likely case, but I just want to avoid matching
    URLs, so we don’t have to reject this case.
    
    t/u-trailer.c: `expected_contents[]` is not formatted like the other ones
    in this file. But this is what clang-format(1) gave me.

 Documentation/git-interpret-trailers.adoc | 13 ++++--
 t/t7513-interpret-trailers.sh             | 19 +++++++++
 t/unit-tests/u-trailer.c                  | 52 +++++++++++++++++++++++
 trailer.c                                 |  7 ++-
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index b4988d39eab..903d598dcb0 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -123,9 +123,16 @@ OTHER RULES
 What was covered in the previous section are the rules that are relevant
 for regular use. The following points are included for completeness.
 
-This command ignores comment lines (see `core.commentString` in
-linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
-and `commit-msg` hooks.
+--
+* This command ignores comment lines (see `core.commentString` in
+  linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+  and `commit-msg` hooks.
+
+* Candidate trailer lines that have `:` as the separator, that have no
+  whitespace before the value part, and that start with `//` are not
+  recognized as trailers. This is to avoid accidentally interpreting
+  URLs as trailers (e.g. lines that start with `https://`).
+--
 
 OPTIONS
 -------
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 818a8dafbd2..e3555b6d51d 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1989,4 +1989,23 @@ test_expect_success 'handling of --- lines in conjunction with cut-lines' '
 	test_cmp expected actual
 '
 
+test_expect_success 'URLs and lines that are not quite URLs' '
+	cat >expect <<-\EOF &&
+	https: //www.a-trailer.org
+	https: //www.another-trailer.org
+	Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	git interpret-trailers --only-trailers >actual <<-\EOF &&
+	subject
+
+	body
+
+	https://www.not-a-trailer.org
+	https ://www.a-trailer.org
+	https: //www.another-trailer.org
+	Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/unit-tests/u-trailer.c b/t/unit-tests/u-trailer.c
index 3d60ea1603d..7404b165fac 100644
--- a/t/unit-tests/u-trailer.c
+++ b/t/unit-tests/u-trailer.c
@@ -318,3 +318,55 @@ void test_trailer__one_non_trailer_no_git_trailers(void)
 			   0,
 			   expected_contents);
 }
+
+void test_trailer__URL(void)
+{
+	struct contents expected_contents[] = { 0 };
+
+	t_trailer_iterator("Subject: foo bar\n"
+			   "\n"
+			   /*
+			    * We do not want to match URLs as trailers.
+			    */
+			   "https://www.example.org\n",
+			   0,
+			   expected_contents);
+}
+
+void test_trailer__not_a_URL_space_after_separator(void)
+{
+	struct contents expected_contents[] = {
+		{ .raw = "https: //www.example.org\n",
+		  .key = "https",
+		  .val = "//www.example.org" },
+		{ 0 },
+	};
+
+	t_trailer_iterator("Subject: foo bar\n"
+			   "\n"
+			   /*
+			    * This has a space after ':' so it's not a URL.
+			    */
+			   "https: //www.example.org\n",
+			   1,
+			   expected_contents);
+}
+
+void test_trailer__not_a_URL_space_before_separator(void)
+{
+	struct contents expected_contents[] = {
+		{ .raw = "https ://www.example.org\n",
+		  .key = "https",
+		  .val = "//www.example.org" },
+		{ 0 },
+	};
+
+	t_trailer_iterator("Subject: foo bar\n"
+			   "\n"
+			   /*
+			    * This has a space before ':' so it's not a URL.
+			    */
+			   "https ://www.example.org\n",
+			   1,
+			   expected_contents);
+}
diff --git a/trailer.c b/trailer.c
index 6d8ec7fa8d8..971ae459596 100644
--- a/trailer.c
+++ b/trailer.c
@@ -635,8 +635,13 @@ static ssize_t find_separator(const char *line, const char *separators)
 	int whitespace_found = 0;
 	const char *c;
 	for (c = line; *c; c++) {
-		if (strchr(separators, *c))
+		if (strchr(separators, *c)) {
+			/* avoid accidental URL matches (://) */
+			if (*c == ':' && c[1] == '/' && c[2] == '/' &&
+			    !whitespace_found)
+				return -1;
 			return c - line;
+		}
 		if (!whitespace_found && (isalnum(*c) || *c == '-'))
 			continue;
 		if (c != line && (*c == ' ' || *c == '\t')) {
-- 
2.54.0.22.g9e26862b904

