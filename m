Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD476025
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096468; cv=none; b=lvcT5qQDoxsTnqn1WEi6mT7BbXxljrsCniWW5xpXHcbJCJxo8O1ZGQ/H8Vx+qkAml3A7EzcPWXwtUYVU+RckMVhtShZBiZE8eG9Nf+CMfu9MdQjvs+IIX1B+nfmPAUmWr3hR/rLf8gjshqsrBFifkFJDRVZ68eZJysGBXwm18bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096468; c=relaxed/simple;
	bh=DYtaIGVqBTryCTi7LEgR+B7rkQlSg/g3TGwWxGj/Yfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LF9pGFsUE7qxM8fFip3UdSiStfYXuN8BnXxayZujLOl2g+VlYfrwNhpZjq0ymvDeNc7jyIj05junUA91el6mtQgxMxiEMzhu4ifkvQvsnN1D1zuo2ZPejly9DEW1Ef+8oiDEY9plqr9AL0gFi3+laZuFWaF5gbRtiSIdSQnqlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KusH/X5G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lB8wE2a8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KusH/X5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lB8wE2a8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DA979EC0223;
	Wed, 10 Jun 2026 09:01:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 09:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781096465; x=1781182865; bh=TdtaN5kAkw
	+c4aNkGcqxgbYK9dv6e+qwPbaHWhYDWSk=; b=KusH/X5GI34h2b0nfKkpg7mU/t
	feOotnSqh8z/EB1DC0ajQ6cZxfLuvSLQAqEFOeTzkf4z9GzSbT1aHQic3Nrnfhl2
	ZAUaBcUs4wDvBffeZ7SplE3pdmFLSHHJnx4bTnqfMdEk0AvD9ewmWFKDQ2WntCUR
	O6TlYzwe35n69mhpRJMZYGk8k9EiGx7DWEs2GkMGVLhADvMgNGx6u/UsxzIwFU9u
	En+vJEp+NMv94XYfrmhz2hlLJdVSf6brhcfx1XBmJdJ0Z3ziYuaATm5wT0KaC0+i
	xeosoKgFl31LA6TabOzFalhaJRwjUwlqQRdkzlX6rMKQyKz3BhgGzDzLWVaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781096465; x=1781182865; bh=TdtaN5kAkw+c4aNkGcqxgbYK9dv6e+qwPba
	HWhYDWSk=; b=lB8wE2a8LTd/2vP7b5t/UT/PxX+zO1U4g9frrKhnFJXSmowI/xt
	vRQXbSE3FDhCZb3O4EhVo0I7pr2AqrWBKZ5JL4TGxtbyOq0U1Q1stsbzjCw6nVHR
	kGhnqL+5mVflQrOCVYJBjqcjX8Ihsy77j7vYQJ6cJ64apndmlFQ23MerBaKsCv+g
	BONJhsb8nQ7WsH2GP5fkKyNrMvDFhyRnfVbs+5yH4B+jb0pW5/xbG66Qyf2KnZSo
	KTNEAZTlAHM9jYgkF1hKzBWkyfZ6NkKkk3VNjQHnbIpx/j4W7OiaqqiOdFX17TJx
	mMlyhKYjOSj2OMq1NwKl0R4w9sSKd9QoKvQ==
X-ME-Sender: <xms:EWApaoTvWCXHjnCwkZgJk4rQNyY46dRxmDdtzm0bopiDH63pbg_7Dw>
    <xme:EWApasp56y7TrcANhdSqTD6j_UKNq5yRC85yIQt2P6Ot9VcOUwWChEmtfY7aZRZFa
    lKSJMJAIoI3JFfKGNwTtCNjxDY40q5dUhS4fVXwDJPttJtbfQ2ktA>
