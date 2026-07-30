Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135053F7A8C
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403131; cv=none; b=ipdvj2b+Eic6oxE4JAvA55CIMjaxOLPkSTISR80ArXNtBKkfIyV2q9Htq7P8BVJEHQUkU4Loag+vlG72tXEqk6yfVXCwG6rZTcwmvdXnKnpvokSUz68VUL4tP4ztUlo1+h00bxdcugrRYh++in7DKLKYfEwB5k2GKQ+GT+BllYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403131; c=relaxed/simple;
	bh=odxvwvwHxm4+41TFgQGDSoldbj16adObG9EXBaPBsjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmLlUO1zyPRjmOgsFpRqTDCdzFimhTA8MUXwsNMrZ+TEq8FxQ9I3IMneJ3ge9kf1DPc7JE8vlOB9papDJa9gagsX0pn63BE4cUybe9bQKvKCc3lL/0Ujze/Ij3WexeowPcd66nyV3t3amXf3UmusoeWotLD5wpbmSWiGmt4q5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lQTT88iC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCsxzuHf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lQTT88iC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CCsxzuHf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E8E861D00126;
	Thu, 30 Jul 2026 05:18:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 05:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403127;
	 x=1785489527; bh=TzBIh84VaSrVhBrKz/2GNmbjZiaVYAcWirYNg0Wzgco=; b=
	lQTT88iCwT1yQcEksMdiuYRVdK8sKN7cL6K1pn90Z5Dd3mdVdkXm/kShw0WDrT5n
	qwAD5Tv2WI3pFlv1umdSDjpC5i2pKdEBfxPVOErAB8Z9jggMX8qQfXlarcb27ZDK
	2Tx+/j2mHNqxnvnWcYIdmfBuIyh1xDQCSkqWxyv+e7T7NluXHGMrzhgGPWl7eXL5
	b6ruah5UfeOOkBIiFX6lEugbO1vNM7HpfBgayVTiW5gMbLjlMDJl2w+wbXkndglf
	Zcu4zk2WfKCAKgGrgZhY2i+GsBI6+L58EWqC8yzm4IRduFOBiZj48VZbjEr4Rg1n
	iHoIpOuYlHbbbpvY6Yq0QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403127; x=
	1785489527; bh=TzBIh84VaSrVhBrKz/2GNmbjZiaVYAcWirYNg0Wzgco=; b=C
	CsxzuHf4ylXjNOjI4ieAQTh4YnnGHtxed5LMnR6x1sAjppbGsIa1L/Fx02ACaix8
	qHXxwPDNMVGQ7Ug6kc1V+dKN3wWCpCdbyYSlJzs9dRe2H2tU/jDjbNq+Inbz8KAa
	UbQONIh23m829sOqPb8rHgzGxAIo2lhaI2GCM/byZKLbfgXNpq8LDSi3/vFV4MQv
	zw3w6Bs/cqL2tJZkYwQwYmqS+mFwydrAvzynK4rHCmJ4tq5WoyL0kuIcfBPqdPyS
	grdwErR94RUZIctOkc287+3yDzQAVcqFYBaf0SOWXNUkcZHfHJBZ5y9C1yromIyj
	yuGR7B7uofKFYFmuqB54Q==
X-ME-Sender: <xms:9xZraoZrlJ2u-thylDeC3M5GziwtYty6jvxEMSxA8YdmBRN5qcZMb2A>
    <xme:9xZraicnvVIgHTvjkrmH30jKAU0fKhT1wigKnp1WKGEfR122iRzSvwim_bbx9q8t6
    mKshAALHFC973lVxC3zfzLnfy2rm7BwNkhpBJlxOgg9NKQY_YKvCg>
