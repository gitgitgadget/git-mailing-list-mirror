Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FE2594AB
	for <git@vger.kernel.org>; Sun, 29 Dec 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735473750; cv=none; b=rYhBlRshmsWSRUzLget+97TBeksJL6hAXUFQUJlQfv6LT6AhXaTFgm9DZaeRm/hdO38c3gLd+Kqc2kayGj3zfJ7qij9d2YCJlR9BzeGgv7krxJnyJALR27VmqfGwx/h2syBEjn7ejeqWWPOX9sJUNx0B8CjuqQRHHH0tCIwjWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735473750; c=relaxed/simple;
	bh=8rEDLsNqh3olnjuZHzgpy0tZdgN60tMIFip7sdX7nnQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k47oqCnet6rEc8pdx/XAjPTpcaIXFBi8tezhDdlljXZbb+L2LR12e85m3kDG+q8sACQM0SCX2593quirDEVmex3bM+7C0Ko7EhpMdCEipy85OjSBvRDSR2lx+mwzQTRpF3IoZvgp4EYfu0CHBNgS5Q+0j+ZCWGA+vjRCoDz5b4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Z5NDHZ50; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Z5NDHZ50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735473734; x=1736078534; i=l.s.r@web.de;
	bh=MW9kD4PbahdtKXxtVMIqFdd4utmlJuZq8FmcZmpv7g4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z5NDHZ501CvzyGwVbESkKy4uHPQ57t3tqHO/xZpzfa/nEZBVSO3Gm+vsXVcH5qBO
	 RVxRGi7BFz79iSaRaouDegs2alYOKPeCzS+Fadmiy8jyMxRQ837BpzMbfB68JTmBT
	 83hlnGhIfozzNy/a5JQ/rh0fuX5WyZNmJDIhCeTPiiAt3HF6RZhmLkgxYJ9uC1gdW
	 4qVGz4Ku9Wq+M52zZ/H6YyJJlrvnPzmy6v/TRjTDxnei180JRIip6LjHdQwrtOsyu
	 3VDEgRxObWmLzMTcvv6jxXL+3OcD85fRkEnPV/O9aG3hjUfv/AGOq3UYJb/EC/UbH
	 bx4MN/OQoazjgLVYxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGWc-1tJaGy1OeQ-00Gv67; Sun, 29
 Dec 2024 13:02:14 +0100
