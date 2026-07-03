Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C8284693
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093588; cv=pass; b=gZGeoWq0Moe0+/4KpV+TQeJfQ2cji0gNHTFLzVBf2u/OW+/B3oNQ+3MATKE03IxmWpAOLe/XG5vl1j2BXWRv6MMfFixKUa5OjtTUvRd+kZJFnB+w9JDLXReQMTKL9ckixTYB1Uw5YaQP9md9ddeXdxVBPuqBx+64Wxpt4J8LHQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093588; c=relaxed/simple;
	bh=XdiIgjCaAubXZY163uX1dJAyppTMPi2Tw8TaVteWFqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4bpxmTSl2/f4EjnEqB+mO0WVu0O9HbVauLeXml5iPfBXBrWeIwXnREfWuu69mgjhpqRJLAFFVGnGun4U4ORe4LVh5iUq0gj57D26UAPPeU2szjx5moXkMlhLKeiPZgMrPpGUNo16OHjRUAllRVWYLLmV4J6ThS/UnBj5bVLDmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlOQjBQP; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlOQjBQP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-847a52edeb2so550480b3a.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 08:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783093586; cv=none;
        d=google.com; s=arc-20260327;
        b=p00WMp3L9WVG2iO0rQnA/IryCi7qWI+y1wK+IzE+nZvGLjXnjcx5+KMisr74+XFnKD
         Coumj4Hy6RXBqqnwyPQylkta0mQffJXPNN67UCwFwOs8Q/GWXr4jiq+YyDF978RWgSm7
         wn4mTPfcBhiQuLvQVh5Qs+idE8zCTFePL0xGocuY5nKYoRCy6ZdItG/rCcSKDAC0ZV9K
         QBdFXzJzykrIbmuKmjVsIpIfF09FKezPdVjRQjED/GUEpw0Q25HzGo99VucGKD8Dc24n
         fhwplE7ZSzminnoSPnE7a/AZ6m1nDMGxTa/nYCg6ocDPq6ooG9vEr5S7QI8I0cF7ptiW
         GBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XwNJbzGFZLmOYF3SUIKQpGaZQIy0N10NfUI+ARqcYiQ=;
        fh=XjQ7wSgBN65vGB9/IbiwVarztbcAt5gKb7fv5SFPkDU=;
        b=kVF5mMgRwezE+KAqHTVOlHyYGtuo+BmpD3f73/m+k9zhw/vsrJCtlUyAHh7hrs9gS0
         Jn+LCP8qsLqSC5TacIHx0H2R8RuheXOoXZhmJuVcgYh4PnVyOjV5k85IqMOjx/XbYul4
         +dhttt7g5U0yeTLxAeuuoYD0w4YsyObFqvJbT8gldX9w1+tYIQHHF+Hj0sd7Lc8R9tzv
         e2cMrVUk6zdnskmyHbRmAFwiRzcgKB4WRDHhOAanqP+4+o7Ww940RW7YjTqGsa1K0ywf
         56b67uUVDlAZXt7s1gnA60AEDCwM/NsihXhPlbP5VDo0ZuPWWHXPRCk3NDMkU9+W4HaD
         mgYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783093586; x=1783698386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwNJbzGFZLmOYF3SUIKQpGaZQIy0N10NfUI+ARqcYiQ=;
        b=JlOQjBQPGMPl6EYy+PLBAG1bRcuVXZ8K8iEsADQ0gD74ccr5rSE6akFAowG9yjHW3E
         dKGzW09//9sRo1VPo5Yqjm6c9rCx1tiV4+wqorkfn9URhOYVA660OdESM2KdFjAN5wo8
         lhi9vE++Gb0Thdp6aeGS2T9GnJpReIoDYbcU/W4Q7Inzpyr1BYLUui0sOiFFpQYcuiAa
         hYdivnCk8jbGtvOQAKAb28rj50rqnne+0/Gnblsvua4C568zeTFoNN8nMl6fxGK+OLtL
         eCf/p1+Y0SmWpPGOFzx51rRPbzlK8LnqMYnWOHKi49mY/xdeh6jnqchvxOCakl4EIikf
         ne7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093586; x=1783698386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwNJbzGFZLmOYF3SUIKQpGaZQIy0N10NfUI+ARqcYiQ=;
        b=cWKWaEpmI084+Hu5cACY9lbglDOIe6+xgfYvm+j9Uo7iyIQaiqEgH+kluDi8eDRTNP
         O4IlSCh+X8Y7C8WUliCmjlBsuN2zK612KhU8LJqzlY5n7TLl0awfnPj8lyXBUdW1oI7M
         5cLNhzlZ4oH9V2O64JOPDixKgnNWuROLqBC/FC6e5LrnDmM1kjPmD8wHOtLGslGHZNkL
         0+ZrIBzEH03d+05Oxajxf9oxyA7NMjc5YYneWkTZ2q/kMsBCC8FeuEv5p88m7TStPhZ4
         iePLeU3lhWoQyPHFbhUCi2hKGC5ijA/eaiaLZhy1fPV7om0mzvd/hByUgTRVZd0Kcw5z
         PrWg==
