Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86E4ADD8C
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788627687; cv=none; b=MIKVcDddCI/K7ULwdruycYCmp829sp0IVvvBcyjAHsLJIrcoDv6ktm3zHaaKlDbB/tANiAAS1szWKi4BnTsLPP/1oGhxr4eDbJb3POO+SlvARvNFBkh/F8YjWWkKcJJft12jon+TSl1foFiu88DTcQ5cro8W8j7GMHqbdepiWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788627687; c=relaxed/simple;
	bh=lqAG3S/Q3e/EfbAXJnhEDNSQwEcrJ5voZMrkpnIrOpc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SQD+E2itzWKtlgX7cenVxufqjx/g8FQ3tv96IUDyxMeF2fXLuZ7afDZMu5xL8WaBpJhYJA82m1r7MduCzc0jakOYvH9mnTACJ+Cft7ativzUq9BVxYccqTdfIis2VmHx4Xn4DUIsKxVb9QcIu2b4PhuvN5IDJ29dmmogNcE6sW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DyOj14g+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNMhCsh4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DyOj14g+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNMhCsh4"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A802F7A0056;
	Sat,  5 Sep 2026 13:01:24 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 05 Sep 2026 13:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788627683;
	 x=1788714083; bh=Wo0IsUZKxdfiZHdAl3XMTkmVbRtANWl0d0PIcEZe+Wc=; b=
	DyOj14g+ChttO++iIFRoTnUmNv6A9ndmirm6YFFGDkPHI61m0PpJ1bupPps+Jkir
	oQLsK0IiKOdGnGLb0MS6YGrmzRgn1CHXBeWxKxKLp0irspq6/7L/wdDkmYOKJuHy
	/IyqdCzPZ9g5BUWpcBnLsU+Gpfq+2NSVj+nvj7zUqdr7bQMSltVCPX13cVXeQtyG
	70FIjn5RffVqZYO1txKDK6XpnmAhmQhpVuqnuiaIB6lUwW2jmF5qbFIwoNT+uAMM
	GnZOHrpShoXz8lLEQg+RXjBXfSNvwaCsd6L4S40qQQxGILCYsY4gRH0OBxQQAc0z
	vBV0fjXzXXweIXSxQIGgYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788627683; x=1788714083; bh=W
	o0IsUZKxdfiZHdAl3XMTkmVbRtANWl0d0PIcEZe+Wc=; b=hNMhCsh4EaoXNZYZ4
	Wyszp/2DJkPzaraM/Lbg+Z0RN8oWKuiGrfPjSYkWhAoDR9S/78ABRlpHBlC9xYas
	j2bdCVERdN6HDJoGvzGEXl/rFUMv7bBOXRpd8NzWrhEUNk7sy9CISWLqB0sRJOGe
	2eYiyxtpzdHXjaUn/oYcyeJHD7ZwroPrSJeMKPN6cMdouREnpU9EHnI/WaINcUFs
	wbW7FxGwAHGvRA4BCMacoe6vUxwzG3eVDQ6cRHZVZViVfekh/qB9HTiYFagVuMUt
	cRcVD4XF2q5YM8rM5oRIsax0UvfKsNfGuFwVcxpV623gFioYOHNnMuitIExXudJS
	Q9J/A==
X-ME-Sender: <xms:4Uqcalpsmz_3OzsHxrlxP0a9GVSR0uUOgqUJ9IiRbaaEYEFGziJaMpw>
    <xme:4UqcaifSDIPI9MTb97XwlFzJi6s-09NujrUTRb4u6nWQBQm1EHwnxprIDTPPRXdcr
    hU0Y4OqvSm2R9BNDrm67sKJJegxC92_D9x2lBHBGKlZpZlISXRNWUw>