X-ME-Received: <xmr:9xZrapJzN6kgbzvp_MCyBcH7h-LX6HLKjEikwFaz1GH392yai7u-IIHQfOOeP5FhjuPNQWcOatM_hSeve_tuz52srua5Qyi3CZXwROa9_1KZbLGsfrKQudY>
X-ME-Proxy-Cause: dmFkZTExg2M07ikKsex/xkRJ/+IjaBleLpkEQA0mFFT97kujmFFm1+fx+DTkiPUtX/C0Pd
    YbodheeE6uCvm1DUr+IIN90n/UNTwCnUMqrA+qJEa8vwXB9lAdGO2a+I6kg2a0GLGnz3Av
    nUr61i1tcZbcwDm8u4vYeijK5ZQ9SmJyBqDhV6jQmPmGG0D//Rz7hUDm41k/NxrwXmaMRI
    LhyJ4v0ZzRz8JLtG70XWuNh2JPC2ZyQwLhlKumO5FXq1C2wQNGdoxRklA+vWQqRoLkYPW5
    tmkdjJy9o/8fmVpFiE8xR0kgEFL46t6X7jsFWgChVIG1mqYZ8xPLOq9lxmvFbh7i7fgJGN
    WIWWcRX/OQXU6tXTv/d1arJ5lYALeMDhPESgI2KKvMZb2mzvVecb0LadRsascZmB8vir0j
    kokwc7Pd47Maj+8u/IPyoCGR4zHqizGgc6P1zoMoXgeGzmff66Qjbo+Ae9YZ3bSoHuDgVh
    99VVpBgh4kk0KKBZdUkGJHfcfNr73kbc+TpOwydZZsl+J5jJDWAFUP9e79zsqS9hqTcJW2
    Egq3jomqw05EmYS+qsWsPC6hpCNnB/Lfb4XiMk3DXh6S6P7q4wJPRVtUmGg9REY9Uo4iAd
    An3kNBQgO3uhhduQo9A8EhnefYwJbwippohZPEG6gCMyRugPfitxFo5yj2Bw
X-ME-Proxy: <xmx:9xZravJ-8nlta3VnhaV9u5079I3jY83klqJ3XeHF6wUCe8uXkLc7oA>
    <xmx:9xZraoUHpNUmczxkwwapxK9S6JTlCQSl5hpEQ8L_6fF7sdZts0Lw_Q>
    <xmx:9xZraomv7HroYEDkV-3UnslMrM4MEkbZYFx6JvxofjG2graFkQuSOA>
    <xmx:9xZraukjix-yDiRbatlg-neWu7HWtKDvrygIbUhvyt3oBYV9Dp6Scg>
    <xmx:9xZras3S8R_qgq1emc-l5dKdJKzujFjGTSrqsnQgaJ8fp9s3c5LS6Zvw>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:18:46 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/11] doc: interpret-trailers: explain key format
Date: Thu, 30 Jul 2026 11:18:13 +0200
Message-ID: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
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

Here one change lead to another in order to make sure that everything
stayed coherent. So here’s a linear overview of the changes (as of v4):

• Patches 1–3: remove RFC 822 mentions, “metadata” term
• Patch 4: This command is not just for commit messages
• Patches 5–7: Explain the format in the simplest case, explain
  the “key” format, and add a new example
• Patch 8: join some existing paragraphs that are about the same theme
  since that makes the text flow better
• Patch 9: Also use the “trailer block” term introduced to the doc in
  patch 5 later in the doc
• Patch 10: Rewrite new-trailer paragraphs (relates to patch 8)
• Patch 11: document line comment behavior

Thanks to everyone who has been reviewing these so far. I understand that
these eleven changes are very incremental and piecemeal (see “very
cross-referenced commit messages”). And the commit messages can be quite
long, just to explain (again) very small changes. See for example patch
“replace “lines” with “metadata”” in this version, where I explain why to
write “trailer metadata” instead of “trailers metadata”. But right now I
feel like prose sometimes needs all this ceremony. With code you get
restraints like coding style, then you have all the years of looser rules
about when to use certain data structures, when to make helper methods,
etc. But with prose it seems that you bring much more of your individuality
to it. That means more choices, and many of them are not obvious to the
reader of the document, which means that you need to explain it in the
commit message. Then you also have to consider the writing history of the
document, and this one is twelve years old at this point; see the history
review in commit message “join new-trailers again”, after the thematic
break (***).

§ Changes in v4

See the patch Notes for details. Some minor things might not be mentioned
here. But they are all mentioned on the patch Notes.

Patch “add key format example”: fix doubled “to”.

Patch “commit to “trailer block” term”: simplify “blank line” mention a
little bit. But I might need some feedback from Junio on whether I
interpreted his comment correctly. There are detailed notes on the patch.

