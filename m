Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382514A484D
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472176; cv=none; b=hi2f17al6ZhQHyqhnY1B8YJVHxNGXtru6UsT2fZjdiTslsFkyvdj0ZEHjugeWReQzgP9kZvHwebnWab7d/TtisqKvN357oESye3gCpt7MdFEWQYeSTOWdihCsvfJm1tinF1mVFNzW9V2HtKQxtoQ1Hkoa53grf5YK3aq97NFAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472176; c=relaxed/simple;
	bh=Rjnvkg0NHJ8HRB9G5nfojx+1qL1O74P660iCa548IBQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WZAU3w2+S9+t8RrOMsPToGx1O/ws5AqAZpdG8P4hFBWyiMidblJJ7ozmLC1ScEGG2tbm8P80YIT9E54+12cnl28uyw0w1SNpn83DaAmgHV/9YLogNkSuKP0TyQAn1s4tKAqPRTmfwknT5IPkSEktugNxDFvt75Hh55MEuPhXyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=bnMd+KTe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixE9yrNg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="bnMd+KTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixE9yrNg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9574F7A009D
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:09:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Thu, 08 Oct 2026 11:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791472170;
	 x=1791558570; bh=vlkG38nlllCV/IapX5tRtI5amUNomLAdTcrkd/UPOd0=; b=
	bnMd+KTes+j/S0RH30g93kUopB+Y7wYa1jv8JsBiHSKzYQvQF/te6/kieRejBtxs
	pzObPa9O+26u9CnZEyEEAsVFYZq5fcpUp+YH9+L9yl9OAzaz0f2nTPWrI3R7SNjq
	s6z/+Wl3e8Xi8zRwtwC9Yh69mL6NahPK5N5PGxGmU9r8SH08HKjdguvqmS9mC3PJ
	1YWGKUih+akFKrOOAjIDLGzqLGDokUEc3g4J4EdPf+XTKxvFsS40gH94mrruhIv2
	NuPy2pmX3Du2tIcmK9ffWSL+DAVe41AN8Ll08EL+Voxwr14+Mh8+FU/434wWGSeh
	6VK34uL+civ+XP59GWDiSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791472170; x=
	1791558570; bh=vlkG38nlllCV/IapX5tRtI5amUNomLAdTcrkd/UPOd0=; b=i
	xE9yrNgf6GKKvuQ2fdFXQPI2Wa0vxd4dgne/LHrQVQ0jrglMgJXtpCrtVaAbxs0+
	/m29+6meNiq5zvFDoeDB/6z6t/5ViSDwnj8XpZrIupxLofUS9ln7X03iLG4CqKJP
	IK+N07hyZY6fhddSW+S+VKcWAIl648wQmZ4qQe9cGcXhE2KZwipcHOuryEQjYo1S
	1ZVtCakNQ3cWdJSK5XadEqrxgkDqmG+ehkbkN9cX+fd8qRlp4QakRbsFL9dal56I
	z6LzQvzhkliUJowYsMn0frXIGb6y6Z5Rmba1qMQlaex0lW2S6M+heXWf+l4BX4fw
	Kg76q+z19JlRB95w0trXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791472170; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:l2wdwQo99OYBnAeBpiuiUUdqJRNZmMGYqEC1sqYMX5+374q
	r0awVWYRLYO8bM3x7isWTqrSRqfvKVVJzQ3nzZrbF8kOucLyePhb+9wZc1rZRHln
	9WIyy5gjoM0fG26lnyVbxDG636axbaC1UAmEJupBC9dRjHA0/ZNLaSq81pBUmVW+
	Y3YjXwAiPTS7pN5vX0jJvhnFcOOHznpk9r3zNPusQ+B/1smF3SuIb/1wt/XfPT2/
	2FL+ZlzvFwlS0VZfjnhYmrSQaRJZtul+NhJSvrG3AYZTadhVPW14h0z/lHSe4Pan
	O+0+ndhWdLQ94TIkKgrvXod64sZ1du70fRNcbig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OWR5j73EPj0d0fL4yLafLZ0Hp1coLGkVD+KDotgKh70=:Rjnvkg0NHJ8HRB9G5nfojx+1qL1O74P660iCa548IBQ=;
X-ME-Sender: <xms:KrLHasNkdQcktEFoquj5JB01zRrH6ljk_aOYiEOJvTHtqaYa5QLLPw>
    <xme:KrLHatzs1X4ojLexato2nTpzHL-s0TW0xbKHt4PQZi8Rd9Rdp1DWrstDUy3NcpF27
    CwB5ULg3wowceAQbjFeEm1n_gzGfpQgkYMR18A-7T5MSnyB9xqPZCL2>
