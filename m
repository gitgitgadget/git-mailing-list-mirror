Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13B379998
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565594; cv=pass; b=j04pAIv+K6PVCkdg82rSPT60L2XjBmKWeEAgoaTGZLDemvP0UZlRFCCWwOerXrt2dHDXIMFouJ6/MsyQvkyNeodNcBUmqRT/ZLTqxWycZsn+9HrHTnt5ks3rEd98HBAxTjnUGC+PYLqbuqmhOnlt42jHhAD8FcIL+B2ehOP/phc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565594; c=relaxed/simple;
	bh=Y4ylD1kNEbNoz9wCBDmYs9NL7F2xfcJX9YkjrxA6Drg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkEkQ0d0xkyoJL1qcHikEUKR0CXEqIZj+uVgKFGVBTVVhMH/3tocuZTJI7z8vM9mVpofsc3t/pC3nsEGbSywqask4wLk/pRzp316cB2pSiX6RpZbDCDS5umYe3gdszw0ZARyQ93r/JkrnQYgGuuPjRNq0tKWFB4LSIHgRorJfNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b00m4UTW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZem1hQo; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b00m4UTW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZem1hQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768565591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4ylD1kNEbNoz9wCBDmYs9NL7F2xfcJX9YkjrxA6Drg=;
	b=b00m4UTWqJoVdemJa35TOJvxQBgGX1gU5E7bPREP/rxXfCoTAbCXY7Q+/wwK6J6+7Ollai
	o8S7gJxHcrqRIT+eHsOAQPo7k+JhC6v11Cznu63/4y4pv4jQY4IrwTEeVAF8DCOkfPU0kZ
	cH5sWB5K2zZbMU2dxHcLoV0eBTw8DHI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-5GOK9xEkNB6LEwJdKmPwww-1; Fri, 16 Jan 2026 07:13:10 -0500
