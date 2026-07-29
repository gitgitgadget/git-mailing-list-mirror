Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0775331A78
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785359842; cv=none; b=aAyZQqb5TZUYoGoEhIWBM0+yG/RdPI38H3OBKtaTRgK/JBuXoR9jhI1x5qvNQwiIbYAQSpNzHc4GvXXK8Qmi1zUYtgW3mfCzpmtIJsgqZjF3zdnaypYFBvRBFvmoZu6RRbIEzkBO1eR+tPhcHGvBLPwIlgP1bNT9K+Gg9Cq7Wz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785359842; c=relaxed/simple;
	bh=gX20jXM/o5Q8qdhJuhoo/mqBZma4//5khQ/QTHWlBQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCWMf+jm8+XvLe1JH9Aieq1cjVaWj+80sdLFlhUB6yxoJyeMbm4ch8LJkVHZdr07ks1XrQbT5Rv28OnAqaJ8F5RXpQR5dPtPdXL79o8xEHGh0OrHkcRFRXVS4ILDIuKEeoTqf2FhNFsGBAxwAdrUhR7qaTzyo0Lyhjw8Zi6HRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=XNNaugUb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="XNNaugUb"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c16ac21acso9329991cf.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785359839; x=1785964639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gX20jXM/o5Q8qdhJuhoo/mqBZma4//5khQ/QTHWlBQM=;
        b=XNNaugUbursXnGo1DeOs0DJTNFkxUdtEMuptxWmRZFCK6M7pRS8DMHU7rDcDgiIaAz
         OPnZ6KAO3ce3yOeMmAZ9FZGbK+EdCFGb/QYfj+Ox8UU2Ds1FlBSeTk/rQ3iYDulLhsn6
         kLhpTz/Av5gOJNjkklLb0vdQ4cyoAn/Boj+mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785359839; x=1785964639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gX20jXM/o5Q8qdhJuhoo/mqBZma4//5khQ/QTHWlBQM=;
        b=XSjFxbC/8hXnwJwErhvuykneLFoazFBhlTQndl5UDvkdNnvIYdwvAz/6U9VViQy0ZG
         81X20lzJo2bnIzvhMOiDMACTUltPbjdB4MuUJJc4LX9rL2tn9MRNwdtQepPt1YA6zpKY
         OiHEAlgXr2qvdSd/03R7B8YAlceE7S2Tm6KtjLGbR8o6alhSO7IrN+p/BSSEIUuVRChf
         q/NQNRvYNx7EluGOx9c2gUxBbXM/0jnTFb3jggluZP6VQ2PTUDlBPncig/2WT++/9X0x
         nao5DhAmu47uNsbM/KBCyu/+UKn2F0F8Jo1H+V/cYtzz4Wb/JGNrOOeURunYgrvEMShu
         wT/A==
X-Gm-Message-State: AOJu0YxysH+OWine6JMC0sL7xF5toYDfs7R/d+7Tqx7IkU4jaLsts6OD
	jTIC/KYnGpG3ulHOSFemWbeQSy+zR91OaLTkgHNS0QaXWb7gJRvT29J/2WElQvDQgtiJIRJQhCh
	yrfzZo8sPsg==
X-Gm-Gg: AR+sD133nbTJgLr5NsZxYWBXoG6doqTfojzHjv8mVrDbhop4VaO6Mta9qS3fHB0caqt
	As2OZz8OPMmtQKN8tkcZJLiG76pqHsse9hFPXkl0FtVoP+bDGMmYt+AvvZo4pndvOi/I7tTHv0k
	Q69AWSQttD509OIliMDl/kAzAaU4Rk3BwBY8s101a1Fibaigvbrlh06dlmoPvOLAAzEHIRV4PRt
	CMbv0XbGlHupkS4ctZzZzKnddEF7I9Mw9rHKi5+VAhLHKXoguQj+ns5lSypYmj/WAAsjT4I38YS
	1mQUuyTMOnCWiwEgLwh6SVkD8+tKhmiPDMrNA+Ye7cyZ1IFvOKW2AN9uXJH2sAB0Rg8+GXKdOR7
	oqAdfbZWTwipImS6kislq8rRAsCxsSj+QnhJsJ+7ie3OI2ferUsu4eQIgjCYrNU1N3HkUj6JaI2
	RBKkXOBLd45BU3iEpKIMpJfcvmCLzbezYVC4nUSlDUrZWW/eRRScSrCzLXPOoZeV7w14uEmIhG3
	yJKYdMxtIEGI+0iVTuGiu0VhraicMu3LC+Sgd0jlsxB2b6d/+DEJDjpGWGB6Lp0rgFemOnNb7s9
	MVd+gFMc9YK3DMs5vjt0Oo9wFmKVcUSDbW9KJHWRjLkpch6hazPJrlRo2y7X
X-Received: by 2002:ac8:5943:0:b0:51c:b58:dfeb with SMTP id d75a77b69052e-52b38661639mr1676721cf.45.1785359839481;
        Wed, 29 Jul 2026 14:17:19 -0700 (PDT)
Received: from com-58127.corp.openai.org ([199.47.143.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b4f241sm27412731cf.7.2026.07.29.14.17.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 14:17:19 -0700 (PDT)
From: friel@openai.com
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	peff@peff.net,
	stolee@gmail.com,
	ps@pks.im,
	jonathantanmy@fastmail.com,
	friel@openai.com
Subject: Re: [RFC PATCH] index-pack: optionally allow duplicate objects
Date: Wed, 29 Jul 2026 14:17:16 -0700
Message-ID: <20260729211716.40166-1-friel@openai.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqtspho7tk.fsf@gitster.g>
References: <xmqqtspho7tk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Friel <friel@openai.com>

On Wed, Jul 29, 2026 at 01:32:39PM -0700, Junio C Hamano wrote:

> I can live with such an extension as long as we teach the receiving
> end to deduplicate the extra copy.

That makes sense. We don't want packs containing duplicate objects to
become a persistent source of duplicate objects in other repositories.

For our server, duplicate objects would be an exceptional consequence of
an optimization, not normal operation. We have not seen duplicates in
practice yet. But preventing them imposes a cost on every upload-pack
request even when duplicates are rare.

I'll talk with Taylor about whether the client should repack when it
detects duplicates, or whether Git already has a way to mark such a pack
as dirty for reuse or retransmission until it has been cleaned up.
The intent would be to pay that cost only when duplicates actually
occur.

In all humility, thank you for reviewing and considering the RFC PATCH.
I'm still getting acquainted with mailing list and the history of Git,
and I'm happy to have Taylor & Ted's help.

Cheers,
Friel
