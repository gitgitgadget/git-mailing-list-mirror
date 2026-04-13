Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390835AC0A
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075860; cv=none; b=egNRpayc0h6fQZp00EHr1gNivoXcGIVzs37rEM47At+bYTktXTsnPqPqo+kYjFSLqkQ/sgifOAgFGLusP57phDEUi9lPqU1zaVT2ZdwLAAgmNhxXSV2DRoqnM78zvnJo+4QfOKMKUVpgA2oaUyE+HeMEQZa8Y9KaVrw8UZlu0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075860; c=relaxed/simple;
	bh=IAfEh0alB0mpo9txcABxaRDQGIrvDpgxUNURoeG5rkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNOpHWOWVelvtkRbnrwcU8JZzzlEerBEwJKdibJRym57657xBSUpwO02vaNYbxhT9QtQomE0E0sCx6PPdTSQ9Y3YietT01RI4Kr1QKsWqEcdZ1zRm/S3r2fqGPDzx2CYOd36VrfUfgOvib+SlaDPLJZnBAqiiTEXzdLwCR9ybBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FamlwIDv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+QCtSyq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FamlwIDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+QCtSyq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BB604EC0385;
	Mon, 13 Apr 2026 06:24:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 06:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075858;
	 x=1776162258; bh=VYTH7ZCk3iCQP5sSOzYY+Qk3Z2IiRrbUwdV7rFWpkjk=; b=
	FamlwIDv3xM/WAOCdCE2Lq9Fbh1e0I8D5PEpFW7d/B3aSm6q94ljFJYQnk+uUTFN
	pLKHz+uOQ1Ch6FYt6Mr6qPT5ywW79a2fC0gjyNyf0/LMRGIoCqH3qVaB6cMdk8AA
	Z9q68TYhziIOatba+rJTOIWc1NonfZ0SL+giharp2rpjDgMs+0oiUYq9kq5xxzGh
	Pbk/gbF+GBRrMExCW0XkImFGMB+Depm/Y+eG13Xlf/dTaOP9NEq1FGNNF3+azDCM
	IakKdDZfTrn2DcGzVIZZIdlz+Qu1LDRnLBDyHrGUh0RinNrpYNA5xHxRXJzyt0Or
	fuAw/Y/wU9QYWE2pGJgHKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075858; x=
	1776162258; bh=VYTH7ZCk3iCQP5sSOzYY+Qk3Z2IiRrbUwdV7rFWpkjk=; b=m
	+QCtSyq2IaJJ40lqq7zTPFxhI8lI2QI751hz5Z/y4fXke0FijZY7okfE6QixlNqc
	vXhO0oRaVvJSVHTXsNvYUZUOQTl0GKKw+G8DbPYC38nwn40xCD0rD5pOHxVNV5N/
	aX7Boj41Ddm+NraJG8PK/5IrqqHBG/g8uuMKDP7cVoBIXoO7hIREguD92a5d+hd2
	vNWRhYoNhZsocBmZ5TCEEsJTMzZ9nFW6R/2sOzYfF+BfBHtZNLHL4vPLqVBJ4k+A
	GKLplKukulj87MFE4Yco/tY4zmJHLGjRONrpwinRSvqrW5OF1lQqyAS788a/Qob8
	emIxQ9O1FCVO/xqB18LTw==
X-ME-Sender: <xms:UsTcaVTjiQNj0GOG50x3LVsrOtalZ1KJN22i3d87n62a8icNuc-dcE8>
    <xme:UsTcaVopkOigsTwQBIksSeKQjnbaYadEGHEmcBvvhgp7xx7cgdJyd1v2Nm0B0e04o
    58QoWZ2VLM0Q9b3P-WA3uthKLHYGFzlBi9N30_7oycATZpzX-flbyA>
X-ME-Received: <xmr:UsTcaTIKk1glLkOSQXgO4wVeZkeaJ4plkLq6VQLiasWKbZnBmqn52NIhidI8R94aQE8nRVf2443bNTo9c-1wTlymYv20dHqMdystl5I5-CBfr_g8eoCrzio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:UsTcaYptfRlrqeIFSQdkdJ-QnuyJv5oVaHEMfJtGxo-0dOPEdkThPw>
    <xmx:UsTcabxcH2eDp8hD_AO2UXfblyj26y5UmL-4AV-0FR8DJg8u3WcBqQ>
    <xmx:UsTcacO9955vmeK_RJ-jgbcdBddtN9ukG3KWD99W7OI2Dhrzt65KKg>
    <xmx:UsTcaQ5G9qOLJVdhfhdxjlXGACqjbM7sEbXGACUgSouuz3P46ZaPYQ>
    <xmx:UsTcaU5FL_nGTNwFr196MQGmvBR_KA9dGWqZAqdKxKOkYTqelHkbKY4M>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:24:16 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 9/9] doc: intepret-trailers: document comment line treatment
Date: Mon, 13 Apr 2026 12:21:08 +0200
Message-ID: <V2_trailer_comment_lines.61c@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Comment lines have always been ignored but this is not documented.

This is mostly for completeness since this is unlikely to catch anyone
by surprise. But we really ought to be reasonably complete here since
it’s the only documentation page that documents trailers.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index b693e89fd96..b42f957d666 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -103,6 +103,10 @@ of the message in turn is either (i) at the end of the input, or (ii)
 the last non-whitespace lines before a line that starts with `---`
 (followed by a space or the end of the line).
 
+This command ignores comment lines (see `core.commentString` in
+linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+and `commit-msg` hooks.
+
 When reading trailers, there can be no whitespace before or inside the
 _<key>_, but any number of regular space and tab characters are allowed
 between the _<key>_ and the separator. There can be whitespaces before,
-- 
2.53.0.32.gf6228eaf9cc

