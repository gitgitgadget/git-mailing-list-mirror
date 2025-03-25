Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC711DD0F6
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942682; cv=none; b=WN87Mmhedw0lKPJLNac8Ail6Fwed62zVvhfjAvuxW9aQC6fFBE2vQ3r6SVxbEhs7Z+16q9aTMJStKQJxfNMMYm5/za71JeJvwaWYYw+1U0TJ/2sN7MGoPVAxo7veFk1hPBlhGCdEMtYHB7qZ8WmnTlPuUPDruf5ALpU4On8y3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942682; c=relaxed/simple;
	bh=AR5qObMP2v/emOIsY3vBXvKT/QU4JW3Y8aWHoecAr0Y=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pC68vFFwjqIM0GVCKRaB5uY70GmYB6iw4LYACaKZHNFGSJnRBAdjdupFuhmYJm4SLcig52OEu4p4sIhEiLghNKZnzo69isoAPOxm4jJ+L22uddpN5Qdvh2Je08CNSw5uysssBC+D0QEPR/n9Uk6ybGymssYtwa98LL5dtbd+nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLS5NkT4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLS5NkT4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac29af3382dso1043395266b.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742942678; x=1743547478; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR5qObMP2v/emOIsY3vBXvKT/QU4JW3Y8aWHoecAr0Y=;
        b=mLS5NkT4nf/6T0OBwrD9tyTYC/ruhOv9Yc5QlLPVZmBK6nDXx2/WFZlO+C/cI8z0u1
         RrajI3Trpmct4uDvFARJHmTLfs7V4DDGinT2SP0Y4/oigbo9j/BN/NalBQV8M957d6cn
         fMBTfI/IuWqV/5efF9f4tS/UrY4q566Aw7ZMk8OPlhqoRbAE5W9kbXZimGOyAwXV3s20
         IvfDuQv9WWSsNo9nZlNtxGA9YVjwFFF5PtqbUsiYmXCxTPRa60BBN11Qz1PtRozA/E7B
         zbNTzsz0yGO4LR1jQTnxczETjtQ1CjqxsMlLg/Uu7L7WOqlHd0m88zxNgepY67e+KT/W
         A+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942678; x=1743547478;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR5qObMP2v/emOIsY3vBXvKT/QU4JW3Y8aWHoecAr0Y=;
        b=qg0/PWXDmOBPFJssk5bpLBKLBCQuvdqoKteOVwWYT986BKFSt8AGpShlifFKIG1tc2
         Zex340Z3NEnA+24S9sr8heOEaX6X5z2ffd3TdlxeRYrFOAK4BZmgQgIk237uxAQd0BdQ
         0XqVkUTq32h730wwbYINIZHOWJwidECngzWXzUvDVlzOPouwrX6H7tDmQYUul9TEG3Rl
         jI2AU6Lc0NW46Kv0QzFbmbfZahwiymf+ThUHpYlnVFxbULmazZH9kGJ6aZxdbX1OW33D
         5kXkU1t41sI38VZUj3xa6zdi+d/bDokw2/fmO4XX4R22jG7eUWUqR65Z8jJ1PFmYgO9u
         4hbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf8TqYjbI7yrGbGPtAUlOoin/xI59tW43qeVV7qUpq803Ef6L7foh1QCMNy+68pexDzUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGTfpvOOQ6gjsmm1oxxjFweQBGaLdV3mfizxOixXoZbdw2w63A
	R0Y0IKhwvJucsCR1iXgdLOxFKBbK5NDe/tWMSHfIDRJZxf99JiE=
X-Gm-Gg: ASbGncumADsqJq2ijzoBW5aW8jZHTWXG12lq0cWEujZ0DvcRHlAOG2tb3Jl8cfdIsXE
	/c05iZyPyUuCQX8fSQXjYNveZxdfWwMhV8bv1N2BuT3afI6A7T4m2paWA6R30zKcdP3imqHbSpB
	Q1fCJjP1plKpBFHqZdWdL72Y65ZCNhvaURTTvfXAiOGR6C/QSKz7bKXMO+TeQLIm/Jl+r2zNPyj
	iDsiJMBqX1TPv4cOQE2InUO8NXYiSDB2lJ5plA/pw8glQr2vflFb+R8wMbOZbAOUXUcNI4UcEak
	ct9Uj1NcQayfxPUbwTXhF9AtydUoPapI0IWbqUVCnEe2Sc2vP7eBODb53+yCgOfq2g==
