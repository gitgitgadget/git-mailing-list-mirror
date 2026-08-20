Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881A1A275
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256057; cv=none; b=GLU/N8I1xS1rQEQZiKsLpKTExxWdvBYHg4cZvMEQZyT7zbfv7QIT3+ngEy213PKsp8wpSv8FlE6MfJ+O90kT3L+oZ2KYeEo37hJHqh5aYoSWKoK30cj0FUcHaYrvPPp1y8nz6pV98Rg2xTWaLuuOS55SN1PDCgUhmyKUv9K9z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256057; c=relaxed/simple;
	bh=VUghJjX7eJ+7wIdQPU/c0nTpAYyWSC9Cg28ck/nY+/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd9/MerDUGO7rHXeNDdyW9DKxZ7y96i0rw+PeUCRChpxsAcdfzjZ7TM7dQbNAxfvcxjw43U+nguwUIZ+sSTS4NBSWU2rkN/H+FVRgkMX1Jy4qb0YsLBVLGX8rjeekDkNUSlE1ASyv60zts/CK+B2hwqhTxdjBbcak9jnoo0oJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Aa0Cj2Br; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GiVj9mWU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Aa0Cj2Br";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiVj9mWU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7552E7A0137;
	Thu, 20 Aug 2026 16:00:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 20 Aug 2026 16:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787256054;
	 x=1787342454; bh=V4eXab7lOGC3lakIFHibjzaDfWsXQDiQZeRBAJUffmU=; b=
	Aa0Cj2BrsNmNMvE4MJo0+AdyjFXWzkvyblHKNC5UHBcAFm4j3gAH4rXkE7OpKGBO
	PgMYN77ZBev17rSnEmpv/fLB2dzMeKxJHRKp++JDGQHQ4Z+r6HJ7+j0s52ph1wv8
	ygl0OypbF9PnQwt+VFQrXD5b1yTOTKwkcf27gJR+NEgBJ6aKFe3+lD1i5RZRD7Ak
	uzHM+U+s14vXEAvurYZC83xfqwpl73kV/hAbhXAqEtZV82X2xE8WwIWsYWrGVAJ7
	/LFLCk/RM16ZkZWibAxPyNX3darqTOsHcYf9e3ocS9X+R8HkASRTzmBS6OpOxx0d
	Vagxq9w1cTmW6Xvr7tDyNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787256054; x=
	1787342454; bh=V4eXab7lOGC3lakIFHibjzaDfWsXQDiQZeRBAJUffmU=; b=G
	iVj9mWUHDLVGTkXI8366CURP03CxOCUKerjdtSRv4exuYRwxgnXI3dsuFfgDXa/+
	0SsJNIboRNJum3fWpwYMJpvKlUqUErjs7uHwZr8FFNF2nA5TASRbTk6SJm1nEuV5
	YJpyiqPJ0+qL7lCwG8AmCPe+jCaxCXh6PJhCTqfptVEcc925dcXTuYNBzDXslV7E
	osByCmfEW3ZQEqQu7by/YpzNfgclgF+vAvsSS3i3vpjqFXXRA6QVg5C4kY55yk/G
	Ubpu7fB3aaxOzed++iQU3tCELg6sm8kA2aAFWwrU/xlmsCyDLlFm+UKnVI1ClwVL
	0dGwD2nH3IBpPUvx3HTig==
X-ME-Sender: <xms:9lyHan6rFgOeL8cY8CvUcD2PDDe4aYEX4MpGr2q3tGChO1JXs2jxSv4>
    <xme:9lyHaj75EG7J6pIkAz_2VQkLVeHbgnuRrJSyTSXoDEldbJjpD3iPIjkKBB76A4U6X
    qNWGdF5GF0kszhhWRon9yT_ewsLHZuD3LziG0NmkfuXqjQif2lVRH0>
X-ME-Received: <xmr:9lyHajfhORSFLKoU64FCDps4PC8I-2UrfKjS-T2GN-5wAHN7tAV2bG7uFkvp6E-xViW6aPwYDkrfqwi53RX4bu3xo5sds32lCvC30Q4ZchfYniJI0gfaKv4>
X-ME-Proxy-Cause: dmFkZTE7ZUu7dCJ+rVQGYH2Fpc85YR1GO+2yNASLiTtBJQ7OK/7A46fWWMfi5yg98d9nV4
    431YxZSiezTt9FWpwUnbavbYJ7BShFJdX7Wv6VEdjo/xvSeJR134gzjAjzIV0NNbwAaEBx
    b1oguCEfxFIRZp1qE79vT7QIakxEhZ8VBGVwhJJC8cqKN35/RLRQYys+4D51enc0vDTnA3
    CwPdClH+kGIJ4TB90DTaWjSG9Q/Uq1zuPiwRB79QOfrYQexJB95QOhm+dw1E655c+KusxA
    c905qCjNYvRvJQ0c/XPKS9mwwQucB7U0Tt41M3YMFkqZkLuaVpbdgcst7LwwNLTNa4m+P4
    bfWcK3uuHz/bQdLiAh1Gkt8Omv5sPwCxO32mIH16pAbwieLtj3CbWCPu2X6K4JMZKOGuS9
    wV8fsE0sLfebUjDbehWmHeQWLiutOHFhbAhXQV8GKILhBzx6Ix5j3Gw6vpJzCkwlMC+DbX
    wTfAsffh1KMKS/UPX3DMx1bIGZ8phzCVlytP8UmJqYHi5cyC9hoWXkmhN/FGukmWUtlVnU
    4eiqoP3uVGHX3NvWnrXCnGaBR5KxjJfS0Y3TMFg4ghSuEIa/gAdyyWUVmvQEhUX22seVzS
    UdSMRksNyg/N9oVaMmYroIDv3T/OyxGbOkaFH+vRtj529ZzWp0+GdBJkhuMg