X-MC-Unique: 5GOK9xEkNB6LEwJdKmPwww-1
X-Mimecast-MFC-AGG-ID: 5GOK9xEkNB6LEwJdKmPwww_1768565589
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b871e14de77so448984966b.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 04:13:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768565589; cv=none;
        d=google.com; s=arc-20240605;
        b=dcfWIk14vHxPpaJDjReOJ0SUa+Qu1Q0jAKI7ZGwRJ/fiGATdpuW5m1/zYbFEPA8Gcd
         Lgc9kMFi8/AunoYLYdJCuvpQCXrFIiWwXtnZmQP1qhr5KKkHM3NN7oGScAOKi5upZuGk
         UWtGNe8O6H7pto8Eu/H2LTcDP/or1x3/7Nt0hdbnXn3VkPjysFjIk22x4sHiJ2taxrYv
         tsn5cDHZ9stFlgFkzA7EIYou1KkhNdbfqI1n2JCLgPDJPLtA2xwaKksff22GZHTxXLon
         bziCVmvkcqG1/B39TOZudRlRXX4vYVQd2CrUZKNsIIOqoWg+s3J9t5X8xeuS5IoBWrra
         fAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4ylD1kNEbNoz9wCBDmYs9NL7F2xfcJX9YkjrxA6Drg=;
        fh=wtIudX2/zyrWlK6GJ+0xAGmTStkMjn3VXVjDBZ5qYD8=;
        b=JDTo7ij9eYKo1HuVSYTVR7oSL3QXqEKxtB0/uXK0WQ3Ei8euYlZNMspnwSdux2c35g
         d8+GhPU9TGlwXycEEqbHHmCdQ5PtbvcFkrCqZZuKh2hGO9vRIADYga57IGc/NbWe4Jat
         PXc6H2mjn/Tli5RE2ihD/jC+PvzKI0LbSSc2EcVqniiTdDSo0PQwsAgb9jGAKgwtSuws
         N8H26A3BmBPCmjsKVQypMZZpw9YH2uxSrDMoiU+NiE+HEyK/rq9pJSbI4798jd2q/kX+
         dx56CsUB88FF+C7PU/zo2uKZsmrd9eQfBNzYMlmvwAn32e/Tc7KjwSSY2dqaeYn8a37y
         /zig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768565589; x=1769170389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4ylD1kNEbNoz9wCBDmYs9NL7F2xfcJX9YkjrxA6Drg=;
        b=RZem1hQo3ZzJo+9VQOz6hqOPQvykZDazdNFJqtkWqjcq0H1XXKfOatiYTgGq+SjOgP
         eu7qfSSYzmH1N6ysKLEiE6j4KGQ9/r+L42ol1YCnjNgEQXMnpPz2ZsuBmoDlCExYmBIl
         uX9EwGyqLqOaiJR/PQSD+FQpXUsOltDV4cBPwFIx7NCfZCSb4UxZyKiRJtucOj1Lw39d
         zL0EkbCDDZ9T+hlNME0nhFy3OLFDXA5RIGou2tsCbe0ObfEmOQyRb0agJx8zVOgVSnWU
         RTq+wXv9xi9GvUgvCQxNJiEQFNHVTItp75L9EEOMb+7ETRdFJcX86pGlSkMXMccS+ZsH
         UFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768565589; x=1769170389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4ylD1kNEbNoz9wCBDmYs9NL7F2xfcJX9YkjrxA6Drg=;
        b=EC0Mdmna5s8YGIYeXMTMgPzwfxfx3iAUoizEJrkR3W1/OEDBq14IUXHoIufaYZYHJG
         u0Data73U/ylDoXTYJ8qFtKyb+tCuPpeyvBvxaXEAU8Nm6A0qgzCIwaeUbWG+nDl1hMB
         l7Dr4C4H/K8BiJLjMBERcL/FfM74Xy7PeeU2XmHQfNOZ6SCjFRz/alEqhnOw17LLrdcd
         CpxFuKkhPpXhXppmSTsU+m7xjNSsDSgggZ9uqLbAxOyQTjQdtLpMDqSRlC8qHpS+aRmP
         UZe/rLkM23G+PQ6n2NpAwb8TpUSdBYy6siBklOURcNCkuTXcNakm78ewrnvcDflVw0ad
         5VSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi4J2D+QgiNmeUqkEa9EIPle5DpQFSiLXI4PRGwa2ofQKuVg+ho2je1McuDpNFIlQBlXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAu05id/+xpSikepy7b6//bcd+rOFHPbfQo7OJr/bFy6yxExHT
	rarlm0BFsNBISTyM/hudOhR6fG/sLc9uGxRPqfVPybfvkpV0KgG9bqLlDmEELNJjWWdIwGyVG9B
	8tMkV6jo7TTf5xAcEYnRPSjZWpL57O9UOfssVbQOpZAGDcPxPLV+L1xVdWDD4WqGpBWnrsnKYuR
	22JQn2EQJFGb1RoXzIPGCb157h2rFU8HPBqH5u
X-Gm-Gg: AY/fxX5B6lL4WiO98KZOng6rQf9s1dkYeIWwQZ2H2tgWGpgmqyA7zy5m2ELA+DkXvBs
	464TRMcJ3dekHNUSxPvlZ8GNX1v5KzlOaIJZ+QCo3yIp5xXX/XZfVCjcI+sPB59NHMH9aWajPmz
	wJ5Ps8NawCKJCX99cvAP30/eNSY8CVYG+qJ4fgHTv7E6k4vbqPtjXTqIppj+KzIPI+E6E=
X-Received: by 2002:a17:907:d1d:b0:b87:35f:fb4 with SMTP id a640c23a62f3a-b8792d67d78mr275146166b.11.1768565588730;
        Fri, 16 Jan 2026 04:13:08 -0800 (PST)
X-Received: by 2002:a17:907:d1d:b0:b87:35f:fb4 with SMTP id
 a640c23a62f3a-b8792d67d78mr275143366b.11.1768565588234; Fri, 16 Jan 2026
 04:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im> <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net> <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de> <aWnekt4ESo0bKpOT@pks.im>
