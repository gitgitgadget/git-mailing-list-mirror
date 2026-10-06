Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556635AC0E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282030; cv=none; b=b6DEoQGsStUw79YsHOfmYeqVS8j245pwckhyx4H0Hpsc0nNANQHWC88anaK34REMFA1syDOUcuSaYHEWUxNViyHY2DY3U8HUIOK+S578PdTgkGBgnhYNPaMxkwoDK7jUoGUwqTqyO75llj+OkCKGo5BXUSM139fGtoFuaVaNdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282030; c=relaxed/simple;
	bh=5pBymjo2k70GGqEg6EYeRHHiDNPkuDiYIvkaqi45q6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1pkS5Gyp8N99apnK5hAPYGhnkvEbolL8w680wkE70HAveIgsLQX1i1t7gLStw6aVsSLDr3gIeD+/7GmQn2Do/zIs6ZPcZd0A1IRkhIeHK1Oc1E9aeZxcYYxZh3KPlvQk5aYBCGd0I4Nx1eg9244sOieEsUo+9JFVRnFzyX24to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EhV3gA2q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KcBTpTXK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EhV3gA2q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KcBTpTXK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 52A8CEC098C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 06:20:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 06 Oct 2026 06:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791282028;
	 x=1791368428; bh=lJjlNMiyjNPne3tsbQf8vrAVEa0zJDf+GNe5b85vcOk=; b=
	EhV3gA2qbrswpU1qARnSkouDaLEQYKS29jbyy3i1wwOC8eJOSzqMZhJk2VKzvann
	OTen3/QxXrLhaRrgvqMSNSxuBhEt/t/rfjT/adonkNC/X7+LKbyMEWbPqPdgldyx
	EZxorTqGB/u+aGiRTjrRtqA+q9GzaiNCqMecBk6p+YL8Sn9NI1VsORa7TA7G1yHy
	AppyEHH2mPfOI1MNr4diVoMfy7QtC5ELHd23Poq8dOss7AnnAWy0TCAnhQwAtcn5
	n+D6ex2eTd5+1vZnfbldUhTTn177Mf7GlXy3BpY4yg+mQru9r1YSFc4bmuvTa0F/
	sXnFkQzJMYQDqQ0M4Uw+HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791282028; x=
	1791368428; bh=lJjlNMiyjNPne3tsbQf8vrAVEa0zJDf+GNe5b85vcOk=; b=K
	cBTpTXKUcwYvCeTm0CmKA8fAA1hIXGl62ZTzn1Zi36gnb+mULNVFaiiGts+twkeT
	+mpCwDc33p1xatunzkv4QYvffboK/WOOfCFBvIpU9O+I+iJK0W6J+k23PniNNaX0
	OO/kumaD2JDBgmoVg+x/O4GarCpSVO9Rzrr5hx3yp2CJLhtdTEZiQZYtNtHIlpbi
	VUMwG16ovPMMAZfiYIO3tfE/us25DZQvv7Zlpx79wF9lhKBsSyI8/zF7qVEU9NM0
	jZjYtZqWpRLXix63Prh6G/zkd3dP21AJnw1mGFDAOhnUCcCVQKSXG88xkejIcd9X
	weC71xRdKdOlV1LS6jTXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791282028; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bNRzohGuU9uW9nvZTQMh+7ulWI3me5bx215UStBTo9My7K+
	RO0/K/Y+D2/tXlK21TSvvt5cpBTU01X/AZMQB+SvrhBhkpwtIPn6QfOwIuVEr/1S
	aPS8jBJDYjoDxJYUUECf6//WulHjyKBoAetemguYTAAyDEpKhK9WxW9+YFFKiz2j
	V41rtPXzSu/9jkHVatmYDkB1kRrFHX50oIA5Kjkj72E4sOUyyjTv6RMRlRR9yV3V
	0cyJuO9KhJAnFh7HSgYEsEcnWGwsZjbnA/0/dF+8I7qKwNoMiXUInqU+yFKeBflY
	ZO72D7laVgCTSVZiIA4U6spdPQnFN06jYh80lKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uFWqXhLjBS5rAmzX4xiN0juXoJoMT6fhKDFFjRMpHq8=:5pBymjo2k70GGqEg6EYeRHHiDNPkuDiYIvkaqi45q6w=;
X-ME-Sender: <xms:bMvEarcEXB2Ojo-_fhhTAcmgUBOwBx2bAdGoiB637rKeDmawBH7-6g>
    <xme:bMvEaoFSS1LYD-ftEETH7OOpe2heGn62N2Hf9329QotzbNmQTzsbMqBNDdF1HGqg4
    j36d3K-e74LghEHVM_8xzXajWOJjMsPOVH72zG2XMwM7mfdHrWiWA>
