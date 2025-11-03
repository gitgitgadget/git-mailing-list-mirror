Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520C136658
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134346; cv=none; b=mnlxQf/xYUJ5daWm4MQk10R1TljtXhWTSqp5mbTQH9SfzRvzTdYoyGg5SAECihja2FIi5/gNKb/e6DbTavkxjqrkx8N6cED7Qaz1VA3HdSIOLoIMb9DufPj04GrZOw0dicnT0auS0aLQ2dVH9uccL7fK+4chOyafZ2LV66O7SBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134346; c=relaxed/simple;
	bh=5nQb0FiESNJX43K3JauerDuJa0bw/XN/2UXp8ypPjZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igEW5AVlG+UV2pIVz7Z48Dnv4LCPLOduiOt+cd0QI77sBhTTGJp262vDWIC4tbzoilqHOdr9wdDzy+VncFLTE7pR9GruTMo2h2f/TbVUMm2BgFU8TwOXA8RgLZfM4xRHy1qq+iWWp8BN/EzLSw6xCPtUAMoF4jTD3YDnaOhvUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9NwKS1u; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9NwKS1u"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7866e9e62e1so6658057b3.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 17:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134344; x=1762739144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ+0AyuSFfc8zdFu90yAPTqocmNFZ33kiqkLL1hovkQ=;
        b=B9NwKS1uoTpjkCnf9hdlewL+WRHvooK6gkQ1rk8KzW+P9dSwZAdjXM80Nkz7f4oNwM
         HwAweJfKeyT/B26QaJqT06O99//Egn7Qp7Q2pYIGTXDK6RT/7M76kUbuj5aaeWYrNzh5
         QnOdwd0Q7uwl8Mioj1ilqEa7HLW0oqhzlEFXuy0aFvZ96cSsfJyOQ/JK84GTpxoLdsmN
         x2iDjBeT4fmGv2IhaxUD5wlxsqMq9cXOTPxpiD7XDF9JCXBcyoaiIXu1vpuN+KTktuRy
         tGuhrh3u4CZq576aIAzSlloARL0M1NqTBZa2PxQNxhhEt8bMCEdYbb8T4c1BrhBNKccV
         4fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134344; x=1762739144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQ+0AyuSFfc8zdFu90yAPTqocmNFZ33kiqkLL1hovkQ=;
        b=JATRfRAH9fDKUbn12MCFMJ9t++mr/a9EhtMRHrWxnoJ3itogEE+DTlx7Z23bSCab5I
         AAxB1uV71ubn2sFVvY9QsefXmFb/NV1GDhkJRyAYXEYKzaLTlxaXgOxzuYuw+VZ2eev2
         TPdCffBT5FTM3RqzLP0MQtZHOTYf5CsNWUJNzQNbGQyl/pEaNZ5fGzFcPbUgQFFgJbFR
         wgXwcPllAayaXhqiZFaIhyoXVy1kWdz2HoBXOOMHyeTCgFwWDrf/7/iFX5ZRVekSwZX0
         rKLP5DUGg0h24NdHQny3eapWBldUVmQ1TzjLiCLjKq48zNTqVqqrlSo5sxR9s2Ojnr66
         O+/g==
X-Forwarded-Encrypted: i=1; AJvYcCU7BExX3Oie36G66xYxTOh8309bWF4q+60DgLR7fFJHLn2yV2R3tM0IDNb+ZC8R2WIJtco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBQJ+Gkp8JuYR8BVCqzh6ZttoQFUyCNzGIOZpDfm2S1ILOqK7
	wnZ6UGp4+orBjHWXnuqcJpdOnH0xlTScaRQuTk2Oilzbxqbrb7Q2uF+FYtjPO6GCJcewlLqX0gK
	jV3WXSI4wrveOpRjXM5UQ3inVlPqCFz4GGgV1Fk8=
X-Gm-Gg: ASbGncu6ajrDzREvFa7/4i1jxrUtQC9nIhKDaebaz986k08kbI/9kSpLyWzA5tVf7q8
	R36RdNlULB2By2xIE5zfa/PBTXXWPJqUzkYDrltICZNN31aTzCEHEA4DsXrwmYxZUb7CJaY87pD
	sVKB7+ECBDnozy7410KSNIhVLiB2U1+EjCS2lVuyfQhhmQ+yCcX3xwUf2eFcMS2zNhimeLooMPE
	f92lbdpgovY7mK9AVTphteNfEMJyvYtBRxuhXIX3uxzjxmJN0tVZ9gNUZ5DASA6N0fn0uKBgWKm
	yjk6rkaoiADiSEF0ogqLZAvM
X-Google-Smtp-Source: AGHT+IEumCZ9fST0DfpCauT1A3hG3zNr+MPUkFkTM3KhcB4sG3FKrjw+abJvMfCBHHKa5EaSAQfOmfoPeXrDIaqsjE8=
X-Received: by 2002:a05:690c:f0e:b0:786:87b1:9633 with SMTP id
 00721157ae682-78687b19b84mr2899807b3.32.1762134343865; Sun, 02 Nov 2025
 17:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
 <xmqqcy8418me.fsf@gitster.g> <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
 <01b001dc4c62$04943500$0dbc9f00$@nexbridge.com>
In-Reply-To: <01b001dc4c62$04943500$0dbc9f00$@nexbridge.com>
From: David Bohman <debohman@gmail.com>
Date: Sun, 2 Nov 2025 17:45:32 -0800
X-Gm-Features: AWmQ_bkn_WYo1Z9aGEuIxeg4zZBC97yAHvvelr-f7wkPoqq4ELf9cxjRXnZ0SUs
Message-ID: <CAB9xhmMzqDUXk4K=p4EW+OybH68WTGBLVW+tPwjO1nTeAtiPZA@mail.gmail.com>
Subject: Re: git-2.51.0: Fetching tags does not work
To: rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 5:34=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On November 2, 2025 7:47 PM, David Bohman wrote:
> >I am sorry to have to bring this up again, but I am still occasionally s=
eeing this
> >problem with git 2.51.2.
> >
> >What is happening is that I am cloning a repository as bare, and then la=
ter I try to
> >fetch the new content including the tags:
> >
> >% ( cd bind9.git; git fetch --tags )
> >>From https://gitlab.isc.org/isc-projects/bind9
> > * branch                  HEAD       -> FETCH_HEAD
> > ! [rejected]              stable     -> stable  (would clobber existing=
 tag)
> > * [new tag]               v9.18.41   -> v9.18.41
> > * [new tag]               v9.20.15   -> v9.20.15
> > * [new tag]               v9.21.14   -> v9.21.14
> >% ( cd bind9.git; git fetch --tags )
> >>From https://gitlab.isc.org/isc-projects/bind9
> > * branch                  HEAD       -> FETCH_HEAD
> > ! [rejected]              stable     -> stable  (would clobber existing=
 tag)
> > * [new tag]               v9.18.41   -> v9.18.41
> > * [new tag]               v9.20.15   -> v9.20.15
> > * [new tag]               v9.21.14   -> v9.21.14
> >% print $?
> >1
> >% ( cd bind9.git; git tag ) | grep v9.20.15 %
> >
> >As you can see, it is getting an error for one of the tags, but it is al=
so failing to record
> >the other new tags into the repository.
>
> git fetch --tags --force
>
> should clear your situation, where the tag is different on the upstream c=
ompare to
> your local clone.
>

Okay, but before 2.51, it would fail to move the existing tag but
still insert the new tags.