X-ME-Proxy-Cause: dmFkZTGzkOP0Oj1dU1QhwYsvE7SRzUYsx/FONA5fdk6u1AMi92oAOtEq5W+diweO7itrSU
    S2SnDENnp+TpXeBx+xOyKvZbK+D0R7QKCKpCsJpZm9Kmizt9DoDqlIDGUHCjz80eAoBhTb
    f2tKGI3DmdtmqeY81+t1Zsrqay35g/h9aNUI8jWhftDwmIt6WadQe6tpEFwuikKgPPYXlg
    lY3nXMUhmtudO9PQQZbScOpTE5iG1eJQt4wmOO10p3zed09PMpByIfYF2ho/FqYlStCidb
    QN3eX6cueqlgEWkDlOyLoAqoc18TaXu1gRbSjL33QkdTysYS/FbHwfErUrmKuZTfVb46c1
    aQ1P+O49fBv0IMSmJXKJZwYSIfM8uk0gWnYRjI9nKt3Sgk5ENHlfgLQpGN+r/t6IglcSLW
    ROiBXGxn1s2VnM16VMA3zXEl+s6ag4YGSVFHU1zJY6SBR7uKSOkX3PD2PS5d/lbJlkpk8c
    PxYUD8JUVfqTS8VgwaZ9cDqyuLI78o1aJXiv8Tg/0qs8wc9W5DUGbixG5N3jXzpzuQaik5
    7FS3RZTRfiyr3EPY2ND7641O77r1APJGhM4CYMczF/qlnwsxov1ncef8wZpZUvJdCeBgXc
    0rLCu548waJHPkg6K9p955FkpiAfpWdq413xZrKnUtIK4oqPEa2xwJAR6Cdw
X-ME-Proxy: <xmx:4kqcagWeYTHiTcvQaFgNUm_o0wO8weEwFr_4_CUgHs6WXZswX1jkaQ>
    <xmx:4kqcaigP_-QJ2kBVfE-wLip8iDRirtFTDlcgf0xNBx3mEOz2gnIjPw>
    <xmx:4kqcar_h3TpWPnpOriVhFO0Ic3oBF-X-E7WC84MdWoIeblVNsonlwQ>
    <xmx:4kqcasCj9sSyMhgxpPNJEK-b51b33FEhj7DcHyG0XXbBW9N_QUgS8Q>
    <xmx:40qcalPzmjcQT_8BmIJbz57rUMB-H779-XS-Q_fdr258tZvSKwyf8tj9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6394022C007F; Sat,  5 Sep 2026 13:01:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA5_BBXhTxhZ
Date: Sat, 05 Sep 2026 19:00:47 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Fabian Kratz" <fabian.kratz@proton.me>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <abd6ddbb-7981-4b1b-b050-73ced5b2960b@app.fastmail.com>
In-Reply-To: 
 <T7GtKqbLStRVv4G9RYr5tCWEEkfQ5s-KzbS0OeeKfVArboamsIObGafTbl_XHsXRcCP3XjsR0xEqOsU3OzGVIurZWLGOnsUO9ZUn9UG0XHo=@proton.me>
References: 
 <T7GtKqbLStRVv4G9RYr5tCWEEkfQ5s-KzbS0OeeKfVArboamsIObGafTbl_XHsXRcCP3XjsR0xEqOsU3OzGVIurZWLGOnsUO9ZUn9UG0XHo=@proton.me>
Subject: Re: Typo in man page for git-merge
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Fabian

On Sat, Sep 5, 2026, at 18:29, Fabian Kratz wrote:
> Hi, I just read the git man page git-merge and believe that I found a
> typo/error in an example. I don't know if this is the right place to
> post this, but this is the section:
>
>> Assume the following history exists and the current branch is "master":
>>
>>               A---B---C topic
>>              /
>>         D---E---F---G master
>>
>> Then "git merge topic" will replay the changes made on the topic branch since it diverged from master (i.e.,
>> E) until its current commit (C) on top of master, and record the result in a new commit along with the names
>> of the two parent commits and a log message from the user describing the changes. Before the operation,
>> ORIG_HEAD is set to the tip of the current branch (C).
>
> I believe ORIG_HEAD is actually set to G here, not C. My own
> experiments support this and it's what I would expect after reading the
> explanation.

This was fixed in Git 2.51.0. Specifically in 953049ee (docs: correct
ORIG_HEAD example in "git merge" documentation, 2025-07-05).
