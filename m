Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9631716B
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126495; cv=none; b=e1dUwOANgVdHnz/JYAUo3o6JmcaXI1v/sswHezXulKp9GZOPvRMQqEG821GPy6GKebbT4sjQBrnbcTtnuy2WA3kaGiuxQ87vAqAi0quu8aT3XAElPuFwJyH6QaA4RYBcDEf9vqZmQal0xdd3fyWFp9NNlB/XQ3geX9mxg3gpuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126495; c=relaxed/simple;
	bh=Vb0dzkSRv4Mph5LIdw2Y8GiyZczthaqY6v+7Hkqn438=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5PAnlmypCn5wBrRm3bENV2ZrfeQBF8tfLzAQ7SVB843wk7FyLrACQW2+NiIuJeeuI+SNYycTqo16pHp5nIcFTtqFtppQjCwIbx/49h77GsR0rlFUjneDw2qN50SeTPnNen6e121mUtO8dCvV9lKIAoJGkCyV8t52XCIrMlEFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lYX7xry8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=St61i8cA; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lYX7xry8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="St61i8cA"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 112D71D00101;
	Wed, 10 Jun 2026 17:21:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 17:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126491;
	 x=1781212891; bh=ZuYdu0WKEaTv94pSesaHI6Jqinu1JRFyQLDI/Rk3bdM=; b=
	lYX7xry8a0fLo8ff4d1oogyzHD6RCx3QPC+2hAlM+56+2uSAKNVQlSJvQ94vIKZt
	mhyiJz2dxc1gFZg03laZZ+Q1AfQCoN4UAfzZ5f+c0QG6nADUViX2nW0ML7dm9DCJ
	009u4H2cH565YAF0n+2yt2BzSBHL/av63JuQKizbPUrn7sKYlMPcA9D7YLdsC3/Q
	4vnxnaGnMP7IcEvyAbM0xDruA9hp1SLp0O5j48SwQO5gm9tBeFnnXRY1+DVTtmEf
	T1WY1vFhzUja0hrOm0t2e/K8K+/uzatXtp841/HAAO23vr40IPzp7dyal/trd22Q
	/4b5tf0mUIDKVJ0qA4CFsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126491; x=
	1781212891; bh=ZuYdu0WKEaTv94pSesaHI6Jqinu1JRFyQLDI/Rk3bdM=; b=S
	t61i8cA/hHtmrGJzi5Ulo01CRCig3y+ABeFyV/EFivqtrRcquQSLoXvjnBLv8uBB
	8T276hY4f6sr6iQIgB84pWs+DsVfTJFCNsow4uMua0sSOogTsfcpchSwupXof/dK
	Px/udWr37ej5PbW+5pUiB8gNfxbkjHwwqAtXogOsdkZCfmUukszCxf7zYd8mZav/
	S52tOP2zhu1ZRIEXlTKIPTQOGUB+uDYbXbUl1KcCzIJMjYEFpiFhMhcsauvYkPTf
	b2hxoWGdK/WiK3bdmPeJzx3JuyTzhHuxo5mIfTuVCo4anBpvWx/9snM5LNahzI38
	BFuOG7892mAz03EPP35XA==
X-ME-Sender: <xms:W9UpamJhF_g6dbfXk55Iy0E-MJwvpN6QLhky48onciryTcnuQoUwlmo>
    <xme:W9Upah3EO126ydtDOY4IvEVFNyByx_zd2P9izxS8fNUxGU0WrxfJEwOD-Nt8YZ9Ew
    zjVdbSGjDYIr0TXBJXBT9C8nhprj2l7GED0zPSK7_DFriSY8h1PTg>
