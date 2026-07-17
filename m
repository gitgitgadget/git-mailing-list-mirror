Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17231E83A
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264415; cv=none; b=f/i6qhMAcEL8dmlBqEYaA5lDygbCO8EKRM/mAtp7ofnUI0fDLhyFl2JBQ9gsnXj3NMadjVs/VL+SpZWPOepDvvuWj54J9+HBUMCO8BBbyDz74pR2cBUq1vuE1DRdmAlr1s/Eg2vYubkytunYw4jqE0zu8qb0iep0kTXp7AsNqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264415; c=relaxed/simple;
	bh=czZNTwq+WWVT59ukBRReahkjWTnSSojKg11jkqLGfJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOOpAsPuqQUVTY/7Xkj9FFc7gCr/cMreWsgofDoZnGhrK+AQK8PW485G+JG3y/GjfD2i3zU9Ugov7AfR3ZRU9Sa8qpQ5NovOCwIuwVUnUpADbf5QjIbA+iWJ463spW9k+zTfI06nAos47GXO7SxI6f0uXelSFdc8SiEYlyDKYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ElPm0Ijn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJF/ssOT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ElPm0Ijn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJF/ssOT"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90E4C1400086;
	Fri, 17 Jul 2026 01:00:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jul 2026 01:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784264412; x=1784350812; bh=W6CB2m2Gwo
	C+pK3D1zsycTZh79DnYwPEvlAwsdkocP8=; b=ElPm0IjnE4bUG+9I03AU742pAb
	M7iwcZ0Bbj4Vhj3rrddem8vi2kh2Kw7FB90B13o9M3gw7/hOxYYocLZnh6TkWIYj
	6vLNchGOtArWOnVwjyLSqa9J+sShQ4jGgo4vyijzVG/aeJ0UN1T3E0MOUfacU+t5
	Jufc1blWWDaJ2TWNhcmMIIjWVtNP/iHowVQbMrUlSNGRpe3Skwprffvxu9hX+zH9
	pQrn/8t7ucKt2f56CH/9MchehP/xGOSXvWnvZMXjYDApxU8fQOMObxnKn472nueT
	i61m/oqgfl41gvtpX7dzmsQPYoxQMn100WyvGo3h8oc9iIHr63RuBavpB62w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784264412; x=1784350812; bh=W6CB2m2GwoC+pK3D1zsycTZh79DnYwPEvlA
	wsdkocP8=; b=JJF/ssOT8Fjw+EKiJsmUiIJ1xh8Di3qQ39bnAjXBYoHBFJj3/w7
	1B4GqlbyIXhI2wvT7l3N42ydoTzNsuASPB56QGYk5E3Ih/xdc/H0zPzVYWHlH6V2
	ANw14T9JJrPzLCBBa4FDFDq70UwJqZ69GcYQtGWs/rjfxnWkMinlfJZLlsV0BF5D
	JhKoY6Z5YZpJFKbJ/ZojrRJXj37Vo2EabJV9Np1+YVqMna0VsXswP9Wki7p5JzlY
	yAWZBCLUiufk6mUcRJdkuCwisSNKLfY/Frsz0meytM5UGk6fd0kJAtN9GS/RW904
	RAIZvZ/8TDj2JXQ+mOdygY8L5pYyhdwvBvA==
X-ME-Sender: <xms:3LZZau-JkzJEcgsVQeyZAuV_QKs6A3ZVBDvWUnVxJOtrUKQWxhWe1Q>
    <xme:3LZZals1QeT-C6zX7Osx8oQklJxqZGhJp56iXrE-foYoN2rlm5audqRRRPotbJ8yI
    6VB5SbtEs4SEMGLkZHa25wn48BvOlQtVs6tbsIViO5Soqfee4_K>
