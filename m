Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5EF37DEBF
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197331; cv=none; b=uKFTQqQdZ3o9MspyzCmibwTyqWCyERz8TAX1MtUGl8dJYZyxbNpDsV5IV+YzsJEjUf/yo4p8bpMRCcNBruh6qtAEgWakyjTD8RON6nC/+FYwGy8GdNzWZ690tWkuMih8OKKmFiT08tU8gEwGMnO298Gkk73/UCFw2YL/tZ8Eyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197331; c=relaxed/simple;
	bh=26I9Mg7PhPxqIFM6t+WSJIO1isUjcLiWhRTNt4l60h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5vBqU6fmNoKTyyP6mm9Qe5zhLbaHLL2WCgwztiyISLz8Vf36BHt0q3FxtgeCX+cRAc9rZCF4syBOOLNXvCyZrv0c/7OgmV1rcXka79FqBFPSXc1ih441lol+X9pVuwPrDIhbIEKRCd/MgT8rbHy3+jlCoj94YIPZ+tCW0ATDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjzGxI3W; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjzGxI3W"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so230091266b.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197327; x=1790802127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AOLa8xwpI2MW74xEilXy/YG5vgREXEKqGYuCb+tnx9A=;
        b=RjzGxI3Wn+Ef5mQWs2GwKlphdsGn9iOZuVtsweWSfr8rJYgewIlgRxjzjjpk9+KI9U
         RraQV0Lyy3GzDmiUtATfyjZX85gZl4+82CKfsRYo3HmPhJf9psTnAkFJode0FrVgEoBC
         NLAEytTGNtWs9qqcVGPu5VANJItPaLLBAzhiL9A8+4FoZ9rWXYKoxyLgRyKnTtqJS4Dw
         8gPLjuEoCXBTGMHCyPuxo3ez63cs//qoR9Ge0kYVr4wd3v59ynrbYnU5CHNWCtXXM2Sq
         FQ9evVzK3QhoEYHF1DMSfB3+aMSLUAZXHYe5CVA1bnpgXqb3TV7MFH9GzIBfpew53mWI
         t9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197327; x=1790802127;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOLa8xwpI2MW74xEilXy/YG5vgREXEKqGYuCb+tnx9A=;
        b=DzamKPT+8Ok58xX5rZKA6fA7Q3XhVCWFlKtIpIwtlg3Lobus9U9sVkGvTOQWceSQnX
         WST5hgzHJbdJRn+RO50oBYwC0WGlBUFQUCmfkYwajfWaTtPNUjBGi/+3jjBkaL12DgfK
         ggNogvVL/QbuMhOvr/WumvxHjx5DSm1IMMuhpVUTv7aMsozJeHXLhKQIzQiyL9r7CUdv
         j9SFDDwAFQqP1jgPAKFp5NamblMWCWhdj6FpOf6eH37wb6Bcq2DC+b2YnhBL1HZLqpMM
         VmQvLlUApA/7rQTvgjFEnAU08dSnmnSAC2bOS+CdYpmNoF5ckWgWQeb4zttoVO6iHS7n
         NiaA==
X-Forwarded-Encrypted: i=1; AKwUvBzbfbdHZcxsggwgBAIGbEfVk+y75TVkB6p9EmgM1ScoRKVAJFMIl1FCWQWVYs7T1kemiW0=@vger.kernel.org
X-Gm-Message-State: AFuF++kd5NIuwPQCKChQWJuaSTEqPwTlVEThKyO5yUV5cwFRJfy8KnUJ
	JDqYJ0UlIcyy82GaIFbjYsLwrFF4msedEQ5GABF/YTfhvqunaiIcMkXd
X-Gm-Gg: AYBFou18B4j/0UEt3PMsXBib5j3dm4YxbSImV3sHWewjH3nlx+RCb9NuYgtOII0EgGA
	rZAFlQ2AsBjW+5vTPCKMA3DVKTkYcX5tVXGLaTVRZ5XNrLiCjOb4xvOU3oU0pOhHMuCmYwtIX2m
	pY6HyymvGlQwsXrDRhGJKgcDMs2Od98sJsiq4BiCz7bQ7fhTijWSXkGUbj73TrYYbj0rf9SE1O/
	D4E+I/YaNB2+ri0s+juhS9Viznty2qdqGOQNQZv/4NEuFkq/ar3tqACZfrFOa5VU8gOJq6XvwDB
	+fo17P50ybBtuLH1CST1IZASetTezcqoQuAXIbZhX//whk74WZnRRzaoo8L5TrJognIgtoA2hF1
	p9LRz4i6JV6j/1HH+Ua3nmntLj/ORM/cy/CH6COeBGYm0qJIWwmgPovGyOvQ2LjTUSiL7rRwRkH
	QCJrqEgWWNQcg9cLdfNQYZEFMp2SHERrjn85rrGO7WfyTCaoIfluzm/HI+JbtfejGFvAT4KXFWK
	+ZN13PSivA4RaJ0ZbloEt526xfWFg5XiKUcSpSNQph3IunNQXfm46FhWjv5XHOgiV+DRkUPgri3
	UwLY4/qsWdtwoXA4/RXcZoW7mhfgdxMB8oGxAdIb6t0DHYjM
X-Received: by 2002:a17:906:6312:b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c2ac2308fd7mr30354666b.11.1790197327433;
        Wed, 23 Sep 2026 14:02:07 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33e046sm187572666b.8.2026.09.23.14.02.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 14:02:07 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 3/3] fetch, remote: retain old OIDs when pruning refs
Date: Wed, 23 Sep 2026 23:02:05 +0200
Message-Id: <20260923210205.59543-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <xmqq4iffag6k.fsf@gitster.g>
References: <cover.1790079917.git.maciej.ciemborowicz@gmail.com> <cover.1790113781.git.maciej.ciemborowicz@gmail.com> <6f34853c79625794d2eb364d227660be57d1539b.1790113781.git.maciej.ciemborowicz@gmail.com> <xmqq4iffag6k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Isn't adding a new parameter to refs_delete_refs() needed before
> this step?  The corresponding changes to refs.[ch] was done in
> [1/3], and the fact that the callsite receives this update to add an
> extra parameter this late in the series means [1/3] and [2/3] does
> not even compile, right?

You are right. I updated only some of the call sites in 1/3 and left the
others for the patches that begin supplying the new arguments. As a result,
the intermediate commits do not compile.

I have corrected the local series by updating every call site for the new
signature in 1/3, with NULL for optional data that is supplied only by the
later patches. I also built the tree after each patch. The final tree remains
identical to v4.

Thanks for catching this.
