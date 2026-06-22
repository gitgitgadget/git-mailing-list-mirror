Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803863AE1B1
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133732; cv=none; b=hUbrFjbpMTmO/NeixRVKjH75UkbDFVQm28gqhSeV3KdGbSdkWxvMLX/G1ZLOT7p0JhwlXSjF9Bee3IR6TXE8cRSonMUjthf/UONdma8lyagaf/yvNVe1PCcnbRkdil5WFEejF++fLT8hdX51dX71glEl45QAnD8MiPkvU+43QF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133732; c=relaxed/simple;
	bh=04V+hUYZrGU6j47eNIOTQNPoHaMcfCkWmERdGOx5rbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YbrD4ECDd8i0FqKgOH8DMzajhvtk9Dte7KyvEt0WYlsixFvkuAgfLMiQOWA5aNgFHJX3wuVTHvnTU/QemHjGF8lObaYvuJ+0oZFbibI0b/WklbH68fZCl9WItgdAqXKEFIlafIz3Ljs6sI9wUrTim0wOx3WufaBwETu4shGcfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HaT66q5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvYO3YPf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HaT66q5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvYO3YPf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BAD181400126;
	Mon, 22 Jun 2026 09:08:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 22 Jun 2026 09:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782133730; x=1782220130; bh=ddrncCnQ94
	HWaIUA5BYl38LkwApWhz5XfRr+HYr9b2E=; b=HaT66q5mgxlJiiZX7o6rhDwdXe
	NzWW6+fjpjPGtc6LI1z7W1h8Ya0EcX6XMp6vXGZdkNxcE7j/UvivKcBZlt8xJTj0
	S3ll6hFKt+TYUfFL1P2ISUNJWtIERgMY7dPy9lkmJfiAUQxWjE90meg4ekOt37Pa
	odM4bXw6k6FZmjM28mDM0jTOSaSeUEhykwOp33dR2ovPKVqA1JEqq3y/z/BJU+qP
	vVSLEbuMIGNlgKjVLA2XlZ3mnZMXExxxFveoox/mcUgl6o8HKE+bgnBgxP+T2/13
	S3+1Pj55HR5iAljeTZKEM7AvOfxg99czzdxINVGNU4fJPrBsdI0cuI8CqUOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782133730; x=1782220130; bh=ddrncCnQ94HWaIUA5BYl38LkwApWhz5XfRr
	+HYr9b2E=; b=bvYO3YPf9jaFof6TkXK1VeKww3QAcah+Evu0+WQvfIVWqXL/hC1
	+JL3SfHwn8GCujMs84gwvfsD4bKvD4HJcyBby4BZWmj+EccXiFJj1kFJKLH7jczN
	YSmpwxKPrww8P6OnPSW+4edSW0IMY4c3lcb05aGVAXzoj26F1COzaa0OBvS0YD1c
	hMI/Nk0JpMjvco1T3R6RVEukLuf0575uBXFbOHX+Nft7Z6pYT/fmz0BeVe+NeaFR
	2wkVCdQFZ1OkS8spTUZyZW1z/8nd7e9Y80kt0JPH+FOSXtIh2+pAQXlaEgjIxMJF
	2iOg0Ef0zwwHlRhFMOmuDonojK77F0+mUoA==
X-ME-Sender: <xms:4jM5atP_b3UgRrsCaULd1djC1G_KPlKeCiK3kybrVg1_RyNvCOCk2g>
    <xme:4jM5agrtuv978s1zv9UTlBJtTPqPMRAyN7cGrr0k9k6GcEvty2FiR1G0TAdDDyH06
    5H5U-vK9ZPwDrolyESMYX8sNeybeqJk_4AOS6vY61TV2XHxPbPzYA>