Also follow up on other copy editing feedback from Junio.[1] Note the
things that I didn’t follow up on because I disagreed or didn’t understand.

Patch “rewrite new-trailers paragraphs”: copy editing feedback from Junio.

Patch “replace “lines” with “metadata””: use “trailer metadata”. Suggested
by Matt Hunter. It reads better.

Patch “document comment line treatment”: rewrite motivation for documenting
how comment lines are treated.

🔗 1: https://lore.kernel.org/git/729baf6b-53ea-4e8d-95ab-5935667e66c2@app.fastmail.com/

§ Apologies for very cross-referenced commit messages

(see v3)

§ Cc

(see v2)

https://lore.kernel.org/git/V2_CV_doc_int-tr_key_format.613@msgid.xyz/

§ In-reply-to: v1

The recommendation to reply to the first version/cover letter is from topic
ps/doc-recommend-b4, which is in `next` right now.

§ Link to v3

https://lore.kernel.org/git/V3_CV_doc_int-tr_key_format.8a3@msgid.xyz/

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

 Documentation/git-interpret-trailers.adoc | 88 ++++++++++++++++-------
 1 file changed, 64 insertions(+), 24 deletions(-)

Interdiff against v3:
diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index d5e856f5d68..b4988d39eab 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,7 +14,7 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse trailers metadata at the end of the otherwise
+Add or parse trailer metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
 
 A _trailer_ in its simplest form is a key-value pair with a colon as a
@@ -66,14 +66,14 @@ Also by default, this new trailer will only be added
 if the last trailer is different to it.
 A trailer block will be created with only that trailer if a trailer
 block does not already exist. Recall that a trailer block needs to be
-preceded by a blank line, so a blank line (specifically an empty line)
-will be inserted before the new trailer block in that case.
+preceded by a blank line, so a blank line will be inserted before the
+new trailer block in that case.
 
-More concretely, this is how the new trailer is added: a `<key>=<value>`
-or `<key>:<value>` argument given using `--trailer` will be appended
-after the existing trailers. The _<key>_ and _<value>_ parts will be
-trimmed to remove starting and trailing whitespace, and the resulting
-trimmed _<key>_ and _<value>_ will appear in the output like this:
+This is how the new trailer is added: a `<key>=<value>` or
+`<key>:<value>` argument given using `--trailer` will be appended after
+the existing trailers. The _<key>_ and _<value>_ parts will be trimmed
+to remove starting and trailing whitespace, and the resulting trimmed
+_<key>_ and _<value>_ will appear in the output like this:
 
 ------------------------------------------------
 key: value
@@ -83,14 +83,14 @@ This means that the trimmed _<key>_ and _<value>_ will be separated by
 "`:`{nbsp}" (one colon followed by one space).
 
 Existing trailers are extracted from the input by looking for the
-trailer block. Concretely, that is a group of one or more lines that (i)
+trailer block. A trailer block is a group of one or more lines that (i)
 is all trailers, or (ii) contains at least one Git-generated or
 user-configured trailer and consists of at
 least 25% trailers.
-The trailer block is by definition at the end the the message. The end
-of the message in turn is either (i) at the end of the input, or (ii)
-the last non-whitespace lines before a line that starts with `---`
-(followed by a space or the end of the line).
+The trailer block is by definition at the end of the commit message.
+The message in turn is either (i) at the end of the input, or (ii) the
+last non-whitespace lines before a line that starts with `---` (followed
+by a space or the end of the line).
 
 For convenience, a _<key-alias>_ can be configured to make using `--trailer`
 shorter to type on the command line. This can be configured using the
@@ -419,8 +419,8 @@ mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
-* Here we try to to use three different trailer keys. But it fails
-  because two of them are not recognized as trailer keys.
+* Here we try to use three different trailer keys. But it fails because
+  two of them are not recognized as trailer keys.
 +
 ----
 $ cat msg.txt
