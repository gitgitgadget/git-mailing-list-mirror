Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEF1DF75A
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001825; cv=none; b=MaSmKoHipUE/lIlOjIC38RCkfgOfMRT7OXl+tCdUjNmOfaS12fLlHbWoDvG/ssaGSoc6igAAQUYt1/5RCY0tuHQGuS7VJkTBjYXpbUTspIprHcbJvuMob0vd9aWF+gF1K1dGb5F3TwStBaYl4y351rL14QLrLtzZGobp5UNNK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001825; c=relaxed/simple;
	bh=+AgC4NQX3S0p3BoVx/cRXUdXwQFCgblSGF80fIRu8lE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DgB3px9DeO7by+DRe6DOwt82AA1B3Mz3TWxkIZqMbjjz3OPft9D5Dk/FsK+H2A33XLnj8D9UOrmvgnTRuTf53sA9HDZo/qelhwBmuDII+PlS9vrQAY8jWyeUGxMEI4lt1PdJeoeDPGpsSH+3HlRIPd3CM206A/q4j8XTvCFyDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pbSUyHU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=An4T9e/A; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pbSUyHU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="An4T9e/A"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E60D1D00107;
	Wed,  9 Sep 2026 20:57:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 20:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789001823; x=1789088223; bh=T4yKrVTyyg
	iD5MAgg+50l5X8Q29jLwNwBCPLmQyASwc=; b=pbSUyHU/GpuFuo99z6I9Mp7SBV
	6DzYiusr9JohxMbbUcUMblEnwW/23DnNAyRuILsrLEJn61RHBxr9OSZFv3cY7CTu
	q5/YjwCjxIyW4cQ3TDjjUGZb3PmSWefChBxUCXMu+gfRaaSpOmhKyNqz4Xfpus/j
	33+JTlHpvCRmcw16GV3tD/22IwbPm0xvIa/FD8muYunGgriAsHqglj0My4ugs/p4
	O0Amk8nyo5wcRuVLzL0Vy89ekD5Dgh5+fXuo+8k72J9M7ylJ7+Hdg2B3jnDRdJ/0
	UI3JlDMMxgyHYtOxExWVxgp14+0V41R0uVxXgui9A9a5RYX0aLGgTz59u7Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789001823; x=1789088223; bh=T4yKrVTyygiD5MAgg+50l5X8Q29jLwNwBCP
	LmQyASwc=; b=An4T9e/ABtIbSm5G/Is4pmCQ8IR+deIMQJQqqBNCdfZde+l2qck
	tjEzL50dXDPYyJEP3PRdj+z2fqzw9O1yPBqhQq0W9VAi720NVFi/Oin7R5a6WYgd
	bhVAHoI41Al1JwnmIzEAYtJadR8TTNBKkA+2wRNIhKllVn9pJdyZsq/IfFxOXg/5
	RX+qYYAZuUMjXSQBgF+VZrE1vEFaz6q+iBZYEABbKVTt7TBCIehcXCZuWTADeqQi
	tuP4Va2iQxRxE8os3SgxL+Q9yZlq4upYztziO0qM+p9exDP6X22FnekdDCS/81Xe
	35qFjDRWi8i17vabyXroNC985GlQRQQ0eHQ==
X-ME-Sender: <xms:XwCiagkih-NYUZCyzAzcGe_EU1GwtEPcF9mqP2e-u3pwpt7WM7OYww>
    <xme:XwCianSLOymsC0anD1mbQ6xglQt-kkJ93jK9MZY4RA27w27_FEpUjQ2VQ9b3Dw7Tj
    0C6sYwceSFM7QNs29zLFaOtuU6BKphSg9uHAOG3NY13HbM6EYA2ciI>
