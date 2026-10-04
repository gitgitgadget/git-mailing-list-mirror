Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C64756CB
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136767; cv=none; b=nRr0uxqiBm6OZgZubLU09uNrgpn0DCvuIUQXLX1SoNNfTG6NKXAjP6kjsutPuWP8G4Bjm2mZ7LuOOlyrKGC0Zujn3L1chiRiG78pA1bIi+Jyx/xPn+0xYt+w3YOhl0dC1cLkN3J9/Nm7KRpM2ZqIuwhUsXIX02fq4AyTdZGIYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136767; c=relaxed/simple;
	bh=593lunBRqi8CTJU9ojLLYg4S/gZ6vGRF0zci33+1w0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6dJeqEEWbB9L0omyHUmVTxqRSpxJATlyR7LSGRjR7tJBAbcXxVDo9avNWCelx6a887aH19vAzHX6IpZ7TC4UP0C9WUpJlb5ARLpNFwnNZUSB1odRr/bcVNOf6bl9TJjgzXgQCdELKUKszXbakuyJI738AX9iOvtiu5x2AV6d+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fRZEj/07; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMYWIdjq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fRZEj/07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMYWIdjq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 369A614000F1
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:59:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 04 Oct 2026 13:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791136762;
	 x=1791223162; bh=Uh8OuQgmcee4Wg9mQJEZ73lN9dTnbWxySDgZ4rwVBjE=; b=
	fRZEj/07rsf+b9g/LKbu8pWC3VOeJJjb2C7mnk24i81iwi88lFl4FO83ByIoT+li
	p3A7zttfSEPX526LKMTS1dgDhK9l+71N54wOVDBSfGMNrKjuNOlD6hgHy/sBSNW1
	B6H5OaJmcXB8kM4f70gZniGXTN2/cLRH+ur6UD8S1d3sIEpBRgL9yvK883PmhD2F
	DtaKiZt28Ni786XYlm5Nu5i34w31RJSclJ/HucAwhmNGvBIwn8CVheeQcZy8aOct
	WNHCcfsNe06M/Gz31PDLDYQ8XnBWC3hffF8I446QAPZiPZKR1oa6Le7GDb9WSYO+
	mfZMtnk7YsdJDpq1iZYOjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791136762; x=
	1791223162; bh=Uh8OuQgmcee4Wg9mQJEZ73lN9dTnbWxySDgZ4rwVBjE=; b=T
	MYWIdjqYKa+S/yzTpgbw+9uxjkD/czPEfFNz5g+VHQEErW+Wei3L3D898An2On+Y
	HqykmSWxXAfzo3cvpUnJKWqMnK5l+/xcuTGQwcDciVKYD0GybyFDbJkDCd8+gp3E
	Rj6/9DxR3Nh0HpLf5kQmfLIpzww00j5acrV2hNmh2PwYI27fm8iTTcj/w5tawD2W
	NOgR50J71hUkQFh68lHl9CoyBdlsC87Ou7MqTCFFM9mL7S12XL5owdf2xFZBsEKl
	A2N+06EN5LMFJrv1Py8DICCiVoEf1TcfxfvkZnUI6K0cyK/SCqahEq/HUVX9x6a8
	DHoncmHZhtsBaaNfLk9aw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791136762; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OwDMtj/excWVYdTE2gF8njeRIAdD2Ts9GOaui5M4/1Oiipe
	c1YC876/zWWVusgG+0kQ6Y2hMa7l0awJrnVP7GdrGexBmrcRlBG4GtR10dJobuIX
	UgvByEa8lYkULQ6/vS1R6Dd5gf6HBfR7nkH9N8YEDpPgRKFz+CW2BY07/HfP7y6o
	RqKUMmd5cI5Vit20ZthKCA8YQid7lS/d+KXjkeR1uIKMukTUvXcNv2pw7lZFC8xa
	RykORrOKaFBGZZ5coLSRTgmGR0AQ6d7ebpGL0CDGdepXLryr5ugwFsZLVQuRG/oA
	O1XNJPs22fNqVmQgzURY8+L4yOTeIzeylgPf6VQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9EJzP89aHdBKwJOP2jiGiuQ+8Lq5yBsMWGz02p8N5g4=:593lunBRqi8CTJU9ojLLYg4S/gZ6vGRF0zci33+1w0Q=;
X-ME-Sender: <xms:-pPCaqtQKJrjLNbUxfKWHT_yLgRH2AbAzY6x5FMa9uPUvu4Y-qBrgMk>
    <xme:-pPCame7dubsvpZiagSl4RJsS7ZGsqu7vVXIsIbOr3SpDoaHX7bmEsshwjKuXGafD
    2k827TlT9nfeiy2klRIMJxQd5zgRV5NLDtX6SThIgDz_tDw5YvBwF4>
