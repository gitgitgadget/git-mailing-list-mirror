Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD24B0CA3
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213943; cv=none; b=KnNHMUDBfXE5AgyqCHejEAsKJFdpEahjxC20UrXmGGjD9xBuoOuRHalHsJUE/wAUOAUJ5MgVjV15lNV/DUdHATWr5hc9iYWZk1iJ9Z0koUCxnAC+zTizK/CHq0b1QEy5ISSAjxHi/X7wUbjYQ0M4CQvlK8F9pjIQkRXABYV2w+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213943; c=relaxed/simple;
	bh=xdVpxcEk3KpJDgtKK8c7oFofvNal9oHMnYRH4to7kaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c2ovKxX3JRDF15qlkHUAk4sJgJDNyjc7S4yO/ErMPk4TYPQMVkL6SZcVNGW1GBaDLPd4I33oyTj8nsopy9IODwvUJoKvubYyUBqfh9L7GAXwgrfuxY5ODaWJYlrH5KS2QR1JZ1ES9BegkNMCknzaOAvxwxccVSHySd7aAq7CxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EInlNot7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ItIYbEq2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EInlNot7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ItIYbEq2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D49001400135
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 11:25:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 11:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791213940; x=1791300340; bh=5e83mEQoGh
	eiXlo9BjxtyHcg/0YFDai0fSTWDdDAN5c=; b=EInlNot7aikmhsx7aOGf+jEFFS
	NKvS7P21eJkxkhuBhE2zQnEquBZvPxL9A5udkbC2GXikz1w1QIRxdVf0Xs0qgA18
	k9bWRunrJt1vg8n+PfKD6C+CKRvZZgmRYbF6cjySsZIwfrQjF2Br24l9fMOHGtYc
	b0JeRB8GQxwA9vo94ah4F5LwY3zqSqSicdMvQG27v8W+OmNxl5GVPqbLRt37nRE+
	XTYIAkgvMhCNSKESh6cmn0T08qkCu4NrvEAR9ym1g3qKmi/+i/uiL8NTBFtfVMIy
	R2OCmIZxvTdFxx3m+sNRRdnOe90K5/R8AlcAwIdtOstEfziOvQqbHQ1Q9ppg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791213940; x=1791300340; bh=5e83mEQoGheiXlo9BjxtyHcg/0YFDai0fST
	WDdDAN5c=; b=ItIYbEq23XfKtqKUFXmGqQaaIRq1uYMGRtKDmNIrt1TsAyAVixp
	2m2/ycFHSNx0uA4b5rFumUFNTrOUnGdeAVCF7TJ87/cbz8Lr72/4jRqEXwQ3+CU2
	Qw6uQ9VAWiDR4uj97867PhiMj8XeYaOt0cEWKduS/QkJgUyrJdf6RpFb9B4c3SW1
	5/W22ss4Uxa6sSYg6rIRXAp+RKFZL2WsmjEDt6DQb3c2jdZQbhOh8eFf9hBpRglm
	C1+QJOCr/9IosP1WJILxia5TFEFe+NxRDGBzW9ikWdMH+uYsbuTinLJ894Ao11jE
	dpqJPHDjyKKYqwZoAVH2uCYS4Yb+oMX1WpQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791213940; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HF94rPbxhtdrLyfMeriEDj2VLUFn7ynoXfUWLj6u8aUh1sH
	AQPtaqt0ZzcDjYLLRpk2CgJAlKSKN+rB2fc3hW2x+lRFOui+rSH8DL7GyGzjb73R
	ua6gzmSmgnlnNLL+SAKYq/ipxT48u7eie5QNLyx1H3fkS6TQ5wCT/sV/qsbFh7Zo
	rxwXGZVOFPe4CFVWW0loWQvA77OvUfsgVCW3IL//gnC2FRJE1/ICDUXSsaJ3jDzY
	JSzED+6nxOiwqi5eMlBYIV+us6wmgr0wrNh8vwrTsV/9khpe++GxkF/wU9kRGo5g
	eA+nceZVDOHZGk1h0t2XgU6jLDBN+KHbI9GODzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pjuyNG7MQth4fD8tHTQTSXJ7KGeAQLv8Uo7nKPjUsz8=:xdVpxcEk3KpJDgtKK8c7oFofvNal9oHMnYRH4to7kaM=;
X-ME-Sender: <xms:dMHDaqbe7dmB1c5CrlzlRRe42vCiOgYj60QzBQL1d4aO7Nn6RDa_Aw>
    <xme:dMHDakTXhdD2KbWsPaQGaCSUcXaigyUtF8uWnTolkBgw6dwY4QvhxATND0rM6H1g-
    hxVk_sUmUnNVgwSu63mYg4b01T6Ejwj3T6ArVLAc0PoBBn1GhL14w>