X-ME-Received: <xmr:bMvEas2ZMEZlLeGBH3l19OHW2t92wNKOyxbDZz4NFkMvDYE7PfQvEBoNn-9yN2LPqAFTzQ>
X-ME-Proxy-Cause: dmFkZTFm7cxsOlrHj5ybS/AZvE1fyDctY+Qm/GmX7r2wG0gpo0zYpWFPX7sbtz+iCjZz1O
    J3wGKdsI1wxvtR1ZpsajndNXCTr+2DS8G0VxGiNcia/xhSuw6D5W6TGN1Uwwc5KBzFX3Fc
    fmKkqi1jHsWPIA8ZkzLKQXQQ+63YF4P0n9OlHY1sd3jANbSzkB6XhbKvZQtfZMLXO1GlNC
    3QTRyDU+dAl+06OAQJ+8m93JZ19lk5TZ8kvzJk5l1SybA2Xi3n+MWTEz0ekviPIbNIxKp3
    ecn6AOWsUvbofb4sJgFdmv1kjoIY4Ay0Q+YLWv/2gLgE6Q26y+dOcokIVgBUgHMRPtqch0
    ftruhO5knjdbAN1iBTIsOm6J/OcW92uHOI0hvESxtpDNrkBQQblDwrEVDu5ZmpE3jr15Iq
    o5MkJqv46Kf4vChMWbUOeZv7bHLO1Pky9vF24y95xWoL/dGLHGjZ6gCXN0P1jR8VwroV08
    kZk26CkX4UNOA3YlocWvEc3xHrZk8bA0lJFuOv4foP/PR7mANsa8DVS4vnjo+UIS8Nrj5Q
    pTibnNwvBS6HjJKpr2i5D1QyLLlBMS1xst2RHbbcFl/cp+92S6jRnJEA4UAGRL6nJ6CstB
    A1bztrLCZkU5oG0h1fciJHAA5doD5GWMq8Lob8ZHCY15tpi00Tot/X78EaOQ
X-ME-Proxy: <xmx:bMvEaonUfKHxCGE1lZwmJgTaDRzZauPOJ-vhvyPpG-S8N-JzBgf65w>
    <xmx:bMvEak9Re9pC1VoFM_khmlpCxlXes4sy-JevsXvYB8-mzC5xm4NH8Q>
    <xmx:bMvEalryXkzRyqNhbr3sqw3vRyWdUXGMjIxJEPGB-8ZLyRbNPgqZ8g>
    <xmx:bMvEallUW59hxW_g-V6dGX0kZ0ta5cd9tiNFlVDWEqPKy99rQLmZcg>
    <xmx:bMvEavHD3_MDkP_5MKSL9c6z0lto4L0NgvphTAEkcUAc6HlQ4EbuhnWm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 06:20:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55ccbf9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 10:20:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Oct 2026 12:20:14 +0200
Subject: [PATCH v2 1/2] packfile: move around `close_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-pks-packfile-stale-delta-base-cache-v2-1-69669a2fc6ce@pks.im>
References: <20261006-pks-packfile-stale-delta-base-cache-v2-0-69669a2fc6ce@pks.im>
In-Reply-To: <20261006-pks-packfile-stale-delta-base-cache-v2-0-69669a2fc6ce@pks.im>
To: git@vger.kernel.org
Cc: Guillaume Chauvel <guillaume.chauvel@gmail.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

In the next commit we'll want to access the delta base cache in
`close_pack()`. Move the function after the declaration of the cache so
that we won't need a forward declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index 4fa5fd67c8..af1b837974 100644
--- a/packfile.c
+++ b/packfile.c
@@ -355,16 +355,6 @@ static void close_pack_mtimes(struct packed_git *p)
 	p->mtimes_map = NULL;
 }
 
-void close_pack(struct packed_git *p)
-{
-	close_pack_windows(p);
-	close_pack_fd(p);
-	close_pack_index(p);
-	close_pack_revindex(p);
-	close_pack_mtimes(p);
-	oidset_clear(&p->bad_objects);
-}
-
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
 	static const char *exts[] = {".idx", ".pack", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
@@ -1263,6 +1253,16 @@ void clear_delta_base_cache(void)
 	}
 }
 
+void close_pack(struct packed_git *p)
+{
+	close_pack_windows(p);
+	close_pack_fd(p);
+	close_pack_index(p);
+	close_pack_revindex(p);
+	close_pack_mtimes(p);
+	oidset_clear(&p->bad_objects);
+}
+
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 				 void *base, size_t base_size,
 				 size_t delta_base_cache_limit,

-- 
2.56.0.406.ga2d225a756.dirty

