Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346E28FF
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724042; cv=none; b=P9ZKMSj28T656OUj+6Nnh35XCeE+7K/YQzWwSfb0YTCazAag6DkrT/rN677fjqZV1sPAL8kjhnIhbRKCL4qBfX4c3G+1WCSv6SmWW+tYMwHV7jaw6Z0h3+1+mCgD84pi8iE4pFRGPMXTbJqa3lNfRRH7437QvlVuupndxuQIBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724042; c=relaxed/simple;
	bh=byVzCz+jbO8YSBP4z2WXBSe+esiPf51VK722HDwgsXM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dwt8Kpmb9ituIz5XLPqboa4d+u/Fq4vf2hDUuwHMIa4fLluU9BW99M9I9qCBXAai3HUMy0S4rgfC2V5x//mUhEdhZ1BdGyWxwkoZTs/CbIVxnIpE92Dt0VsGd1lLAkIUJcBxcHsFXe1y2WCiM9Uaryo1zZzKwN8e/ORauUeUSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46BIrrof3917763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:53:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Emily Shaffer'" <nasamuffin@google.com>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Taylor Blau'" <me@ttaylorr.com>
References: <20240709225042.2005233-1-emilyshaffer@google.com> <xmqqfrsi9i8y.fsf@gitster.g> <CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com> <007a01dad306$b12caad0$13860070$@nexbridge.com> <CAJoAoZm4ThQfJHuARnyfRAy81sfp9LchCSF7K=TZ9z-xFBGxvg@mail.gmail.com>
In-Reply-To: <CAJoAoZm4ThQfJHuARnyfRAy81sfp9LchCSF7K=TZ9z-xFBGxvg@mail.gmail.com>
Subject: RE: [PATCH] Documentation: add platform support policy
Date: Thu, 11 Jul 2024 14:53:48 -0400
Organization: Nexbridge Inc.
Message-ID: <00e001dad3c3$adaadb30$09009190$@nexbridge.com>
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
Thread-Index: AQLOJF488y2+/PGZbbSRsjvDFvsFqgF8FxGtAe/+URUDpk7FQwFShnGzr8gXJ7A=
Content-Language: en-ca

On Thursday, July 11, 2024 2:20 PM, Emily Shaffer wrote:
>> >> > +* You should run nightly tests against the `next` branch and
>> >> > +publish breakage reports to the mailing list immediately when =
they happen.
>> >> > +* It may make sense to automate these; if you do, make sure =
they
>> >> > +are not noisy (you don't need to send a report when everything
>> >> > +works, only when something breaks).
>> >> > +* Breakage reports should be actionable - include clear error
>> >> > +messages that can help developers who may not have access to
>> >> > +test directly on
>> >your platform.
>> >> > +* You should use git-bisect and determine which commit
>> >> > +introduced the breakage; if you can't do this with automation,
>> >> > +you should do this yourself manually as soon as you notice a =
breakage
>report was sent.
>> >>
>> >> All of the above are actually applicable to any active =
contributors
>> >> on any platforms.  If your group feeds custom builds of Git out of
>> >> "master" to your $CORP customers, you want to ensure you catch
>> >> badness while it is still in "next" (or better yet, before it hits =
"next").
>> >> If your internal builds are based on "next", you'd want to ensure
>> >> that "next" stays clean, which means you'd need to watch "seen" =
(or
>> >> better yet, patches floating on the list before they hit "seen").
>> >> Your group may build with unusual toolchain internal to your $CORP
>> >> and may link with specialized libraries, etc., in which case
>> >> maintaining such a build is almost like maintaining an exotic =
platform.
>> >
>> >Hits close to home ;)
>>
>> I hear that. Sometimes having an exotic platform and specialized =
libraries are
>overlapping. I am still stuck with 32-bit git because some of the =
available DLLs on
>NonStop are still only 32-bit - I'm working hard on changing that but =
it's not under
>my budget control.
>>
>> On that subject, I think it is important to have known or designated =
platform
>maintainers for the exotics. The downside is that some people expect =
miracles from
>us - I just had one request to permanently preserve timestamps of files =
as they
>were at commit time. We're into weeks of explanations on why this is a =
bad idea.
>Nonetheless, there is a certain amount of responsibility that comes =
with
>maintaining a platform, and knowing whom to ask when there are issues. =
The
>platform maintainers also can provide needed (preemptive) feedback on
>dependency changes. I'm not sure how to encode that in a compatible =
policy,
>however.
>
>I think it's a pretty good idea to have a contact list written down =
somewhere, yeah.
>Maybe something similarly-formatted to a MAINTAINERS file. I don't feel =
bad if it's
>just appended to the bottom of this doc til we find a better place to =
put it... or
>maybe we can put such a contact list in compat/, since someone lost =
trying to figure
>out a compatibility thing might be looking there anyway?
>
>Who else would we put on there? I can think of you for NonStop from the =
top of
>my head; that AIX breakage I dug up was reported by AEvar, but it's =
also a few years
>old; and I could imagine putting Johannes down for Windows. Maybe =
that's enough
>to start with.
>
>By the way, Randall, should I be waiting for a more complete review of =
this patch
>from you before I reroll?

Please reroll.
--Randall

