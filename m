Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D658DF71
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3BNFZEfB2969398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Dec 2023 15:35:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Josh Steadmon'" <steadmon@google.com>, <git@vger.kernel.org>
References: <xmqqbkakqx6s.fsf@gitster.g> <ZYN-5H-2NNoRRpf-@google.com> <xmqqplz0p90k.fsf@gitster.g> <20231221084011.GB545870@coredump.intra.peff.net> <xmqqsf3vmqug.fsf@gitster.g> <20231221214550.GD1446091@coredump.intra.peff.net> <xmqqle9njjp3.fsf@gitster.g> <20231223100229.GA2016274@coredump.intra.peff.net>
In-Reply-To: <20231223100229.GA2016274@coredump.intra.peff.net>
Subject: RE: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in set/add
Date: Sat, 23 Dec 2023 10:38:48 -0500
Organization: Nexbridge Inc.
Message-ID: <08b801da35b6$22c6e0f0$6854a2d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwADX3ewLDVAgiuHrjB4AMnmID8AGPqT0vAoi+uCsBXXooKwHkhHiOAfD/iRkA3kx+BQMQkyJ/r6GYnPA=
Content-Language: en-ca

On Saturday, December 23, 2023 5:02 AM, Peff wrote:
>On Thu, Dec 21, 2023 at 02:04:56PM -0800, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> > Right, that is the "gotcha" I mentioned in my other email. Though
>> > that is the way it has behaved historically, my argument is that
>> > users are unreasonable to expect it to work:
>> >
>> >   1. It is not consistent with the rest of Git commands.
>> >
>> >   2. It is inconsistent with respect to existing options (and is an
>> >      accident waiting to happen when new options are added).
>> >
>> > So I'd consider it a bug-fix.
>>
>> So the counter-proposal here is just to drop KEEP_UNKNOWN_OPT and
>> deliberately break them^W^W^Wrealign their expectations?
>
>Yes. :) But keep in mind we are un-breaking other people, like those =
who
>typo:
>
>  git sparse-checkout --sikp-checks

I don't see why=20

git sparse-checkout -- --sikp-checks

would be the only way to get that typo into a garbage entry, to be =
consistent with other commands. Without the --, --sikp-checks should =
result in an error.

>and don't see an error (instead, we make a garbage entry in the sparse =
checkout
>file).
>
>> I do not have much stake in sparse-checkout, so I am fine with that
>> direction.  But I suspect other folks on the list would have users of
>> their own who would rather loudly complain to them if we broke them
>> ;-)
>
>Likewise, I have never used sparse-checkout myself, and I don't care =
_that_ much.
>My interest is mostly in having various Git commands behave =
consistently. This
>whole discussion started because the centralized --end-of-options fix =
interacted
>badly with this unusual behavior.

I use sparse-checkout every day and do depend on it working predictably =
(although I would take a fix to see it work as above, with the -- path =
separator), so personally, I care about this a whole lot -- in terms of =
consistency.