Range-diff against v3:
 1:  e5d58237bc2 !  1:  2419b1a6863 doc: interpret-trailers: stop fixating on RFC 822
    @@ Metadata
      ## Commit message ##
         doc: interpret-trailers: stop fixating on RFC 822
     
    -    This command handles the trailers metadata format. But the command
    +    This command handles the trailer metadata format. But the command
         isn’t introduced as such; it is instead introduced by stating that
         these trailer lines look similar to RFC 822 email headers.
     
 2:  5ddd39bf157 !  2:  859ab42ac41 doc: interpret-trailers: replace “lines” with “metadata”
    @@ Commit message
     
         † 1: 68e3c69e (Documentation/glossary: describe "trailer", 2024-11-17)
     
    +    Let’s not emphasize “trailer” here since we are going to define the term
    +    in the upcoming commit “explain the format after the intro”.
    +
    +    Let’s call it “trailer metadata” rather than “trailers metadata”.
    +    At first it seemed better to use the latter:
    +
    +    1. We’re introducing the jargon, and the format is often discussed as
    +       plural “trailers”, with its constituent parts being singular
    +       “trailer”
    +    2. What this replaces uses “trailer”, but it rescues the plural mood
    +       with “lines”
    +    3. This is very soon going to go into the constituent parts, including
    +       each trailer, so we’re contrasting the concept name (trailers) with
    +       its parts
    +
    +    But:
    +
    +    1. The former reads better (most important)
    +    2. “Trailer *metadata*” suggests plurality, similar to “trailer *lines*”
    +
    +    Helped-by: Matt Hunter <m@lfurio.us>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-interpret-trailers.adoc ##
    @@ Documentation/git-interpret-trailers.adoc: git interpret-trailers [--in-place] [
      DESCRIPTION
      -----------
     -Add or parse _trailer_ lines at the end of the otherwise
    -+Add or parse trailers metadata at the end of the otherwise
    ++Add or parse trailer metadata at the end of the otherwise
      free-form part of a commit message. For example, in the following commit
      message
      
 3:  9f0227a1978 !  3:  ab5b4af970e doc: interpret-trailers: use “metadata” in Name as well
    @@ Metadata
      ## Commit message ##
         doc: interpret-trailers: use “metadata” in Name as well
     
    -    We now since the previous commit introduce the format as “trailers
    +    We now since the previous commit introduce the format as “trailer
         metadata”. We can replace “structured information” with “metadata”
         in the “Name” section to be consistent.
     
 4:  4cb26810d4e !  4:  b79ddf3b13e doc: interpret-trailers: not just for commit messages
    @@ Documentation/git-interpret-trailers.adoc
     @@ Documentation/git-interpret-trailers.adoc: git interpret-trailers [--in-place] [--trim-empty]
      DESCRIPTION
      -----------
    - Add or parse trailers metadata at the end of the otherwise
    + Add or parse trailer metadata at the end of the otherwise
     -free-form part of a commit message. For example, in the following commit
     -message
     +free-form part of a commit message, or any other kind of text.
 5:  196c91bebe3 !  5:  e7101eb1fcb doc: interpret-trailers: explain the format after the intro
    @@ Commit message
         well as define the most important terms.
     
         Note that we name the “blank line” rule since I want to use that term
    -    every time it comes up. It gets very mildly obfuscated if you call it a
    -    “blank line” in one place[2] and “empty (or whitespace-only) ...” in
    +    every time it comes up. It gets very mildly obfuscated if you call it
    +    a “blank line” in one place[2] and “empty (or whitespace-only) ...” in
         another one.[3]
     
         We will define the format of the *key* in the next commit.
    @@ Commit message
      ## Documentation/git-interpret-trailers.adoc ##
     @@ Documentation/git-interpret-trailers.adoc: DESCRIPTION
      -----------
    - Add or parse trailers metadata at the end of the otherwise
    + Add or parse trailer metadata at the end of the otherwise
      free-form part of a commit message, or any other kind of text.
     -For example, in the following commit message
     +
 6:  688ea55599a !  6:  557b5b5564a doc: interpret-trailers: explain key format
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-interpret-trailers.adoc ##
    -@@ Documentation/git-interpret-trailers.adoc: Add or parse trailers metadata at the end of the otherwise
    +@@ Documentation/git-interpret-trailers.adoc: Add or parse trailer metadata at the end of the otherwise
      free-form part of a commit message, or any other kind of text.
      
      A _trailer_ in its simplest form is a key-value pair with a colon as a
 7:  e6eafbd641f !  7:  eee81fc99fa doc: interpret-trailers: add key format example
    @@ Documentation/git-interpret-trailers.adoc: mv "\$1.new" "\$1"
      $ chmod +x .git/hooks/commit-msg
      ------------
      
    -+* Here we try to to use three different trailer keys. But it fails
    -+  because two of them are not recognized as trailer keys.
    ++* Here we try to use three different trailer keys. But it fails because
    ++  two of them are not recognized as trailer keys.
     ++
     +----
     +$ cat msg.txt
 8:  8849ace33e6 !  8:  cd3e47459c7 doc: interpret-trailers: join new-trailers again
    @@ Metadata
      ## Commit message ##
         doc: interpret-trailers: join new-trailers again
     
    -    There are three trailers that talk about how a new trailer is added.
    +    There are three paragraphs that talk about how a new trailer is added.
         But the first one is separated from the other two by two paragraphs
         about how `key-alias` can make using `--trailer` more convenient. This
         short how-to does not follow thematically from the previous paragraph,
 9:  8323b84e134 !  9:  c50b6d25170 doc: interpret-trailers: commit to “trailer block” term
    @@ Commit message
         invented term.
     
         That term was useful to explain where the trailers are found (they
    -    *trail* the message). But it is also useful here, where we explain how
    -    trailers are added to existing messages, how trailer blocks are
    -    found (beyond the simple case in the introduction), and how the end of
    -    the message is found.
    +    *trail* the message). But it is also useful here, where we explain
    +    how trailers are added to existing messages, how trailer blocks are
    +    found (beyond the simple case in the introduction), and how the end
    +    of the message is found.
    +
    +    Also note that we simplify the “blank line” point. The text says:
    +
    +        A blank line will be added before the new trailer if there isn't one
    +        already.
    +
    +    But this isn’t quite coherent. The previous sentence says “If there is
    +    no existing trailer”, so we are in one of these modes:
    +
    +    1. discussing trailer blocks in general; or
    +    2. discussing creating a new trailer block in particular.
    +
    +    If (1), then we shouldn’t add a blank line before the new trailer if
    +    there exists a trailer block already. And if (2), then the “if there
    +    isn’t one already” is redundant.[2] So just talking about the higher-
    +    level “trailer block” simplifies the text, since we don’t have to worry
    +    about the different contexts that *trailers* can find themselves in.
     
         † 1: in commit “explain the format after the intro”
    +    † 2: Note that non-trailer lines don’t matter here; if you have a
    +         trailer block consisting of `(cherry picked from commit <commit>)`,
    +         then you still shouldn’t insert a blank line before the new trailer
    +         since that would create a new trailer block
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ Documentation/git-interpret-trailers.adoc: key: value
     +By default the new trailer will appear at the end of the trailer block.
     +A trailer block will be created with only that trailer if a trailer
     +block does not already exist. Recall that a trailer block needs to be
    -+preceded by a blank line, so a blank line (specifically an empty line)
    -+will be inserted before the new trailer block in that case.
    ++preceded by a blank line, so a blank line will be inserted before the
    ++new trailer block in that case.
     +
     +Existing trailers are extracted from the input by looking for the
    -+trailer block. Concretely, that is a group of one or more lines that (i)
    ++trailer block. A trailer block is a group of one or more lines that (i)
     +is all trailers, or (ii) contains at least one Git-generated or
     +user-configured trailer and consists of at
      least 25% trailers.
    @@ Documentation/git-interpret-trailers.adoc: key: value
     -The group must either be at the end of the input or be the last
     -non-whitespace lines before a line that starts with `---` (followed by a
     -space or the end of the line).
    -+The trailer block is by definition at the end the the message. The end
    -+of the message in turn is either (i) at the end of the input, or (ii)
    -+the last non-whitespace lines before a line that starts with `---`
    -+(followed by a space or the end of the line).
    ++The trailer block is by definition at the end of the commit message.
    ++The message in turn is either (i) at the end of the input, or (ii) the
    ++last non-whitespace lines before a line that starts with `---` (followed
    ++by a space or the end of the line).
      
      For convenience, a _<key-alias>_ can be configured to make using `--trailer`
      shorter to type on the command line. This can be configured using the
