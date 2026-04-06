Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A7823DD
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775435087; cv=none; b=JFEeXBvxPn7mmjV+xuR9s3lGCJJPPlAorSf9xJoAaF5Bgwc92LS1dVot0VpR2+qT6XJskgIaWwPcleHuQ/wXslx9wyb0dntkwnS7EC5QPe4BXG2fibC1rJOom/VYDIboLhJT0nDRKTX3XTeiyizmxXlY57MI46hSiELFXxMBt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775435087; c=relaxed/simple;
	bh=qESz/waSj1B8Ssl8yVC5thGwpGgdJLiMEbqr7icw+BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du3McO9WEYAO4l1m95Ol6PUIzk4nAgEnoc4XZWdiXR/7YBU2XgU2UPJ5+Xjp9pz2qDjfpUBeGVv4Mu5eBf4cfs52R1+FwZT620nzNWurGNptb+MWC4TSP16gukfaUF6pWkMshRZW/30dh7Ci96PRWrp/Sjx168DMG5TOZTa3vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoUtPsU6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoUtPsU6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf5fbacc9so1660004f8f.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775435085; x=1776039885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/wjUyKx4bp2bGxBn6ozTwGGjo/OLlj/4kp2ja3sKqw=;
        b=ZoUtPsU6DALJz74zB+blC6KZ5AkRfOSHtUoz/LYZEVKM1eQyqnVig+HUrHeMoZA8ua
         X73UQ+1LNKdKt8u/Ty4u0jFM2vbIV3NHhUROR89ZF+F273v3vfc5lhDRkPieUgm3FI0u
         jgxL9EcBrTq4V17adWUO7Z5gWD3GWNUhQspOVcYYLr1VC6TArKxB59NRiLqqN+OENYNb
         MX/G14CYydmKPg1nJlaP6yUx3PZZGmwnj1rinzJu2dy/W4q0GQqAfd38WUTmo4jVxiRV
         BeAdoFX4tzqht9hgBmv9TjT37b9DArSSBLHPs6fWG4UH/1oGzoQhcdOtrp0A4wR6beK6
         n+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775435085; x=1776039885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/wjUyKx4bp2bGxBn6ozTwGGjo/OLlj/4kp2ja3sKqw=;
        b=kw7gW3Qnmitrhl7erPPzr7TEKK+LFJlyFnbZXUh5LayKinnupXxg9wmtl5253++y3L
         p7Go8VM98FLNBhajzMa0CxZwyab856DPtbrbSSLb23oWdRqUAmVaomqcrvxTRM4uMPCN
         kHWckJw/hzH024T8WAOmsI8T6muUBrlCf/4D+jCcudx59Pn5ZIFRT6HV1Epp6gqfcj1t
         lkJSdmVZGa5+0WgkMB7xP6BQEnrThndptDplU4olsxdWF6a5YsYWej9darRtDUWobt3y
         7mqxIxI9m2hm3efpAYJPDQHc4bSt13//mYIvbIJkdV1tvm2l+aIsvCgq43d4MAx1q/+1
         J1hQ==
X-Gm-Message-State: AOJu0YygqKYDBwHskrerVThnitIE4dO1Z3jX4ZUGuA+8/xVa+sBm9NfZ
	eUNCXcalZiFjIckPPbjMl+Qp2lUfP6jRxTbQy49ak0yU6c1iIgCWdPhEcl8qy3mpmL0=
X-Gm-Gg: AeBDietkxwxwsafd8A+oq70pQHbbrCmTUG3C3XQi6whCdmNSURvEUOWkF1ruTg9wxCc
	h8dSYyF3LEbvHu22O040JapsxoLhbzZdl4Ki+T0Qd7rOynLqhmHeTrE6RQVOe6app4vRwtRxh0f
	7Z9blmsSCYSxmngeNhSW0zvNhL+3hdkZde/Y26fxPTcw0MWcXJE2apuitEV9l73oOV9cS6Z15gj
	seMsSb6Daw3mt1N7ZdGepl8BTOIXo3cDpN4u7eFQhN1dKaLSWKkD04zcVIXCnlPGgJ6SMofdwND
	vZUOGYq0ar8nUGJfunMuxvLTKREj3csKRLogf1+7fzIUInzTZpcPOeb88ra3DRFxWe0XdN8Dko4
	029DJw4KCZeZ+dhnNyeBsozzp3W7VynYk91zwHOUDow3vdAmUEEWrm6by7RpXcBVA9vo8apqlf5
	ElcTlGxc9HzRkQQXcviOrD+wf9ojurjJ0iXxYJ/+VdIQM=
X-Received: by 2002:a05:6000:20c3:b0:43c:f5d0:4f6a with SMTP id ffacd0b85a97d-43d2124d3f7mr13997492f8f.21.1775435084596;
        Sun, 05 Apr 2026 17:24:44 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm34499899f8f.27.2026.04.05.17.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 17:24:43 -0700 (PDT)
Date: Mon, 6 Apr 2026 02:24:40 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v3 1/5] pack-write: add explanation to promisor file
 content
Message-ID: <eb1964dca8d8f7e17efccda0b21e2300dab55d65.1775431990.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>

In the entire codebase there is no explanation as to why the ".promisor"
files may contain the ref names (and their associated hashes) that were
fetched at the time the corresponding packfile was downloaded.

As explained in the log message of commit 5374a290 (fetch-pack: write
fetched refs to .promisor, 2019-10-14), where this loop originally came
from, these ref names (and associated hashes) are not used for anything
in the production, but are solely there to help debugging.

Explain this in a new comment.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 pack-write.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 83eaf88541..b8ab9510ff 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -603,6 +603,15 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 	int i, err;
 	FILE *output = xfopen(promisor_name, "w");
 
+	/*
+	 * Write in the .promisor file the ref names and associated hashes,
+	 * obtained by fetch-pack, at the point of generation of the
+	 * corresponding packfile. These pieces of info are only used to make
+	 * it easier to debug issues with partial clones, as we can identify
+	 * what refs (and their associated hashes) were fetched at the time
+	 * the packfile was downloaded, and if necessary, compare those hashes
+	 * against what the promisor remote reports now.
+	 */
 	for (i = 0; i < nr_sought; i++)
 		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
 			sought[i]->name);
-- 
2.53.0.585.g1533fa96a8

