Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D128D82A
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755961612; cv=none; b=ues1+v4eglBhh1mHvKdhG6XcScBlkIqMQWmwp4jEyblFfXuQtDqHfQL4+kL3X7l6jPrp/mICkE6epjZQqPnk0IlGMb2dMqdQtL10FGAN2xju1OVgKONVi9fAs0rTcDx9fuZ5avQFI2Wna0ZGk0O1c2Zsb0AxCxqm9PlZhWAFMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755961612; c=relaxed/simple;
	bh=Je9IkSmlR5eXBLqECzI3FAR5yPHCOMxV3dOqAKcAWKQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJoutNhXJH/dUosWiEEetgHkiL/y6mN8ENNTfIGLfkxNEXS04XQfUNK2bzC8uN2/mEWDistiHTtVyQQCQR9hrHcAwQPmKnN4j81NlONTC7cOqkobX1ej35/XZTZN5RRw93gwgsmbc+p5dEPpAQ91/+X9i2IM3oegqyol8fvsyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57NF6FBt3401818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Aug 2025 15:06:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Josh Soref'" <gitgitgadget@gmail.com>, <git@vger.kernel.org>
Cc: "'Elijah Newren'" <newren@gmail.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Christian Brabandt'" <cb@256bit.org>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Eli Schwartz'" <eschwartz@gentoo.org>,
        "'Haelwenn \(lanodan\) Monnier'" <contact@hacktivis.me>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?utf-8?Q?'Matthias_A=C3=9Fhauer'?=" <mha1993@live.de>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'Sam James'" <sam@gentoo.org>,
        "'Collin Funk'" <collin.funk1@gmail.com>,
        "'Mike Hommey'" <mh@glandium.org>,
        "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com> <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com> <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
In-Reply-To: <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Sat, 23 Aug 2025 11:06:10 -0400
Organization: Nexbridge Inc.
Message-ID: <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQHKaANAdlFqcOHeZ+UNw9ZV5fNZlgJjoZaSAeK73o4BCSPnmQFMkRvctF7NcfA=
X-Antivirus: Norton (VPS 250823-6, 8/23/2025), Outbound message
X-Antivirus-Status: Clean

On August 23, 2025 10:26 AM, Kristoffer Haugsbakk wrote:
>On Sat, Aug 23, 2025, at 15:43, rsbecker@nexbridge.com wrote:
>> On August 22, 2025 11:56 PM, Ezekiel Newren wrote:
>>>From: Ezekiel Newren <ezekielnewren@gmail.com>
>>>
>>>Upcoming patches will simplify xdiff, while also porting parts of it
>>>to Rust. In preparation, add some stubs and setup the Rust build. For
>>>now, it is easier to let cargo build rust and have make or meson
>>>merely link against the static library that cargo builds. In line =
with
>>>ongoing libification efforts, use multiple crates to allow more
>>>modularity on the Rust side. xdiff is the crate that this series will =
focus on, but we
>also introduce the interop crate for future patch series.
>>>
>>>In order to facilitate interoperability between C and Rust, introduce
>>>C definitions for Rust primitive types in git-compat-util.h.
>>>
>>>Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com> [snip snip]
>>
>> Does this introduce Rust as a mandatory dependency for git? If so, it
>> cuts out numerous platforms.
>
>The proposed platform support policy is in patch 1.
>
>https://lore.kernel.org/git/6d065f550fe871cf010409f7bd2a63438cf52723.175=
5
>921357.git.gitgitgadget@gmail.com/

It is a very disappointing policy to be honest. It kicks me off git =
because Rust is
not available on my platform, representing tens of thousands of users in =
North
American alone. Rust is not available, but may be in a few years, but =
there is no
guarantee that the hardware vendor (HPE) will provide support. I =
previously
commented about the problem with Rust and was not taken seriously. This =
is
disappointing and exclusionary.

The assertion in the policy that Rust is easily interoperable is =
incorrect.

Not Thanks,
Randall

