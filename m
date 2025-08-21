Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88B3277B6
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782279; cv=pass; b=DhNH+dWfBPEek54/ZO0Mom1mmo6gWqaldBwnM7F6G+WyECvP8MibFC+tD354hfzfvwzpnhccQV0KdT/ogEGUx2khooQYMQIG9QSqsQk3W29cRk1ifaHe7Mx8TgztsfnzqrK4kGsOvqDqPcr6Q8fomPosvWCa5oUMoSWetzRNxWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782279; c=relaxed/simple;
	bh=oQ+Mu19+1rL96uEhDfH4AtLPAl6+cac6wBYt6NKiCYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQvPZdn2IvPhiQkLRBt+Fd/k9yUjlaQ+83kII8lIfVSthFXPPM5Suxs0eJpalCoP4TghlUC4nCgtDszXlVq9HBT6IGCvYqYlsPV04j5a6S6GXxMCNfLUyIhows38/k/4WwDbX69+mHaArYae+bOlb7q4wVOT4V9LvHACTdeJgto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GJ7VV4Xm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GJ7VV4Xm"
ARC-Seal: i=1; a=rsa-sha256; t=1755782263; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NKZW9oWpeC4V/JV8wALN0SGPtSuf0DRH4aH8TaRziqL8BPQTkhKjUN5YaYQLfLLfBcKs7+vnZsVivOq6Z2s20+tYareGapxuYEmyfVyTZf2fBOKXr98krvdLgEiWxuF0vcm6gbGHH0/304exCQKzhbAui675WSpPNOYD4UqS88I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755782263; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jq8OhBXyQJYYJaxnbQNSqVwEapB/2WzH86BEgSQ3N4w=; 
	b=mw/S776KtLzgpZcPnnt8okREiSgCAXrxS2MLFw8f3xgu2Ynzjqe2Nke8fLH2Be5X/ZdQOKm6ldvNfAyNpRTm0qd0Huo9Lufydd1vVnSaRvG/cxzxCvlM2GuC0xjXB1fmDNdn2r9YFW8FJ1DILuXHRdpH72IVavhf4HWr/9uE7s0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755782263;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=jq8OhBXyQJYYJaxnbQNSqVwEapB/2WzH86BEgSQ3N4w=;
	b=GJ7VV4XmQ4fU41vvte6HJgTKHklUawlTlEi8YvqSI3UMNvhK9b2ZETXaxGSxYilt
	cj3N8nWUoc2INm1B+z7wbiQ3CFFGhe8hMMioX2UriUPNNl+M4ZQsjw//jk9bma7eA6/
	mQbYsD0XjUFfvSnZrLWHhe4H++XUk0Jb7avzRnes=
Received: by mx.zohomail.com with SMTPS id 1755782261782183.89282263859718;
	Thu, 21 Aug 2025 06:17:41 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 9/9] t: add gitdir encoding tests
In-Reply-To: <xmqqplcsgu7w.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-10-adrian.ratiu@collabora.com>
 <xmqqplcsgu7w.fsf@gitster.g>
Date: Thu, 21 Aug 2025 16:17:38 +0300
Message-ID: <87plco7r0t.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 18 Aug 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> Add some tests to further exercise the gitdir encoding 
>> functionality alongside the existing mixed directory and nested 
>> gitdir tests. 
>> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> --- 
>>  t/t7425-submodule-mixed-gitdir-paths.sh | 52 
>>  +++++++++++++++++++++++++ 1 file changed, 52 insertions(+) 
>> 
>> diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh 
>> b/t/t7425-submodule-mixed-gitdir-paths.sh index 
>> 902b2560ca..cfdf487a56 100755 --- 
>> a/t/t7425-submodule-mixed-gitdir-paths.sh +++ 
>> b/t/t7425-submodule-mixed-gitdir-paths.sh @@ -152,4 +152,56 @@ 
>> test_expect_success 'checkout -f --recurse-submodules must 
>> corectly handle neste ...  +		longname=$(printf "%%%0.s" 
>> $(seq 1 $count)) && 
> 
> Use of 'seq' gets complaint from 
> 
>     $ make -C t test-lint-shell-syntax 
> 
> See the commit message of d17cf5f3 (tests: Introduce test_seq, 
> 2012-08-04) and b32c7ec0 (test-lib: teach test_seq the -f 
> option, 2025-06-23).  I think you should be able to do something 
> like 
> 
> 	longname=$(test_seq -f "%%%0.s" 1 $count) && 
> 
> but I haven't even run the test with such a fix, so take it with 
> a grain of salt, please. 

Ack and thank you for the pointers. Will address in v2.
