Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12054759
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500826; cv=none; b=UcOFqbhFZFs/+gUDZiDhIyUV1bNd2eyK0zLaJdcu0HoNrUUmaDTh48JZdsnjoY4ZgOjaFAheWZNx4LeCzYqi3l6j0+GVnJCcaLEdE6hYMAFCratq9HA9RJNo2E1C4lbkFTIr6tRAAN3BN00HhS4+pg/XCVTqDijBnNGEZRDwZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500826; c=relaxed/simple;
	bh=KViFDJYFSuK7WTSFGFjrx6UAR8Vto1bAxnqCpEF/jYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8b/XqWGCc2MpQwOTf/V8LBEZ7SEA1pm7l5A7cRhtXhiTvtlunoP5mSLa5kuARAtRVRAxzsfI6GqurUi35BE/0JC6z4r892OfedD6aN72FKb6yepqCFQxgjwelDFaTjSJavHpM/5bisNmuJM9tXCd5EHzdFnfavtEuxcGa1TI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lyOUJrAQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lyOUJrAQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BFEC2E0CD;
	Mon, 12 Aug 2024 18:13:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KViFDJYFSuK7WTSFGFjrx6UAR8Vto1bAxnqCpE
	F/jYY=; b=lyOUJrAQQf7U3yAfiG7mEqg2HT7Emri95WgV4ICO6USR69vCWMAV4e
	rd2ScjgP4ap2wr/3CrmjH4ENORZvQAfZA6eFq7FpKUWgIa1bXecFtmwl5GGfRFtJ
	j9gZbbp97EYZOvRzErk5s4Bh8lbzzYRXIXXxCxWVkuvKTKoEhU6Tw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7484B2E0CC;
	Mon, 12 Aug 2024 18:13:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02DB92E0CA;
	Mon, 12 Aug 2024 18:13:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Josh Steadmon'" <steadmon@google.com>,  "'Patrick Steinhardt'"
 <ps@pks.im>,  <git@vger.kernel.org>,  =?utf-8?Q?'Ren=C3=A9_Scharfe'?=
 <l.s.r@web.de>,
  "'Kyle Lippincott'" <spectral@google.com>,  "'Phillip Wood'"
 <phillip.wood@dunelm.org.uk>,  "'Edward Thomson'"
 <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 0/7] Introduce clar testing framework
In-Reply-To: <033401daecfa$773fa5d0$65bef170$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 12 Aug 2024 16:58:58
	-0400")
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im>
	<k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk>
	<xmqqy151zcsc.fsf@gitster.g>
	<033401daecfa$773fa5d0$65bef170$@nexbridge.com>
Date: Mon, 12 Aug 2024 15:13:39 -0700
Message-ID: <xmqqplqd9yp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 219491C6-58F8-11EF-840F-BF444491E1BC-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

>>For something as small as "clar", I think it is fine to start with the currently proposed
>>layout and see what happens.  If we can keep going without touching the imported
>>part of the sources at all, and the system proves to be useful and stable, that is a
>>good time to suggest moving it out and binding the selected version of the
>>upstream as a submodule.
>
> I think we already have a copy customized for git's use. The main clar repo on its own
> has portability issues. I have contributed a few fixes, but they need work.

Yup, but as long as the changes we make are all upstreamable, the
story does not change all that much.  Changes like "#ifdef TANDEM"
would be totally uncontroversial thing for them to accept and we
should be able to upstream them fairly easily, and once we thin our
local customization down to zero, we'd reach the state I outlined.

Starting out with a local copy helps us making these portability and
other changes without much friction, regardless of how responsive
the upstream is, and the request upstream would see is "here are the
changes to make it available on more platforms and/or making it
generally more useful. all of these changes have been used and
battle-tested in the context of the Git project for N months, please
apply."
