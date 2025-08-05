Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F981DD525
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412932; cv=none; b=n0QwrKTncpavMjFC6AZPXcL2+YfnVVrtf5NVZI+gt7/i8jLZKzkvLgQ2kDrib0wFeuzudOV6NIHySrj87D9VF6ki2Ro98FJrI9hyZ4zrlgcIcP/Mbz/iuZzeF7VBxVvL/S75IX89KGfWdrdXXyygk8u5EzNn94akDJV6X1bMPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412932; c=relaxed/simple;
	bh=4ADoacT/G6eH6dnoWjDOQF2Z/I/N2l7YGjyAT/L1V80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oC49qwfE+D4Z00L0PT/+ZjN6NuyevyWnjB9oSrdKQxYnB6fX90ceiVDFG2/WbnmNyFz0TYQsItMHrMbIMom5GdllJYKu6jaTaKLGJotKR44RBGOsXo+/cwdNRn8cyGikcf8r4cCd0FGOyvhA1ulIQEx9cj2ZyMSP4KUtpMcUw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qZegufRP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qZegufRP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754412924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY1zfuSNe+GHYXT45jgE/Qw1fduUti35gX3bsbonujc=;
	b=qZegufRPO1lJbFzJQzY+xl9sE+pMtNciIi4u5we8NrQxoRCdhp+vvPNfG/awgaL3uee1xy
	vcuVJ4hpU2YpP2qHYjI74ADEJ+2DajpKwxNj/KhJrH2EyK7+2gZe51twuDdWd6uMKKFzl3
	meRN6PMo/JM/HbIHHxiSzd0e3Mj+g60=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <xmqqjz3h20cs.fsf@gitster.g>
References: <20250730175510.987383-1-toon@iotcl.com>
 <20250805093358.1791633-1-toon@iotcl.com> <xmqqjz3h20cs.fsf@gitster.g>
Date: Tue, 05 Aug 2025 18:55:14 +0200
Message-ID: <87tt2lu2rx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> I am happy with the updates, but am wondering if documentation
> update along the lines of attached patch is also needed.

Ah (annoyed grunt), I should have added backticks. Yes. I missed those,
sorry about that.

> I am not sure about the last two, i.e. things that are not dash+option
> appearing as enumeration labels, though (and Cc'ing Jean-No=C3=ABl to ask
> for help).

Well, this gave me a nice opportunity to test Jean-No=C3=ABl proposed docs
linter[1].

    $ make check-docs
    [snip
    git-last-modified.adoc:25: '-r::' synopsis style and definition list it=
em not backquoted
    git-last-modified.adoc:26: '--recursive::' synopsis style and definitio=
n list item not backquoted
    git-last-modified.adoc:30: '-t::' synopsis style and definition list it=
em not backquoted
    git-last-modified.adoc:31: '--show-trees::' synopsis style and definiti=
on list item not backquoted

It seems only dashed options should be backquoted.

[1]: https://lore.kernel.org/git/pull.1945.git.1754399033.gitgitgadget@gmai=
l.com/

--=20
Cheers,
Toon
