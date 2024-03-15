Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373C50A6D
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529865; cv=none; b=a+pKBtIg7mu1B2Qh5Zp0Wwwb9P2VSg5qlXn6TIjge0AUbX2ZZHtf2trn7Mt41PPfBhtCD/dL08qHjDAW8umVafLI5evRXlB/hPK+z0XEDIzQdMULxaayz4sPk5EB+yipRQ6idbGdGvZC/rq99XYI5lg0GkuN+UvF+AvVkRtplDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529865; c=relaxed/simple;
	bh=LpV4Z2HTPDZ25Wm6JEfeB3XsDsuoSZEbzmSDs7MNf9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4boodMoYXfSjWyriIVatwrf28KNsKt785gzlIw/rdAPTcNgXhMqbsb9gb0SrJmzJ2EG90RpObXanKUJ6Odf8vnCBY+j2AK6Cy5dRl1b3aYGj9EV/ZQimIn0DU9MV3ojbGx96vENR5XFJaaq1msNBjyAB9I/zxZazCDK25M+f6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gjEe/SSu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gjEe/SSu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 559C31E9E3C;
	Fri, 15 Mar 2024 15:11:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LpV4Z2HTPDZ2
	5Wm6JEfeB3XsDsuoSZEbzmSDs7MNf9s=; b=gjEe/SSu6SpDZXdHWHjvbe9x0HDX
	er8/RAOsRt0extqZjCQkQ0nZahkGbg8WbJuIYQlwjywqMsdqQ7G9B5wAEEYH7c9c
	QRy1OzM/gYgDud61DNeoWVcDc2J5EqUZ88mFEaSdy2awNIJl6KU52hZHAyTuhANO
	l4jx97IULN/lfcg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 210161E9E3B;
	Fri, 15 Mar 2024 15:11:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F45D1E9E3A;
	Fri, 15 Mar 2024 15:11:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  "Christian Couder" <chriscool@tuxfamily.org>,
  "Emily Shaffer" <nasamuffin@google.com>,  "Josh Steadmon"
 <steadmon@google.com>,  rsbecker <rsbecker@nexbridge.com>,  "Christian
 Couder" <christian.couder@gmail.com>,  "Linus Arver" <linusa@google.com>,
  "Josh Soref" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
In-Reply-To: <75ff994e-f086-4490-a442-dcaa6e2230df@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 15 Mar 2024 19:26:13 +0100")
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
	<xmqqjzm3qumx.fsf@gitster.g>
	<75ff994e-f086-4490-a442-dcaa6e2230df@app.fastmail.com>
Date: Fri, 15 Mar 2024 12:10:59 -0700
Message-ID: <xmqqzfuzpayk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C276858C-E2FF-11EE-B003-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> I=E2=80=99m the only common CC on these two. Maybe dropping me for the =
possible
> next round would fix it. Would be interesting to see.

But there is nothing strange in your name or address.  There may be
"something" that confuses GGG about how they spelled your name and
address, and if the next user does that same "something" for some
other recipient, it wouldn't be you but that other recipient with
the same issue, I am afraid.

