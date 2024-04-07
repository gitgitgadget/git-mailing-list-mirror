Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D5EA4
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453895; cv=none; b=lqXtZEt1y68xmP7nclwgjreOBOYQsc20oI2uzNFg5wCBxMg9JGTZH6WQUqBsmJ8Ffzf/YSevN0jft6sfz6WrV1CMnkKhGm3UZaEW2Y3trwNHEj+NAiZKl/PdL/wUptFUN6/LZTn61z6hZjUb33rAoDEx7Vo/K316GIu8Z33oJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453895; c=relaxed/simple;
	bh=saRu3sOYEeq3BiVkKZvKRMUiGbRDudSZ1CoiEoqKg38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFKtN60O5iN7Ir4k92Vy0bZyQa1DmbZ3N3Jis4g45dmxUoA3ZZcHstLBXRTw/YlIcOLZvkjMGuaANv08t8gv9z//9JlLzelEXeQrVF6ZIk4YHF0RPtrc7rIb/7h+i4NzqVG4SgJKoJvEqSiALf4vcw7j2yEbNBfSGo+cjD2x9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtHRaGlb; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtHRaGlb"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c4f23d23d9so2022092b6e.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712453893; x=1713058693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCFbmkk1+EkzcJ6+d/mjHVOUrtYjyul8RwwdNuPlhN8=;
        b=TtHRaGlbqncjx02RUTgw2D+Sp6m1HQP13g/9GElwgtzWoJBsuPO7gvaljUhX8JsSLZ
         NSlf4GNo4XBf5iTU7UzMhHiA37P+Ckx0gzbIYTehRXsYQW030RMqjFA6sukTuKIIPSpX
         TMPK73gIhdFZkyCgLTrovWHKunECy1RIKHig4PBH5unmNSEZ1IUevUUTIDy7M5NhvZjH
         d6jxzVLbbAaV0eByfQahgMK6ZpHCdCvnbxRsaaS0iAa61Jj39ecF2e9F9z/S937yUfkX
         QUNJ3RAzmEAIUYhxgMiHF59WC06zWj+ZYTE0XGbtpTD4XkxLzYZbNxSkvfqXCMwZh92v
         a4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712453893; x=1713058693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCFbmkk1+EkzcJ6+d/mjHVOUrtYjyul8RwwdNuPlhN8=;
        b=XEcAubLS9HkK5xiTU64oxauY4C6ZsdRanpN0PPZtJlW2aFJ+BXRD16dmR1SpEkrmVk
         4T1SdrFbrl4oZosu6Msh1YFlo+2YR4AVFi6nSNxdxtTnrpYiDLOMsoNbSQjkKT7st1gc
         8aejNxMqx63wDY5kYeL+h1rlfgakCYKhBIqolwqLpYhRxSEeStn/5qEVLkiyRvowIffN
         KvSo2/5UwvC/jDc7N+gbueUf9CMevk7ftE1ks+zPKDVNF4hutAnE6hL+TNvpbch3xWaJ
         OlbwTQhD7HVRioeIDy8m+HFDw3jE3fuCzTQnK7LGSCNcnb/b5AcQxKBgj1GbPcWJbBqe
         PMbg==
X-Gm-Message-State: AOJu0YzMxennLoFVHqpYolg7oa8KUiT+WtO8qIw9RHK4lYPLkClJGs2x
	cZ8Gamo91lDme+GHiRDUSTl47DBbAru6ba3dlkzr/m1so+OJ7OJTEBXQ1OAC
X-Google-Smtp-Source: AGHT+IEVBT4e4Pla2A3nVS/2vueNTLqNGoc0L1E8RqYSLmbFiLags9SmOAWGvok3yCM1GXHCqzFJrA==
X-Received: by 2002:a05:6871:442:b0:22e:1f29:e7a6 with SMTP id e2-20020a056871044200b0022e1f29e7a6mr5919951oag.24.1712453893075;
        Sat, 06 Apr 2024 18:38:13 -0700 (PDT)
Received: from localhost ([14.191.223.174])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b006e6686effd7sm3778696pff.76.2024.04.06.18.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 18:38:12 -0700 (PDT)
Date: Sun, 7 Apr 2024 08:38:10 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t9604: Fix test for musl libc and new Debian
Message-ID: <ZhH5Aoc1WPKRYtpj@danh.dev>
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
 <xmqqsezylmh9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsezylmh9.fsf@gitster.g>

