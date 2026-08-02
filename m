Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C722ACFA
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710299; cv=none; b=qeBmlPdj1ump6aIhDTMw7D9KnRQHnJS9vpQOzW9EQjsqzJaS+qB9j1C9ELabTj1FlIkKrP9viDxdog08OIbdD+ee449SITuYBv0h2odVCbuQtJKi2wYFr7F88Q85X1wqrk1fJETPzvEnQkVaaKI7RLUwBb4KkK2HgzyaNE+Y1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710299; c=relaxed/simple;
	bh=+7wM6Mm4bYlczk53Pi8+Ye/wdbYN/jN1PsrYZS4Mv+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLeon164SxugZ32xZh7Xku0DUlo6EoouDhiUcdzV7u8atxc18jJbdVUbV729XNUEvbiBJu72NFwhaPXgNjpEgjdB9H1Y/tQg5jx7YkJM+VcKKdcdzkdW6B20atsXz2DoO3CH97vIYAhrPVUtbgm5nksOBAW89ZJDrNYcqxzWKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PK/aM53X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UzmKYm0o; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PK/aM53X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UzmKYm0o"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B7401D00071;
	Sun,  2 Aug 2026 18:38:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 02 Aug 2026 18:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785710296;
	 x=1785796696; bh=YvGD1bmx69jRW5SYeLlNOB05OtgXcjHx7YtkRv0KFLA=; b=
	PK/aM53XV8OYI92fmIMTWlavhkNOpfqVoHxhNZb4AbOxiYJG0kPkEYGLVLhsOJZ/
	clJR3ReGlSUtUWVVg0Ty0DhsoVoVErH7QnIhPtVLDi7BLihQ5GSOoPtWDbUMKRtI
	lFe91n+woY0Y140w4KgM1RYpt92tpG9xhmUxG7Ivwet/A7YJkNeSKQI/Yp4xAmXm
	Ff/7RA82v4FgF0PRwOe1VZNwvpUZjn8G5CFpl92/ToeTMqER5LGrHWeduGtsbEi+
	aca58/Q1mhl0xzThjQAZZrtVTcrWS2QN3SmeuJ+OfdCexmP6umDCgzyfRyynCEw2
	hSKjq2T4+5Pax4U3hkLVjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785710296; x=
	1785796696; bh=YvGD1bmx69jRW5SYeLlNOB05OtgXcjHx7YtkRv0KFLA=; b=U
	zmKYm0on5z5Zv42ri3GqxrSWwydNWykgehLHGy2BLVBmqYF55D5HD+CpdM4eRvLg
	wcQuwzbpb9i1B9LbvpaSHoKzEETp7FiZ9vBvOwhe+PipOhjgtQ+xy9tjMm3a21X+
	cUOhNKHaouZCMhp9TG6wgqHwtgzMRY9sq3NFWEIJlrWl07lr/5WkASrwRDdLZGPM
	8E9CGih2iolvyC2co/mnrsK8LRqFuo58DeR/r+cTNf5hbjm/T67Mr7yIjh2BxbOo
	JHmbJMzBfJUEaUaqgpfXhUTB0LQ0QzYZgXiGNgulF8Ja8gZ54K4XEuHisRHZ1yZw
	CY/zfdpl/KbtP6GIdHifg==
X-ME-Sender: <xms:2MZvah3_4DnJmgp42tvnh8hkYV2KwQovJN2Bj8rox9nTuliWaddnfQ>
    <xme:2MZvavikjtApOoNcnnGzUpQchhFUQyxFiYH7xI8E_K5YHczPZvpXVMLVNMfwYa0wd
    gPXgq0GBtrdyjcAFw8grUOybvZ-xgTtiljN85JlsfznQbU2pYck3Js>
