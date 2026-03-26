Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E7313E36
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516825; cv=pass; b=Ia4ygDYfnFwvtiC6b8tjyjIxXQb2P1VjRVZaKtRA6fvHIqmIIKqKZz4j1dap0AyyX2HoiQWFi9q1TM5IXRhJk+AxpLHr6SuvPVrw/UBWY1Aw1v6RV/GJYbcxAsL5DfQbhx5H6hs7eYlIe1d3kge0a6lBFFs2maus+XjMzMF7/pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516825; c=relaxed/simple;
	bh=INj5gU+uoj3UUqH9voioa9oR6j8qZ/Llc7/4kwMwp9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DaX1CwtX0r7I4AWNJCpfjRINcndbl7LkZhG+W2y6wjzqTXgd/95wKtn4T1w0qxTKQN52upIab675Avg4M8mLQhH2JPdfgOezqtKEnAIh48o7hfx/oEcB/XS683s7PIHaXhfdnNIoOq/Yw86BrSnEEiW0Jpfvo4xm0a3zagaKLbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XLGNxlqH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XLGNxlqH"
ARC-Seal: i=1; a=rsa-sha256; t=1774516813; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m8+wPySKB3IffB2tdNx94ovN9iE1bELqE/XsRV61wH83AXZIXtUtv3GcDIVvDtGaFce1QJb+JbsyFtAMOW/a+UyBM7ZdKviZat2vZWrx/6Rr55pWSp2kZ4Uj+aIrxuk4zrzQIi0jIvL1IVlCuSydFPyvno8x9J4Wcsmh0W/h1kE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774516813; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Pu8XqTvjSGbl0GSyUk/NZKwksNSERXWvmpMQt8ab0o=; 
	b=SPmWDLpajkGxxPZXrpvFFdpXWHnayek1uwNJlLaoFR5IAddM3jlg3nV0oDQuUpmecHYMIuzdqrsGMvO2SExB6ACAlwam29uYdQJglbtb+5Jszy1fCKm7j0ovMTGas1tpvzZw978ixe55UxklVgv6jjBB+ndlm0vH+m9PjJUoP1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774516812;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=9Pu8XqTvjSGbl0GSyUk/NZKwksNSERXWvmpMQt8ab0o=;
	b=XLGNxlqH7k4pumWQPtT+IlSZCAfLfaXetnHBH8M7YUv67/y1odSwJb4IhfHnlbna
	N8I1WxX8NgbGXUioO5fAmk+f8ZomINbiy7cM1br+eIyGXGmkWsY4lVqxhLGVu8/3JHx
	y4cWLGYy1j8wryVW9EmDuSiI5cMst7YL0J8cN4fs=
Received: by mx.zohomail.com with SMTPS id 1774516809690457.9790041662458;
	Thu, 26 Mar 2026 02:20:09 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Pablo <pabloosabaterr@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, nasamuffin@google.com
Subject: Re: Tonight's pushout has 'seen' broken with "hook" and "replay"
In-Reply-To: <CAN5EUNSM3Hyb-6M_cSis_KhofhgjaEe=kwcXmQ_oSeZ486DbiA@mail.gmail.com>
References: <xmqqcy0rsfgo.fsf@gitster.g>
 <CAN5EUNSM3Hyb-6M_cSis_KhofhgjaEe=kwcXmQ_oSeZ486DbiA@mail.gmail.com>
Date: Thu, 26 Mar 2026 11:20:05 +0200
Message-ID: <87ikajc5h6.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 26 Mar 2026, Pablo <pabloosabaterr@gmail.com> wrote:
> Junio C Hamano (<gitster@pobox.com>) writes:
>>
>> I didn't have time to figure out which topic is broken, but here is
>> the test summary in my local environment of 'seen' I just pushed out.
>>
>> Of course, help is always welcome ;-)
>>
>>
>> Test Summary Report
>> -------------------
>> t1800-hook.sh                                    (Wstat: 256 (exited 1) Tests: 83 Failed: 24)
>>   Failed tests:  57-66, 70-83
>>   Non-zero exit status: 1
>
> Bisecting between master and seen
> This one comes from 58f670dc7a (hook: allow parallel hook execution,
> 2026-03-20), ar/parallel-hooks.
>
>> t3650-replay-basics.sh                           (Wstat: 256 (exited 1) Tests: 48 Failed: 3)
>>   Failed tests:  46-48
>>   Non-zero exit status: 1
>
> And this one comes from 76457c38ae (replay: allow to specify a ref
> with option --ref, 2026-03-25), tc/replay-ref
>
> I also saw three more when I ran it:
>
> t1301-shared-repo.sh                             (Wstat: 256 (exited
> 1) Tests: 0 Failed: 0)
>   Non-zero exit status: 1
>   Parse errors: No plan found in TAP output
> t0005-signals.sh                                 (Wstat: 256 (exited
> 1) Tests: 5 Failed: 2)
>   Failed tests:  4-5
>   Non-zero exit status: 1
> t3600-rm.sh                                      (Wstat: 256 (exited
> 1) Tests: 82 Failed: 1)
>   Failed test:  36
>   Non-zero exit status: 1
>
> Haven't checked for these ones. Are they already known in your local ?.
> I've CC'd the authors of the two patches above.
> Hope this helps :),
> Pablo

Yes, ar/parallel-hooks v4 broke.

Today I will send an updated version (v5) rebased on the latest cleanup
series which I sent yesterday.
