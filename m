Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0C2EDD45
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338628; cv=pass; b=LQCprv7itwpRVroHKMY8HpD9CpOdWc6lM74j4bS1ZZ+/64B8yY+V3Yjzx32yyk+1iB9T6ho0uQ1iQvkS3Ay+vdvw3f3dGXS6eEiVmgqoH/0LBGIHjLPgpuhGH/WnbVfLJKOAtTe8/jJK4KYtZUabQG0rLpoRctAQ0UW+xpsMGUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338628; c=relaxed/simple;
	bh=vPN0ndgX7hqcebNiOD01m29xvoQ5QqN1DIeQfyR85Xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2ErQmqFRd3/YsOHS+qU2P5UQhW2CZAuxPjMsHDdVL/uT7kkd2zdHFJsiyJdLnLk00AoGH3+ZeriNNcwhlmmfEKKED46jWeM686yBmtioTRajb9H7ELOGn1jjN72ayikY6qT+Opz48QJZI1E3BlPjOO90PUCn5UVJWDNqS1IKXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Y7mzKi0g; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Y7mzKi0g"
ARC-Seal: i=1; a=rsa-sha256; t=1768338620; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kIumAvGVvDrss7YmbkKt41GF2M1BEvUE//wfj7Idz+XLq2vzangOyVU+lTrVX1aOkzhAbIpIs5JwEB7nOjE3HXMiZ3+5plYmayyqLV7ypWMh61mOkFmX/IeEVCj3p1kEZ4pACV/155zcNY0no1EQrfFdgfn28mEa5pJHVIVb3S4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768338620; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=clQQ0pVBeDcZXI3M27V79LCI8o2O4PSp0YldxMT9too=; 
	b=botCu6AWafeNgBXKR5SLETn2paIlNlNzs+2Uonb7BHaUmeaoGYPWqkxy0Qh64mtMQl4978/HuE8xn1wVw//eSW88vhjHaqqbm+z8J2zuiulKwdynDpqvFqEHtyFQ6l+y14x70IgWnCKjEtpzBfysCMLYFlC81BAPn2p6JsoJfH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768338620;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=clQQ0pVBeDcZXI3M27V79LCI8o2O4PSp0YldxMT9too=;
	b=Y7mzKi0ggJW457ufAFPMg02KzWB2AMUbVaQDQchsGqQs7J2qxxThSA+bdNTKZL8a
	USuntG/Gp4yuM92IGe1G8NONitLODgluopz3vFsJYp/lUZlc/ZqGWISbwxBIQdf2Tr/
	hLB1NIZdUy6FuI7MEGyspOZiunqOfgvD6Nk5B35M=
Received: by mx.zohomail.com with SMTPS id 176833861899618.183871233373452;
	Tue, 13 Jan 2026 13:10:18 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] push: pre-push hook that waits for stdin is slow
In-Reply-To: <xmqq8qe1i6o7.fsf@gitster.g>
References: <249f08d1-4457-4a41-8dbe-9725c0c392de@app.fastmail.com>
 <xmqq8qe1i6o7.fsf@gitster.g>
Date: Tue, 13 Jan 2026 23:10:16 +0200
Message-ID: <87bjixi5hj.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>   Thank you for filling out a Git bug report!
>>   Please answer the following questions to help us understand your issue.
>>
>>   What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> Used `git push` with a pre-push hook which included a loop over standard
>> input (stdin):
>> ...
>> I bisected using `timeout 3 git push ...` with a local remote to
>> 857f047e (hook: allow overriding the ungroup option, 2025-12-26).
>
> A shot in the dark, but it smells somewhat related to what was
> discussed in this thread?
>
>     https://lore.kernel.org/git/87h5spimno.fsf@collabora.com/

I'm 99% certain it's the same bug and root cause.

Chris confirmed the v1 fix worked for git-lfs which is great.

I'm very close to sending v2 which includes the regression tests we
discussed.

Many thanks for reporting, sorry for the breakage and thank you for your
patience!
