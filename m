Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707673DA7D8
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132769; cv=none; b=q8cxBjBSs0j/c60F0k3aZoVu5U7IFxl5iagdtEfOAxI3P714VJS/1qTZuNfxAWNl1tjK3IJPIQdtTITC45fbS14GI9EFArnQ9RCFUmQ9qCzpz94+XoYa1XFJFS5MnS2Tkn/ZhR2axfc5wN/Wkl14eI5It5m4G0xGybTf6Of8XCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132769; c=relaxed/simple;
	bh=Dqb0QfqonmsSG+7P2vXih9t/lYq5vaXCmo+HF9tFY4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a8T3SDbLt4olejjOzenzV40SEHUUQpTuc8lCyZgnPV9iO29Qm8QVPG19TofFQxJqmzK84+Je9t3kLFIKI5UsmkaDU/xi+wjmgqCu3qCtUhOZ/84M+GAyKN7KJXzb6q/NYoFhJErc+D0Oo6sQrw70ciqDjBwvVMbQvEJawtHysbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s0ACdFJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oMzKTdW8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s0ACdFJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMzKTdW8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 50D8B1D001DD;
	Thu, 26 Feb 2026 14:06:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Feb 2026 14:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772132762; x=1772219162; bh=AtcCx6O2M9
	IRKukA2hslD1DpDZki6HbCoHtXdIt15AU=; b=s0ACdFJmfXMkZ5l7mooMeLgQ5f
	VmIAu94FMm/zxRjEB9fvYLYdGk8aLTHGIsy8XWmxx9T0B/wruhSnPR5bXWENHcOn
	g19M/teVP4BD+R8GV5JttOMWd/odzrwf+3DD1CODjjUj4QrBAMnkphlq5+aOEZJI
	0E3N9BmODwoMdtZCH3ZnE60/tv5pQHsoKlo12N2adMUa1DUfGMpdwAtuTzKiKvyA
	H/EU+iDF64pnEUobQCXHdqtuWFW61wQpd9hs5COqgSwsUXwNzf0oRtHOn5RQaFHx
	yuTFoJYVkyWof5q2hRYjhy/ZaiKr0a4p+RhdV+d7V81nbN56fyqAOeEZ3JkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772132762; x=1772219162; bh=AtcCx6O2M9IRKukA2hslD1DpDZki6HbCoHt
	XdIt15AU=; b=oMzKTdW89McRThcPRBS65GnqI+s/pdfadA1BmjqVLDkIKjikRUN
	V3dM1vHRqtz5pcVRxqJAAy1kiOaaSLwbBk2/DLWrTwJvj+XESTEB/nPLUY6O9Ybs
	hxH79TNSWiaZuIhDqBO9otKV2WDTCYQtW3No4nT0xj0E3uGWBDAdRUMoMhfcf1X4
	MSV4+6d2CF+U77tbIhjLiR+hDGHKu1raS6f2aUuUBSffro6MSq+JdJp5H1ZFy4fP
	eUtEP7qO8hsdI5U/21Eyfs2EqFYYWuNeOR4ksLOkeuQsmFB35A2GFz9uikV66e6o
	IGs9nwifjPv7yk30RQl2jtPhUFatgyYSfAQ==
X-ME-Sender: <xms:mZmgadDGdudp1d-L8CwIEaoEhgTHZpjsb63BSGKOz3a0KVt3GV28Qw>
    <xme:mZmgaSZtHgcXcMYJF5Mn4qqBOC4XGV9wpCKUtSJkqeHdwfC3moL2uDSyihWTdCrNN
    RgFdY9Sv3dFq8G5jSyJUhrbNgzeXDMODO9i1QYAvhePMrkJ4viZ>
X-ME-Received: <xmr:mZmgaQ4wH5SelhgAGZvHKf0uHnOy7S1ukP3ZxMgqp2dwN44KFdC6fI2yYQDDSOdMymOZOHo9PGZlbv_Qv3DsoImHD0nl9sUdhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeikeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhiphhorghklhgvhiesihgvvg
    drvghmrghilhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mpmgaTY0_QwNmtkIB3Feged9EadCxS6hEzLaWLpALXO62MmFx4glHQ>
    <xmx:mpmgafh7lS9MJaw4sWOH83xXthWIFAyCKfW9u8npC-W6zrPuAVJVcw>
    <xmx:mpmgaU_youx9fJt3wYMWXrLhPTWCquQ1LJt9W4nNtuS1BQSrooGz-A>
    <xmx:mpmgaaptIWAdVtlzMZSqE3RHSv-f83QfmQcXGjA8x-ckJ2kvXsRzsg>
    <xmx:mpmgaZyXskZwe6I8V1cJWXu5GXU8-od7rMVD0UKMbsXczHAoP0du2xkj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 14:06:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  philipoakley@iee.email
Subject: Re: [PATCH v3] send-email: validate charset name in 8bit encoding
 prompt
In-Reply-To: <xmqq8qcf2vk8.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	26 Feb 2026 10:45:11 -0800")
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260226165559.187261-1-shreyanshpaliwalcmsmn@gmail.com>
	<xmqq8qcf2vk8.fsf@gitster.g>
Date: Thu, 26 Feb 2026 11:06:00 -0800
Message-ID: <xmqq4in32ulj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index cd4b316ddc..3230b80701 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -23,6 +23,7 @@
>>  use Git::LoadCPAN::Error qw(:try);
>>  use Git;
>>  use Git::I18N;
>> +use Encode qw(find_encoding);
>
> I wonder how common is this module already installed on users'
> systems (not asking "how widely available"---which is "can users
> easily make it work?", but asking "would this work out of box with
> what users already have?").

Answering my own question: "yes".

We use Encode::find_encoding as well as Encode::{de,en}code in
gitweb and git-svn, so it is very likely that anybody who has a full
installation of Git would already have it on their system.  Also
Encode.pm is distributed as part of Perl itself, if I am not
mistaken.