10:  c7495c3b39e ! 10:  c11a116605e doc: interpret-trailers: rewrite new-trailers paragraphs
    @@ Commit message
         1. Declare that we are about to talk about `--trailer` appending
         2. Explain the default behavior
         3. Explain how this affects the trailer block
    -    4. Then state the same thing (“More concretely”) in concrete terms with
    -       placeholders
    +    4. Then discuss what each trailer line will look like
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ Documentation/git-interpret-trailers.adoc: are applied to each input and the way
     -using `--trailer` will be appended after the existing trailers only if
     -the last trailer has a different (_<key>_, _<value>_) pair (or if there
     -is no existing trailer). The _<key>_ and _<value>_ parts will be trimmed
    --to remove starting and trailing whitespace, and the resulting trimmed
    --_<key>_ and _<value>_ will appear in the output like this:
     +Let's consider new trailers added with `--trailer`.
     +By default, the new trailer will appear at the end of the trailer block.
     +Also by default, this new trailer will only be added
     +if the last trailer is different to it.
     +A trailer block will be created with only that trailer if a trailer
     +block does not already exist. Recall that a trailer block needs to be
    -+preceded by a blank line, so a blank line (specifically an empty line)
    -+will be inserted before the new trailer block in that case.
    ++preceded by a blank line, so a blank line will be inserted before the
    ++new trailer block in that case.
     +
    -+More concretely, this is how the new trailer is added: a `<key>=<value>`
    -+or `<key>:<value>` argument given using `--trailer` will be appended
    -+after the existing trailers. The _<key>_ and _<value>_ parts will be
    -+trimmed to remove starting and trailing whitespace, and the resulting
    -+trimmed _<key>_ and _<value>_ will appear in the output like this:
    ++This is how the new trailer is added: a `<key>=<value>` or
    ++`<key>:<value>` argument given using `--trailer` will be appended after
    ++the existing trailers. The _<key>_ and _<value>_ parts will be trimmed
    + to remove starting and trailing whitespace, and the resulting trimmed
    + _<key>_ and _<value>_ will appear in the output like this:
      
    - ------------------------------------------------
    - key: value
     @@ Documentation/git-interpret-trailers.adoc: key: value
      This means that the trimmed _<key>_ and _<value>_ will be separated by
      "`:`{nbsp}" (one colon followed by one space).
    @@ Documentation/git-interpret-trailers.adoc: key: value
     -By default the new trailer will appear at the end of the trailer block.
     -A trailer block will be created with only that trailer if a trailer
     -block does not already exist. Recall that a trailer block needs to be
    --preceded by a blank line, so a blank line (specifically an empty line)
    --will be inserted before the new trailer block in that case.
    +-preceded by a blank line, so a blank line will be inserted before the
    +-new trailer block in that case.
     -
      Existing trailers are extracted from the input by looking for the
    - trailer block. Concretely, that is a group of one or more lines that (i)
    + trailer block. A trailer block is a group of one or more lines that (i)
      is all trailers, or (ii) contains at least one Git-generated or
11:  fc38e8660f0 ! 11:  7d20cb7528f doc: interpret-trailers: document comment line treatment
    @@ Commit message
     
         Comment lines have always been ignored but this is not documented.
     
    -    This is mostly for completeness since this is unlikely to catch anyone
    -    by surprise. But we really ought to be reasonably complete here since
    -    it’s the only documentation page that documents trailers.
    +    The primary motivation here is to reasonably complete in the
    +    documentation of how trailers are parsed; this is after all the only
    +    documentation page that documents this format. However, and going beyond
    +    that point, we could imagine that someone would want to use this format
    +    outside a commit (or tag) message context, like say in Git notes.
    +
    +    On the other hand, it seems far-fetched that someone would be caught
    +    off guard by this considering that comment characters/strings are not
    +    likely to be alphanumeric,[1] which would mean that these comment lines
    +    would be treated as non-trailer lines if they were *not* detected and
    +    removed as comment lines.
    +
    +    † 1: A notable exception is that Jujutsu VCS uses `JJ:` as
    +         the comment string
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.54.0.22.g9e26862b904