X-ME-Received: <xmr:dMHDatRSJhY4Iq7A03PfSB9GmbE8lLi5grb_5vT8KRc4TlK1_VsIunUGhyeGK0tFoN_kzRB9T3Gx9SfPmCCPK1ee2S4HECT1Bo81>
X-ME-Proxy-Cause: dmFkZTFefG1MIEDJPy3i+ge3Dd8UKhHZhkWqjTdgyTm7rIj/swDhZ7DWbr5TXZEB3DPx+I
    fpaI/MkaphMxnX9T2E9ucBlgN+cIScO6BRDLPcW6QzgjjCMrSgIEj/I+KQsRP0ByQPovWa
    5aA9mQZtH2exY/gUwoZjruTUDXjdUhgmbz+7Ejq6XTh1ZUdg35h9qzuBcJprIujRwsNzQE
    hUxpZaDoIthDaZyi5JFZPagn4TK5LzhvFepqVWaHTHp6aguNDFDHaFIXiVKHHpazioArIc
    2aGJ/SrkNw1cfEjYzaG/j9FhAZ4U9Qv1oLxGRDkP7dZSHkN3Bv2zTVbl1Cb6FnhQmJi8Xs
    gm2/cTf1FBuvAPMvE9SvHt9brGVpDBMcEyomieme0nBkfQunSXLT/vozvOLlP3RzZqtnLM
    i0jUgQ4SNXBO6PCXbLB4S9R4Taj+29lYgaOfVCIvTw7B99svnD4kxlKT7rRJ6kgLhu8Qu4
    0/hr+lJElrmjW2XFsnhTo8U8MLnhnkC4GS+LTqW+C314UC5TJ2bWoXtiaW3nO+l8xH788o
    gF19YrJj3rH9h+mbb+6x1LgZpNtG1ptf5LCh+J4XH9GMtaK3qNMO/DhC767MC0uw2KYo3f
    7WZMvNxH9McKSAwz2jFtx0ArZI2YehcjoBICBqCZ2ywQwQkRuXQegHTa9cUw
X-ME-Proxy: <xmx:dMHDaoTmzJXt70z35op5lihOfdmRh4k3rz3mvBJnZEoHbXdd2HmsoA>
    <xmx:dMHDai57Hg6XZoqZTDDdce-r72emawuK4zMes1AxqG2WohXho3aqng>
    <xmx:dMHDak0gCtzykIOGJBPbnUXNyRxsK7RAZssOtMYRozBq55XGKz12uA>
    <xmx:dMHDatA2iqz8DUjnC5kOIfSVM-F2k8xm8G7A-JSBWqWjiGHcjJ0faw>
    <xmx:dMHDajt4-eovJ0BY3P-hy4lQIuCUyM3tY8rYRtXKd0nDxPx5z0hIQiAT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 11:25:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hanan Arshad <hananarshad619@gmail.com>
Cc: j6t@kdbg.org,  git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through remotes
In-Reply-To: <CAKPibBwjRSb5cXd2iWo8bbYby1odcXNazEg-D9hcqbehrR6g3w@mail.gmail.com>
	(Hanan Arshad's message of "Mon, 5 Oct 2026 02:06:36 -0700")
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net>
	<20261005055337.7579-1-hananarshad619@gmail.com>
	<e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org>
	<CAKPibBx6364BcB2nqyQ7jhTaQMaUuR2TNKzZ-9H8VopcRjXbZw@mail.gmail.com>
	<7012706b-516b-4cd9-abf3-0144093e0779@kdbg.org>
	<CAKPibBwjRSb5cXd2iWo8bbYby1odcXNazEg-D9hcqbehrR6g3w@mail.gmail.com>
Date: Mon, 05 Oct 2026 08:25:38 -0700
Message-ID: <xmqqzewsmaod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hanan Arshad <hananarshad619@gmail.com> writes:

> The narrower proposal I am considering now is only around the parts of
> the temporary handoff workflow that are less convenient today:
>
> - discovering available remote stash refs,
> - fetching one and storing it as a normal local stash entry,
> - removing the remote ref when it is no longer needed.

FWIW, I agree with j6t.  Quoting the part you left at the bottom of
your message (by the way, please do not top-post on this list.  You
quote what others said first, and then you write your response below
that):

>> So, IMHO, there is zero reason to upgrade stashes so that they can
>> achieve the exact same thing that we can already do with branches.
>>
>> (Hence, if indeed you do share your half-finsihed work ten times a day,
>> then, please, by all means, use the right tool for the task: put your
>> work on a branch, not in a stash.)

All of the three you listed (discovery, transfer, clean-up) become
easier to work with if you used branches, branches have always had
good support for these three (and other) operations, and I do not
see a good reason to add a parallel support to do something similar.

