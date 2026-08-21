Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87837A846
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289995; cv=none; b=hF5VVYvgOGKz6pzQBurlbY0H4H7EDHW0FNr4rUWeR0RyjMW/xmQOWW8Asho3gi9YYtqvWwbB8HTlkBKhVTprfSEYpAByFow4umz+ynTj6Eb2wsbUHpJ+lNwpz1fsssl9r4GhCpCKvCLeWY5Og2GATO/sEOmC9drXlSR+nSbKcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289995; c=relaxed/simple;
	bh=BwqsKXAcoNd+3bafOS6pzIAJEfpi5oe+FeMAwQHZmKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUkGcHWX+kgO6Q9yS0HkM5Fui7uW8CYACGorHNs4EA8e8e83UKeJsmnkAfnNxcIv0Fi/xajWwt2b3xmxPvIGm5UzowmyyJnRDCh5yXQN5fV4HG8wTo+10og+N4SUXY5oxvsOIHliY3Ewv0i2dpwYh1wV6A1gGHTlb3Ipf32VzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ofcd73lz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nj45OwPc; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ofcd73lz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nj45OwPc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C604C1D00019;
	Fri, 21 Aug 2026 01:26:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 21 Aug 2026 01:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787289991;
	 x=1787376391; bh=6uqXoP0svcvq7M/OdQZ91xJPYkGwx54olg1QoJmBPzk=; b=
	Ofcd73lzlV7++jA7Y62zozehrKcDSq+rzRJP1VV50vd93clfedtmc4G7V2oE6RaO
	vBkhIuwrsSb0gxA95iufejN++O8cMfd5vUxPt9+jTqG77lR/5KlhGW6UPN3XcWka
	wc6YMRCjQyRySk9eFKcjlG61gV+L17I5Zy0Rze5UV3PYacxjeuO4uiO6oytGmunE
	lItDNpQDBFtz1DkYRLtfxDQAup9GqIUghTcxe5nJDVk9H3DNchGQssZs1zf8nTh9
	okEo2JLLCF8F9G4ZbEP3tR3r/Bln+Y34dr98xNXFPIRM4p4GuMFnehG03yaXqwpL
	wPJDYxV/9egWv0B6jDu+LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787289991; x=
	1787376391; bh=6uqXoP0svcvq7M/OdQZ91xJPYkGwx54olg1QoJmBPzk=; b=N
	j45OwPc8wcxuA01MY2OENgFj+OOIaK+ij6TxDJwWQ6VF9QvzNA8T6gS2jhK6DuIf
	aNmVWJorH850EVlgxyXaWWWG9FjMh3n/JwIpGRblxD/BPzNkANRcgsCuRivFlj4S
	hL0g41i4ti5xUAK+pvYsdv4JjMfYVmshekDjK577XLjCtEf+ND7Z6VC6rZSaBLsL
	efQPhbBtxvxnKFg8MGtEKYK50kF9OuZS6ZSj7IrxsONwWNP4d9WAevZqjpTcxOrZ
	dzL5N/ltr11iiqmC+Wok+FFNBP5Y9J4ZDkhl6H8syNseUMD4VFJq6W+wNHe3C09T
	WXWRyvHuMlvFkhiNA+tEQ==
X-ME-Sender: <xms:h-GHam-6bcv8_n_eLjvfuUBD9vAYYk-nhKF_GyPvCN-_DN9yoYOfi38>
    <xme:h-GHatvburbw-3Am3N5FJ_gOSlnS_-WfL_zU1UpZzJ8tUYbX5yHqllICsq6l694LI
    zyiLs3h2SlRLm92WAEHPNHPFzlnllSt9X90xfiK81Dz3ErBLOd7xP4>
X-ME-Received: <xmr:h-GHahBs5LQ5WWUIBs0aaclfHowur5APaW8BCIi19LzgGJofx0cDS4uZu--adnl0maBnSeF3YsovvPeN8FNb-0KlpvvaoFZf8_PKHjFOJSM065VMJQ>
X-ME-Proxy-Cause: dmFkZTGbrIiinAVogI/5gnviQpOVKw/bCw/tXCmm9pILWchz25gz9hJPYzE8+dqj63T40+
    tGMLK0YfOBs5C4WC2JKrz8lOIq88lcCjfcomqXq0i5w/ARG3UtiXJun0MisdqRCPdmF0Mq
    wbm5SFRLxvsGU1X3fEJooGnFXntK+TdDwPAeS/lW1yNxmw+82W+/FupeE5ZX1igCgWJ+3Z
    c02uNY+vTLaCrRC7FXviw3XgEgQddgdghhw5a5i8c97eOs9XuykjA75Vbxbhhin6H3JL/q
    PCoouke+qPzoXPWOdEzCKDB8TQ4ZmVWl05oh7L9cqoegbRGL+gx7LavKXBiuqFJOFp/xr9
    lf0G6CSMrT2GnmcGzb4YwQHLwSXDosQdsKfMAk42vrcHTyNACRx20E33Qp35zlPGllIlLz
    +kqFUEL9VPbXqmikuhNFmwp2HYVDByoTTyufzAYolHV7DvWEwQIZer1AyvQdeBnA7rPOpo
    bjpXBMGTmz3g46XO4B6LwHaStpvjSrzARrI/w28RTrCU2g+p76P1e6HdZ7ua9lGvBWJzJU
    Jlnruu9I49nXBxAm+XlAidEyugUqK7byVb2PdBvBwvW3Cy6hkrq2U4QXTE57uoVJUQc7b9
    Q0PNeQkMP9WuKR/GTH2ggo+ah4wjVsqsvrM6OgtBPju9Zz3fDaowJZyQQGuA
X-ME-Proxy: <xmx:h-GHatVwOJb_LSKZRcX5kGKTUG9bp-R5GHxq6bYZy24xfKUQTN0D9w>
    <xmx:h-GHanCeBBMQEXTDmFDHHgMUe68ECQ21X629zc7IcdJ3L4v2Do_QOA>
    <xmx:h-GHao9jJr3rYJwK6seO2HAhcA3_CRW9DpeNxDxeenpNW7QEhfSYoQ>
    <xmx:h-GHamHxiVj5MhCpY7gNGYoB_7qab7m2e6ANIxDhyYytiDCY4RVr9A>
    <xmx:h-GHal8I0xFV7LGyzS1HQ4Y8zI7LnQv66o1Gaf2CjGrVTArWao6Yc9fD>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 01:26:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: [PATCH v3] trailers: stop recognizing URLs as trailers
Date: Fri, 21 Aug 2026 07:26:04 +0200
Message-ID: <V3_URLs_not_trailers.bfc@msgid.xyz>
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
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name (applied): trailers-no-urls
    
    Topic summary: Stop recognizing URLs in trailer blocks as trailers.
    
    § Link to v2
    
    https://lore.kernel.org/git/V2_URLs_not_trailers.bf3@msgid.xyz/
    
    § Changes in v2
    
    • Add Ack https://lore.kernel.org/git/20260821004248.GA296777@coredump.intra.peff.net/

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

Interdiff against v2:

Range-diff against v2:
1:  2f8d10c1c6d ! 1:  736610daf6e trailers: stop recognizing URLs as trailers
    @@ Commit message
         a mere heuristic, not a URL parser.
     
         Helped-by: Jeff King <peff@peff.net>
    +    Acked-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-interpret-trailers.adoc ##

base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.55.0.13.g85d2d65e389

