Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517033123D
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309996; cv=none; b=tUOD+eQ8Y03uwvj6ORZDKlhdAn4Ey7SRyIPC3QZ+mT/lUL5dQHHm6zJWMHAfqzbSjO4zvCz31lyOvuk+K6L3fDzU2RsirXMaTG4/egB9oRMBrHDJ/9XSi0ExVKIczbEhtHwwsCs96h7/tXNJFmXSvy+3vyBMO8K8x2t2SA0GJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309996; c=relaxed/simple;
	bh=08AoSnUs9s2aJyeNML59w4YTw0pPwNPDDRHampGXtkQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEK79motZv0+oqcK9ZTL1adV8r5ERagjk4wQa/1Tw4cjJXreAaov9LEPQt6ZSX4pQula7z6K0oVUpajb9t5RYIEn6zVucQpnHHDx8WN50yCSOwuslUtoWJ64NThqPa2bWQCRMKmz5tW/4FX9Nj6Eoo5MPCWtAxntPgh9Iorl11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=BDzpf/LR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="BDzpf/LR"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e56c287b3so255503685a.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791309994; x=1791914794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hagk8dmpmTKsQr9inDj/+mKMYRX6rIgGxgP99TUw0X0=;
        b=BDzpf/LRiSWHtUVFgtC6lScGGqKGF5rPv/lECr4Xd8vNBq3C8vjqjJatur0FYHNCaM
         W9+1zXOLpAMEFnvmBpbYuiOPE+JRJ/UXyrZBOrH7NkbRUcGD8ioo4irRep0Z69b7AOKw
         k5aoMzmRoA2+RQDmKbf4QEJGeG00UbF/kOmDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309994; x=1791914794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hagk8dmpmTKsQr9inDj/+mKMYRX6rIgGxgP99TUw0X0=;
        b=keAqMHY7qtWddkTj9MLjd57eHL/iOg3A/VeY4BWsP5h8JpssYyAEL93YY63Sehf4i6
         O//G5/QVTMn21fWmkwNdXZjWgZ1NSvS30UGlamMTCEAeXu2bLIMJOlg1D0aXRdgsSGU0
         nyP8aZUY5TyIRKu7qt1r99DUfegCsPmcAG23T8MOPja4L2FZviFNI4s6KfidtStNRlb9
         yZ+Ff0tn1NtF7VsFylvBCUYYmEVoUk94ceM8L1ZUyoKFxcyNl63TAjPIpmvrJ1fhv8hL
         hR8NA8Xazh4sp9ecZdnzG8h1NILyzB4qA6TG9TOc1Br1V/RqxP6RSn4IhOC3tORbIErL
         nIPw==
X-Gm-Message-State: AFuF++kq75zkG6p6gNHT2Ladbxik9TkD78atfgs8P2zeSLwxJgsMXOyl
	N9Kwk9vyXuun/GIlvyffkvkKkbx6jEb5lh5wS/uGj2WlJfzyh0WtE5D39zBxY++ApFhDHqx9TyJ
	+sguFi/8=
X-Gm-Gg: AYBFou3kVxWxzq+6y58RM17Or6PxnKLIidXmLBQ9YM6I0+8IPvSXV07OAKNcP8EfmiQ
	0H4r0mEr/tIu0SeclGD+WGYg7nJImjrArZ7WwPv+51dErnirMInYhXPS4FTv6MPqO5rZAJ0TCJh
	8iP9pLVWtFixCcl7mqsC9qMikob92k9IE4Jr83F7lcTgwS4/l6m81CJwVMO5HJdMvsClV13qcFs
	cRto2qOokMQY4nPgjAtRS3yKv8dj6P3HQzsSsPaMSTkareyrutIw05llWIXpORnCrUwHWkvO1AP
	9nvBhJQ9aCchMW+9FRN7HVmuztyGhNeKYDsKhYZM5GAiABQkBytols2fD345SZVI/rj2wR23jVT
	SKLeyzdQ/geYAFekQAzyZZhr5HNbT+Bxg0pa7Lxer0cYgjlKAhZxI9W3C0q7KLTPv4bm3bQHafu
	ktcMMuOSI0ErrW2rgj3aL0wQDLYdLaPsj6xYSEMLJwIfQv5S+t97QrJR0bwWwmC1InSVBYC+pPb
	E9GxGOGXogCEL0QcdoScBl5Sl/M7sutOKhQl71msnzrEBWGBBv176C7oHHY1IrjPSUcBZkr7Jz2
	heaZJJ633IQ=
X-Received: by 2002:a05:620a:28c2:b0:93e:9809:8391 with SMTP id af79cd13be357-93e98098422mr123150785a.81.1791309994177;
        Tue, 06 Oct 2026 11:06:34 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e9919f3aasm16820585a.29.2026.10.06.11.06.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:06:33 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:06:31 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [NOTES 05/07] What can we do next with pluggable ODB?
Message-ID: <summit-2026.94e33e9ddf234334.05@ttaylorr.com>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>

Topic: What can we do next with pluggable ODB?

* Emily: We saw this working in Patrick's talk. What do we want to do
  with it next?

* Patrick: Most things work, but we are not all the way there yet;
  commit-graph and MIDX are examples. The plan is to add a repository
  extension in 2.57.

* Peff: From the Mercurial talk, you can convince Git to make good
  deltas, but doing so has a cost. I do not think the ODB API is at a
  level where deltas can be created on the fly.

* Patrick: I think we can do that. They have information we do not have.
  Renames are tricky.

* Peff: The ODB does not know anything beyond the content. Could we give
  it more information?

* Patrick: We may want to evolve this based on the representation. We
  could pass a `struct commit *` into the ODB API instead of just
  content.

* Peff: What we have now is a reasonable stopgap.

* Patrick: Content-defined chunking is another possibility.

* Taylor: Would that be at the object layer, or a property of a
  particular ODB store implementation?

* Patrick: I would like to do it natively, but that seems like a large
  change.

* brian: It could be part of a new pack/index format. I am very much in
  favor of content-defined chunking.

* Peff: There is a logical object model. Would this be a new object
  type, where a chunked object and a blob have different hashes, or
  something below that?

* Patrick: We could start at the storage layer and eventually move it to
  the object layer.

* Taylor: Perhaps, but perhaps not. This may be easier than we are
  thinking.

* Patrick: Moving the ecosystem may be difficult.

* brian: We could have a compatibility fallback.

* Peff: Then we would have two equivalent representations of an object
  which do not hash to the same thing.

* brian: We could introduce a pack-only object type.

* Peff: Which OID would I refer to?

* brian: The blob's OID.

* Taylor: That is analogous to REF_DELTA and OFS_DELTA: multiple
  representations of the same thing.

* brian: We would need a format extension, because we are out of bits.

* Patrick: Would we still want to put it in a pack?

* brian: Yes.

* Patrick: Start with the storage layer, then see where it goes.

* Patrick: Would this only be for blobs?

* Taylor: Is "chunked" a refinement of a blob, or an attribute
  independent of object type?

* brian: Trees are not currently binary-searchable. It would be nice to
  fix that too.

* Patrick: Perhaps reftable could provide inspiration there.

* Emily: After Patrick's talk, my skip-level manager asked whether we
  could build a commit cloud with Git. What else could we do that is
  totally wild?
