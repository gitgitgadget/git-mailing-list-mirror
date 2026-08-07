Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE8339B41
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137072; cv=none; b=j4uKX8OLM8TVHpaBVWAhftxnR9oXhoYTWw98j2L0HjFFsdQqvu2LU3D9xZ89/HvJ2X5TCdzGpHiiFshUr+BK3nYCRwzf2CRIDALwNc5OgVvW/rUDfCCDHMTAU2VANVjXuXGvniLYxFk361vK5xWFh1YK3sh74WbAExVrQlcC7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137072; c=relaxed/simple;
	bh=RS1LAQPWOsxwZ7AvNIPNDQwpEEENymDKZJ3PiFVOSOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmJ2jyr3hFQSNZHGB19NzGS14/zmGD0V7BYL59iyGJTTobcM2sVMwkdq+CFOSywqPmKwxXGK8T9xBKvZjcXU3fEqZ/wLKouqv5wvPSxkl2m/F6Jp+8eLZthIdJ69LeCMQ/mI95YOWmjJxOrih07b5He9CSOXH/6EqcsU0sksjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bWM6j0jq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SRmEobfR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bWM6j0jq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SRmEobfR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C43B01D0012E;
	Fri,  7 Aug 2026 17:11:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 07 Aug 2026 17:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786137070;
	 x=1786223470; bh=Cbb0nesWizRqHjUaWc4OMSr9/x2Vn24DODzqXiwoC4Q=; b=
	bWM6j0jqKqU6CbDh1vm1IZSnKfXJnWi6eNHzw/1G+hrDYm8QZ6QbbRh0ZnQ1/DWK
	V2b2Y5vh65MpnptKwhK5qPmrlmQFarP9M5yRVOsBomq2zJ8oqNVebADuVFWWtiYB
	0g8f8X3vay7S7oKD96gl0Zb9j9fTr/ZNcBwmd+xzt5FkDn3tdlTl+HeEwWc/LDFU
	kQx1zZ0bVoCCZEkEWUkk5hL9S0QdffcrlPeM8bR2mdM6HRAsTlZwVfGVSaNgBFrT
	b+23uiEf91JytbaLl934r4Z/UOXmhbj9Ba6TSgTZQkHBGRI79lsnSnJ5vjng179p
	dCt7no34obrHgtWj5JYxwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786137070; x=
	1786223470; bh=Cbb0nesWizRqHjUaWc4OMSr9/x2Vn24DODzqXiwoC4Q=; b=S
	RmEobfRB2ZI45o573B5TrcNx5TVxtusUf/ypMibjC3gcPEvKVaUtOdpA7wsZgm/W
	qhhfd2J1dnn5iq1FyADJ0K1pdao50ErkIL+sQwCHDuSXA9cQVGCPCDBoz+wYImwS
	rrRzHy3kqApPsqf1rcoExdJeMqfhPPCAODUHmhy/ShYkjDvM4VQEMLzc2yLApeIu
	XJ4FAqtNoa2sIXUxMakd36SfV8I1JFbpemPjJ/vH1MSinu9aM6jE/dAAZaDpsL3u
	x62T/T2b9c4meNGaJF6GdL58YvDnYXFXS8fiwIMzJLXT/eImOzjO2bmo8d0Sk8RL
	8dnAJJErE60/U3zEmCdUQ==
X-ME-Sender: <xms:7kl2aryVTzcOqdjoY3nWgCC6fSON3cia2Q7oPof7osxCrTF2SPIQBg>
    <xme:7kl2aqRp6IGU1W6FDtgILwI08krtpYiy2ge2ijnWWkvx6VsVzgTIFs0enI67BQgmR
    Ekewsem1H1v1GIfJrAPWtS6TtOqCZUC-vT8PR4jRwAfSF1_LoYOJKI>
