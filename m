Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703E19B3F9
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927434; cv=none; b=I7tHH4fV6+bC0iWlkA7coM5ew4PrCiuKhgoqGfUDNujKt/2bBs/sSVy11L0QfCdqwtUhD7tJ2EaSpGDZMCvmsXHZ873h1vBUZ0ByNw8GNkmBCa6Yp9JSltRznt+XWOeF74lo1B+NYZ5cYkePUYgFIlhRdJt0xJiA9b8eSZ+9i0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927434; c=relaxed/simple;
	bh=TIkpemJRVz0sclFSlP8oq1QqMOe1Jvki+/VxAONRps4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2TCaxFNmF8CobgbEB1ekS7Au9e2QbBOv+sIGd6nZO/cA9yu+XEs62tc1KNWzXchLHyjd//+6pLRsJ77P/mt6t8axb+QSbRPDW07eG6O6i+Y0w8mGgvnGiXFR0AnMdwc7RDxO/4k1iyWxrPgZbXWDcuy6BVOCSHWdUUSBVO8C/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eh5SZnoD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eh5SZnoD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A53B1A816;
	Thu, 25 Jul 2024 13:10:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TIkpemJRVz0s
	clFSlP8oq1QqMOe1Jvki+/VxAONRps4=; b=Eh5SZnoDxcwb6pI2oZu7jIvzw1zI
	nrT56xrOOirPHotAMwJLz2BhV19EVDyVBU2YkuIJD4xyqp0inWiczZlv6hrSOLE/
	D7OTTX57ykXypYR4cVdhk2E60TzK754iglU8njIDfuclADw4j+JZXPnBrOYKqNgR
	05BasUBNWLhodEk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CC141A815;
	Thu, 25 Jul 2024 13:10:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E55021A813;
	Thu, 25 Jul 2024 13:10:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "David Disseldorp" <ddiss@suse.de>,  "Teng Long" <dyroneteng@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3301-notes: check editor isn't invoked for empty
 notes add
In-Reply-To: <5fdccb84-1e60-477e-99d9-b22e3ef83f54@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 25 Jul 2024 17:52:25 +0200")
References: <20240725144548.3434-1-ddiss@suse.de>
	<20240725144548.3434-2-ddiss@suse.de>
	<5fdccb84-1e60-477e-99d9-b22e3ef83f54@app.fastmail.com>
Date: Thu, 25 Jul 2024 10:10:27 -0700
Message-ID: <xmqqv80tfldo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CAD2BADC-4AA8-11EF-A8C2-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Introducing a regression test in one patch and then fixing the bug (and
> making the test pass) in the next patch is a style that some prefer. Bu=
t
> I have received feedback before that it=E2=80=99s best to avoid that.

Especially for something very small like this topic, yes.
