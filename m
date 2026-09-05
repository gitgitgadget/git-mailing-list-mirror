Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771C27AC45
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628435; cv=none; b=HXBNSkebuZH3dwqY3so5yFWB2Kciaf8Lb++c3B5i+mjijC8Wc+ciEZMSql2oRGnD+N7Af6lORVaw11OF0tsSL4VD8eciCqwKtzm5owl5uOR2fV3DDsmpA+2aieMqR+Fsq7O9VJzSTIayCXRZe4rD16YfBob7cSUYI+3L+76P2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628435; c=relaxed/simple;
	bh=uIMwaDZY3HJzIlvjROq0oyZaEl9JRR1uGVkcBS32MVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htdEohYnLKDQVU/qdmU5azbXlMYdbrcdgU5vmIWBQ1b6ybmrKgEE4E8kHDsIyB1PPtG4FtThm9pVs3xjitbCnvRmRiFAVMQWhy90BYl0O4tvlI1G2OVBYjmlyRZFJmpmKgLaJc1MQ2v4kuOE9T73WMSUVwUTuRVaQ0mcZterZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=P00GzbQb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="P00GzbQb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso15029815e9.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628432; x=1789233232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uIMwaDZY3HJzIlvjROq0oyZaEl9JRR1uGVkcBS32MVc=;
        b=P00GzbQbkg6uhXmEnzsGc/UqRZTPvjujA9LKZ2G7jUFdCd5YGkpcQq2DGUAYpZ/kb0
         uXDUwwogLC4v5GarmFrIcOwo/3FJlrHG89CXGLB5ua+ibImgIIld/+xEAzK839S8IXc4
         6qblMoYA/+A3pfblhnLUyAQWAJHtyDYLxUxHT51vlSarzrAWddA84ndmai3ZBE45mx7W
         ElXAFYBt6X8MAMrxNRySSxGcdJYWY0tj2vyftDcYReThUBctFWSFFG3THNb0a8uAXSvJ
         xMsbCRUugh0AqscTyalagXBT2EnSY81LKIi1mE6YobzDrgkXmAPtPQQ3lGvpFVI4/CWg
         nsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628432; x=1789233232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uIMwaDZY3HJzIlvjROq0oyZaEl9JRR1uGVkcBS32MVc=;
        b=UdiHEZZm6qds3DNAmPFemyQnYA/HIVrpYhcuEEBe0jyIvWIMbIbZR/zk4yAAnIW0/R
         m1zfQ1uDmDgy8hXCo9U3hR9cjjOykzeXoXr4hnbLoSV1Jfh1YUxBL0vcNsmGGKAJ7zAY
         PI7+atrNYp3oGveIQ7dJosPw7waRTYbPkLCUUIk6PC75mulAHC/0Q2zCGi/1m+QkaJXN
         TQpqxnObBoCQyxA8MPW45gDK38pbVO7+d1HYubVcnTW+UnheDJHP2kWpZ8ZxFkpQtmVU
         KOcX/b/oEyIvWNrg1Ap9bI52UkNyrH0Y1pDpFDU+taTWiRiObt0Ug31DobGXkjon5/va
         zczg==
X-Gm-Message-State: AFuF++mg2vGhUd7cGV+1DYZcNEEz5s1L3GUblHEMSdWtlrNRGN4YYnlV
	qZ/isR9rnnppO9ZRnWgDIQFMMqLcl8VTFIkuWJGH1q26sONIPKdgLZ1LgV0befzwLlwuifUYngG
	/gpVzjXRlA7Wv
X-Gm-Gg: AYBFou2bRoc7p+Jg1vbuYXDWWnn3uLXG5wPem0+BKCajng1GkaIFMq7qsSpOTbyHA7Y
	4peMzX3NR4TVfyennNcGB1nbxwLHQ0fp8knQ7Hr7r3sQufEJqsW+TN2FbxMq6IHYaXCZck68ZqK
	jLB5htFzw0uv2PUcx0of63NeObVEjJueqPtIgT0AbvOP19bPLdQfAnxHx2K2f4q3mZ6oZH90z4d
	mLii1KC8qRtQz9+vZ8FYGzzHgXEIG6c3bCbhqsM+8o+Grk9pWlMIz/N2MljJfZyDBnuOzIxUIsn
	ZOZ5aGK16udLPqgt/gnD8eBYCQ/4a1VcV7aj5zw7k5WQmQda1uc8nzSocd9Jmtvm/DbcQa60pfz
	0ryNKPy6bBW05BUlcala7B2eP6mHN+Az07s/oFPr7uJ9c/jCzgmcLXSdtW+weoaqbK3KYS4XjR8
	/tRpTto0RAPduIa6CUwkZL0Th9o2taHTptc38GF9z25OXmFM9WY7ZqLHr6szaFuGuvkxr8
X-Received: by 2002:a05:600c:4693:b0:49d:577:532f with SMTP id 5b1f17b1804b1-49d05775424mr72405385e9.15.1788628431194;
        Sat, 05 Sep 2026 10:13:51 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm3085555f8f.37.2026.09.05.10.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:50 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting --no-commit
Date: Sat,  5 Sep 2026 20:13:49 +0300
Message-ID: <20260905171349.34798-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apqSXT4lT7v0ILjp@pks.im>
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g> <20260903214553.53942-1-f@lex.la> <apqSXT4lT7v0ILjp@pks.im> <20260904124505.12952-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:
> But we need to have a better argument than "we didn't have it yet".

Correcting my earlier mail: I said I was dropping the test because the
existing clean-pick test covered it, and that is wrong. The clean pick
is checked, the conflicting one is not.

The justification is the condition itself: whether CHERRY_PICK_HEAD is
written depends on the command, on whether the merge started, and on
--no-commit, all in one place. v3 puts it back as a single
test_ref_missing call in an existing test, so no new test and no new
setup.
