Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D62E8DEB
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467305; cv=none; b=Kq+n/fVFvL2xBqfUDxjAIx0VsgSI1Ca7l0jUagWdZ14/H1xcLDMlrXRRP20vBO2vqiuUA/7mLWZLlwbhSmVljEotOkby4+2YTkYwipVhxkCoq0qcQ+NZEgRSI0druQTpfI0guZpaKkDging7aoDw/6OWyrz5CiLewPDVN+6hWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467305; c=relaxed/simple;
	bh=or8+COf6uLNWxfCTHbCsbFhRBEnBFHG9+Y7eFoEbePc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oSza9S3crR7OnsiyUDjhFwv24iaJcZGBIxN2lBChEg/p4jnjgcZNkVUfUB1dbLvRGwcyh2G6pgqtnxN96jlficAF7+wUQKx6RGE/qn7nSVZU8ePNRcTYJYSahKIe8pxgECC3rEHwA0gIaGhLzrqZozC8bdGkU3xrGyyfjQPhtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f8S0wW+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hD7+0pug; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8S0wW+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hD7+0pug"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 822ED7A0068;
	Sun, 10 May 2026 22:41:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 10 May 2026 22:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778467302;
	 x=1778553702; bh=cnFYMvS6lsz+Rzi/Pbo3Xfudp6TGbXIou5Ln+SYpFk8=; b=
	f8S0wW+tYqgBUaRIIWaePKUmzpxIVwcU46F+1MeVkPkTUP9+vkGrYoKwTuu0GVam
	F7ocskipPa7erf6H33b/4/K6tqIDzuC5CM6E95sDKIfVNVT/9ZLIZamU+itlu7tY
	lvnTrpXQF9JjED/MMPTasNJeb55nbVby3o5lOaE5y8k8l6Z7shPQd3Sv2wqe9dxs
	hOMUd1I9B/Y5tWoHFX4LxS0xkpgemprz199KW0R7AUk6kgp4YlCMUzicGou7LJ/w
	LyrWpyfMOvXIInQqDDxSf+HRZnFW63Tco1MDWWDLu1sRQJSRPp9sVZSprvkL23KA
	iNmChUXdLW+uYRUnOJw9vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778467302; x=
	1778553702; bh=cnFYMvS6lsz+Rzi/Pbo3Xfudp6TGbXIou5Ln+SYpFk8=; b=h
	D7+0pugpKVN/0IMqvRrAvSTcWEB+BTMmSsoweyXglprd0+QDGGHkJhpmahx4HdUX
	3jAFeQXHiWB5InAKhs523/1QN6uL95kFBLPP9q+ATghJgsxB8dCXqGGxTwWJ3ioK
	BrzQcVjI1/9wLxsGNuPXf0lFYJJ2f9AqdAlauGL7Un+vQsotPuChrEFAFPW09ckA
	eD2yH3ACluAEPVgh0VB/3WRDcVq2Un+fZ7mTaPj6CD1sVYmiZoeG9F0sB0cyU+Da
	oqDGZqGfdo5I0D58pObLl5+gctuT1fdoRTxntZHH+ftxhaEtCGL+aLEpAhS42YKj
	401toVdoLY8ABggiBsmwQ==
X-ME-Sender: <xms:5kEBaonhA9yoBI2sQforEjOBOg1ZBqLM1X-sVpO4tTPu-6388AQisg>
    <xme:5kEBaqEhYuF3rg6TQw2hYBkrsjqq9HV4VZiFUIa1wRHjshxvx8oVJIns-WB1NTuYP
    CPw74krT8wYWRm4EIgY5k9CP_ACCu4knwmffCrYxocpYgBIpNQDWQ>
X-ME-Received: <xmr:5kEBao7Trqrsqk7M377NNDWQlTA75FC0jLwFvm9487Tep4e2xCsCb5yolQOPDT_NqAhZdvHAiRe5l48E5QJIscgDmKs0UWukvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhm
    rghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvug
    hupdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5kEBaqkVGXil4VnOaQafm9iurFOQyGAhXo-G9_IJIIqOCdjPk0VaOQ>
    <xmx:5kEBalrjpHlhVeLwchpF8KC1ldfR8s7Y7m3UMUOQX5EVq0Q_8UPNNA>
    <xmx:5kEBahsJveRD9LSZYvR-JpUGkHRgUZI7Jr_nkt8oxrGj956hefS6hg>
    <xmx:5kEBaiF-aX1vxe3-dTiRu2Q9THSatpJWCK3z65FQ3eCtHBL7tVoEtw>
    <xmx:5kEBasSu1HjfgUBHyyKUpraMU50f9AzFVm04lovpi6XU_WqkG7i9rDSa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:41:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Christian Couder" <christian.couder@gmail.com>,
  jackmanb@google.com,  "Linus Arver" <linus@ucla.edu>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/9] doc: interpret-trailers: explain key format
