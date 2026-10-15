Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D93EAC74
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042088; cv=none; b=h0LOmx9huDed8T0+avnOE1WA020uPw1J5qzAsGTxxiACTZJyr40siJodmS5bpAN5UOe+05iDcZ/cUOc8xWCnruSlINMhVHdn0/PctHtYP+Z06BKdnLgdvEenbUBcBvQliohWb15Cr2kcFfQJVOnYGf/Rc1gfuQ05+1zu/uHG/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042088; c=relaxed/simple;
	bh=PSIn2NvkXJ+sxTIMwzUtf5SCYLoyX0FUhJp2hgVb9Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrcYDHZewoqr5JYHJULgU/jotsA1svVy/54zdQRIPAqRzMfkmIVDpy5OpKksR7t7W6wm/zB3/MsiKbPJxbuHNTHb4eDHENmEBipciL0t9RHTxWS2wxIDmXCuaazM5jg5cIDx28ismH9ZUFSOjO0z/j91m+Hnt/Ng8cOPK8utwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rxvm2icR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ug0DFM6r; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rxvm2icR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ug0DFM6r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 781C57A0193
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:28:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 01:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792042085;
	 x=1792128485; bh=UQkBZAwBmhkgCJVh0q5Fo+1NIW5QW3+wGHZIJjr+Ga4=; b=
	Rxvm2icRb4kvLAd0eah3qg2slrrvnSE8dBoKiBOnQLK31IFX+2HBqaROl08Ps4R5
	5bTLSChr53y+f4RfNMDClfQ4W09F2lpCf1wmeqw4sBGZIPs7cPUQzY8MTKZjSjPe
	wgpM+coXQJc9LKsrE/RVxlC0X2JGZpLlvfRLj2xlIC6MqJqByo2qHOomVOIIxpzz
	RA4zCyWryFOGMnSCEqtP/9UrYKUj66ED6c0lmR5eqQdT5Pdww+5IeqOirz0PoTk0
	K2vcu1+xLpufZBmQp0Q4b9ySOfdupm2CQYKQCU2TMmJqL1AzU5k51Rc6BZa3xKo+
	5v2t7b1HYHOCDiu/bkNIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792042085; x=
	1792128485; bh=UQkBZAwBmhkgCJVh0q5Fo+1NIW5QW3+wGHZIJjr+Ga4=; b=U
	g0DFM6rNVLtsxE5FM8tTd3Rpe5JD60Pe7nYYGZji0rTZao1Mo8yFRIJ84oSj7vI3
	prZ2qBW/0H/yMUS+3P8zGf9oV++rpkWiIc66QXKUGGz/gilSTlF1Q3VZ6vpSyg70
	owwgY/iQLyq5KQC5PlDwyQk5wXo3fBhiFyYCs4/6gP9FG6Ohf/jGsp0vV8GgRDE1
	0TXjd4Le4FsC4Va9HXDMg3AqMI9KlB8ebYbfMALdP8syEgcNLIsIhojcla+w6uGw
	Y2BO9T+49ChMcnomwVQXvNveb8zkXAIaQsJZdEzjW2Z9Tq4XLs3UZmL+PA0gaOqj
	wXHBqn4xwjxyn0s6s/66w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042085; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JrkpuzXvKwJOL9vfWCmWtyLHTtqcAcbkpqlQx5vMryOWGYO
	1H5j/Wn0h2QgN++GfflDcT1EFMlzry3tFuU5pDhSi0/2yUuLwCE1a0XlM94TgIF8
	1uAtI4JFgcbn+TeVWuV9jtlEvGlBPrOt9KpswVqBD7WPhwqrpnSEJtLAbBU3G/C6
	GVkh/AWOo8+30Ac+ZCJWkcqyQy/ZzoiXfzK+n0tENi9GF1GSC1dbhte3d1XUYNdq
	WzvvKkrIG7m01DGh8CWPztUGLeAL3rMnruD/P8F4Dh2tn0sOsKpTIUkn611APVCp
	M0FnUFc9B+XEDDoGziOSg2pesjUvGZJDOwy0xbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hixtULtkk9TVVH48Uq+CFORj/Kcc0MEF86CHGEzzPZY=:PSIn2NvkXJ+sxTIMwzUtf5SCYLoyX0FUhJp2hgVb9Zc=;
