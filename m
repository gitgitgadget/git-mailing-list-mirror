Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAD2AF1D
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774675584; cv=none; b=OF+Scn3reA3F5OvizkyITttllXSuf9TZ4fugrkG90klYHaTkp6DZVhmA0E8sl+pXAXKOz5wAQnfP+EGNz9taHlXm4/QTCkixhfbm/I6qUsRno7VQhOSpvuGdUyl6tO1JOerv2m+EV+VCpXffsDRR5oypz/JHyXFuev7vfSNSmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774675584; c=relaxed/simple;
	bh=qJTwN0V8Yo0L7Y6VGkIfJaEztIBi1IntUCsCKDdC1N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QccsXmfLTzgSgNFym2vRgtr8siCo/dNaiOhNRBgngjnlfCE/jkrtKW5qCsS4KIFgQjwtQq0uNlRSZNm2dtqwA1ZIEApWO0WNPtGmH3FavfUQ9mIm0nel5jgYajgR1E2h0L6MKlOxrzdeOY7U8pyQc9GutNHHoD/ExSGyfBSPP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaQz1VZZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaQz1VZZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d901060f6so95257a91.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774675583; x=1775280383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJTwN0V8Yo0L7Y6VGkIfJaEztIBi1IntUCsCKDdC1N8=;
        b=QaQz1VZZbzxwQ1ofgyEgvzVU+DlCtFnudf0pEYLBPqynN3YFrmhy5qjtxZxU/H4X/R
         OS6vFAFMN4wY8GHE4hMtQeJ2XGheCrUNcFrqM4EOJZBB42FhfJX/+vqVPLtsBvLKl36y
         pt3pjdmsxN+9wN67h3ALM/58iNuOLaS9D+UueMKrhJwHrJsbGXL4CcjA6wHZRulOkAeW
         udbfPKYR0AjIlLYsVIbBC494BbwTzdDCTflOE6ees9Uo5JPP04opVBGVEINAZ0JcZFz5
         2XpSNq8oynQfs9OWQlQVFOpmREUCwvpfcsuT6Wmgn+peuSeHM/kVAw3Ly+okdy5cGsb3
         y4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774675583; x=1775280383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJTwN0V8Yo0L7Y6VGkIfJaEztIBi1IntUCsCKDdC1N8=;
        b=Z1xoToXXLqeP/MLXG2H5tbzRpYh6EOuuFBYJbpnqaH94Dm8OSe1KPi9zTAf85D+sMC
         pLnvRivnYPxj10nA94pWIXa2x8AYxqR4geXrWHAPJP8UekvSEbjlWdhYX/9O7MHBaD6Q
         EDKoYDP0duXpyRnC0bn8dRGaJzBvKyedk3VG1Q+rS4uFhGq6lcP4gvfuU3UlrCv9Pj/r
         S+R0oDWN9Bhv3pTradvlvsW7XqRObJr1qJk2WjTbOH6735gx7YvLANUksXZ8d+2/ekQd
         j9aZStV+lOr/6hNyMR8St9RtIEQjRCZBqbSqLBkaXWeHmW3ht+sutreeCMv3gL8nzb+Q
         2q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3m0dL0Mp4lw7gcd+aSkcrnalsQ6QpIV76L9/21ENK75p3UvvW0RKG450JPfa7W0rENyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFOIu+cCAyZMTO5LfXdRdheJAWbrdfXTEgzsxo0o9qlPGBhl5
	8hrFIYFlU0kydejfHDxuf8L2kjffVg64vCQkj+Mczz4n9yXtVpqrWnxk
X-Gm-Gg: ATEYQzzsTSNr9C/LK5Hkw2KIsNGJZ80mFyoH9HC8glrCRGOQ7YMutRIFFtQOJTJTrEm
	PSNa9IAq6GMbwdO5fZvx6cKwtuSwksvjpfsC62Tr4DCYoQFHBiVYsVH3mvitJ4w/L2tVzZTs0w0
	n+RPjTyzs5PCTDdgRjNCyvYutsPialipv/Y0Q5xJu8I3y3aHwofKdqlz8SXUElBWtzoCov08Y/Q
	OvOaIPQFuJuHw2823f4hLMmoxKHG3MRRJH0ozkZJwnCBd4a4fieYE62Q186zhNmjIhrDlh/UDf4
	G9CNIouMWLUPpDK9P9ht8NNOQ+NKDq70CT5xduRFdDoLUYGea8sgLQi/3GrcW3tAncsrQHB3DDo
	MbTgOgIV+oUCI6ueoEFhqV96oXRGZewkR9ZK9ISf68ex5Amk/WLBhvOf0UDA6bj98EcODaDJz69
	66SL+PXYUBoTfOxjJ4NBPbiIngsgcfoIFHH/z+BvqShm3qjKAv2EkTkxPvZ2rSTnsU6RAtQic=
X-Received: by 2002:a17:90b:4c0c:b0:359:fe72:3555 with SMTP id 98e67ed59e1d1-35c2ff30582mr3348754a91.2.1774675582529;
        Fri, 27 Mar 2026 22:26:22 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm757333a12.23.2026.03.27.22.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 22:26:22 -0700 (PDT)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: gitster@pobox.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	jayeshdaga99@gmail.com,
	jltobler@gmail.com,
	siddharthasthana31@gmail.com,
	stolee@gmail.com
Subject: Re: [PATCH] read-cache: use index state repository for trace2 logging
Date: Sat, 28 Mar 2026 05:25:04 +0000
Message-ID: <20260328052505.76445-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqqzp5kzj3.fsf@gitster.g>
References: <xmqqqzp5kzj3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio, Derrick,

Thanks for the detailed review and suggestions.

On the fallback to `the_repository`: I agree with your observation that `istate->repo` being NULL would indicate a bug rather than a scenario to defensively handle. My initial intent was to be conservative in case there were edge paths where `istate->repo` might not be initialized, but given that INDEX_STATE_INIT(r) sets this unconditionally, it makes sense to rely on that invariant instead of masking potential issues. I will drop the fallback and use `istate->repo` directly (and verify via the test suite).

Regarding scope, Derrick’s suggestion to split this into separate commits makes sense. I’ll proceed as follows:

1. A focused patch that replaces `the_repository` with `istate->repo` in the trace2 calls within this file and removes the associated TODO comments.

2. A follow-up patch that replaces other uses of `the_repository` in places where an `istate` is already available (e.g., `refresh_index()`, `tweak_untracked_cache()`, `do_write_index()`, etc.), keeping changes logically grouped for easier review.

I’ll also run the full test suite after removing the fallback to confirm there are no hidden assumptions.

Junio, thanks also for pointing out the author identity. I’ll update it to use my real name in the next version.

Thanks again for the guidance.

Best,
Jayesh