X-ME-Received: <xmr:-pPCaqxiyk8beBfsaVE8i-Qz-ZZpzbXUJMQM1IKT8Xwln2aNHtmBVNKtPKIypLn4tji8u150YZwpaD-YVz9-Keom1GvxaLcgpqR_mVbNTtIaxDoMFo5iVhs>
X-ME-Proxy-Cause: dmFkZTFE40wb2nO85tOwpzrNXDZFMW2s7Tbt31EJB3fPbWT/d3+jZqBVAgrGgSZ1NsfpTx
    AJWLjpFp2cZBBWMONUGBjLsYAIRvrIjUsKgvu/rYav3ZHiokcKCkNlWt5L4kIhSRGNKVMB
    TAlsd8ch9fBvchyuwr2JnDjP7BfA9tcj1TRHXc4IL7s2FzTqaqMIiwK3mIblajVFY16QbZ
    ZKAlfCCugjcGNOByfjd8G3sFJif4kzSj/lYBuuujCd+/XoqD3t+lvMI5OJc+68QD2C+LSl
    3RhD4sWTPASNLWZOiUsRAaNXCcMCFmXtREhunsEglmeVHhqo7GDImJw7sPoujLtyf33ipz
    oj+OvMmgZhHO6rFYnbs3dYuy6CGnBX5zgfRj7ng0T2dSJMdWhM4NlpvLzdV2E8mUNLnUw8
    EkUOgYxeL8Hxgb3KWPmJbUanF36QUdCMXWAzld9Gs7ws3lsVPcIkwTIlcxHNUd6h7kKRsq
    KklSTl35GapJIAduZCOJKYBBbB2B4lRVap2jNkIhSNDHKvv0ndiXAO++y4ee/Hq5g493ow
    vchtwpG1wGgjCeOJz9iggpgi7N4Tfx/gML+iCm4+AXyjQqEv+iKyioAySxh+yASJ0OodjW
    p2P09QH75M+l+ZI6Yq07pWR6wh9/he/oSSDSWbh3kHfE8b2gFl+aiiqzLJXQ
X-ME-Proxy: <xmx:-pPCakGZgsXF0Z3zcRrz5gQoj3C_q1HQl31TckC1G0GOFfrqcp7CdQ>
    <xmx:-pPCamzceMGhb7FDsE4ZkHawyWK7Vdcg5C4eMKwcqjfPHN-DvTHNPg>
    <xmx:-pPCatsvpSDd_g0UTJcr3D0iHvCClR8dfyadSZ4l8SB_IOaf2OQSVA>
    <xmx:-pPCar01I9_TN_GTpB1sOPt0LacNPRbSFkzAgjjfRwMMuqYmAA2uDQ>
    <xmx:-pPCauQXF4QYUq2VS6QyDykB9TK4zWv-7iihfYyLZHjE799ipgEJ2TM7>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 13:59:21 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/2] format-patch: simplify get_notes_arg parameters
Date: Sun,  4 Oct 2026 19:58:34 +0200
Message-ID: <V5_simplify_params.d6c@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V5_CV_format-patch_learn_--range-diff-notes.d6b@m5gid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz> <V5_CV_format-patch_learn_--range-diff-notes.d6b@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
`rdiff_log_arg` to `struct rev_info`. `get_notes_arg` was changed to
take a second parameter, namely that member:

    get_notes_args(&(rev.rdiff_log_arg), &rev);

But this is obviously unnecessary; we can just use `&rev`.

Now is also a good time to format this `for_each...` line since it’s
gotten quite long.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Shorter commit message. No I.[1]
      🔗 1: https://lore.kernel.org/git/CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz/T/#mfbb107570d497be5bfe54fe209014b607f5d5830

Notes (testing):
    v1:
    just compile tested

 builtin/log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 350b35c5563..560af00e2fd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1333,16 +1333,18 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
 	return 0;
 }
 
-static void get_notes_args(struct strvec *arg, struct rev_info *rev)
+static void get_notes_args(struct rev_info *rev)
 {
 	if (!rev->show_notes) {
-		strvec_push(arg, "--no-notes");
+		strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		strvec_push(arg, "--notes");
+		strvec_push(&rev->rdiff_log_arg, "--notes");
 	} else {
-		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+		for_each_string_list(&rev->notes_opt.extra_notes_refs,
+				     get_notes_refs,
+				     &rev->rdiff_log_arg);
 	}
 }
 
@@ -2404,7 +2406,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&(rev.rdiff_log_arg), &rev);
+		get_notes_args(&rev);
 	}
 
 	/*
-- 
2.55.0.793.gc667de3f2c5

