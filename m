Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3E4C67
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805853; cv=none; b=Yn7NuoSd65aFzSgHKJpxfallyDAKMV2Jf8Acg/L8tEUDvWkZGprukFVSYCbGlvaHoahvybNd3h4zeXhEROKdYtYHmeX5YwdeAZt56VARUwC3UTSj7FKNFyDPcAR6O5aT5wKSrOQxB4i2uTxUfkS8jA9MU/x54R63NAiTHkwRLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805853; c=relaxed/simple;
	bh=CKFo8KoAWS+V9jLmabDM28rXvz5TUKOq55LtbHSehAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fU0OzZRG5V4W+q1kJpiNbamc58bUk2XlXDAtEWdNI5WtoJQifpWgCAMtPpUFQUTi5/KX22Z8rrLyswms3gBxfz19ZltPqyOyJQPWXB10KWWxDPEpMrSWYmVMZsJg9FbJwEQR1SuEaotDYyGS+xiZnB5KBmXyZJUb7zu9/wyyrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iCwVQJqu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iCwVQJqu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 53D7D1BDFB;
	Thu,  1 Feb 2024 11:44:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CKFo8KoAWS+V9jLmabDM28rXvz5TUKOq55LtbH
	SehAA=; b=iCwVQJqu2ygrqb9rs+Shyl1qGcI9qrFzNqNm4a3Jm7nU6hRl1xvSre
	nO/lzGBXv6AcHLrm48adz/0QNOf37iH4t5de8lH4RB3aXlkQ8DxgVQ7cVg4dej9b
	rvSMYNWjLb+5tVigH0BdYrdWOswsJfGPF5oe9k2aGOh1dhTBx6zRk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C4951BDFA;
	Thu,  1 Feb 2024 11:44:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 793F81BDF9;
	Thu,  1 Feb 2024 11:44:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Cai <johncai86@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,  John Cai via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
In-Reply-To: <222CEC85-73B0-49CC-BB81-D6E6F36018B3@gmail.com> (John Cai's
	message of "Wed, 31 Jan 2024 20:34:54 -0500")
References: <20240131223032.4065897-1-jonathantanmy@google.com>
	<222CEC85-73B0-49CC-BB81-D6E6F36018B3@gmail.com>
Date: Thu, 01 Feb 2024 08:44:05 -0800
Message-ID: <xmqqzfwk16ei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1DEBC130-C121-11EE-A01D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

John Cai <johncai86@gmail.com> writes:

>>> Thanks for clarifying! Would you mind providing a patch to revise the wording
>>> here to make it clearer? I would try but I feel like I might get the wording
>>> wrong.
>>
>> I think the wording there is already mostly correct, except maybe make
>> everything plural (a tree -> trees, a .gitmodules blob -> .gitmodules
>> blobs, hash of that blob -> hashes of those blobs). We might also need
>> to modify a test to show that the current code indeed handles the plural
>> situation correctly. I don't have time right now to get to this, so
>> hopefully someone could pick this up.
>
> Thanks! It sounds like we may want to tackle this as part of another patch.

Yeah, the existing documentation has been with our users for some
time, and it is not ultra urgent to fix it in that sense.  I'd say
that it can even wait until JTan gets bored with what he's doing and
needs some distraction himself ;-) 

As long as our collective mind remembers it as #leftoverbits it
would be sufficient.

Thanks, both.