X-Forwarded-Encrypted: i=1; AHgh+RpdMeRSKvp1EWi1tCE+Mj5qDmtaXMsqf6YTOFzkE8Z53PJo9NXu8mKpU5B9b+8Uj8KYUUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LWxc5yyHj3nWBsCCUf+9qcsV6iS4WwIbu2LbciK8rJSb33Q7
	2pXW4KsQTADMXU+qgdh22tZC9eUXcP4E2z0q3asOIg7BsLIefC9/TpqKWw7Ryk7XAg2H8gFC3Xg
	bleJmOLcy+8GVzjCPJd6d7PCYVhX0FNQ=
X-Gm-Gg: AfdE7cnJHwXg7w89hhoWp0oYYOT5mqECAT/WZfPqiUGjp/OZZpaLL8kv3up/I+EulLx
	wBeijIwn6Qf+Ou2witv2TS0f3B0DnMLjhapG0ftEykiYX/dSBhQU01/vJHqXuc3hlJv9X8om+dn
	CGvkdVGcWnhsY8SGyW89IRTaW39+aBll2p4f4uoaHoKlxz+izT+G1GQo8HEf79igh6avfbdH3j4
	+NIBsGYTmIDsNy5lQMXm5nGLFZhTP8hdxKdFB4ptZLpMD7QPIW1VZkeNR/23ARnhmACxElAP2PC
	gWJ0U5JyPYgGk3yXGfHjjM5mt9CQ15kL3Mtn5xbuCJdBxzJxLYdkUWsmK2CEzOPJAjdgFUHh9T2
	STYXyf6rpbDFV1Blu4dvqUdqXhg==
X-Received: by 2002:a05:6a00:3686:b0:847:99a7:c751 with SMTP id
 d2e1a72fcca58-847f6dfde0bmr69744b3a.25.1783093585996; Fri, 03 Jul 2026
 08:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net> <ajjuoS5Qc3K0nCRl@pks.im>
In-Reply-To: <ajjuoS5Qc3K0nCRl@pks.im>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Fri, 3 Jul 2026 11:46:14 -0400
X-Gm-Features: AVVi8CfOUAU-g-AUOci2bRAoAhrVMyeSrLL7Mneey8DsoBg3UkUKwjHUr_kpFwU
Message-ID: <CALnO6CDAG4e4A_Qn-3QVe0s4D9xB333Sp0QRntNATwMygNXmQg@mail.gmail.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[with apologies for the delay; I wasn't paying attention to "What's
cooking" to notice that this was waiting on my response.]

On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sun, Jun 21, 2026 at 01:49:34PM -0400, Jeff King wrote:
> > On Sat, Jun 20, 2026 at 12:00:24PM -0400, D. Ben Knoble wrote:
> >
> > > Autotools-style builds permit enabling USE_NSEC for cases where that'=
s
> > > desired; the equivalent knob is missing from meson-based builds.
> >
> > Seems reasonable. This is not changing the defaults at all, but just
> > bringing meson's options to parity with the Makefile.

For now, I still think this makes me in favor of the patch: source
distributions like Gentoo can then offer the build knob for those who,
in Junio's words

> know the target box with its filesystems happen to be OK with the option

Otherwise, the discussion would suggest removing it from Makefile as
an option :)

> I was originally wondering whether I should recommend that Meson can
> auto-discover the availability of nanoseconds. But your below remarks
> make me question that.
>
> > I'm not still not sure if turning on USE_NSEC is a good idea. There's
> > some discussion in Documentation/technical/racy-git.adoc:
> >
> >   With `USE_NSEC`
> >   compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
> >   members are also compared. On Linux, this is not enabled by default
> >   because in-core timestamps can have finer granularity than
> >   on-disk timestamps, resulting in meaningless changes when an
> >   inode is evicted from the inode cache.  See commit 8ce13b0
> >   of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> >   ([PATCH] Sync in core time granularity with filesystems,
> >   2005-01-04). This patch is included in kernel 2.6.11 and newer, but
> >   only fixes the issue for file systems with exactly 1 ns or 1 s
> >   resolution. Other file systems are still broken in current Linux
> >   kernels (e.g. CEPH, CIFS, NTFS, UDF), see
> >   https://lore.kernel.org/lkml/5577240D.7020309@gmail.com/
> >
> > That's the most succinct description of the problem I've seen, but I
> > have no idea how widely it still applies. Kernel 2.6.11 is quite old
> > now, but I could believe that other filesystems (especially network
> > ones) still exhibit the issue.
> >
> > So I guess if we wanted to go further it would take some digging as to
> > how each platform behaves, and then flipping the config.make.uname knob
> > for ones where it can be argued that the behavior is always reasonable.
>
> Yeah, it would be nice indeed to figure out whether these concerns still
> apply. If they do, I would argue that it might even make sense to remove
> the build option completely. It doesn't really make sense in my opinion
> to have a build option that nobody uses and that is subtly broken when
> enabled.
>
> > But that's all outside the scope of your patch here.
>
> Kind of, I guess. If we figure that this mechanism is still subtly broken
> then I'd argue that it doesn't make sense to expose the option via
> Meson.
>
> Patrick

This bit addressed more down-thread, so I'll reply there.

To summarize: If we're all leaning in the direction of a run-time flag
instead, I can noodle in that direction. That certainly involves a bit
more surgery than just giving Meson access to the option, but the
dynamism may be nice. I'm not too sure how we'd write a test case for
it, though.
