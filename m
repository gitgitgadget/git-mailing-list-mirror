Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CA1B7F7
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324678; cv=none; b=rlF7ZE0QmDcRGZyg1XwFTHBlGyXH/tM+k/A/b9dVi3VcFX+9YzYbnQ1XVyQXI6vpGkPJBg6M4iJGNAIrSQK13e4HxoVRikaLD4bwkJloL03APqGLVEKBst1VSYPeFTn6eqDb4SSItp3brXaXVhXcVK4vXZglXC5lDVfH+LiaDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324678; c=relaxed/simple;
	bh=mXroUE98udVVfQqjvk8cnWOS45OQuL1wzTFuubVPr1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJY8WO2X9PFkxivyF9uuq7ZWI9dV/GKcdbZKzIlq4i+rB4WBhAhhCv4wHmpgsXYw0nvx2a7shWU4oDnguGZu78NBMaOxPCE3VjP+wbM0daerlDGVf5Eq3CbQvN/Xh24pMQvwgFkSTLo6Tt4+oZ+UGCHgEI/o4SGnxNnM4UwHEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2hUfmDN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2hUfmDN"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso6675966a12.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719324675; x=1719929475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXroUE98udVVfQqjvk8cnWOS45OQuL1wzTFuubVPr1I=;
        b=Y2hUfmDNd8x//SP4XnOxsHB2MArSYFYyGqsVEeJt+FyiB2aqjKPpLfAJ1bV6JaAMLx
         fJxndpQPZx73dc4As/z9WTwo2iwsbAOmcJStMnmHkr8s+PLidWVsGK8YI9uJH2wf1j7q
         RYHdBLqnd2t4GyHVUCTQvENKKqgAxsJN0YiVqvlZ5GqsqVGhLT0qt7Bb6s78R7lA/tIN
         plZ4M9/6+u7+i7/P4Avne1Symf7y+lOXYIikGiUBorWpb3+rHChrRBFEH/QMlP4hPHPO
         zYYvs0glOHe43PKfPLsR4WyyFUY3y9WlUXzO8heSFK0QjgUETthP1vIMYVBBn1ywNmXK
         uZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719324675; x=1719929475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXroUE98udVVfQqjvk8cnWOS45OQuL1wzTFuubVPr1I=;
        b=PfE/6ymWNzoM7FaDJJu8R38HSxek5pZ5VR0p9G8IOA/Un6GKCDZKzqYu5rf5jKJdlp
         sdlIoX3J9YAqQZn/Gt4yjBlQ5fl/bfdshPAPwA3s5nSSJEW2Q9ZBwl9RbKGsscZhGqeR
         Vsh5rFpM6eNBrgzO9x4POUFZPBQUMOjI4ezAtGYJLfL+MjAfpHPsNKsKcRW14kJjyMPN
         gKQNYPHF82L0FVx6llIEHSXMi6dbLScffRQIyvMnO62scvEw0l3L0vBlpeehSBtXQ9IY
         xMODjP4Vhv6AAf3toAb8qvKha0j7xmtP1hDqRUJcjY55Hb7plKmvA5YDKaN3VMc90JIm
         P+sA==
X-Gm-Message-State: AOJu0YyZdTdyFl4Q1kxc7B7OWH0PQ1R+H0C8n8u6yJzlkF6wAjy3e4+U
	oCC63lFRu4w2wlWDCaAKA9z4JgZ5wW3kwZRx6EVNLI5fqHLo5KMk2eLg88Q8Zv6uB6z2/O/UZ9F
	IXIugbKOfHVXg1RRLD39jccXbnIfpsA==
X-Google-Smtp-Source: AGHT+IHmdPoVFB4ABH4cxi7LvMiO3StLdY7FkuxO2kjTSE/NLLRWNE89HpLnqrx7TgbQRtWdCL+vJd8KIYMj5Eb83AM=
X-Received: by 2002:a05:6402:340d:b0:582:5195:3a7a with SMTP id
 4fb4d7f45d1cf-58251957777mr1571767a12.35.1719324674833; Tue, 25 Jun 2024
 07:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-10-chandrapratap3519@gmail.com>
 <CAOLa=ZRTwCvuRFCrHoK9f+zaKqz-Bb2HNAqpD_1y3tPYgrvatA@mail.gmail.com>
In-Reply-To: <CAOLa=ZRTwCvuRFCrHoK9f+zaKqz-Bb2HNAqpD_1y3tPYgrvatA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 25 Jun 2024 19:41:02 +0530
Message-ID: <CA+J6zkQ4z6AWsy2uxMQfmtjqN0b_i1njR_a5agcQrnd4o6tmsw@mail.gmail.com>
Subject: Re: [PATCH 09/11] t-reftable-record: add index tests for reftable_record_is_deletion()
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 14:49, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > reftable_record_is_deletion() is a function defined in
> > reftable/record.{c, h} that determines whether a record is of
> > type deletion or not. In the current testing setup, this function
>
> Nit: 'In the current testing setup' holds true for the series, but on a
> commit level, this statement needs to be modified with each tackled
> type.

I'm not quite sure I follow. Could you explain this a bit further?
