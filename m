Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B081EAD3
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708295800; cv=none; b=PmiKpfZMJh7vxsuKZt4no6jDYslk3YXEIKrUZc26MscJgvypTsl3zvqU+pf5ZKvl+X4+yz0uLrZVjdF91ARbR14HHrUbNMXjZZnqKQdx6btNfXhSZH1H/P0swyuN052uh20skaFD3a3s79gHvN/VcQaTfWXap5pk2tG4h8dKRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708295800; c=relaxed/simple;
	bh=SJBW2rZH9cAiIIVo6Bjo9/jfAGmM6KWDdEcdssZTLQk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RXLkc/wIrHJjcZHlHNPJhUrghX3cb5md0KZPYsUlQFXyn8Vct5Np8Qx/PiTDqRi4kUreCUxU8kDZJ6IRc2pa09FPMdfmmlqrcMi2r2jyxuiv/DJylXi/f5lbjyT2wU2C/fT/l/J7eYzcteZBnwVhR+HRlmyW5Xz8RguJFhBKfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=bqAkTyo+; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="bqAkTyo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708295795; x=1708900595; i=johannes.schindelin@gmx.de;
	bh=SJBW2rZH9cAiIIVo6Bjo9/jfAGmM6KWDdEcdssZTLQk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=bqAkTyo+dX74PXIGKVjVlQWysOCdfXCShmVkDL2ajbmwNASJYVpRpCIMXIkbmCqR
	 tBZ2rEc20sWUop0m9VW8yQ3DnexM9hBOk4EM/ysqMWgt53JXAieW9mHxov5jPUgRm
	 c91poBS8Vn3De2LSpCdPhnDowrVp0l+FOFPcmCyQSqm2F4aINDCMVMpSYoNR57H9W
	 mgGCY2v3Rbv4uUlbiXSrrAVQ/VCuZwDdVDfEg4sr4lSjLZVwU71NGysmCKTDBM+0I
	 XQd3nVjHbA8EBtNfTOH9UHjzhhFNA6wrsLWmVjlzlP3M2eXraphxFIkSleVdrZJv4
	 RkNOSM2s1aWE8D7Rvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1rf8d50uXk-003LDI; Sun, 18
 Feb 2024 23:36:35 +0100
Date: Sun, 18 Feb 2024 23:36:33 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Teng Long <dyroneteng@gmail.com>
cc: gitgitgadget@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Always check the return value of
 `repo_read_object_file()`
In-Reply-To: <20240216064326.89551-1-tenglong.tl@alibaba-inc.com>
Message-ID: <63f7fc07-56b3-a271-e469-e9e230c9c2ae@gmx.de>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com> <20240216064326.89551-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QV2CDUOz2xQvimdGecvc1CSXxHCimkcPGlaw9qQrlhM+DeGVsVM
 +JZQPNCDgAUHzq0sETxB8R8CGvF31JxpmcA8kml6GWPamY5xsFK74cctdpQmX4b7V41lkJz
 cSOd3VJDEjTn3pQPn2ZHHGz3p+Y1MXWsIpEKhvwRe6cY7dyJXuitbG6w4zq4QKRv4W7Sui/
 wtEkI9aEovngljZFWJGEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nY5w2bpe/lE=;AvMutVTbwgz9G1f4IXBh9NWDfta
 3y2p7w5r/8+FHFdpbziY1HOx8FTvLdeCWZoGde0IOmZ3egbgB29Y4ikVtPdUPailPX+ZE1MLx
 87k2hModDk+mdF6BzYVjvHSrCuZcHrE6idV9TtM8iourpXRRBR4JZnHriIX3mMlARR0412iE5
 mcItxZd84BiTi2pSGO/PsjUTHSdvGhJ9j9x1Nt5nzu1ZxmlJQi0YqVp3QwYRMSh7p90AJUlht
 6Hcdsll+h/OG+q9S/cYuvgRloRXWiZZCCdiN3nCzke9GJpMiSK6WxXJtWNUgLgAAW4sJ5xu3Q
 u6VdqN4YVWKh+D5nnRhD/b5muM9sQCM2LQRqE6ObHQverioS82B/fFGOzl+MkRILfI/k34Aim
 FDDkns9Jcj+LrlNu2O+PLnWoSvjpa5LbGkYR0LCmWApfgK/lFF7oJ7i3VuQ7Oixu6P6MUwV8U
 l31ASrc/mKeVB8zXzIwf55HYMHhnUZfxB51ZzJtOqgAxeNieU8PM9LJjJKbyC0PhMD03VjBKk
 Eq3YR/nOhpAcjJAe2oY7b2UZMo/W3xRbWJOYMb4PdH2Okd7HwdO81WzGdcUgXhY7BtdBNVymL
 pB+itmwPyDfaWXKD4HJLbGgRcKX6HmER8frczWRH+Ll00pa76CDy06GBeCERl7QVDEJz7gRqf
 qT9Axst0l++dLDWqO1h+AKiDVuaeKHT5waHTZjvKt4VXucvSZc3fHorSb6e6SxUGGMIc9b5XU
 Ds/muWAKVFmpUh4T+XWzl3j0vkxUx/NFBdFuISziVW2CukS6HzyvpyT3QbuyaNxuEZTLoO5QK
 R6F6/ytegH7svS6nEZNxa+dPTdqH96XFUdbLgEnpmnHVU=
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 16 Feb 2024, Teng Long wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> wrote on Mon, 05 Feb 20=
24:
>
> Hi, when I do zh_CN l10n work for 2.44, I found some check changes like:
>
>     die(_("unable to read tree %s")
>
> in patchset, some old code for this like work is similar but with parent=
heses
> surrounded with the OID parameter:
>
>    die(_("unable to read tree (%s)")

FWIW I copied the error message from
https://github.com/git/git/blob/v2.43.0/tree-walk.c#L103, but only now
realized that it is untranslated.

> I think it's really a small nit, I don't think it's a requirement to imm=
ediately
> optimize, they're just some small printing consistency formatting issues=
, so make
> some small tips here.

Thank you for paying attention. I agree that it would be good to make
Git's error messages consistent, even if I sadly won't be able to focus on
that due to changes at my dayjob.

Ciao,
Johannes