X-ME-Received: <xmr:2MZvavQVEU5IjXZjwGy2LSxqPR9tFe4qdY22NQScwhGDdI5mbmACN85PmMFy8dD05cJ5NsVNgU6bnCnDDv_zKIba3S7nxawesA>
X-ME-Proxy-Cause: dmFkZTGs6XUhd7BpfLGfypPAMeE9GQe9vtA9N0x6RFnVbfVii10ECCSP2YuvpVNrZPTIIw
    woKr5LdQrNSSKybDIwxIyAvt3F9drSxO4p5OcqrEB2fvoA3Zi+WMa6qnGxs4ypO+O6L1IS
    o50lLyNiwvIO+/s9ydfmGnYDyNLuRZka3uHC79gqZBAxdkkK0qwbHiZcn9e48YT1VB+wgM
    EDwvCSB3T7T0NxCtOCNPGgvxVmWtW4xSO5EsHD6cjtSOMZtpChSRW2l5lBrnHUAvJpDkVC
    5ZZ8ggxkqi1xutJvakh67ekQW+EExtNfcaDiAdqAoHheDYzUt3NS4uoMXZLp1pTsGZiwpF
    dGW5jNSAiVnnqeqaZ8vXHtXH8MgMcmDcqyb6LflNa/tQo7pS4C5E0FXdZ+7YoONWTiYX/q
    vOMVjWxC7CiwhSALt5TM7Gzk0v5J9nR9VRtLpXSqUm0ctWHwsuy0g/e5cQK3r355br7z3/
    eWn297/SgCPYZy4lWlObroQ2u273Aslxva1ymE51ky15GB6ZKRS3cy1eBKnC1kPUO2phq4
    q0ItENGwQqG+NYfp6x3xNDUFaW5GW1jOb+qHZkJN/BAivrI+q3lKFG4oUeL76WWaTHzdMj
    0PVcHtw0/dOPnZmR7wbXnCDLEZD0yNcRW4LxeADBuAz8wRuGFVePK0lYe4Ow
X-ME-Proxy: <xmx:2MZvaogUulQujjZrL23s7Yd44jmCFf2Yx-WlbBVso4xEbXFrqevyGg>
    <xmx:2MZvan5pbols8tkcvlltbF6G0WpDzq5R2wgWdutA3wLVsiwdipUEiw>
    <xmx:2MZvatCfg0WiGx4cyhp8lm7ieP03D-7re5KTTCV3KhgSuCFuuL24oA>
    <xmx:2MZvamb1MvxrFh0FnjD8jdKPLjmUkDZmkhe7FzVD-bYJx-kCpndSNg>
    <xmx:2MZvajg1p7nDP7stWYZd2OrcnpE4Z5SukLsEE3JVeN7EAGUBHG9TS_nM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 18:38:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
In-Reply-To: <CAC2QwmJeohdnWhUbcP6Pc5w1X8yZf3jXvpR8JC=Hb9gqkFF6ig@mail.gmail.com>
	(Michael Montalbo's message of "Sat, 1 Aug 2026 17:49:40 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260728215219.753678-4-gitster@pobox.com>
	<xmqqse51algy.fsf@gitster.g>
	<CAC2QwmJeohdnWhUbcP6Pc5w1X8yZf3jXvpR8JC=Hb9gqkFF6ig@mail.gmail.com>
Date: Sun, 02 Aug 2026 15:38:14 -0700
Message-ID: <xmqqfr0w2lnt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Wed, Jul 29, 2026 at 8:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>
>> Left unchecked, this loop may end up scanning a large binary file to
>> the end in vain.  We may squeeze in something like this to punt
>> early.
>>
>>  merge-ll.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/merge-ll.c b/merge-ll.c
>> index 5e5044b9e3..ef5287dee8 100644
>> --- a/merge-ll.c
>> +++ b/merge-ll.c
>> @@ -516,6 +516,9 @@ int has_conflict_markers(struct index_state *istate, const char *path)
>>                         has_markers = 1;
>>                         break;
>>                 }
>> +               if (buffer_is_binary(sb.buf,
>> +                                    ULONG_MAX <= sb.len ? ULONG_MAX : sb.len))
>> +                       break;
>>         }
>
> Should this check be before the conflict marker line check in case the first
> iteration accidentally matches for a binary file and breaks with
> has_markers = 1?

If we misidentify early, that is a desirable outcome, isn't it?

We did not have to scan much and we gave control back to the user as
soon as we saw "<<<<<<", telling them that we refused to add the path
to the index, so that the user can inspect the situation more
deeply.  In this application, false positives are much better than
false negatives, and failing early is better than failing late.

So, no, I do not think so, even though in practice I do not think it
would matter either way.

A question that may have much more impact is whether the attribute
system should have any say in this code path.  I am somewhat torn on
this.