In-Reply-To: <aWnekt4ESo0bKpOT@pks.im>
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Fri, 16 Jan 2026 13:12:57 +0100
X-Gm-Features: AZwV_QgLeluPfSB8TcB-EFNpt_oqJdXYPNNWYrPO6X01j8_JD0HdFaiU-UCrGIQ
Message-ID: <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I just want to weight in from the downstream maintainer POV.
We've been carrying the patches Johannes has created in Fedora, CentOS
and RHEL for at least half a year now.
The only change I did is to make the new behavior opt-in by default
and give the RHEL customers a release note explaining it.
So far, I haven't heard about any issue with the patch, but sadly I
have no idea how widely it is used.

I think the patches proposed are making sense, and they should be
merged. Even having them as opt-in is better than not having them
merged at all.
In my opinion, giving a user option to harden against this kind of
attacks shouldn't be blocked by the discussion about what is the right
default.



On Fri, Jan 16, 2026 at 7:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Jan 16, 2026 at 12:12:47AM +0100, Johannes Schindelin wrote:
> > Hi Junio, Jeff, and other interested parties,
> >
> > On Thu, 15 Jan 2026, Junio C Hamano wrote:
> >
> > > Jeff King <peff@peff.net> writes:
> > >
> > > > Is there any reason we cannot introduce the new functionality as a
> > > > config option but _not_ enable it by default?
> > > >
> > > > That gives people the tools to protect themselves if they want to b=
ear
> > > > the potential cost. It just feels a shame to deny them the tool bec=
ause
> > > > we can't agree on the default.
> > >
> > > Yeah, I like the suggestion---making it opt-in would have much less
> > > chance of breaking set-up people are relying on all of a sudden.
> >
> > Can you help me understand how these existing use cases (which are not
> > actually in wide-spread use) aren't broken by design, given that they h=
ave
> > no chance to ensure that their ANSI sequences go to an actual terminal
> > that can understand those sequences?
> >
> > As such, it looks to me as if they have a valid goal, but go about it i=
n a
> > way that is easily improved: If they want color in their sideband outpu=
t,
> > then Git has to be taught about it, much in the same way as bf1a11f0a10
> > (sideband: highlight keywords in remote sideband output, 2018-08-07)
> > taught Git to highlight keywords in the remote sideband output. That is
> > the actual correct way to do this, not by expecting Git to pass through
> > all bytes to the terminal without sanitizing, which is a well-known wor=
st
> > practice (not even GNU tar does that when listing the contents of an
> > archive, nor does cURL do that, just to list two of the command-line
> > programs that sanitize properly what they pass on to the terminal).
> >
> > Given that those use cases are rare (none of the popular Git forges
> > support this!), and that it is a security issue, I still think that the
> > default should be as I proposed: To pass through only a small subset of
> > ANSI control sequences that you gentle people already agreed should be
> > safe.
>
> I have to agree with Johannes here. There's been way to many CVEs
> assigned to terminal emulators out there that allowed arbitrary code
> execution via ANSI escape sequences. Sure, you could argue that this is
> an issue in the terminal emulator that needs to be fixed, and that is
> certainly true. But we are significantly increasing the attack surface
> if we don't sanitize escape sequences. And even when working as designed
> I would claim that a lot of the escape sequences can cause active harm
> [1][2][3].
>
> So I would think that we should have behaviour in Git that is safe by
> default, not safe if you know that the options happen to exist. Because
> if we do the latter, then the majority of people will never enable it,
> and I'm just not sure whether it's a good idea to increase the attack
> surface for the majority of our users only to enable a small set of
> niche edge cases. Doubly so when those niche edge cases can be made to
> work again with an opt-out.
>
> Patrick
>
> [1]: https://cwe.mitre.org/data/definitions/150.html
> [2]: https://www.infosecmatter.com/terminal-escape-injection/
> [3]: https://www.cyberark.com/resources/threat-research-blog/dont-trust-t=
his-title-abusing-terminal-emulators-with-ansi-escape-characters
>


--

Ond=C5=99ej Poho=C5=99elsk=C3=BD

Software Engineer

Red Hat

opohorel@redhat.com