X-ME-Received: <xmr:EWApauLp-J78w5WXzNPf7TdBbIVreq0xkq6_nu3jwQVkDZaxhsen86QCe73k_lCF6WxOWZG8kqQl1x7yzHuOLX3UaqwbhSpWXy4F>
X-ME-Proxy-Cause: dmFkZTEtBklZa/JLal1w0fEU3/Rw0/UKcv+Yo/yJYxUa4t/AVknsfJ7y53yvU15UFKQe5r
    Nb4ADV6wkKgK1eqjmN2PDSUkOEmzIA+s8tHS5zmyPM14NYtf1vehajLyh6+cQCgiO1pU0P
    lpa53hE9u09mUBOCDJ74hlzWrpxKQp+SLk7XuZz3nsqlFJupsAKjUYbcbk/YhhtpZATCXu
    AtXb/OfU+KFfiIz3j/nRph5HXYbgXeLxbtCwGZkAXjCvhZ83O/8uOBe3hJFLOH+l5Omz/Q
    XAr5AcLb0lDpMZmG/ZxVek1+t7VstvJRv4W/sCsSrCdtY8Iqsp+F40JmjdhkV6uQT5Lms4
    smYLZ1E0nQtoOD4K7g2uya+kaKwmrQ+IfISAZyO4UNGdbS8nR2GDvbzs/hqEB+2ebhDs8s
    2eKF5NmM6O4ASlmaARGL8PG+ovgu1h2kEtzfy4cE+L5jvUTbZ+AqLyWgEiD2TPoRDscE06
    o1WWR0eVjseOAWWM7meF+YYj6WbmuA5aAY2zQQHMC6cQBySlrkIkfk0JSxvEQNwhC5HK1m
    lu1CfNy/VSlJvvbwi8J+y3gHg9sjTtVqgOOqZDU6Nl/1jhGQwG6hj4egwnYT47+XBk51XO
    WMcgE70WHY/eZbFUEKEJqzbXhziDxQkFyWRVJE7hhzDcgI+86QdGgJEdqSdg
X-ME-Proxy: <xmx:EWApanrLFXB9eKe_aSDNm9nIPOr4E0Mtnp0DWPLWBv2iYkYVw8bUYg>
    <xmx:EWApauz7pOPMX14WEsELTtggfSrvPByXHWqqBgleM6U4L_JU7BKhCg>
    <xmx:EWApajOlIRETnk1NGrqmYCxiqbz-CPPpMKRAI2veVOoWR52fU-nR4g>
    <xmx:EWApar5w_GBsgEVsaYIvZ8XmUnqZv1XP73sJUSdCT1hrq-i01jV0Nw>
    <xmx:EWApalbjUIeAMV2oeijmlxCMUNE2puRow8Pw_3DmCHEjji7-bk2GqnlP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 09:01:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [PATCH] read_gitfile_gently(): return non-repo path on error
In-Reply-To: <ah6WEtk2pXyViEQA@pks.im> (Patrick Steinhardt's message of "Tue,
	2 Jun 2026 10:36:34 +0200")
References: <20260602061159.GA693928@coredump.intra.peff.net>
	<ah6WEtk2pXyViEQA@pks.im>
Date: Wed, 10 Jun 2026 06:01:03 -0700
Message-ID: <xmqqeciezh0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 02, 2026 at 02:11:59AM -0400, Jeff King wrote:
> [snip]
>> Two other points of interest.
>> 
>> One, I'm not sure how useful printing the pointed-to directory is. We
>> _could_ just say:
>> 
>>   fatal: gitfile does not point to a valid repository: /path/to/.git
>> 
>> which is enough for somebody to investigate themselves. That would
>> certainly make the patch smaller.
>
> I have to agree that the patch is somewhat gross, and I myself don't
> really see much of an issue to move to an error message like the above
> if it ends up simplifying the logic.

So we are in agreement among three of us that simplifying the code
to lose error message with dubious value would be a good way
forward.

Peff, can we have a formal [v2] then?

>> diff --git a/setup.c b/setup.c
>> index 075bf89fa9..2df6fbf595 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1641,9 +1650,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>>  					return GIT_DIR_INVALID_GITFILE;
>>  			default:
>>  				if (die_on_error)
>> -					read_gitfile_error_die(error_code, dir->buf, NULL);
>> -				else
>> +					read_gitfile_error_die(error_code, dir->buf, error_dst);
>> +				else {
>> +					free(error_dst);
>>  					return GIT_DIR_INVALID_GITFILE;
>> +				}
>
> The `if` branch should also gain some curly braces here.

True.

Thanks.
