Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898B1C30
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40ANmbIM1710760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 23:48:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Dragan Simic'" <dsimic@manjaro.org>, <git@vger.kernel.org>
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org> <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com> <ZZ8ZlX6bf+hjmhN+@nand.local>
In-Reply-To: <ZZ8ZlX6bf+hjmhN+@nand.local>
Subject: RE: [DISCUSS] Introducing Rust into the Git project
Date: Wed, 10 Jan 2024 18:52:21 -0500
Organization: Nexbridge Inc.
Message-ID: <007c01da4420$10a7b700$31f72500$@nexbridge.com>
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
Thread-Index: AQNL0k5wzhXZATyUnQ76Vxjn4eCV+QKEQ1wBALH7sDwDPprtZwK9Rr3fracIxQA=

On Wednesday, January 10, 2024 5:26 PM, Taylor Blau wrote:
>On Wed, Jan 10, 2024 at 05:15:53PM -0500, rsbecker@nexbridge.com wrote:
>> Just a brief concern: Rust is not broadly portable. Adding another
>> dependency to git will remove many existing platforms from future =
releases.
>> Please consider this carefully before going down this path.
>
>I was hoping to hear from you as one of the few (only?) folks who =
participate on
>the list and represent HPE NonStop users.
>
>I'm curious which if any of the compiler frontends that I listed in my =
earlier email
>would work for you.

Unfortunately, none of the compiler frontends listed previously can be =
built for NonStop. These appear to all require gcc either directly or =
transitively, which cannot be ported to NonStop. I do not expect this to =
change any time soon - and is outside of my control anyway. An attempt =
was made to port Rust but it did not succeed primarily because of that =
dependency. Similarly, Golang is also not portable to NonStop because of =
architecture assumptions made by the Go team that cannot be satisfied on =
NonStop at this time. If some of the memory/pointer issues are the =
primary concern, c11 might be something acceptable with smart pointers. =
C17 will eventually be deployable, but is not available on most =
currently supported OS versions on the platform.

