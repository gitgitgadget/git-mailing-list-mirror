Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAA1E4AD
	for <git@vger.kernel.org>; Thu, 30 May 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079618; cv=none; b=jgODPlj2ySXHbL/QsEZCTlYiEpXiOJ+vQ1YTvB7x1JXqGVdfqUDjVHgv3oPI/PqM32evgBKKbsv417HjyfTv0F1fWMpeAx7eVB2ws4EOpScMjwKhbuVbFzS5kXAlJKGoNrjnrKp4/Ea2MNGSHX2LbxgavDs8cL4TDa8ACAl9hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079618; c=relaxed/simple;
	bh=ewjrlwJlKTSYUkqHdkHc0QZH9MYoMFtbYc3XZbJDM6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VYRv9bGYLT6pRrIM1gy+G8ZHK3o+JEc5Iht3GQRsDXQDD6uhy8ow5s0GLFjDPxCIV0F2PLBf/Z66sj20qKRYZLavCm+ftpk430GmLAGwrjqYfUWo8YfzPFpzacRea5nIrcsaDV8eWOKF1WWQiYINhWPD6UJO0i+qnlMKBX6s7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iHpzmY0I; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iHpzmY0I"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9B133A921;
	Thu, 30 May 2024 10:33:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ewjrlwJlKTSY
	UkqHdkHc0QZH9MYoMFtbYc3XZbJDM6c=; b=iHpzmY0IjtjTcavOCDMigwXNF4zx
	nZQ9o3077aaRLfoEC0nGHE543tIblnD4AEpj2lizcnh1eGbrcWQeIEvvdi5RYZo4
	2oZI9jMFNmOCjY2vcySgX1uw19KVobIqOw0bgU0ZBgoeFGWzCG+8gtqGsQMKvfF4
	VeRzB5cKK26HdiE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D231F3A920;
	Thu, 30 May 2024 10:33:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46AA53A91F;
	Thu, 30 May 2024 10:33:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 0/4] t: port reftable/basics_test.c to the unit
 testing
In-Reply-To: <CAP8UFD2UrestEMsh=q0WOrJjk3DwhOz8XpweggWQ+VTwCpDtsw@mail.gmail.com>
	(Christian Couder's message of "Thu, 30 May 2024 09:52:27 +0200")
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
	<20240529171439.18271-1-chandrapratap3519@gmail.com>
	<ZlgCKsawq54QNe6h@tanuki>
	<CAP8UFD2UrestEMsh=q0WOrJjk3DwhOz8XpweggWQ+VTwCpDtsw@mail.gmail.com>
Date: Thu, 30 May 2024 07:33:34 -0700
Message-ID: <xmqqy17rqsht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 98B822B4-1E91-11EF-9AD1-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, May 30, 2024 at 6:36=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
>>
>> On Wed, May 29, 2024 at 10:29:26PM +0530, Chandra Pratap wrote:
>> > In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new un=
it
>> > testing framework written entirely in C was introduced to the Git pr=
oject
>> > aimed at simplifying testing and reducing test run times.
>> > Currently, tests for the reftable refs-backend are performed by a cu=
stom
>> > testing framework defined by reftable/test_framework.{c, h}. Port
>> > reftable/basics_test.c to the unit testing framework and improve upo=
n
>> > the ported test.
>> >
>> > Mentored-by: Patrick Steinhardt <ps@pks.im>
>> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>>
>> This version looks good to me, thanks!
>
> It looks good to me too.

Thanks, all.  Queued.
