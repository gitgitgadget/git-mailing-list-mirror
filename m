Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B0482CC
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174556; cv=none; b=lwh9sRvPi+JVO7VaGOReMdrlb+HKSoacT5j2rNViAHhL5RgOET23JJIVI9RZ8ciqvLomRuvZiKssfos7hvOYU5bqOXpoZ5HMErZtmPUxX3cXbOVwr5c6kTDsOaWP2LpcB6lkJdXRYu7SfPno8e3+KOaCy4K3nbM8RfIRle0nH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174556; c=relaxed/simple;
	bh=f/UzQmGB4OJF5hsWyxE4PGsBIrgzjgggc1s/cvSMKhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gtj/86B9ZVuPxFjsIf6LxvbXTrlS9rnvwvgxK68dUioK/S1fJ1yIDqAu8zYvBmwV1/Ejq9fCBGwtXljEbX7I5vXlYnuVRnglUunSa1dGjTXK2sIRz7WLX4YzLoO5rCghpDAvf6ERZYuF9z3/anvdzERp0TvTZ5OqOZiVu12eXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RcGUvntv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RcGUvntv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D9DF81E3457;
	Mon,  5 Feb 2024 18:09:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f/UzQmGB4OJF
	5hsWyxE4PGsBIrgzjgggc1s/cvSMKhc=; b=RcGUvntvU8rwu3beMqkmVr9iKpmh
	7FX4P/j7Ro6CRo/yGazno8/fBSyzl36HVYTQ1Q0WEN7h6JwIFH7F24uZiUb9aosM
	k3/jFXik29dBnwg6FIYRCXfHn2eP2zWJklRmH2LtkXZY3ciaZ5ApolLObT//iiRt
	MRD3UeQB+NfIDf8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D296F1E3456;
	Mon,  5 Feb 2024 18:09:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48C931E3454;
	Mon,  5 Feb 2024 18:09:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Vegard Nossum" <vegard.nossum@oracle.com>,  git@vger.kernel.org,
  "Jonathan Nieder" <jrnieder@gmail.com>,  "Phillip Wood"
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
In-Reply-To: <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 05 Feb 2024 15:38:20 +0100")
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
	<20240205141335.762947-1-vegard.nossum@oracle.com>
	<ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
Date: Mon, 05 Feb 2024 15:09:11 -0800
Message-ID: <xmqqy1bymru0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 93B4A3E8-C47B-11EE-9EC6-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Mon, Feb 5, 2024, at 15:13, Vegard Nossum wrote:
>> Link: https://lore.kernel.org/git/0adb1068-ef10-44ed-ad1d-e0927a09245d=
@gmail.com/
>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>
> `Link` is not really used a lot. Junio=E2=80=99s `refs/notes/amlog` wil=
l point
> back to the patch (which is often close to the =E2=80=9Csuggested by=E2=
=80=9D and so
> on).

Good.  Also, is there [PATCH 1/2] that comes before this patch?
