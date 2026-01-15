Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6F3D522C
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499606; cv=pass; b=tTbI8FZtaczWqhT8QxzHf+C93Bu7wp0g1/Z3wiwaFD5H38517rfO7KZfDwaJZU+3zpSTPlW6o4fA/Tr6Y36pQpDEDlFItej6jtQc40tORcziQnAw7qyNVxdEEGJ54gBBKo42Yhy7a53I1XWekbQcJSzxUMVAKW/iSO5Oe248mzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499606; c=relaxed/simple;
	bh=6QpxPJXFDEIl8TxExhFQHtT8p+Mcrr7H4N3Mb44I0iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHK0DPk6MT+BhTjkf4N3W+UTSgB0FJy6pTJ6gXQUcpr7z/0CV/vqejhjsUCXbEbN6qJLeelWT2srAb651cCfuQh4IIC7xmn2o8fTJFWEMRoLi9XBkJtrcdYiUTKtG7hXXI0alqKa2en23SVf9VZE/jlDGWD4Tn2F50hiGccJ468=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Tao4OGqa; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Tao4OGqa"
ARC-Seal: i=1; a=rsa-sha256; t=1768499590; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XCQugZaZqxmHvilU+2ug+58QP7jDqJzXhblwkKJU+xrSKCwRD1lJ9sOKsZgNE+BkwoPe1KCLFR/jHovdO3H6jNbE0VE/a+az3Q2LdqpNqlYg4C0zv6Qszjkdfa8SzNIqzruX4BU0Xlw3flk8x7VzFD0xIHLaCfhTRCWhYZn5rMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768499590; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KozKa1o6e2D9DsVDe44Pq1YR3o9NPo1F3S0jb+FAV8w=; 
	b=gsvTNFqpI+FpRXzdtW5u73FKdG19Bm+hxYWqtJxRsZTPbG3AllTLOxWn1uHX90QdoelH4LjCGuGHmMMG/4JqCtmST3yd8kQb/CFKgUck0+HO7HK5Tc/JhYxQGtimnB8o3zwhhhX3gvfvmha7RB/so25gOAeuyRIA+9d7VAp08k4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768499590;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=KozKa1o6e2D9DsVDe44Pq1YR3o9NPo1F3S0jb+FAV8w=;
	b=Tao4OGqanAUomSh0zPCA/HjddDLd6HjhZ2oUsRwy+Zfat8q0lopzJGaISgqyuYo8
	P2Z5nBv3Eu3f/cEYwlFVe2UPlc6iMKa847vhqAnfdhBpcUHyBiJhD5rJHQptSncJKFa
	L4mp7i7+ACeIQO3ig0wyQ9U1voIt7f732QnLGPLk=
Received: by mx.zohomail.com with SMTPS id 1768499588405541.227984969964;
	Thu, 15 Jan 2026 09:53:08 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Jeff King <peff@peff.net>, Chris
 Darroch <chrisd@apache.org>
Subject: Re: [PATCH v3 0/2] Fix two hook conversion regressions
In-Reply-To: <xmqq4iomdbn0.fsf@gitster.g>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
 <xmqqpl7bc68b.fsf@gitster.g> <87o6mulrnq.fsf@collabora.com>
 <xmqq4iomdbn0.fsf@gitster.g>
Date: Thu, 15 Jan 2026 19:53:05 +0200
Message-ID: <87ldhylq4e.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 15 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> I agree with this.
>>
>> We can't let these two regressions enter a release, so we have two
>> real chices:
>>
>> 1. Merge both fixes to 1.53 or
>> 2. Revert the 'ar/run-command-hook' topic merge.
>
> Hmph, at this early point in the late release cycle before -rc1
> (yes, rc0 is scheduled for this morning, but that is not really a
> release candidate that counts as anything), it is tempting to take
> #2, actually.  I just do not know how much damage such a revert
> would cause to the tree.  I'll experiment after I finish cutting the
> -rc0 preview release.

I do not expect any conflicts and, if there any, they should be trivial.

Let me know if you need any help.