X-ME-Sender: <xms:ZWTQas6ICWyjdpdlrVyHyT53v8QjlXG0HisF_mYddomxB_rR52C-rQ>
    <xme:ZWTQakw6DW5QYu19TvHG15__PBvLpO4hZsPkdPGxXwsjtLhmqTPboc-LidYGJss2z
    s0HMYOfibRqEtANW9HkNMLqPiayWnMcasKy7Nd_ziZFrn1hr7t-bXsZ>
X-ME-Received: <xmr:ZWTQajytJAfDVOCjGy4gRcERtYL-h69-tlAeEgpRpMV_qP74uJvE4SrUhSD9PqqJ2rjKDmw>
X-ME-Proxy-Cause: dmFkZTEa9JLFP211LHCPYAkcBBzEFk1IhJ4kgxZx+xXJTLD0p3Ey6drVVWQQL5l2AdU40C
    Ac/CKiFIR0gvL9/mDakqsSAPTjkzbS8TdjwpghFe6st3LJKw0bvqDCWGmZk+tpLVzFgW6k
    LTxfDRjI75E80+A7aT42+66KrxDs9tRv9a7kBslu1G2DcutR7sMdUSJPx75otId12kNwzZ
    YQW2FwQKLs970Txkry9K7eJ7JQmy6JHi1RpoHkPyOsFTY361NNI0H/W7dfkG4RTaraEMDN
    4CQW2BcGOU9oJJeVo8k4+AgzYKTE5w+nmis45BGjp7iaV/ypNPjF12zEkbDmn78vjVHxj4
    cXLxU2X3lcHOpu1NYU3Q1JzYLxPPUsvF+5uIZn7eU/ieuC6EE1zoItag/ijTcwoBtzwCvM
    m6mRvkxwgst1lbpKQo2hJMb9UpBZJBRW73VgS4XhVUUTWl+QP8wj73tJUVserSH6BBN9VX
    OJjEjLxZc2jbkG1CFg02OBuYqaDeqIM+hhNunfAavt8LGIQoVcX9+iQldTJdcWPg1unnHq
    VNUwfAHgO9/uxsusmtFAWpMp+Qd10bwvK5kkaZnaV8pl0LxUWZSphPQyZBsiRvJZK39Y8k
    HBtB2swjUvZv/nsrqMX6JfieHgo0lTRBSRyX9GDrEHp+7c1Ra6hrEHiWanoQ
X-ME-Proxy: <xmx:ZWTQaszUMj9fKsPcS1VEzB0GOVogFkKXo6Uooojzh37I9bDzcfMGsg>
    <xmx:ZWTQataf-dxcEhmfIMQOUykKN_xQdInqUddUq9YOHNSw2hqa3l0ebQ>
    <xmx:ZWTQatWrJ01n28dAjZWn1HKbVROQkdljHj9hdLHnAYRWNJWFbZB7cg>
    <xmx:ZWTQarjP2vJYpjaBI3wTLhWet38iX0mj2Ydh6XeGeONszd7h7-tDEQ>
    <xmx:ZWTQakO0HlSgU7tRDCUPVhgzImpfrfw8TPSo9kJOwF2i04dAsHGWFMr0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:28:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c19c048d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:28:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 07:27:56 +0200
Subject: [PATCH v3 2/6] odb/source-files: fix performance when streaming
 objects with alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-odb-files-alternates-cleanups-v3-2-bfc62fd780eb@pks.im>
References: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
In-Reply-To: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>, Tyrie Vella <tyrielv@gmail.com>
X-Mailer: b4 0.15.2

This patch is essentially the equivalent to the preceding patch, but for
streaming objects instead of just reading them directly.

Exercising performance is a bit more complicated here as streaming only
really kicks in for large objects. Furthermore, I expect that the impact
is not as big as with the last commit, either, because for large objects
the time to stat the file will probably be dwarfed by the time it takes
to read the object itself.

But even though this is probably not as impactful, it makes sense anyway
to do this change to align behaviour across both of these functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 9268f5aa9a..54235821d5 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -462,8 +462,10 @@ static int odb_source_files_read_object_stream(struct odb_stream **out,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
-		if (!odb_source_read_object_stream(out, &dir->packed->base, oid) ||
-		    !odb_source_read_object_stream(out, &dir->loose->base, oid))
+		if (!odb_source_read_object_stream(out, &dir->packed->base, oid))
+			return 0;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
+		if (!odb_source_read_object_stream(out, &dir->loose->base, oid))
 			return 0;
 
 	return -1;

-- 
2.56.0.212.g129ede20d9.dirty