In-Reply-To: <55d5d53a-ec30-4b72-9ff4-c5a0631620ec@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 08 May 2026 17:01:30 +0200")
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
	<V2_CV_doc_int-tr_key_format.613@msgid.xyz>
	<55d5d53a-ec30-4b72-9ff4-c5a0631620ec@app.fastmail.com>
Date: Mon, 11 May 2026 11:41:40 +0900
Message-ID: <xmqq1pfivfa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Apr 13, 2026, at 12:20, kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>[snip]
>
> Sorry to Ben here who I forgot to set on copy. :/
>
> +Cc now.

It has been quite a while and I have no recollection if there were
still necessary adjustments or not.  Is everybody happy with the
final text?

https://lore.kernel.org/git/V2_CV_doc_int-tr_key_format.613@msgid.xyz/


 Documentation/git-interpret-trailers.adoc | 68 +++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05..b42f957d66 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -3,7 +3,7 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - Add or parse structured information in commit messages
+git-interpret-trailers - Add or parse metadata in commit messages
 
 SYNOPSIS
 --------
@@ -14,9 +14,15 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines that look similar to RFC 822 e-mail
-headers, at the end of the otherwise free-form part of a commit
-message. For example, in the following commit message
+Add or parse trailers metadata at the end of the otherwise
+free-form part of a commit message, or any other kind of text.
+
+A _trailer_ in its simplest form is a key-value pair with a colon as a
+separator. The _key_ consists of ASCII alphanumeric characters and
+hyphens (`-`). A _trailer block_ consists of one or more trailers. The
+trailer block needs to be preceded by a blank line, where a _blank line_
+is either an empty or a whitespace-only line. For example, in the
+following commit message
 
 ------------------------------------------------
 subject
@@ -81,19 +87,25 @@ trailer.sign.key "Signed-off-by: "
 in your configuration, you only need to specify `--trailer="sign: foo"`
 on the command line instead of `--trailer="Signed-off-by: foo"`.
 
-By default the new trailer will appear at the end of all the existing
-trailers. If there is no existing trailer, the new trailer will appear
-at the end of the input. A blank line will be added before the new
-trailer if there isn't one already.
+By default the new trailer will appear at the end of the trailer block.
+A trailer block will be created with only that trailer if a trailer
+block does not already exist. Recall that a trailer block needs to be
+preceded by a blank line, so a blank line (specifically an empty line)
+will be inserted before the new trailer block in that case.
 
-Existing trailers are extracted from the input by looking for
-a group of one or more lines that (i) is all trailers, or (ii) contains at
-least one Git-generated or user-configured trailer and consists of at
+Existing trailers are extracted from the input by looking for the
+trailer block. Concretely, that is a group of one or more lines that (i)
+is all trailers, or (ii) contains at least one Git-generated or
+user-configured trailer and consists of at
 least 25% trailers.
-The group must be preceded by one or more empty (or whitespace-only) lines.
-The group must either be at the end of the input or be the last
-non-whitespace lines before a line that starts with `---` (followed by a
-space or the end of the line).
+The trailer block is by definition at the end the the message. The end
+of the message in turn is either (i) at the end of the input, or (ii)
+the last non-whitespace lines before a line that starts with `---`
+(followed by a space or the end of the line).
+
+This command ignores comment lines (see `core.commentString` in
+linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+and `commit-msg` hooks.
 
 When reading trailers, there can be no whitespace before or inside the
 _<key>_, but any number of regular space and tab characters are allowed
@@ -107,9 +119,6 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
-Note that trailers do not follow (nor are they intended to follow) many of the
-rules for RFC 822 headers. For example they do not follow the encoding rule.
-
 OPTIONS
 -------
 `--in-place`::
@@ -402,6 +411,29 @@ mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
+* Here we try to to use three different trailer keys. But it fails
+  because two of them are not recognized as trailer keys.
++
+----
+$ cat msg.txt
+subject
+
+Skapad-på: some-branch
+Hash-in-v6.11: 45c12d3269fe48f22834320c782ffe86c3560f2c
+Reviewed-by: Alice <alice@example.com>
+$ git interpret-trailers --only-trailers <msg.txt
+$
+----
++
+Recall that a trailer key has to consist of only ASCII alphanumeric
+characters and hyphens, and this does not hold for the two first
+supposed trailer keys. And now none are recognized as trailers because
+the candidate trailer block has at least one non-trailer line, even
+though `Reviewed-by` is a valid trailer key. Recall that a trailer block
+has to either (i) be all trailers, or (ii) consist of at least one
+Git-generated or user-configured trailer (and some other conditions).
+And (ii) is not satisfied since we have not configured any trailer keys.
+
 SEE ALSO
 --------
 linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1]
