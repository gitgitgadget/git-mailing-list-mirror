Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47D394
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636142; cv=none; b=ErCAUgn6KzNtmNPa4x0YVPegg+dJ3/oC3cmVpbOiP6Tjyh7lQveG6Rr0PJGt75LhJlBXZg4GGlfm1EdV+zqbwMP1CsNr8bRGfKMsOAbEu//xbHmRXPoulx4di6KVPbNIicbLdghF1QyIT2k6G3DRre/KXVdaexkUw0yz35pCMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636142; c=relaxed/simple;
	bh=nau00YWVHzuCmiplf4f1MNhenCH1SJG9tzMQfELlopw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lV2/kowrtLh5+P3eCE+PnQXLXan2xkRfuYribdO7rhC2JeR71WhwaotH3gU9B2gLwfjsDWnXuFOC80TQKkivUsdKKWrjqwyR8DURf+MQ3pzjBmxmeqgC0uNoduYE6J+wH8I+3brAxuwea7pZniFX6EJHPfXw0E/EjDIpb1bfufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0IL8mOp; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0IL8mOp"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so76215831fa.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723636139; x=1724240939; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nau00YWVHzuCmiplf4f1MNhenCH1SJG9tzMQfELlopw=;
        b=I0IL8mOp5GCp+UfjSABUvmJhUYe19WXEMPVMe/O37upkhJsJsNVUfTMODbLjIJ4zdK
         xtoIs8tahvWpFdFrFh8LEAJu43FW3XVq70VLcQfj4UrFWUuOzjtNq+EVl1kCqgr5KPun
         IqwfEAQw5EDYetpnwsQKm1gBlPUUQ5m5tszunxlgk1gK62KpdmeO38bGSXAUktW79CT9
         ZGqwWiH00iZrRysudRNCVzCi9delcz/4CnHSRn4jS2bZQsnovhMT/cz5mz5rnUWUxudz
         4d3QGvCQiPKXVTUTHbQrI2h3ewYsOsH8Uyj904yfNBs+1WKf1+zda/gDdr2tHuJ3QB4+
         i//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723636139; x=1724240939;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nau00YWVHzuCmiplf4f1MNhenCH1SJG9tzMQfELlopw=;
        b=vgts/8eIhJq+Bgi9lVzmpYhgB0udQoMxCq4YX4iLzaRdvdtakoW8zJSWkV35MRX+uk
         NJQqwI1sLTX98fQvvai+BDauQMT+s0UvpnK+YEOIzb4uxju45xifNcFhGxPr1LacvzLK
         eiKPl99c/r5oc6/DR6/KNkuSm1jt2U+10VQHHvBIPRiwqz670khLrVUQivRj7kjzkMJ5
         ym7STGwMrkHfVag8wSUaUEFx9He9f7vGN/JTw35ce7Q6kSb6kOfgv/ryVEBeXva1+koP
         uAsa1pY3Jj+eo1X8cKN9Y5YAPWuzzherVEabooCQwQ2trCHdKMDUoduUpxHFgZ8nw/up
         ALug==
X-Forwarded-Encrypted: i=1; AJvYcCXNzirp/PBXPv4Hpd54vpVPhWDmrkWuT3RES0PP9q/b3RZC3pY9Ice89tIEIKjTHItsTWtSxYNwv4uXdVKvK9cCRPXh
X-Gm-Message-State: AOJu0Yz7PRSiW5hyMlDcAw3kFSTMZnPgAklAtWqBeCifq0M+wR/rTQrl
	5YtsTobDGpWRBH6jjE+Q9C8Kda+PeiZrrAU7/rjkHLMfaNBB202hP8OTT/ao0JfFYU/ex/THnMZ
	qlt6SvXfBgoIZG4NNJAZgmep6LSg=
X-Google-Smtp-Source: AGHT+IHB1bwFc1c+Dm1XA8KKuFr7BfJmmyzGWZRfiBRN/quTj7cA0fEmYiMDXC+S0FBl/59qz2zIF5JM15fTAEOx/B8=
X-Received: by 2002:a2e:90cd:0:b0:2f1:585b:f326 with SMTP id
 38308e7fff4ca-2f3aa1fe856mr12825661fa.45.1723636138863; Wed, 14 Aug 2024
 04:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-1-chandrapratap3519@gmail.com> <20240813144440.4602-2-chandrapratap3519@gmail.com>
 <2rxxfpzijfmvo65xournnmx4oawzqlhgipje4cxzxvo5aqzt6u@xppoikj262cp>
In-Reply-To: <2rxxfpzijfmvo65xournnmx4oawzqlhgipje4cxzxvo5aqzt6u@xppoikj262cp>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 14 Aug 2024 17:18:33 +0530
Message-ID: <CA+J6zkSAa4ejLtTqNob_JyS8wwx+BX0vsgsWU9mekWcNtVY80g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] t: move reftable/readwrite_test.c to the unit
 testing framework
To: Josh Steadmon <steadmon@google.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 04:03, Josh Steadmon <steadmon@google.com> wrote:
>
> On 2024.08.13 20:04, Chandra Pratap wrote:
> > reftable/readwrite_test.c exercises the functions defined in
> > reftable/reader.{c,h} and reftable/writer.{c,h}. Migrate
> > reftable/readwrite_test.c to the unit testing framework. Migration
> > involves refactoring the tests to use the unit testing framework
> > instead of reftable's test framework and renaming the tests to
> > align with unit-tests' naming conventions.
> >
> > Since some tests in reftable/readwrite_test.c use the functions
> > set_test_hash(), noop_flush() and strbuf_add_void() defined in
> > reftable/test_framework.{c,h} but these files are not #included
> > in the ported unit test, copy these functions in the new test file.
>
> I'm assuming that eventually, reftable/test_framework (and all the rest
> of reftable/libreftable_test.a) will be removed after all the tests are
> converted to the unit test framework, is that correct?

That hasn't been discussed yet but yes, that seems the most likely
fate for reftable/test_framework.{c,h}.

> Will other tests need these test_framework functions? If so, I'd rather
> not end up with duplicates in each test file, even if these are small
> functions. Is there a reason why we can't link the reftable/test_framework
> object (or the whole reftable/libreftable_test.a library)?

If I remember correctly, only stack and merged tests besides readwrite
utilize these functions.

We're not #including 'test_framwork.h' in the new test files because in
a way, the point of this GSoC project is to get rid of
reftable/test_framework.{c,h} so we don't need to carry an entirely
different testing framework for the reftable sub-project.

As far as duplicated functions are concerned, we can maybe move
them to unit-tests/test-lib.{c,h} or a new file in reftable/. I'll create
a patch for it sometimes later.