X-ME-Proxy: <xmx:9lyHanBc0MajIcvKDXu8xfsTz8pZrs3d1u24mjcIiVKMekwbI9Hv6g>
    <xmx:9lyHam8xRd4GXxbzJXpKejhhFmDAXhjVg646A9nPQk4Lz2dWy62Dag>
    <xmx:9lyHaiIUyvDVz1uNgojIHcEiQGXa_nb-Vy4O8-JK3rgrqQ1tg3GQjg>
    <xmx:9lyHavgxZKelW3ToGOoZRvZX8jq9ZYtexx7lSy2Mga_o34P7N_Id-w>
    <xmx:9lyHauZqXv59Z3P8DX-2KlaVBwtLzySpnmqAOgBq6wH3jyDNy8-0LRpi>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 16:00:52 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2] trailers: stop recognizing URLs as trailers
Date: Thu, 20 Aug 2026 22:00:02 +0200
Message-ID: <V2_URLs_not_trailers.bf3@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <URLs_not_trailers.b13@msgid.xyz>
References: <URLs_not_trailers.b13@msgid.xyz>
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

***

Note that this check has some benign false positives. A trailer key
can start with a digit, but a URL scheme can not start with a digit.
That means that a line that starts with `1://` will be rejected even
though it cannot be a URL. I don’t think this will reject any real
trailers, so I think the implementation simplicity is worth it.

And these false positives are just for a limited start fragment check;
a mere heuristic, not a URL parser.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name (applied): trailers-no-urls
    
    Topic summary: Stop recognizing URLs in trailer blocks as trailers.
    
    Note to the maintainer: This has been rebased on `master` since the
    dependent topic kh/doc-trailers has been merged thither.
    
    § Link to v1
    
    https://lore.kernel.org/git/URLs_not_trailers.b13@msgid.xyz/
    
    § Changes in v2
    
    • Use `starts_with` for readability:
        https://lore.kernel.org/git/20260609004340.GF358144@coredump.intra.peff.net/T/#m74203c474c34f1028a7e3d389ff46fb7e579444c
    • Since `starts_with` is a function, put the simpler conjunct
      `whitespace_found` before it. It’s better to put the cheaper operations
      first in a short-circuiting expression. Right?
    • Explain in the commit message that you can technically get false positive
      “URL” start fragments:
    
          https://lore.kernel.org/git/20260609004340.GF358144@coredump.intra.peff.net/T/#m35047d5c7a79abd23c11f97e6b6a0364409805e3

 Documentation/git-interpret-trailers.adoc | 13 ++++--
 t/t7513-interpret-trailers.sh             | 19 +++++++++
 t/unit-tests/u-trailer.c                  | 52 +++++++++++++++++++++++
 trailer.c                                 |  6 ++-
 4 files changed, 86 insertions(+), 4 deletions(-)

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
index 6d8ec7fa8d8..10b1abebfbe 100644
--- a/trailer.c
+++ b/trailer.c
@@ -635,8 +635,12 @@ static ssize_t find_separator(const char *line, const char *separators)
 	int whitespace_found = 0;
 	const char *c;
 	for (c = line; *c; c++) {
-		if (strchr(separators, *c))
+		if (strchr(separators, *c)) {
+			/* avoid accidental URL matches */
+			if (!whitespace_found && starts_with(c, "://"))
+				return -1;
 			return c - line;
+		}
 		if (!whitespace_found && (isalnum(*c) || *c == '-'))
 			continue;
 		if (c != line && (*c == ' ' || *c == '\t')) {

Range-diff against v1:
1:  e7ba66a0ce3 ! 1:  2f8d10c1c6d trailers: stop recognizing URLs as trailers
    @@ Commit message
         † 6: There are only four commits in the Linux Kernel of this kind, and
              three of them have the same recurring person in the signoff chain.
     
    +    ***
    +
    +    Note that this check has some benign false positives. A trailer key
    +    can start with a digit, but a URL scheme can not start with a digit.
    +    That means that a line that starts with `1://` will be rejected even
    +    though it cannot be a URL. I don’t think this will reject any real
    +    trailers, so I think the implementation simplicity is worth it.
    +
    +    And these false positives are just for a limited start fragment check;
    +    a mere heuristic, not a URL parser.
    +
         Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ trailer.c: static ssize_t find_separator(const char *line, const char *separator
      	for (c = line; *c; c++) {
     -		if (strchr(separators, *c))
     +		if (strchr(separators, *c)) {
    -+			/* avoid accidental URL matches (://) */
    -+			if (*c == ':' && c[1] == '/' && c[2] == '/' &&
    -+			    !whitespace_found)
    ++			/* avoid accidental URL matches */
    ++			if (!whitespace_found && starts_with(c, "://"))
     +				return -1;
      			return c - line;
     +		}

base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.55.0.13.g85d2d65e389

