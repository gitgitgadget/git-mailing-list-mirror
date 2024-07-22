Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169C1CF96
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685794; cv=none; b=Ec4GnphFgPUrq6PN6q1cautUTlQC+/e/AdTT722bGsnGLQG1Le/yFF1GoSHsvDSSnVzCLM5hM0Tgg8dzjM/xIdn5X4XRB+9h10bId4r7l8ANrj3a/QQhFitNtpkr9AvozD8r1AaXoMAE6ar57FomndLhdV5b3AXv9wZLWdAt5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685794; c=relaxed/simple;
	bh=QE6Y049KA4bUSBmgMq8U2pf1awxg9zMYHWWF4Q5ns3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MWYmNQzMInMqyoubAl/UrruHUqWrCF196uoMkNb/twfkolkIAN6L+ha10Fj3eUy0tJaQG7kUUDzdkSifJicNRHZqJqqXV+L9zViWXQXa2dXhBCFZQ5ZUHiHB/Ji4FnR9N8cwfrOr7/nbEmwzAsrUkiD1sSOFD7nDt2mtBh7o+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HQV/Ov8d; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HQV/Ov8d"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f178e62d1so318156085a.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721685791; x=1722290591; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGK/zwkzExlm+LIFbeqS4fcx2y+vC6hUD9khpNTU2hs=;
        b=HQV/Ov8dsfWXpAJXC1OvLLUpmLLtBiQb4c2brmJwFXqJLJVkuHHBVD8RhWcQNkNPUz
         Yh8MRXBD7B1SaG6En5fTKIhOdGSXeF2vhcahOaEan00Q53WcWWypZGRyCfD93Tykxo+F
         6X6w5jA0+1HNbbWRRrFwPf7qtb/WaySx2FQyEGTstsHFN3MTbut/oAGFfBW/T7UvlhTT
         lIpsCqFz7kSm9EvC4iucZCCmoBWCvEy2ZntVCARWu4PHGL8ghteMLM9RD1GnZwlBeACm
         q5VTfG53/AL/lwCb6c6NliCxKY/ntPC6hyhxjjcr2LE8TWtbm3QF4hEYq3jGJ4+OOQCP
         Dqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685791; x=1722290591;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGK/zwkzExlm+LIFbeqS4fcx2y+vC6hUD9khpNTU2hs=;
        b=aVX9dJnC91s/3JZGIov1s/tcdjnX9xz3nrQoKBb9OSHGoGtgM6ciJ7wctsnUIyEBSe
         Ng56/gV1O1P85lW7SV7nSIb1lHT6YjVSDso2r+6WkmB9G1D/15Dr3yMDeTeFFZLe0Xg3
         l7C4FzTx21LMCLANxA8xuO25ZpUlFBwBcR6ZQFzP24draDbyAYmil004BUpxBOBWpoqe
         DjGl1/I6lvORNG1zSafsdrf6r+JMnEgob1D64eNImovE/VrpFjIECY4SPOXSH0c2Y664
         D9QXL/c/lB29VQwI0GXCh8qrZWvZMwkot941s/v2EvsAOGo3FrJ+lx56B9xJ7lH5uss8
         lVKg==
X-Gm-Message-State: AOJu0YxzKUOVJqClEujMrF6faBAXENAqi2a0AoLowOD1iJ8qxvWyr96F
	pCXcIg/OYouZnlgzWyrmfm4CrjRhKhYzQJU+ObLat+kcX8hFl2R1k+HT3XKTwhvRqKFc6pfQMTk
	6
X-Google-Smtp-Source: AGHT+IGRfbr9f8hsHgWAG1HG57TSJS4DB9/Raw0IB1j4EqFSShv8FRs4MAKbX2ehqb8DnpwMQc6Z3A==
X-Received: by 2002:a05:620a:4014:b0:79d:a265:cc95 with SMTP id af79cd13be357-7a1a13c4dd7mr1052809785a.65.1721685791454;
        Mon, 22 Jul 2024 15:03:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19907461csm402695585a.116.2024.07.22.15.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:03:10 -0700 (PDT)
Date: Mon, 22 Jul 2024 18:03:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/RelNotes/2.46.0.txt: fix typo
Message-ID: <f5d6ded8f6001415802a25ac7728ed43f8905cde.1721685769.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The sentence describing changes to the bundle URI mechanism ends in two
'..' instead of one '.'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while reading through the RelNotes as I usually do this time
during the cycle ;-).

 Documentation/RelNotes/2.46.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.46.0.txt b/Documentation/RelNotes/2.46.0.txt
index 80620b9317..4cbbca8968 100644
--- a/Documentation/RelNotes/2.46.0.txt
+++ b/Documentation/RelNotes/2.46.0.txt
@@ -212,7 +212,7 @@ Performance, Internal Implementation, Development Support etc.

  * When bundleURI interface fetches multiple bundles, Git failed to
    take full advantage of all bundles and ended up slurping duplicated
-   objects, which has been corrected..
+   objects, which has been corrected.

  * The code to deal with modified paths that are out-of-cone in a
    sparsely checked out working tree has been optimized.
--
2.46.0.rc0.94.ge2b5961b45.dirty