X-ME-Received: <xmr:XwCiasCgEmkXBtOBMw4Ep17OPnxq7aalxGFUHPxMdgAwSdD3LZuFOKhMTgN2-Ipe2GNU1xj7zUC2iZxDgA38PfVeBSUGxtc_zXMi>
X-ME-Proxy-Cause: dmFkZTG0NmKbs1FL18WeWLl0LoOtzYste6/cDZvUpxQjXZPwbb1lG6tKovNz1Mre/wmopp
    H4RRzrbWUpx+BXOKlAtu1iV//knu4mL1kyhfJShX3LIagcdeAOYGlDUA1GZmu1dbUmYAOd
    grebGG2zlNsgBmI/5GG080hKlcS6CGJtCXsGt+GkE4tcS66EW+Nxhrpo3GMwsxaBxo44Eb
    9Tb0T2vDJ0XfL5jRckkoVZrjuWgkQA0t2gij5+WgC7LdezSel5rYgixGvvX65U9zyWd16L
    G+num80uZ9YNZ3ZfDKkz9qbvMTbndAQY14bBcwSYSfPIBA25OhcpEMBQi8MbmzxXJEeUb0
    20dudDJfRucOqcPtpnb3GMSPu86e3zzvZwEJ9GhtkCfkwkV6iQOai837tTRroj2uZQhgYt
    MVhKwArMuYPTOJ3TRjmWI9EoCihswBKJvPG4phhE67bJrrck7MO3VBrSaWuNKhT8F+n5h4
    OC6zC4gth6iFd8nCAzH9mmFqTMhKPIfW6As+3xRZv8ePP/Ai9SRmnBGHGWLXQcAGUf/VCI
    MfCiLOnWVV2YMKl6wWH4zZHRU6p7dREp13wzjxSQ7SUXICoEmRFgu2MjKuK8b+seVZLb1V
    kocwKxnXpzUKf7j4hNBdoQW07FBdIae3JW1zXWOreIkXnd4/cem1UpFHUUzg
X-ME-Proxy: <xmx:XwCiamR1JRNkRDjzcF49GUwj3gd7xNw4CtnmJf5mEFzQKVPO-8Cd9g>
    <xmx:XwCiaipP_ChFqjCCe0pyJzTmfFj0xHRKm7sWniPhs4EDj4sxE7MPMg>
    <xmx:XwCiagzy1pMluHxudlfSyJy7vhqKdNadxyNmi_29pM2vIl6L7804Iw>
    <xmx:XwCiavLg3gie0g-9XkigtrbIRRrVjqS_y3fpWslw41gXK7HlO3GNgA>
    <xmx:XwCiarSOCmkGIMps74DBGoPgN96__rddGei5AzkIAMF2RClqjfuN5pK5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 20:57:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking
 ref has no reflog
In-Reply-To: <20260909065639.47316-1-f@lex.la> (Aleksei Sviridkin's message of
	"Wed, 9 Sep 2026 09:56:39 +0300")
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
	<20260904124433.12840-1-f@lex.la> <xmqqzexx58hc.fsf@gitster.g>
	<xmqq33vn5hsq.fsf@gitster.g> <20260906165052.21780-1-f@lex.la>
	<xmqqjyowz9oq.fsf@gitster.g> <20260909065639.47316-1-f@lex.la>
Date: Wed, 09 Sep 2026 17:57:01 -0700
Message-ID: <xmqqv78dordu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> It is only true for those who conciously disable the gc, isn't it?
>
> No. The fallback is not about expiry, it is reached when the
> remote-tracking ref has no reflog, and a plain clone leaves it that
> way: after "git clone --no-local" on the files backend, "git reflog
> exists refs/remotes/origin/main" returns 1, with core.logAllRefUpdates
> at its default and gc untouched. The same source cloned with
> --ref-format=reftable gets one entry.
>
> Nothing expires on a calendar either. Entries go when "git reflog
> expire" runs, and "git gc --auto" decides by loose object count
> (gc.auto, 6700), so a quiet repository expires nothing.

Sorry but I am confused.  Your sample below is with 20000 local
reflog worth of activities, which is hardly a "quiet repository".
Besides, we are talking about "push" so optimizing for a quiet
repository does not sound like a useful mentail exercise to do.

>> Doesn't it force a behaviour that would happen only to those people
>> who deliberately choose to ignore cutoff and who are willing to spend
>> cycles to go back to the beginning of history, to all users,
>> including those who do not make such customization, no?
>
> Measured that. One repository, 20000 entries in the local branch's
> reflog, remote-tracking ref without a reflog, both values reject the
> push so only the work differs. Median of 7 runs:
>
>   entries spread over 200 days      zero 0.325s   90 days 0.069s
>   after "git reflog expire --all"   zero 0.070s   90 days 0.069s
>   20000 entries inside 90 days      zero 0.319s   90 days 0.321s
>
> The expire run left 5 of the 20000, since all but five are 100 to 200
> days old here. So the cost lands only on a repository that still holds
> entries older than 90 days, which is the one where gc has not run.
>
> In that repository, when the matching entry is one of the old ones, the
> same walk is what decides: zero accepts in 0.322s, 90 days rejects in
> 0.086s.
>
> With no match it is 0.26s of extra work for the same answer.

Thanks.

Doesn't that mean it is more logical to use the default gc
expiration timeout than year 1970 and in any cases using the usual
gc expiration would not waste more time than using 1970, right?
