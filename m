Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919F364BD
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lqgrk/7l"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 04A0E38A35;
	Tue,  9 Jan 2024 17:34:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=27zYjxVX8s/VoABwAfcegWMWGGpYX8XDzCAkiH
	KBb6w=; b=Lqgrk/7l828goLllCl3ZbKXKAdtCoh1U/RlzA2TGNulzit7fNhb1Kn
	ZodyV7BC0XqZCT2XE6h8Ki+wKH2aFXncz4qS32uzMo0GVRXw6X5Jes4G0VLneixd
	NMaDN38wOEsnWCnI1A3/9nDau6ihcQmSTE/VRjjv5kwFlwXqgkziA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F2AA238A34;
	Tue,  9 Jan 2024 17:34:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C23D38A33;
	Tue,  9 Jan 2024 17:34:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>,
  sunshine@sunshineco.com,
  git@vger.kernel.org
Subject: Re: [PATCH v7 1/1] mingw: give more details about unsafe
 directory's ownership
In-Reply-To: <e7594386-4a26-467d-bd27-8ac6268ad219@kdbg.org> (Johannes Sixt's
	message of "Tue, 9 Jan 2024 22:05:39 +0100")
References: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
	<20240108173837.20480-1-soekkle@freenet.de>
	<20240108173837.20480-2-soekkle@freenet.de>
	<d1e1a543-ab9c-4b1b-9f1d-3728e791df2e@kdbg.org>
	<xmqq8r4ygtkd.fsf@gitster.g>
	<e7594386-4a26-467d-bd27-8ac6268ad219@kdbg.org>
Date: Tue, 09 Jan 2024 14:34:38 -0800
Message-ID: <xmqq4jfmf85d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 468D95D0-AF3F-11EE-A9BC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

>> Because len_domain includes the terminating NUL for the domain part,
>> (*str)[len_domain-1] is that NUL, no?  And that is what you want to
>> overwrite to make the two strings <d> <NUL> <u> <NUL> into a single
>> one <d> <slash> <u> <NUL>.  So...
>
> But after a successful call, len_domain and len_user have been modified
> to contain the lengths of the names (not counting the NULs), ...

Ah, that is what I missed.  Thanks.