X-ME-Received: <xmr:W9UpagjpI57yHDfZxMhLMIKjHdr_D-hAFQ3jO7DH1K8GjVuCP4mrcYa_KQtnwnLAcEZC7cDZLzSy7ZrtaOb1k4QMYRiP7gjIVLXgpv5rwS9_PxpMfQsUYI_cvA>
X-ME-Proxy-Cause: dmFkZTEgt8YghDK55FIjASenY5Jk1wT2v1OemYqbHW+kBEf1AI/Eec0pNx3+dF8kwt9HAY
    XIG3xI+of9vo33Hr6QH7lhAL5xEdotBeh7dnXG5Gn8aZZvt++9dPohMUq7ErGSYawJmj7H
    MApKtbxmsd9sjKteX/PmyoO6+NDRjz1HgI5fF25lVezjf/64H/8/EyMvax33ui+JO4ctbB
    4v/LFXuUuf9mLNUvMgs4nv67W8KustpmvKiyzifbBWRUDCkkDyVlP6ixOm4wPEssETmUc4
    50BSYiCuhzyTodLiLZzj2Jw4BiwHJwob7Ve3q+uqUVi8DxPxPSJ/FfwXqPcnZDEI6navCO
    oG+Jcc6jgEMycKrPsq6YNTrjJQHXLSXBCbYbVbhp21LKmlfvTHpMFYXXIKeUgtn+tiLD67
    wqTDyNNLG3mPaL5jYyDVZeAuyZ4YvCHIxBTIJsSF4obnBahTOf1P2i6yHgMPHZOfBOkXJ8
    WskWJG0mZdfv4BwBnzYmPXR5sHgIrzLLrjbVcF6KQrxdfFpOXiTp/ey5Ypyi9LsKypXlRV
    tcr7UpcRUCfCugMBUmUKtawjLzQQE4on5hGZvOxYOg2ZsdENcq2QldTMK8MyyPUwake6KK
    GpChzCijSfHwFh5HhRENJ5I6jOfvrV8Gq7qHIZogp1hvFSJH7bCdfIxpmDeA
X-ME-Proxy: <xmx:W9UpaiXY9D_NvRUdGMKjQNiizpkkAQLXWXaFXHEdObO2WKXyX4WZ0A>
    <xmx:W9UpavUUA_S3v1eYmSU1LLlu7BnnGIEQyKT45Dm7IQNfNlhxeYrgvQ>
    <xmx:W9UpaigpMAETxJe-ZfTXQjSe6ofNwrQcumjHgkB-ep-nyqAivvKi-A>
    <xmx:W9UpaqbsY3Ul7cbaMQXWpS_0u_DzBetriIHqW0wxaztby0s6xtfzNQ>
    <xmx:W9UpakX-HxmzhryA2WBmZLmG54xPUkJ1QADeFxbWuFjBS1FrWBHmoCZb>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:21:29 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 00/11] doc: interpret-trailers: explain key format
Date: Wed, 10 Jun 2026 23:21:18 +0200
Message-ID: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_doc_int-tr_key_format.533@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-trailers

Topic summary: Explain the format of trailer keys (alphanum and
hyphens). This is important to keep in mind so that metadata is not
lost to simple syntax errors. Also replace some terms and define the
important ones upfront.

To that end, an overview of the changes:

• Patches 1–3: remove RFC 822 mentions, “metadata” term
• Patch 4: This command is not just for commit messages
• Patches 5–7: Explain the format in the simplest case, explain
  the “key” format, and add a new example
• Patch 8 [new]: join some existing paragraphs that are about the same theme
  since that makes the text flow better
• Patch 9: Also use the “trailer block” term introduced to the doc in
  patch 5 later in the doc
• Patch 10 [new]: Rewrite new-trailer paragraphs (relates to patch 8)
• Patch 11: document line comment behavior

§ Changes in v3

I followed up on D. Ben’s suggestion about thematic paragraphs (patch 8).

I also made a new change as a knock-on to patch 8. That’s patch 10.

I also changed patch 11 (formerly 10): moved it out into its own section.

See the patches for details. Look for “v3” in the patch Notes.

§ Apologies for very cross-referenced commit messages

Like I wrote on v2.

    Here one thing lead to another,

And in the process I had to make changes that necessitated *other changes*
as a knock-on effect. Shuffle some text, need to reshuffle three paragraphs
later for consistency. And rather than piling on “While at it”/“Also”, I
chose to try to make focused commits. (Which is how an idea to explain that
trailer keys are alphanum/hyhens-only became eleven patches.)

But in order to follow up on related items I needed to refer to both future
and previous commits. And in the process I abandoned the usual “in an
upcoming commit”/“in a previous commit” in favor of perhaps a gratingly
precise “commit <subject without area>”, e.g.:

    The format in its simplest form is easy to describe directly without
    comparing it to anything else; we will do that in the upcoming
    commit “explain the format after the intro”.

