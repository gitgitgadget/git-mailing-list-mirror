Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA22368D76
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790984558; cv=none; b=pufqNqFI91L0X3Uwon99iWQoM9Qkskaf1xEau2Po4AogJgEDg6lakDQn1JbkLQ2Y528t6nsXieAuzKCuEbuaTeLw2NDsqqd0fMQJgdhgfirBRooSPix3vXAtWGRMUQ7zR6I8vu6lVz1EKD+C8wL9pUYO5PlIO3CjnU0rD6DJGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790984558; c=relaxed/simple;
	bh=Y5EOx4yGMgg/hDVD3HIVEva+amYfruvSqNQ+rKKI+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjIzYi+/b7W1/ls2Fr+6F8jBrE4VtmR9HHjr+zib9r/KLictMgCUmYVwWFhou5/pOYugPzHpzLPL/2K5NoMkg2eMaSOgkRCQ6+lV9x1jYcQzvCl16nDqRsfSKaF3Kz12dBDcmiqcHfX+6UHt8CyHAxZFKkfR2SGFdwhhgKOsxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j/gClDtq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoYWptYA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j/gClDtq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoYWptYA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B586EC0101
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:42:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 19:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790984555; x=
	1791070955; bh=+296PFePgePzBE5rbhL2Skva27y1RV4PFHEydHaqJs0=; b=j
	/gClDtqYPT9+KHRlh1Wsz5L0Bl7hmTxLl4WqJ6cKIRIA8tPIRDFkUDKkwd2QvNec
	VGsbQZpngKpn/avR0dhKMtx7+mM3Y1oWJ3h1GDljpt85IxcFqk/A6eZGvmhTfSmW
	EsdLgYpbFY9WRbBalt31nA8rizJ0QYFDjWE1kPlR9cB/MZ+ALeqmC+KC9MQOU+Mz
	IMIwnLcMUvY5u15EE7hkBssdHJkkOvLCT2hdQo6Ba+khUc2bb7/d5oTSXr3c6b+O
	X3+DD4BRaIM+IIKr+m+HX6GBW1SXjVEbk6bEaZXYHDWtBfXIEV11fuXEu7sXxy0L
	iCQXmIPeRt9YXthyLYfxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790984555; x=1791070955; bh=+
	296PFePgePzBE5rbhL2Skva27y1RV4PFHEydHaqJs0=; b=NoYWptYATGmZ9ikmL
	ebTPNbiOqtI0M1ruDthf4b91alQ4V+lALti/wbX9QuPfTOSfwv+Pk5y9qt6A7smZ
	qVUeSooNUFGAhp/wGPL/n576faxyL+Imxxoyr+zNaKy0l1xi74r95nxjfp5HFAOs
	vHgUmJRbAX3PdXqsHK0UO9kTRznMyOd9DAsdeRAzWyOMDjeo5ttLfc0gto9KO1Wz
	lxG8usMVSet0Z9ZRHZxJKVtjEyDbGT2nQAzfwzqEoyfKr1f1y1dffinF6TYHVUB5
	fRrMic5ixYRYI7BAE56mnbYL444GCrnjDCoczr0SWdtp2rtYo/R+KLnvC9roAx88
	zujJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790984555; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nQcm3xHe+skRhe4rj0QmOQZeYZerYzUt49VgrSvgUgHbSgP
	ZDsPLYcxbAKlCISlAN4stfplPqT544wRl4aLKyHsMSNDoKuWve4Knj/nTXFsFjFS
	ujQqYOyfSyfv8FXxJmATAjdzoFiUoosUUNBO2rAbb/lVfFiDAKc7FAgUyBh/DJEf
	OJmXZmQHaqd0pYtUa9lNlbjKLLpH1aAp+wVLqmcJ9gMv9QdE2VWj1YR2iBdL1zI0
	tKcGeaVV1GWKXFpjY6S5QkxwYEu2L3pXwffO3i1h8EakhV2tRjyHRjNaba0eMSc4
	szihmcffyyqfBDlC5l8KcGijRRC4F3YvirL0O3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ippRpE2ZobXPBOil+r9edzFDuZ2EakUqoWnHb9disbY=:Y5EOx4yGMgg/hDVD3HIVEva+amYfruvSqNQ+rKKI+lY=;
X-ME-Sender: <xms:a0HAauCQNEEacAcRfnOBjJ2HTNULMWowt-vno4ndefdyyaOJ-kL14A>
    <xme:a0HAav_m3H1Pu9h9SpbDF3h1V7nAS7H2EMC94I3-xX39xcLxe406BoUH0JrHn3VTH
    LBKJUBtcBfb0o7cCuRBqNtqrfk0_k7SZ6V0_3QI_AdUkhb06XUiitw>