X-ME-Received: <xmr:4jM5aqe9ekxhB_1Wv68JS52eXo4LJxI4_IuZQ7YGwuCU5D9amoJw6O5VAGaBOBvR4SSWw7JhWlF55pM76zCF9MQhI9Jc8Lf6rbwUsGk>
X-ME-Proxy-Cause: dmFkZTF/q2SkpRM/9BPq+tIXKnJ1j/kySCb77YjcKXXzIFXiWjifDLkmB3m/3qNsBT3vCD
    BClxJ9KghcQcrMpJyM39QaRrVI41WDdggR780vPXoH4Dfh9o7M4yc0sg0a5V/QJHyZt3QK
    F1VHV6G8FvfM1der9dRYmOTYBCUYQ5pM5IGbqLODwkNTfvfEC7u98nUg7/9O7M+sKiSLPz
    r4wiSic8Mfq1LVlnLaQDbgToi+dyiYMS6vX2eASQzXMftqnUIoZXbSjWwLRfpzxj3xEnb3
    9cbpm9f8+jbydJ0VTNBnvOX+cfY0DK6vgzhYoijt3bZGuddJcg11KEW6HbPiXX78HNm0Z8
    //KBo2/qWs4Br5cUuFGUBWzIQmw1/meZ12Vvq9nx7SK4PiR2KisL5/NdNvoK8AYGSr224V
    i4NJ2yWJJSvx6EKBdhSipvD47mB/5Kyl9hUMR1TL7SwFoabW7QGWPnvTWhGFrKxhcjO1wK
    5YOjakQqY7sEgr1A1qHDtmZ3IbUzSvyaW3eto/PkaIQYjDnPaCpPkJbdtYMj1eRj6z2erY
    PEcyx7VKF2frEViKdMl/GxtzC0nRDCNDHkqU56rgUSPJpeZZbWaECo0q919GBcpasQWawa
    XZ+ZYZnOpt6+CTEWQWIW18kk3IjyZZ6m+xL4mQrVXrwnRArugMyNUanIQnQw
X-ME-Proxy: <xmx:4jM5auQp6NCjMpEdp-Bu-nppviNP1jfDTCO7-SrPFi03AKr-n_rBSg>
    <xmx:4jM5arYJh1LSHFss_A8h3Dy_UIP7k4pX7IjBDh9FHVQqI-oc_pJM9A>
    <xmx:4jM5apehacw3cqY76gfdYsNrXzhjJ92LmHPba_VhtduvDY1f5Jdnlw>
    <xmx:4jM5akI16GxtjeWPUqBcSwDo74oGaK6aO0CCcdM0GzwXl1qfw1sptw>
    <xmx:4jM5asKhFwbtP2EB5uqaYEVbG1vJseSnLMU8sOQ3ZFKuOm4ajxYzZTcZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 09:08:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im> (Patrick
	Steinhardt's message of "Mon, 22 Jun 2026 12:38:22 +0200")
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
	<20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
Date: Mon, 22 Jun 2026 06:08:48 -0700
Message-ID: <xmqqcxxi3eov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The Git project is not exactly the easiest project to get started in:
> it's written in C and POSIX shell, with bits of Perl, Rust and other
> languages sprinkled into it. On top of that, the project has grown
> somewhat organically over time, making the codebase hard to navigate.
>
> But there is a rather practical problem: finding your way around in our
> project's tree is not easy. Doing a directory listing in the top-level
> directory will present you with more than 550 files, which makes it
> extremely hard for a newcomer to figure out what files they are even
> supposed to look at.

Well, many things already live in the dedicated corner of their own
universe, like tests in t/, builtins in builtins/, and documentation
in Documentation/.  This is pretty much moving everything else in a
single directory lib/.  Surely there are things like top-level
Makefile and other build- and ci-related things that do not move to
lib/ for obvious reasons, but I view this move essentially to change
"for core-ish and library-ish things, look at the top level
directory" to "for core-ish and library-ish things look at lib/
directory".

Would that make it easier to navigate?  I am not sure.  What I am
sure is that this will force many in-flight topic (and soon to be
in-flight because people are holding them back during the prerelease
freeze period) to be updated, and it will make it harder to make
fixes that can apply both to 2.55 and before and newer codebase.

So, my initial reaction is somewhat negative, but I am known to
accept changes that I myself do not necessarily agree with, so...