and,

    This also makes the introduction more consistent with how I chose
    to define trailers in the glossary:[1] “Key-value metadata”. (We will
    introduce “key–value” in the upcoming commit “explain the format after
    the intro”.)

§ Cc

(see v2)

§ In-reply-to: v1

§ Link to v2

https://lore.kernel.org/git/V2_CV_doc_int-tr_key_format.613@msgid.xyz/

[01/11] doc: interpret-trailers: stop fixating on RFC 822
[02/11] doc: interpret-trailers: replace “lines” with “metadata”
[03/11] doc: interpret-trailers: use “metadata” in Name as well
[04/11] doc: interpret-trailers: not just for commit messages
[05/11] doc: interpret-trailers: explain the format after the intro
[06/11] doc: interpret-trailers: explain key format
[07/11] doc: interpret-trailers: add key format example
[08/11] doc: interpret-trailers: join new-trailers again
[09/11] doc: interpret-trailers: commit to “trailer block” term
[10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
[11/11] doc: interpret-trailers: document comment line treatment

 Documentation/git-interpret-trailers.adoc | 92 ++++++++++++++++-------
 1 file changed, 66 insertions(+), 26 deletions(-)

Interdiff against v2:
diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index b42f957d666..d5e856f5d68 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -60,12 +60,20 @@ are applied to each input and the way any existing trailer in
 the input is changed. They also make it possible to
 automatically add some trailers.
 
-By default, a `<key>=<value>` or `<key>:<value>` argument given
-using `--trailer` will be appended after the existing trailers only if
-the last trailer has a different (_<key>_, _<value>_) pair (or if there
-is no existing trailer). The _<key>_ and _<value>_ parts will be trimmed
-to remove starting and trailing whitespace, and the resulting trimmed
-_<key>_ and _<value>_ will appear in the output like this:
+Let's consider new trailers added with `--trailer`.
+By default, the new trailer will appear at the end of the trailer block.
+Also by default, this new trailer will only be added
+if the last trailer is different to it.
+A trailer block will be created with only that trailer if a trailer
+block does not already exist. Recall that a trailer block needs to be
+preceded by a blank line, so a blank line (specifically an empty line)
+will be inserted before the new trailer block in that case.
+
+More concretely, this is how the new trailer is added: a `<key>=<value>`
+or `<key>:<value>` argument given using `--trailer` will be appended
+after the existing trailers. The _<key>_ and _<value>_ parts will be
+trimmed to remove starting and trailing whitespace, and the resulting
+trimmed _<key>_ and _<value>_ will appear in the output like this:
 
 ------------------------------------------------
 key: value
@@ -74,6 +82,16 @@ key: value
 This means that the trimmed _<key>_ and _<value>_ will be separated by
 "`:`{nbsp}" (one colon followed by one space).
 
+Existing trailers are extracted from the input by looking for the
+trailer block. Concretely, that is a group of one or more lines that (i)
+is all trailers, or (ii) contains at least one Git-generated or
+user-configured trailer and consists of at
+least 25% trailers.
+The trailer block is by definition at the end the the message. The end
+of the message in turn is either (i) at the end of the input, or (ii)
+the last non-whitespace lines before a line that starts with `---`
+(followed by a space or the end of the line).
+
 For convenience, a _<key-alias>_ can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
 `trailer.<key-alias>.key` configuration variable. The _<key-alias>_ must be a prefix
@@ -87,26 +105,6 @@ trailer.sign.key "Signed-off-by: "
 in your configuration, you only need to specify `--trailer="sign: foo"`
 on the command line instead of `--trailer="Signed-off-by: foo"`.
 
-By default the new trailer will appear at the end of the trailer block.
-A trailer block will be created with only that trailer if a trailer
-block does not already exist. Recall that a trailer block needs to be
-preceded by a blank line, so a blank line (specifically an empty line)
-will be inserted before the new trailer block in that case.
-
-Existing trailers are extracted from the input by looking for the
-trailer block. Concretely, that is a group of one or more lines that (i)
-is all trailers, or (ii) contains at least one Git-generated or
-user-configured trailer and consists of at
-least 25% trailers.
-The trailer block is by definition at the end the the message. The end
-of the message in turn is either (i) at the end of the input, or (ii)
-the last non-whitespace lines before a line that starts with `---`
-(followed by a space or the end of the line).
-
-This command ignores comment lines (see `core.commentString` in
-linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
-and `commit-msg` hooks.
-
 When reading trailers, there can be no whitespace before or inside the
 _<key>_, but any number of regular space and tab characters are allowed
 between the _<key>_ and the separator. There can be whitespaces before,
@@ -119,6 +117,16 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
+OTHER RULES
+-----------
+
+What was covered in the previous section are the rules that are relevant
+for regular use. The following points are included for completeness.
+
+This command ignores comment lines (see `core.commentString` in
+linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+and `commit-msg` hooks.
+
 OPTIONS
 -------
 `--in-place`::
Range-diff against v2:
 1:  e5d58237bc2 =  1:  e5d58237bc2 doc: interpret-trailers: stop fixating on RFC 822
 2:  5ddd39bf157 =  2:  5ddd39bf157 doc: interpret-trailers: replace “lines” with “metadata”
 3:  9f0227a1978 =  3:  9f0227a1978 doc: interpret-trailers: use “metadata” in Name as well
 4:  4cb26810d4e =  4:  4cb26810d4e doc: interpret-trailers: not just for commit messages
 5:  196c91bebe3 =  5:  196c91bebe3 doc: interpret-trailers: explain the format after the intro
 6:  688ea55599a =  6:  688ea55599a doc: interpret-trailers: explain key format
 7:  e6eafbd641f =  7:  e6eafbd641f doc: interpret-trailers: add key format example
 -:  ----------- >  8:  8849ace33e6 doc: interpret-trailers: join new-trailers again
 8:  f14d641309c !  9:  8323b84e134 doc: interpret-trailers: commit to “trailer block” term
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-interpret-trailers.adoc ##
    -@@ Documentation/git-interpret-trailers.adoc: trailer.sign.key "Signed-off-by: "
    - in your configuration, you only need to specify `--trailer="sign: foo"`
    - on the command line instead of `--trailer="Signed-off-by: foo"`.
    +@@ Documentation/git-interpret-trailers.adoc: key: value
    + This means that the trimmed _<key>_ and _<value>_ will be separated by
    + "`:`{nbsp}" (one colon followed by one space).
      
     -By default the new trailer will appear at the end of all the existing
     -trailers. If there is no existing trailer, the new trailer will appear
    @@ Documentation/git-interpret-trailers.adoc: trailer.sign.key "Signed-off-by: "
     +the last non-whitespace lines before a line that starts with `---`
     +(followed by a space or the end of the line).
      
    - When reading trailers, there can be no whitespace before or inside the
    - _<key>_, but any number of regular space and tab characters are allowed
    + For convenience, a _<key-alias>_ can be configured to make using `--trailer`
    + shorter to type on the command line. This can be configured using the
 -:  ----------- > 10:  c7495c3b39e doc: interpret-trailers: rewrite new-trailers paragraphs
 9:  78125ab39f1 ! 11:  fc38e8660f0 doc: intepret-trailers: document comment line treatment
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: intepret-trailers: document comment line treatment
    +    doc: interpret-trailers: document comment line treatment
     
         Comment lines have always been ignored but this is not documented.
     
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-interpret-trailers.adoc ##
    -@@ Documentation/git-interpret-trailers.adoc: of the message in turn is either (i) at the end of the input, or (ii)
    - the last non-whitespace lines before a line that starts with `---`
    - (followed by a space or the end of the line).
    +@@ Documentation/git-interpret-trailers.adoc: key: This is a very long value, with spaces and
    +   newlines in it.
    + ------------------------------------------------
      
    ++OTHER RULES
    ++-----------
    ++
    ++What was covered in the previous section are the rules that are relevant
    ++for regular use. The following points are included for completeness.
    ++
     +This command ignores comment lines (see `core.commentString` in
     +linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
     +and `commit-msg` hooks.
     +
    - When reading trailers, there can be no whitespace before or inside the
    - _<key>_, but any number of regular space and tab characters are allowed
    - between the _<key>_ and the separator. There can be whitespaces before,
    + OPTIONS
    + -------
    + `--in-place`::

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.54.0.22.g9e26862b904

