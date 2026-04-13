Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C9355F4E
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075711; cv=none; b=ZiLG6VdgCgSmu9mLDj98N99GKNmdJ/NEX6bn4N7++cmtZ++OLEzjUcMKx+0jMvjoYHWDEnm4/uY3NqUy3oyKr/7tgml47L6+fuP++aYBmspM2JZn1bQwaT6dI552pmNFPmimsONCnAjkpdT7RRkksGiL8gPUfTW8LW0wAuuzN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075711; c=relaxed/simple;
	bh=C43/kAkcj5GBI6SZXPanOjb2neRTu7BvVIj2RVDJB90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWDGXa0HrRG9gGx4xG9HLml5eNFQr9KT/Eh4nWJbrg8+vF+S92XdczIawl3hUrnofOveT6WgaHxtkatsTtc/z2KcDQI2jnGOLubZ5tQ1whftNXckYEq7fDi7r8PmfxaXedkkZOQ8QJpdKh0XFtWjZp0qy9tn7aCdlY6fSwfQnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Qn2Ik05S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fWf7rL2I; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Qn2Ik05S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fWf7rL2I"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7C3814000EA;
	Mon, 13 Apr 2026 06:21:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 13 Apr 2026 06:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075708;
	 x=1776162108; bh=KusFap9jl6s8QBzNYX4mQvcyGc13sblTvJOk9u148Sw=; b=
	Qn2Ik05SHxp+klmucQ7YE++wdVpGaQM2yF+M1HsWTz1HY/oJKBcAu1DlcAG3qcmN
	qE53VV/dVUxaHtIgeB7VF/mmIk/rc5fIq4X9axTcjHQEl/O3L0Q38AYoKzD+RuZQ
	hT6ka+myrLU0vtRGaNSnTB/kklOmcUwk8IbmvFMPpc9P9li28MouPEsnXJXjxORg
	qR8qAC4XZ42e1VIz2zKa89V3djcKs1k2WhnjQbQv9RLiVxnzlLWv4yko2pQJZY3U
	iP4knp7PaT9lJtImStyHkFa0gPht4nU4MoxRhr2cLH7ByGSPOKYmTz4cXUF5gHy5
	KUMZyQkjrfnetPxC8199pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075708; x=
	1776162108; bh=KusFap9jl6s8QBzNYX4mQvcyGc13sblTvJOk9u148Sw=; b=f
	Wf7rL2IBM/NOe4b1swp7rMEaKn9SM5uQMLEMtKVT5TH9B76XtYhIOSXv3+t7sv9+
	U2Ph8bjT8wbh12+WpZIyo9HZ+oQU1m3yyO3JU9bJlaYoWPUiqKP00tFjmxOYN3v1
	77LcglJ76j4bpquAMxAfWb/tkWpbQ0+ug/yvD+gEHRdT8w9DoXVpWN9CQ4nTPV6M
	MN9TM+e7pilNBoLIps/nT7nL8/srRnZ31jHvGH8cUwoR8EbOSqk04kWzINFCECdZ
	xGAoTqile74r8rh20iCY/zrr62TtydEFbIdg++YFgWqGboQi0X1LpmOcacg0LO8M
	P9QianNiAWX5NkBqgxYbA==
X-ME-Sender: <xms:vMPcaSK9h0wSOvTK-xpDGqEs-UvuoNLX3yUJRtzYzHuPosDeZgUkpKM>
    <xme:vMPcaRD6PHwnI_zfrLC8feiqaR4evhMXnhJub6PKRxQxjkJMyEkhP6RRq8cZpp5dP
    sk5XFsIO6T2OvxM_PLiXOlnCsh2or8ZAoUBSBvC0YtcDM7KyQZ6cJw>
X-ME-Received: <xmr:vMPcabBrc7j2QZa6myfTc85IpZgSla0IAJlNXbLszUYOltulo68wkfH9CW4tQC91OMB5NsEcldJaLEVJ8LOJhqL9d--KV4cnLjEWFz-5iKt_PTJF-gY0STI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhgrtghkmhgrnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hlihhnuhhssehutghlrgdrvgguuh
X-ME-Proxy: <xmx:vMPcaTAkxqdx2mh2Y0Ysuui-68HwLjy4E6YVVdYxGoek8I_I-E0UgA>
    <xmx:vMPcaWpFNqUqx8mdrC3H3ceRjp-oeGH4I7jUrA-rmgmGArHc-5Q7lA>
    <xmx:vMPcadkjLQjQa-k9t45878DXdCYmv900RTZjQXZcceyER4ETUMx26Q>
    <xmx:vMPcaWyBsplLp2RiDgpAa63WXV1pZ22JHig3MRrv7wUO_-ac3xC4Mw>
    <xmx:vMPcaURmf2lFUTeY2Qf98EKEmlqYDVD_K7XKAH1qIK_7HHCkTf2FyjHr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:21:46 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 1/9] doc: interpret-trailers: stop fixating on RFC 822
Date: Mon, 13 Apr 2026 12:21:00 +0200
Message-ID: <V2_less_RFC_822_focus.614@msgid.xyz>
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

This command handles the trailers metadata format. But the command
isn’t introduced as such; it is instead introduced by stating that
these trailer lines look similar to RFC 822 email headers.

This is overwrought; most people do not deal directly with email
headers, and certainly not email RFCs.

Trailers are just key–value pairs that, like email headers, use colon
as the separator. The format in its simplest form is easy to describe
directly without comparing it to anything else; we will do that in the
upcoming commit “explain the format after the intro”.

For now, let’s:

• remove the first mention of email headers;
• keep the second, innocuous comparison with email line folding in the
  middle; and
• remove the now-unneeded disclaimer that trailers do not share many of
  the features of RFC 822 email headers—there is no invitation to
  speculate that trailers would follow any other email format rules
  since we do not compare them directly any more.

***

Talking about trailers as an RFC 822/2822-like format seems to go back
to the `--fixes`/`Fixes:` trailer topic,[1] the thread that precipitated
this command and in turn the first trailer support in git(1) beyond
adding s-o-b lines.

† 1: https://lore.kernel.org/all/20131027071407.GA11683@leaf/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Use `***` as a thematic break instead of `❦`
    • Change to “metadata” instead of “key–value pairs” since this series
      version adds a paragraph after this one where we dig into this
      term. And “metadata” describes the purpose of this format.

 Documentation/git-interpret-trailers.adoc | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05c..1878848ad2a 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,9 +14,9 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines that look similar to RFC 822 e-mail
-headers, at the end of the otherwise free-form part of a commit
-message. For example, in the following commit message
+Add or parse _trailer_ lines at the end of the otherwise
+free-form part of a commit message. For example, in the following commit
+message
 
 ------------------------------------------------
 subject
@@ -107,9 +107,6 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
-Note that trailers do not follow (nor are they intended to follow) many of the
-rules for RFC 822 headers. For example they do not follow the encoding rule.
-
 OPTIONS
 -------
 `--in-place`::
-- 
2.53.0.32.gf6228eaf9cc