X-Google-Smtp-Source: AGHT+IHvu1uOZ5VMjTjLEbWnfUM85HDYpeVZTfz/mgodSlUXYRzXpYv1GiOWZchkGAsNmtaNBBIfuw==
X-Received: by 2002:a17:907:6089:b0:ac2:aa51:5df2 with SMTP id a640c23a62f3a-ac3f251bd13mr1745507866b.47.1742942678198;
        Tue, 25 Mar 2025 15:44:38 -0700 (PDT)
Received: from smtpclient.apple ([176.224.78.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbd4640sm907236166b.129.2025.03.25.15.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:44:37 -0700 (PDT)
From: Ayman Bagabas <ayman.bagabas@gmail.com>
X-Google-Original-From: Ayman Bagabas <Ayman.Bagabas@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v3] shell: allow overriding built-in commands
In-Reply-To: <20250324202838.GB777700@coredump.intra.peff.net>
Date: Wed, 26 Mar 2025 01:44:24 +0300
Cc: Junio C Hamano <gitster@pobox.com>,
 Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Elijah Newren <newren@gmail.com>,
 Taylor Blau <me@ttaylorr.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Chris Torek <chris.torek@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA9BF11C-4237-4A0A-9C06-37F0C4E8B712@gmail.com>
References: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
 <pull.1930.v3.git.git.1742743771108.gitgitgadget@gmail.com>
 <20250324032550.GA690093@coredump.intra.peff.net>
 <xmqqy0wvov5n.fsf@gitster.g>
 <20250324202838.GB777700@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Mar 24, 2025, at 11:28=E2=80=AFPM, Jeff King <peff@peff.net> wrote:
>=20
> On Sun, Mar 23, 2025 at 10:27:32PM -0700, Junio C Hamano wrote:
>=20
>> Jeff King <peff@peff.net> writes:
>>=20
>>> So it seems like a reasonable goal. A more restricted approach might =
be
>>> to provide a more formal hook/plugin interface. E.g., to run a hook
>>> script with the command name and arguments, and have it return
>>> success/failure to allow the to proceed.
>>>=20
>>> That's not quite as flexible (in your approach I could replace what
>>> upload-pack is doing entirely, cache its output, and so on). But it
>>> might be harder for admins to screw up. I dunno.
>>=20
>> Yeah, we usually try not to be overly flexible for that reason, but
>> given that "git shell" is so limited that rewriting its services
>> wholesale is not all that much of a deal, I think it is OK.
>>=20
>> I however wonder if it is worth admins' time and effort to add
>> features to "git-shell" using this new facility, or if they are
>> better off using something more established like gitolite once they
>> want to go fancier beyond what the basic "git-shell" offers.
>=20
> Yeah, I left my general opinions on git-shell unspoken. ;)
>=20
> For features, I think you are probably better off with something like
> gitolite (which I think does have some access control).

Gitolite is a great software, but it also has its limitations. It =
couples
authentication and authorization in the same system. However, I'm =
looking
for something more flexible that I can plug whatever authentication
or authorization system to the mix similar to git-http-backend paired =
with
apache/nginx/h2o/etc.

>=20
> For security, I'd be a little scared of git-shell, just because it's =
not
> run all that frequently and we've had issues with it before (e.g.,
> integer overflows). If you're taking requests from untrusted clients,
> you're probably better off configuring http service.

That's a fair point. Perhaps writing my own restricted shell might be
the best solution for what I'm looking for :/

>=20
> I also imagine there may be restricted shell implementations that are
> more general and more battle-hardened, that you could configure to =
only
> run a few commands. But I haven't looked at that space (because again,
> I'd suggest just git-over-http).

If you know any general restricted shell implementations please do tell. =
I'm
looking for an SSH solution something pluggable like git-http-backend =
that
I can build on top of.

Honestly, git-shell's simplicity is what got my interest at first. The =
fact that
it's not secure and not run frequently can change and be improved.

- Ayman


