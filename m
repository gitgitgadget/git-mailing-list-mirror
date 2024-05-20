Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12028E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221080; cv=none; b=benxDVzIDXqvrQ4Fv946Yqm1+j9KUqb2/0pjppeEmRaoqdg3C4M+daKPvPHihfp49WsSa5Mbtq0VlEPX2EE/xPUZBZIsJEcJiEl2kUuzw2YFvvDkWed37Jb9sWeCGpIrRkywjvx72ivgWpCjeLSpKmTPB2Rg7Vf8fZfkiEFytzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221080; c=relaxed/simple;
	bh=+bnfgawvHQeUwQ2zxeDTas6dF2OUYlGnvqm4m4F6seg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHzXQOXxYiOANVE3xVoMkR0e+N1q16h6jiWgzHJXNqmthTcAv/5A4kpofrkvYGIg+hg7Di/IeWWTtr6JgP0rBSDTav0wNfBgs2x0QrcMshjDStrEggDp/i/g7gmt3IxIxjsxd0X4fDGGhWJ8TfC+KJ8TNTfzbAASYZCCXERhZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TLbPed1B; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TLbPed1B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E92126EE1;
	Mon, 20 May 2024 12:04:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+bnfgawvHQeUwQ2zxeDTas6dF2OUYlGnvqm4m4
	F6seg=; b=TLbPed1BQgU/zqd95UbZ0HAz4WKymyTMDDO36CMX+pewz72RsNScYo
	qZ9HzYyDCyIEZkyom6IZK95cYknWb97sVAdn7vsUrJ6gUJV0oO3G1U0ITMD2nz7O
	xeiOJtIvLopNL+KV03O+9XneX6AC2FvzSXVdLn7y2YykJDB5uWZ1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6715926EE0;
	Mon, 20 May 2024 12:04:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD4F526EDF;
	Mon, 20 May 2024 12:04:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: chainlint test failing on Linux sparc64
In-Reply-To: <46caaa2d204844cbe5625428ece5b2fe8656364b.camel@physik.fu-berlin.de>
	(John Paul Adrian Glaubitz's message of "Mon, 20 May 2024 13:02:46
	+0200")
References: <8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
	<CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
	<054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
	<bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
	<CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
	<CAPig+cQLsUTpjiZ_TXh2GJAS=tJScUWYxiuR87rtwdTu8H9PXw@mail.gmail.com>
	<7acbd5c6c68bd7ba020e2d1cc457a8954fd6edf4.camel@physik.fu-berlin.de>
	<46caaa2d204844cbe5625428ece5b2fe8656364b.camel@physik.fu-berlin.de>
Date: Mon, 20 May 2024 09:04:30 -0700
Message-ID: <xmqq4jasmpv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A4E82466-16C2-11EF-B9E5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> Hi Eric,
> ...
> In order to verify this theory, I made the following temporary change:
>
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index 556ee91a15..63cac942ac 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -718,7 +718,7 @@ sub ncores {
>         # Windows
>         return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
>         # Linux / MSYS2 / Cygwin / WSL
> -       do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
> +       do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:||^CPU[\d]*:/, <>)); } if -r '/proc/cpuinfo';
>         # macOS & BSD
>         return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
>         return 1;
>
> and I confirm that this fixes the problem.
>
> Let me whip up a patch and post it here.

Thanks for working so well together.  Very much appreciated.
