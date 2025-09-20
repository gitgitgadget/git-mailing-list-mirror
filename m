Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91F1C3F0C
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758410306; cv=none; b=KnFkDRoFFxTDqr1xUo01aJATHwQaIZnuRfpApM9YvAwgp0p/qPFXJRMvP7+As6xLTKDoeYTx/ZsNO64lXpvsfi/2DYk0NS/TOlfxRq469gEB245xiXfiEIYl1X0GI7E/fOyfUeAWUefhYoKIV+UW+UhqeFC8r7sdWkQIzchRgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758410306; c=relaxed/simple;
	bh=Jdg39FkT+gM0JGoUyLjgBg2DyMQQOzSLE8+nr8ApMd0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8zAcLX7nsqAuyUDWJlwOLzuWq1o+wYOzv/qRU5HkYNRF6UXpV6AZ6S+T/RFdU0Vo/j6VqRSNMVQMrPkXqapDlHFWaj7NL+dM/AVHCgwgAILtdeyAIMLMafBESK58HTvl1bWH2ToE0ZwsM0aFNM23BvSiMIS16DX9uLtT/924FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58KNHtKN1586634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Sep 2025 23:17:56 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ezekiel Newren'" <ezekielnewren@gmail.com>
Cc: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>,
        <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>,
        <Johannes.Schindelin@gmx.de>, <ben.knoble@gmail.com>, <cb@256bit.org>,
        <collin.funk1@gmail.com>, <contact@hacktivis.me>,
        <eschwartz@gentoo.org>, <git@vger.kernel.org>, <gitster@pobox.com>,
        <me@ttaylorr.com>, <newren@gmail.com>, <phillip.wood123@gmail.com>,
        <pierre-emmanuel.patry@embecosm.com>, <ps@pks.im>, <sam@gentoo.org>,
        <sandals@crustytoothpaste.net>
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org> <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
In-Reply-To: <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
Subject: RE: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
Date: Sat, 20 Sep 2025 19:17:50 -0400
Organization: Nexbridge Inc.
Message-ID: <002001dc2a84$cda40380$68ec0a80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLgmUmHR/cGrsIL/oCQ2NDpPqhQsAJqIl+QATT20payds6qoA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250920-8, 9/20/2025), Outbound message
X-Antivirus-Status: Clean

On September 20, 2025 3:01 PM, Ezekiel Newren wrote:
>On Sat, Sep 20, 2025 at 12:39=E2=80=AFPM <rsbecker@nexbridge.com> =
wrote:
>> To clarify, gcc is not available on all platforms. The overlap where
>> gcc is supported and Rust is support is likely high, but more, where
>> gcc is not supported then it is highly unlikely that Rust is
>> supported. mrustc is a difficult more that requires gcc even if that
>> is not clearly stated - it does not build with c17, for example. This
>> double requirement is making the probability of being able to =
continue
>> to support git even less for me on NonStop. My team is working hard =
to
>> push Rust availability and we realize that gccrs is an easier path,
>> but those two are currently outside of our control because of =
complexities in the
>loader on NonStop.
>
>Is there a C compiler that works on NonStop and Linux? I ask because =
I'm
>wondering if code from gccrs could help with augmenting that compiler. =
From what
>I understand gccrs is written in C++17, but Rust's native approach uses =
mrustc to
>bootstrap, and then the rest of the Rust compiler is written in Rust. I =
don't have
>$500,000 to spare for testing on real NonStop hardware, but if there =
was a C
>compiler that worked on NonStop and Linux then there'd at least be the =
possibility
>of people trying to make Rust work with it.

All I have is a C++17 compiler. gcc -std=3Dc17 might work for =
compatibility on Linux but none
of the gcc extensions work.

