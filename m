Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDE158A2A
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023712; cv=none; b=RdSBFuVXDgLx4rSrrrG3w3/c9HKQqqyMyO76HxfemNzzpQtYGaZQ1/hv1Wm6jsIZeEdltYrl0N+1BynkPuWgpzHs3LOdfv0Mt7UkY24OaNqTMvJ5GIqQusTjQQI10kYXoQQytopi3jooMv7HOqzMZkyzyQUX5z/By42c7/9G4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023712; c=relaxed/simple;
	bh=JRuSn4fRex6Tq5XrjRIh4QR0j8EcJjmUrlGlzEEO6Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UP8QZq7MMpilEr3q6XkTCHuuTppqbiuvriQEaZERRuVclmtAl7qs8tPL3LWxSAfVPlmKLbRJ3B0QlRe+2TESqOMLAW/MlkQ1cpJd80AMN3sjNZ/r7d6DDjwfyUmly3A51j2kyabDI3/7OpaJNPl//Q4YjYcKr9AJjFxUaAB5p0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rb630Co7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rb630Co7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E90E2E0BA;
	Mon,  6 May 2024 15:28:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JRuSn4fRex6Tq5XrjRIh4QR0j8EcJjmUrlGlzE
	EO6Sw=; b=Rb630Co7G2LVQwWXVQPTNgXEuzTUhrhLOA+KxdBIgDKmC43lyioMHB
	LnfIgUUMSCvo4zUNdvxDN6xHn7nw97DXJB2F4tNkQ4gR/d7fMAx77mKZw8ia299C
	uzDKwzb2OiVrebIo2AUC2b8EGPRBuScG0PgUT77Oio7VnVBoFEpxc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3686B2E0B9;
	Mon,  6 May 2024 15:28:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ECE1D2E0B8;
	Mon,  6 May 2024 15:28:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jtobler@gmail.com>
Subject: Re: [PATCH] ci: fix Python dependency on Ubuntu 24.04
In-Reply-To: <7t2cqi643tvzjdeq4fddci2dqclgffkavps652cnf2swehx4uo@kng4bm5kvs6y>
	(Justin Tobler's message of "Mon, 6 May 2024 14:06:04 -0500")
References: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>
	<7t2cqi643tvzjdeq4fddci2dqclgffkavps652cnf2swehx4uo@kng4bm5kvs6y>
Date: Mon, 06 May 2024 12:28:24 -0700
Message-ID: <xmqqjzk6yc2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF45A3D0-0BDE-11EF-A0C1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

>> Reported-by: Justin Tobler <jtobler@gmail.com>
>
> Not a big deal, but the email is slightly off. Should be:
> <jltobler@gmail.com>
>
> Otherwise this patch looks good to me. :)

The patch e-mail also went to that "slight off" address, which is
funny.  I've amended the Reported-by: line locally while queuing.

Thanks, both of you.