X-ME-Received: <xmr:3LZZapCHgU0hpGQGac2LnS7P4wyY0I5yo_vQmMy_OAxURjhlUYBYOwrWUnluRo-pxije2ILgDwrnyfo3h0AP2ctgHorZTfiBq9Y4RIY>
X-ME-Proxy-Cause: dmFkZTGigsjdgOJJpBgn5udUK+UtGmyga19B0DJ7aVV8+xC19XlKr+hv11aTMS7ypwUwRm
    NX3zsjH3LT+yqtPmeJ1cuUhLg3HEFbaSpLANr7Xd9eP69Tkv0ZXVQ64mVllkeqRUTK0++O
    tPg9JIYQB3mteeQTN89Qj8EaETXEd81VyhhfpEs2YXZVhgMkv2Lx/dqYvbJ5+znTAkkiiv
    /4/PGeNq0BHHM5Hj4xaFgJaabgku/4BarvcFerA1BKlKcIELXwCljHbozkRF+GMHgzFfIC
    Ez8tLi6nIXqTKen402HYyrWUcmoJviSB1iS585wUJ8gFlzWQ/+ZUoATIBjJPIBOnK85XTS
    BLynpTtTFx+GGrTDSXXauyH1n8uAZ2/9BIxraRF3cMK1/QHwucFGxW/gBxoBzzmU4u2E5i
    Kwcrw5xPzUIRXfqcSx4b8192dRQ7yzwLfW5/Kcl3G9rRtrHAXXawyBIG7qxKv94K/ThyW8
    GWDp6ALTClTDtNQp/XoUjujRQg37FXOpbFeN43RPJTa2GfRaS1WOV54IVOpaSNwAuwClNo
    6W8gNJOapBfnw2H7aZcNT670hpts6G+pdTZjuPYaaayY9vYpDRs7AQ1KcYillrSRKYMZiK
    T0VnBO6PtgUE7wUqLiLn9XzyCllWXpyjUc4PrWBGndEeOc14jLIevqNtv9CQ
X-ME-Proxy: <xmx:3LZZalUm0hFyuxq6qdBXi9Gywtfh3aBCPkBP25uCwIGvO1snB6idNg>
    <xmx:3LZZavDlhx55zCWuSFmlVeMcdQTbfRVfdxpG-PG5fAUAsEM7Zn1Tnw>
    <xmx:3LZZag_VSICrhs_QmL-cwyYpCpPuG8_WBSpssk6z55IhbUQyx8WOVg>
    <xmx:3LZZauFELQLRKBnNzqJGceZE4MAFNFhIVe5xJEJjUUmpNBMUR1xxrA>
    <xmx:3LZZasjB86SiWFrQMiRcLSZZ6LS251ldwFO8JsGErXvRGQSR-AmVQIa9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 01:00:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 3/3] bisect: add --auto-reset to leave when done
In-Reply-To: <CAHwyqnUFfewFm7tr-Busv1rKP=4Rqnq+vJ7mEdgbaRLKbpbo=g@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 16 Jul 2026 23:22:24 +0200")
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<a9194b1d00b260a7a7852eccec54c872618b5fdf.1784180159.git.gitgitgadget@gmail.com>
	<xmqqse5ihmsz.fsf@gitster.g>
	<CAHwyqnUFfewFm7tr-Busv1rKP=4Rqnq+vJ7mEdgbaRLKbpbo=g@mail.gmail.com>
Date: Thu, 16 Jul 2026 22:00:09 -0700
Message-ID: <xmqqpl0m9pnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> > Add an "--auto-reset" option, accepted by both "git bisect start" and
>> > "git bisect run", that resets as soon as the first bad commit is found,
>> > returning to the commit checked out before "git bisect start". The flag
>> > is persisted in a BISECT_AUTO_RESET state file and the restoring
>> > checkout is done quietly.
>>
>> I often find myself, after the culprit is found, running 'git
>> reset --hard' or 'git bisect reset' to jump to the problematic
>> commit to investigate further.  If '--auto-reset' leaves me
>> checked out on that bad commit, that would be a very welcome
>> change.
>
> No it's the opposite, returns to where we started before the bisection.
>
> I don't mind changing it assuming no one likes the original idea. I
> guess the name shouldn't be '--auto-reset' then.

Since "git bisect reset <goto>" is just as common as a plain "git
bisect reset" (which implicitly uses the original branch as the
target), I suspect that an option like "--auto-reset=<where>" with
values like "original" or "found" might be appropriate.  And I would
not mind if omitting the value defaulted to "original".

The point I was trying to make is that where to reset depends
more on the situation the user is in, rather than on their
personal preference.  I would mind if you changed it to always
reset to the culprit, just as much as I would mind if it always
reset to the original.

Thanks.