X-ME-Proxy-Cause: dmFkZTFUntq9VoLF2ixurw9J/4c61sgasNd7CMefxYcz3PMz/AZ43p2lET23PfdUevcpQ2
    9K7xCrRyhJJoMBf6QCdUKlXS/9ZBqZlDzshoCJZz09RX2C5uywRGRjWE8Rd7/RiFqSzeVN
    vmwqPFW00ES24U6u7Foe8G6hDmllTfHsjtc6/fiQgbNh0XTD2ePgXKFiw94LrWVsPvK6zF
    9qdFdgqBahOs6V5RK619b2/iBCz4rzlCxKbRh1xjlfte9LX3JqmrZPaj8ZpGeDKzJYOOgE
    +qTYMTPVAqKgG6FMaU9TuGxyq3y2NVrjmryTl3ZKYT3ia+wzHzAxZ5uC0YDABX1/j+i3QZ
    j92h9PgxQSfFQ45CtzapBotLshHQR82UDX6vx0JJCjsnfRFCoIIn3KxL2oqAWBCbXhelvR
    Xvh44dsSJY69+puBHRyH2SBtDRkjEsHQ6APIu19O/91Qlvb885VIQd+3mIqRKc6jcfU6ra
    UsiDTMjsd2Wz8QP28VvHwCe4/77RHItfBU4dt3ECnMKkjIwOe2r7GwyrTMShdwOZVsUyml
    OnYJAZ94Yf1LPN7nhVqefCe7fRgEi41c5ytgNCDzmkqwuLViJWGygn8vlwGeTY6/Q3bfUz
    FaAEdZqaMf3+a1PfE6TmK0YTMmJ/8ceNebhKeUjYOWEQ7dIhIFZEHytypuQQ
X-ME-Proxy: <xmx:KrLHaswH1p1gQdsPtgmJ2dVNLH8BogOm8MvUXzMT9QA_bTWgjktnbw>
    <xmx:KrLHahzE0xxfqSU2TQZqowC2DwPaTNmq6ArIHln8GimzgOEf7Vx1Cw>
    <xmx:KrLHauZkQc9LiVWuugz0v-lTU4gJ_biWTxFioIU4qnJf5sbvx-2qQw>
    <xmx:KrLHaqXzgnvjhA3qMrycHR7WaRtFGPtapx595XjLx6aRPPeOvS9GWQ>
    <xmx:KrLHalGg12bbxeZLFhA2datKf78LvKubX2aJBLON5cLyhwFVH8YwiYYf>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B7A3780075; Thu,  8 Oct 2026 11:09:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKh1_XIvpk3w
Date: Thu, 08 Oct 2026 11:09:10 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <b121896e-03d9-498f-9fe3-6688c4ff4034@app.fastmail.com>
In-Reply-To: <xmqq4iex6zox.fsf@gitster.g>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
 <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
 <xmqqfqyh728j.fsf@gitster.g>
 <3a665230-b221-410b-9a58-96c01210aea0@app.fastmail.com>
 <xmqq4iex6zox.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate the docs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 7, 2026, at 4:08 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> - Removed 'cli' because (from my perspective as a user) it seems like
>>   something that's written for Git developers and not users, like
>>   with "Commands that support the enhanced option parser",
>>   how is a user supposed to know which commands support
>>   the enhanced parser? I think it makes sense as a guide to
>>   scripting Git but not for interactive use. Some of the bits on `diff`
>>   feel like they might belong in the `git diff` man page, not sure.
>
> Perhaps updating cli so that it does not give a false smell of
> getting written for a wrong audiences is a more productive
> direction, though?  I do not think there is any other document that
> tells users the simple "options first and then revs and then paths"
> rule, for example.

If at some time in the future we update `gitcli` I think it could make
sense to put it back!

>> - Removed "user-manual" because it's outdated. The chapter on
>>   "Sharing development with others" explains how to use
>>   `git format-patch` which is not how most people collaborate with
>>   git.
>
> Yes, the was written in a very early days, and by a person who
> worked in the Linux kernel circle.  I do not know about "not how
> most people" part, but I would agree that "many users do not use"
> would be a fair description of the modern world order.
>
>> - Once all the others were removed it seemed a bit out of place
>>   to mention `gitdatamodel`.
>
> Not limited to the issue of where `gitdatamodel` should fit, I think
> we probably should explain the goal of these change at a bit higher
> level.  The original intention to refer to these things very early
> in the documentation was to direct those readers who are not ready
> to go into the list of git subcommands to those "introductory" text
> and concepts guides, and encourage them to come back once they are
> equipped with basic concepts and workflows.  I do not know if that
> design actually helped or was harmful for the real-world learners,
> but if we are shuffling the material we present early by removing
> some and introducing others, we should explain what our overall
> design of the presentation order is, for example.

As we rebuild some of this intro material we can bring it back in.
For example once we have a tutorial we're happy with I think it would
make sense to suggest that folks read it to learn Git.

If you're asking what I intend the overall design of the presentation order
to be, the goal is to bring the Git docs towards more of an
"every page is page one" design https://everypageispageone.com/the-book/ 
where on most pages we don't expect or require the reader to have read
any of the other documentation. So for the the most part there would be no
"presentation order". We'd instead provide links to more context for people
who are interested. This increased focus on linking is why I sent that patch
to make the AsciiDoc links work better in the HTML docs.

I think this kind of "every page is page one" structure would be both easier
to maintain and better matches what users want than a book like the user
manual, so it's a win/win.

In some cases (like the tutorial) I think it would make sense to have an order,
like "learn `git commit` before learning branching", but I think we should keep
those sequences very short. Ideally we would be able to get feedback from folks
learning Git from the tutorial to find out they would like to learn next.