X-ME-Received: <xmr:a0HAau98KVhdYGwIXG4JZYq6ymn9AVmdfIHzuUAVOEzZavkCUqQ0NHGnn4rKMacE6JQ6Dj2xxwkaXunBA5lr-e51MXbrfIuxN1I47MPShL_wGgTLSYWmMc1RowvNUHkO6qcJ2QzPFrnlIgGy>
X-ME-Proxy-Cause: dmFkZTFit0yMEKtouVXwjMZQL0BSyzLANuYGQ7bbKzCiAv7i8xpt5DhEyschXA3wmftHrT
    Wn0f3hLWX6oUSdJcBllxmR4e5linkjJuv+qGPSx5u8g0Y5OC6M7N2pMRjyRNAzwt/2kRhi
    Ch2edHmjKhUs88rY/7B10/n6VT8D6ryJMiO1fZbkXfBDvIWR3ga7fMxO61mPOXv2U7uGF4
    q/oBYjjhaG4kyPi8pKeecJ0+Gru5BqTzMhDmB9QbrGwMac0CLBRGlIFVX6F+xoHUJSUl/d
    vOWzxBeslRfXUtTKvm01PMymx8AeSiEpCmkh2O2LD4XxhBMVaFLhZfnAU8yvmAY2EfPder
    Ik4EaRU+ggacXtUoRE2NjTHchY7Sku+0TGH5yYvGxhM+K6dvky/0jPcM/a1yxDEdWuadOy
    EhCMiJv0isO8FIdPOQRu2mdZkFKThE9r9ZkHOk6gbVcuu8MCLfWRnZtxw1BBz3A/KtzwsP
    UsrUt6U1JEBaYUu57AWlKoAKdSQpPbpm9qfHHGqLOW1um6HulHxilGmSTJgiAhWHMKwQkf
    qsN0w0mxgVI8UxBueukwM3+WMMQuewv1iwfHN0Ks5zA17DVpHBKKzzFwxQbzh++Q0vIidI
    C+T8hDZVa1nbandV/e2QRjix48iw9S1YBBzo6Cr5GA/UCvk2c+ndD+ItFdKA
X-ME-Proxy: <xmx:a0HAamdvByfuPyU00fbyrpS5yt33fP3m-7ABzDsdg_TCQ-phhBmhQA>
    <xmx:a0HAanF0lrslOV42G3in_ox-nJwKJz-CS6oiR3SzTdVTn0E7T4arQA>
    <xmx:a0HAakebamwNuAFedgZUthwIxTVlVUlgPAppzPWDKNDQhC0lXqc0vA>
    <xmx:a0HAahHxLBaJeaVn-n_GtHbLrToRmYrch4D-QcyVzeDigXvyEIWJug>
    <xmx:a0HAarqQtKqSBdCi7MlRYVzRtu3AUkoKRqKzNbCwEUpzaBpsIqSSb4uO>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 19:42:34 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Francisco Boni <boboniboni@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] doc: add more examples of overriding LESS in core.pager
Date: Fri,  2 Oct 2026 19:41:52 -0400
Message-ID: <20261002234203.4064847-1-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260919163725.TExDduTp@teonanacatl.net>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We set the LESS environment variable unconditionally which can surprise
users of pagers which respect it but presume we'd only set LESS when
`core.pager` calls less.

Provide examples of setting LESS in `core.pager` as an additional way to
override the options we set in LESS.

Reported-by: Francisco Boni <boboniboni@gmail.com>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Now that 2.56.0 is out the door, I offer this up to see if
it feels like a useful improvement to the docs.

Cheers,
Todd

 Documentation/config/core.adoc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 0b697f53f1..bdc74d291c 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -621,9 +621,17 @@ command to `LESS=FRX less -S`. The environment does not set the
 long lines. Similarly, setting `core.pager` to `less -+F` will
 deactivate the `F` option specified by the environment from the
 command-line, deactivating the "quit if one screen" behavior of
-`less`.  One can specifically activate some flags for particular
-commands: for example, setting `pager.blame` to `less -S` enables
-line truncation only for `git blame`.
+`less`.
++
+Another way to deactivate an option is prefixing `core.pager` with
+`LESS="RX"` to remove `-F` or `LESS=""` to override all options.
+This is useful if the `core.pager` command eventually runs `less` or
+a command which respects the `LESS` environment variable but lacks
+command line options to override `LESS` options.
++
+One can specifically activate some flags for particular commands: for
+example, setting `pager.blame` to `less -S` enables line truncation
+only for `git blame`.
 +
 Likewise, when the `LV` environment variable is unset, Git sets it
 to `-c`.  You can override this setting by exporting `LV` with
-- 
2.56.0