Message-ID: <965bd864-3ac0-454f-b7bb-f8e0214e9969@web.de>
Date: Sun, 29 Dec 2024 13:02:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: racy leak sanitizer builds, was Re: [PATCH 0/9] commit-reach:
 -Wsign-compare follow-ups
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g> <xmqq7c7kubx8.fsf@gitster.g>
 <xmqqbjww65i1.fsf@gitster.g> <Z2-2dbYVuuLxpNmK@pks.im>
 <20241228190541.GA815586@coredump.intra.peff.net>
 <20241228192307.GC815586@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20241228192307.GC815586@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b4ORKjphJKj6VEkoXeSdz+kwQcio/Y/PhM9mZyC9nOTz0oWjvSe
 gAeDTiRhf7K8G5aA+XZ1H0/bcb7npd9NBcpAgsHyOzZZBzR5kVkz0luD+SfzSE4ahbRtGYJ
 8J9tU8MPvcFKdzUpdaQc8OCEpJchsRJaleO+gVp+3Q6A61T9avUmWNXKK+v4S9mXOnV4P4K
 z0vzKKG1VlmtxEmS+qblA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lgipeV44MTE=;H0CYMgMOIsr5thJVRivAtJKPIh4
 Jx0QU1QLdjQ+j8yRkVC61to6IhKsdOHdEKbAQOadIU095Etbi744+cb4C2gVfdl40CLWeazqP
 GR6vgDKQJfgozIJ8bO4MkWMqdRWVW5sao8LesQyHFTk7O0jqcSW0bYN3fRudGvg4Xaav4nk/+
 vdIB0lBtAUlcw0FFfBGS5RxtU/3eygvsinlF5UYvk0SNuG2PoEirMJ9LxVciXx0psD7euKM4S
 2d0SgThwSgMsdf23noVZgmD6kfO1Pp0XxdxVQdjaZ61hrvpn6fkewuywC86fnZtH/WNc1EOGf
 XlKfsiMUhGiYMSa3gx+Nhxwh7n5heN8OLKOyPOXa9Fc97DSpv1XwCGE5rr7cpkETykFzySh7S
 j4HwmuB54FfRmgCOxt5eHpft1F9t3fWtlbVpjAaM4jFRrLvvxzY39rjm79AiiojQQDdQbc42r
 gokqTk8uT2q6CDB0b00ECLV2f2rOjrFhmkkd3res9xxum2xWbiXM+ityXnAsuvne+1yS0Bt55
 BC+6ECs0LFuLjlqZ9qUJHPN8YDeJzHxznzikI0ec7AlW3/lgSYu0hOk8RhYpNGHg9yC54YRB0
 t6nFqimf7uwHvGeNljWw+6c0z9th8F+f1wzLcaB5ipXz6V7c9TIKIGFDXNcI6cs59q0VBC00w
 +UwtturhLeE4NedxLA08d77dEBqRCUmIXcxMwaDeZoXmQxfwWfe1l6ZDy1Zk7sVWya3Qo2K/R
 lZ0NUoWLM9EXVHJGTBsIrHHeBRALUAFUJFgk4sRvsK15Ew8beQAVnHNOYmqIqRbu7slZEmQC8
 x+Os11NdUf+zpGlxe3K3ROeHpMgNIGPSIdPDX22SRk7D8ARbevW5HffKFgSh3R1OHA/RHSB/N
 eidWpBQVx7TX91tDwLTRfeLBxNKAn62Fio6VE03etIPnpKhReaPOHT6yc9ub+dr5v/NVgwE/x
 6PvLT7pW/TlZY+EGCoNxbV75csv3s5of5X3Sj3kYpH915NE49gKH6/DbRWMPyK0zbZXz0vUSy
 zaI9xIhO2fQE9Y31vutnEq02EsNy8SwdrOyjeAUzIFPTA5nNIEp5B+sn3cOb+D12BAaczbB+T
 uhlbhn+YZGRVR6O+wD+XClzowwDWG8BmiUvcS4sRb18K8rtPj2ig==

Am 28.12.2024 um 20:23 schrieb Jeff King:
> On Sat, Dec 28, 2024 at 02:05:41PM -0500, Jeff King wrote:
>
>> So I suspect the race is actually trickier, and that the "weird state"
>> is not something that happens just while pthread_create() is being
>> called, but is actually running _in the thread itself_. So even though
>> pthread_create() has returned for each thread, they are still setting
>> themselves up before running.
>> [...]
>> So a full fix would actually require synchronization where we spawn eac=
h
>> thread, then wait for all of them to hit the barrier to declare
>> themselves ready, and then let them all start running. There is a
>> pthread_barrier type that would help with this, but we've never used it
>> before (so we'd probably need to at least provide a Windows compat
>> layer).
>
> So here's a fix that seems to work, but doesn't address the portability
> issues.

Windows has Synchronization Barriers.  Adding the following lines to
compat/win32/pthread.h at least lets your example compile and run:

#include <synchapi.h>
#define pthread_barrier_t SYNCHRONIZATION_BARRIER
#define PTHREAD_BARRIER_SERIAL_THREAD TRUE
#define pthread_barrier_init(b, a, c) return_0(InitializeSynchronizationBa=
rrier((b), (c), -1))
#define pthread_barrier_destroy(b) return_0(DeleteSynchronizationBarrier(b=
))
#define pthread_barrier_wait(b) EnterSynchronizationBarrier((b), 0)

Catching a non-NULL second argument to pthread_barrier_init() would be a
good idea in a production version.  Error handling would be a good idea
in general, but callers would then actually have to check those errors.

Synchronization Barriers were added with Windows 8 and Windows Server
2012, Git for Windows requires higher versions, so this native
mechanism should be usable.  Relevant links:

https://learn.microsoft.com/en-us/windows/win32/sync/synchronization-barri=
ers
https://github.com/git-for-windows/git/wiki/FAQ


However, macOS doesn't have pthread barriers.  Here's an implementation
that had to be fixed to satisfy Coverity, so it might be good now?

https://github.com/libusb/hidapi/blob/master/mac/hid.c

Perhaps that implementation could be used for Windows as well?  All
functions it uses are provided by compat/win32/pthread.h; not sure if
they are sufficiently fleshed out, though.

Ren=C3=A9
