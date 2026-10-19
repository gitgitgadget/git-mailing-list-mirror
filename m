Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FF4CF490
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377270; cv=none; b=rXVaAOCjaS5A0AQZFh2U4BtJGlsI7uzGpAoR/d6ahFy9ltkkdgrA3a4NZ1fEn1IAzLEPkbJF/dUtKt2QMqF1FJapXdgQCCQVmaMvmL3BWKUkOj541FlIFj5MuPJhIwq2QDsbXPNaL8ZY2FzhvadkOnEAyTC5lzbdhBJ5sXY+LPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377270; c=relaxed/simple;
	bh=SOE87t2RmC/sxLqRwFtTCKa8VJmxP2i1OSyZG4TazaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6vwvvCGHcvVaGrdLVeMEIdHWRt/zX+xQ73lDb/YhbsTxFDZACHjUjM71LbgsJ1fYFBetmbqJc+CE/92tQbrSSNvy0G5BSkNHlC4PpOstvWtktTZAO6/87oWAm+Fnp1P1Gtk00U/EjWNlCFE0zg6EqeWaWtOGEu7nmnQW/Krm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=aqr9cfsm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="aqr9cfsm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1266042f8f.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1792377267; x=1792982067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOE87t2RmC/sxLqRwFtTCKa8VJmxP2i1OSyZG4TazaY=;
        b=aqr9cfsm0Wp4XEN0mPSmGsqI0nRMPcuHSF+5VaEPWP4FUgNBQtg+sH3Mq3kAv65H1u
         E+rQ+mJ08Y3ZYX+k7juHLJzN5XEIdxq6WG6CvHZ7JMLB1bkPNc1JDjagJkKT044grNFQ
         9I861QaK/PZVOfksqsGvQvlU4CdASMquCRJPzzmXkQLykM7oUPsHOUMZZkXqvMTOFgHJ
         D+FC4rd+4mXsmz10vLAqk+jBLi5yW8UudMvR9/n3FRcEzPe1LB0xsPzwLZl3x+upewAv
         2MxNZQMJ8YGgtKJpQPRwelZgI1z7zadFhLviklxqkW0rtCgIE3NgOir3PyehGS8CIBFY
         E6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792377267; x=1792982067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOE87t2RmC/sxLqRwFtTCKa8VJmxP2i1OSyZG4TazaY=;
        b=FPVnL2vtFMCghRuouoc21NQrITMKlVrLKEkRkkhem3sIFJP5JfqmSEI9SLur9X9lCd
         0dgkKdHTsAjd8vUtll3S7MBaRoXs9Xr/yY0PyJE6AHCxbRUXiLlkTFD8UgzNeZTL1pKN
         ++C8c6Bm/EwnWxfEuzwUkwI/beBN9Wdb1pV15RMS8PcnU1L1V0on38oDX0HPDIsLedgn
         w23Pt6SfeR6w99yunuD3QcoclRspNC2gw9zR/nAupbVO05+0Ap7P6UOh2SSkdGlUw0Ih
         wMF5t1Dxuwv8FvMs6Uw98OGue/x1dIrbrLvE6r2nv43MP85vd7q29JRxIoD0adtETkV7
         oHwQ==
X-Gm-Message-State: AFq9FYJR9kEQb4+uu46DCabRI52XTS4/46pQEpXCH1cacFjyyhbBFN2/
	EvvyalJHfnqo8uPG795GqahN1G5drt8FQea91oOiWRj2QRDgdW/Gqo8BrR/oeHCbiVhBnl/IU82
	zQGeEXcqVHA==
X-Gm-Gg: AYBFou3g4IViNwHldgmVrEWWKxJwfKyD9aALz0X2100uQt7l/BuwjIJ7OHhH8SSiry0
	2h60tPOL0eSSoutG9tpUNPyLh/m2MJFJRUiXdmTMoFMQ8W+uf0dIL7wJO3bPQcGnCwxEf8o54l0
	newRDqqMKh+ah/NhGm5D3DlEQTJ6m+lL8QKTne0dCeMHm4WJsFb6fN48t1ZNag4VpmK8YnPdqCZ
	m9amddXwcGCi///ZgHqEE3JxiPGgTqBsPXGmJaV4fcv1FEYQmS40nqzBUh8rs7MGn3zR5hn/it0
	FscBd0ZaVd1r9fEDQ0CqvyttMdtD/1O4vda5g8kPvukWH5XxFAyeDzf/SiwkFAk8ClipJsZ+JFy
	vH9LRI8hLn7XNEatcPG1ob7prohqP04dCsJ9Ef2ei5YCS6h8+QG4WKXQ0191Nb+1wdA8+90M7KT
	gFRFsGJ1jAviMufoJldPKOvAd60/xdL+lx6JCwPN52WrfgtqWHgxs3C7sHq2X+cK5eY7o=
X-Received: by 2002:a05:6000:24c5:b0:488:7b66:140c with SMTP id ffacd0b85a97d-48e07bc17f7mr10363963f8f.28.1792377267567;
        Sun, 18 Oct 2026 19:34:27 -0700 (PDT)
Received: from ownbook ([195.181.160.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm19867737f8f.22.2026.10.18.19.34.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 19:34:26 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] technical/partial-clone: narrow the one-at-a-time fetch limitation
Date: Mon, 19 Oct 2026 05:34:08 +0300
Message-ID: <20261019023408.13062-1-f@lex.la>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260903125531.68044-1-f@lex.la>
References: <20260903125531.68044-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This one got a review in September and no objections, but it is not in
any branch and not in What's cooking. It still applies to master as is.
Should I resend it?