On 2024-04-06 05:11:30-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:
> 
> > * Note that since our tests are pre-2007, I use the old rules in the timezone.
> > * We can also use IANA notations, which I believe is better, but that mean we
> >   will depends on IANA db
> 
> I know of the ",start[/time],end[/time]" thing tucked after the
> zonename, but haven't seen it used in real life.

The notation can be found in OpenWRT because Olson db takes spaces
(and update).

> How confident are you that it is widely supported?

To be honest, I'm not sure.  I know that Linux musl, glibc, uClibc,
all BSDs, and Darwin supports that.
I also think System V SVR4 supports that notation [1], and
its successors (HP-UX [2], Solaris [3], UnixWare [1], AIX [4]) seems to supports it.

1: https://mm.icann.org/pipermail/tz/1994-May/009304.html
2: HP-UX is conformed to UNIX-03, its support should be there
   https://www.opengroup.org/openbrand/register/xy.htm
3: For Solaris, at least Fujitsu SPARC supports POSIX timezone
   https://jp.fujitsu.com/platform/server/sparc/manual/en/c120-e679/3.6.5.html
4: https://www.ibm.com/support/pages/managing-time-zone-variable-posix 

Those companies seem to claim their product supports POSIX timezone:
- SCO Unix: http://osr600doc.sco.com/en/man/html.M/environ.M.html
- QNX: https://www.qnx.com/developers/docs/8.0/com.qnx.doc.neutrino.user_guide/topic/environment_TimeZone.html

From those webpages, I think those OS also support POSIX timezone
notation:
- OSF/1 and Tru64 https://www.unix.com/man-page/osf1/3/tzname/
- IRIX: https://nixdoc.net/man-pages/IRIX/man5/environ.5.html
- Interix: https://ftp.zx.net.nz/pub/archive/ftp.microsoft.com/MISC/KB/en-us/246/420.HTM
- Minix: https://www.unix.com/man-page/minix/5/tz/

I don't know about NonStop, z/OS and OS/390, but I think our list has
people who actively working on them. May we ask them to confirm?

> I do understand that you saw these
> current tests do fail on some platforms, but we'd want to make sure
> that we are not breaking other platforms by switching.
> 
> > -test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
> > +test_expect_success PERL 'check timestamps are UTC (TZ=America/Chicago)' '
> >  
> > -	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
> > +	TZ=CST6CDT,M4.1.0,M10.5.0 \
> > +	git cvsimport -p"-x" -C module-1 module &&
> >  	git cvsimport -p"-x" -C module-1 module &&
> >  	(
> >  		cd module-1 &&
> 
> A few things curious about this hunk.
> 
>  - The test title says America/Chicago but that timezone is never
>    used.  Would it make sense to actually use it for tests?
> 
>  - If not, shouldn't we at least use the actual timezone we use for
>    tests?
> 
>  - Do we really want to run cvsimport twice?

Well, when I tried to make this change, I first started with Olson
notation. Then I dig into the mail archive, and I see that we don't
want to depends on IANA db [5].  Then I switch to POSIX notation but
I forgot to update that.  I think a PREREQ would work better?

5: https://lore.kernel.org/git/7v4nlvulc2.fsf@alter.siamese.dyndns.org/

> > @@ -38,9 +39,9 @@ test_expect_success PERL 'check timestamps with author-specific timezones' '
> >  
> >  	cat >cvs-authors <<-EOF &&
> >  	user1=User One <user1@domain.org>
> > -	user2=User Two <user2@domain.org> CST6CDT
> > -	user3=User Three <user3@domain.org> EST5EDT
> > -	user4=User Four <user4@domain.org> MST7MDT
> > +	user2=User Two <user2@domain.org> CST6CDT,M4.1.0,M10.5.0
> > +	user3=User Three <user3@domain.org> EST5EDT,M4.1.0,M10.5.0
> > +	user4=User Four <user4@domain.org> MST7MDT,M4.1.0,M10.5.0
> >  	EOF
> >  	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
> >  	(

-- 
Danh
