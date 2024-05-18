Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62632125BA
	for <git@vger.kernel.org>; Sat, 18 May 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716063230; cv=none; b=PT7bMdVlPbSfQcyl0TYvulB+/KepOuoLK2krGAXnaRkdikQHEg4cUwwsAxPfF9Uwuw2aARmm2EGWfashshYme+FzibRfUf8nZ6LXxCyP0kSvb3KpQi2m3VK21ZEEj8OIgZdxixFW20f550N9jiwxgUb16nx6BKYLjwHM88mbMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716063230; c=relaxed/simple;
	bh=6Q4yzqtSylpjwWgM/+wVmvyA5uQ03HZbcdJdm3uu4EQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KaWXtqFutCMK/jUtsMvIsJhLrV+FemktloAthrQpjPhlh430+Feqp5Jc7lO4byk0/JXMwBOFxdd+f4sf0XfRL0zy/W/AgfhflCvcKxEeTvLEZfh0ZQnHestTZnZECs/EobyDbLZo5Vdsorl183ZPuwJKhiMmjgF+g9+8JluZ1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZnsSuNop; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZnsSuNop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716063217; x=1716668017;
	i=johannes.schindelin@gmx.de;
	bh=68ioycJle6EhydxhNPtvxo/LAd3GWbyI3y5KNi/rYqo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZnsSuNopkwOouzG2Y2TKvSrTv0w3Qvs+XndTBdTQc/UUBndT+NzVBSlH9uMdUtTK
	 0eb5oIjjZkjJUH/btOKsC8EB4NlVq5mElNI24qUyQ9tj41QBgghmzeIiV276BCGG2
	 ImR7UccWaQR1eTVjeqh2Q1oxsX6DNmyyMURe5tdK6Z2+dWIY3kDOsvS35bMwsMvTb
	 rtYibfmSf9M27W63o+E4qabdRW1f54MTrmpYCycRm1hoX9e+aRpgmR0GisVPtiSTl
	 30nPVuj4wiMScvgVMW+3gtdKsF2VcNOFWlWRGhu9zK984m+oy2Y71xKS6u3VJPTIO
	 Iq1ZsjpnL+i8d3YX7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlXK-1ssFIk37m2-00jqQm; Sat, 18
 May 2024 22:13:36 +0200
Date: Sat, 18 May 2024 22:13:34 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/8] Various fixes for v2.45.1 and friends
In-Reply-To: <c67780c5-ab50-37f0-a507-91e8b721b349@gmx.de>
Message-ID: <c3c2e460-e992-d7f9-754c-3c8c0aaca488@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <xmqqy187nj4u.fsf@gitster.g> <c67780c5-ab50-37f0-a507-91e8b721b349@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NpbJo0nrWtmdx3CrNPOMuhPLR8AHcSMLfD+L/xWmae1OxPL9FOS
 BO9hgDwyLA1A6JUPb1ppkexPmhHpo172yhhKjMcKmjhQgq86CRUhtinBrBce/VYhTQiGhn1
 GVaoI8dWnjNbWBsV0F4iPToJmoMUJ3S0JKlCIi89PTG4JN5I2RelfSHTi86kdVTmqHpuLOh
 RqVNeYKUKbaBP5nVolMGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:spHnk8TDjh4=;6w8B2zi+G+YaHdJO38s3XpO7Dnc
 t+d7XgDIf5m3ibjojkW6HM//BcLwe+DSVrRO0ZuxtBOudNC801r7HeNhB8Oi1KApxumQRnJ9Q
 gmjNPFs9ENRMaEKRL/EtcPi416bW9J5BeOA0vu2zgRpJTEvyZSgJFPwFOU6DxRKv2nhXd3YtY
 DLLqPq+VnqSc+1DiwiHai63rDHpc1qkFwM+D2INqXD5nV4wxdtfT7ApL1BGyJ72kwF74kJHeN
 PxbO441PpUzg5X0rHcli7BjYNdQDf74M/kjVoPYS8ow3o311QqXKXiDMlbV73rpQko6pz+LGr
 9ypmxQiSTaFdZfvlXLzwwdXs8CMkAgmockgLuZOJ6yS00BmD3b5IoJC1VMuG2yH45zQBfvv1Q
 JjpcP5EVNfVPAMCsYP/UlId42YbpPhPAybqtyuvu2ji2aAP5074doi0D3BxXYbdaHk8Vdq/AV
 ETbJLsBQWh1Gz7se1SwKuX8aeaYsVT3qRXkejr+DW/4NYVefQrQTVLJAvEk0ALFMIHQYiJAj4
 +1VXa5sL6bV/5C7Wcrt8bW1ZNcxSjqrVZ0RmV1xMaaScsCubegTWoKHSoxhxyDALHKAvxtfO9
 tO3qdbepy/UD+wAychkxtK8SNdRLmwX57xQqPE0k1B7vmEzA6GaRQtvLdwWg1+bX9YFDgu3Ky
 ZCzBkOHrgX6+lDWh0cZdI5du7Kr1AWQJTsup1XEJPf27iJs29qdmKJp8xbTWvOWbu6BVickSk
 7+RwGPLW9Fgk3Av+VZAjOcR4Oar3KZ4d47d5ujYEMMtHKhXNbEGRyzM9Da0nHJ4xlXk4kMual
 IYPFahj/tH3RChkiE7op4ygsi/vAN9mMVQEhlFKDvAr7A=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 18 May 2024, Johannes Schindelin wrote:

> On Sat, 18 May 2024, Junio C Hamano wrote:
>
> > I have applied this to maint-2.39 and then merged them up to the
> > maintenance tracks.  The results will be pushed out to the "split
> > out" repository at
> >
> >     https://github.com/gitster/git/
> >
> > as these branches:
> >
> >     js/fix-clone-w-hooks-2.39
> >     js/fix-clone-w-hooks-2.40
> >     js/fix-clone-w-hooks-2.41
> >     js/fix-clone-w-hooks-2.42
> >     js/fix-clone-w-hooks-2.43
> >     js/fix-clone-w-hooks-2.44
> >     js/fix-clone-w-hooks-2.45
>
> Thank you!
>
> As it happens, I had already worked on tentative/maint-* branches (that
> you can see here: https://github.com/dscho/git/branches/active), but
> had to take a break before finalizing them.
>
> The major difference I see is that js/fix-clone-w-hooks-2.41 still
> declares `do_files_match()` in `setup.h` (even if it is no longer define=
d
> or called), and that `hook.c` includes `copy.h` (but that is no longer
> needed), and that `setup.h` includes `hook.h` (but that's not needed
> either).
>
> While comparing, I noticed that I had missed an extra empty line in my
> merge conflict resolutions, a `grep` -> `test_grep` conversation and an
> `UNUSED` attribute for the `ctx` parameter of the `safe_hook_cb()`
> function. So I am really grateful that you did those integrations
> independently.
>
> You will also note that I tentatively added commits to mark v2.39.5, ...=
,
> v2.45.2 ready for tagging, along with release notes, just so we can hit
> the ground running as soon as reviews settle down.

Oh, I forgot to mention that I also integrated backports of some CI fixes
into the `tentative/maint-*` branches, to let the `osx-gcc` job pass
again.

Ciao,
Johannes
>