X-ME-Received: <xmr:7kl2aqVg-Cc_nkvOsi-nuShXaoCZ1cxyd9MIPGRiZnKJxgslAaQp7C_lHWvJeIvuHKqL-f5x2ueMqs4khdoOpAVggNQawPd_rw>
X-ME-Proxy-Cause: dmFkZTF6dgcjJsk1DUmm3DG6OLrdC9wn2OK5j5OODnRwCOmHWx080oeLhZQH+2dxWgjWP1
    tOeFBCTReWxRJa0t5UmO/tSNq+HxN2qXqO/9eNx9KmicvCdwrDrLQJEvVuU58QeEiR8cuj
    Mc3SQSPzeonMJQqjvauh+8ATpu27TJPt9FlFEc5baQXwAYgmDNvNCuaFiUS3p8ClBXZok1
    DR2ugvTpOc+OEvw5UWfWrMeyPAT4gB13+VzHaqbaBd+PBELOiZ5eqx+Zs0RUIxR6VQjnJ4
    6l4k+pxcvQ4NNraCeSJqm/RNNJhbhOUE6pdXwjy/OvqCvnZXB5aOTThix/Hdkdo44gB+RQ
    voEhHJoX1wJL+YFWfJxCWEC88OLV2WERv5mYOAn1zdZyBkCyAKqHpTa4tedI2u89AU73nS
    U0X1yd/J98day3r+21OYZlClDAyLk7nu5HqE+gief0YiIJKOzRBoCg2tV+ZGJeymmsAkBf
    VFxAxaXWTo+NTmKmJg2njQVkngJ3fpoEfNPTViQbq+F5o9E7qJtdQRXvf2TTA8ovZo82EC
    LjToi9GxjBKj9X5RTdcEsBm4pZ1qr6S8mECSe4knBbJ0eHmWKMZsy5DaU4I1u0vi329Ecb
    +GtkN6DETUN566Ci73IUfm3fyrUgji+PjywoetruIDXedKfMr7jSe/hKtYrA
X-ME-Proxy: <xmx:7kl2akZy0TKi_q54xKZ9Xo94TeilWVlIMuCj0oCPJevA0UMWhXDVEw>
    <xmx:7kl2ao3BoYm8Y5-bz4rHijPrNcSlJL2C-WWjKFMDqVFv7IX6Oa80pg>
    <xmx:7kl2auhkVvCwT3sAgem3fBq_nYU0mCi1r01qc0vJt0ggu4007GCsGA>
    <xmx:7kl2akZ6PLGRRJ6f-E1UkjmWb34BM4RxSsjxVuifVhb7Q27K7HNyhA>
    <xmx:7kl2av5vTv8383kQHOsuiL8zGFgNopYJE4vzwSuu8taXrA81l35w3lfX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 17:11:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] environment: clean up repository config handling
In-Reply-To: <anW7wHfUxYj9cj0P@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Aug 2026 13:04:32 +0200")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260807085932.3958759-1-cat@malon.dev> <anW7wHfUxYj9cj0P@pks.im>
Date: Fri, 07 Aug 2026 14:11:08 -0700
Message-ID: <xmqq1pc9eivn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 07, 2026 at 04:59:29PM +0800, Tian Yuchen wrote:
>> Hi all,
>> 
>> This series contains several cleanup patches for repository configuration
>> handling.
>> 
>> No functional changes are intended. The patches make the related code
>> more consistent and easier to maintain by improving documentation,
>> formatting, and the organization of repo_config_values.
>> 
>> RFC:
>> If there are other small cleanups in this area that would be useful to
>> include, suggestions are welcome.
>
> Somewhat unrelated to this patch series, but I was wondering whether you
> plan to drop the limitation in `repo_config_values()` that requires that
> the passed-in repository is `the_repository`. This limitation is
> starting to create problems as more and more of our infrastructure is
> migrating into `struct repo_config_values`, so using a different repo
> than `the_repository` is starting to become harder and harder in our
> codebase.
>
> Thanks!
>
> Patrick

Hmph, that is an interesting point.  What is our plan to really
enable the use of repository instances other than 'the_repository'
here?  They of course need to be initialized with repo_init(),
but is that enough to sensibly use the embedded 'repo_settings'
and 'repo_config_values' structures?  (By the way, it is not
entirely clear to me why we need both and how we sift variables
between them.)  Some code paths need to work outside a repository
and still need to know about per-user or per-system settings.
We were perfectly happy reading from global variables when we had
the majority of them there.  It is my understanding that they are
now found in 'repo_config_values' or 'repo_settings' associated
with 'the_repository', which I think is something we cannot
really avoid doing.  Unless we try to get rid of 'the_repository'
and instead have free-standing 'repo_settings' and
'repo_config_values' structures that are not tied to any
repository instance, we are back to depending on a set of global
variables. 😞

In any case, all of that has little to do with this series, I
suspect, unless we are redesigning these configurations and
settings in such a way that they are not necessarily tied to
any repository instance.  While I do not know the exact details,
I can imagine a hierarchical system where system- and
user-wide sets of setting values are known independently of any
repository, only to be overridden by per-repository settings
using a last-one-wins strategy at lookup time.
