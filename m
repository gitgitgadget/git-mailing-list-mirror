Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F52DCF46
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782422218; cv=none; b=Zov3q+qfi1TzAth34jJOWEcj/ImkqNBynDtoooErYDwOCVgtdkKFnc+JmUVgyX2+9tMUO4MY7KMxwbYUAUQ9DLV68QmkAPSHl51udHL4WE/Nad26x5WNJxObeBJ5DWyBfM1AqrRZcrkqW5wAVmlfC6xeX0BKR9a+qqNfEIVswAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782422218; c=relaxed/simple;
	bh=KWoFbG6BjAybcURFzOCTDx1FERG8Yoddctrp55vUR2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fhn4oJhQpiXTsZCeAi1dBqu0yJyh74NQ37w3w5gW11kztYTxl/JJY+GieW+CsSDG9fYfKAS2dEpuFWRqXsDfsY0XMWwXJPuKxKVqL8IZrijQND7uY4Ze9/d5nmYTZ1hkrS3yODfhBgKIIq+8EgqsnPWNnpwovCWMZ4Z7PIbv4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UYBvjhW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQEF/5y/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UYBvjhW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQEF/5y/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DAB2EC0325;
	Thu, 25 Jun 2026 17:16:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 25 Jun 2026 17:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782422216; x=1782508616; bh=eQZPZf4Stx
	3fDUopijG0M4HX0WFvNBv3IDR9LhrURgU=; b=UYBvjhW1k1wMU6lwZ+Nb07+82Q
	KdtFxOPUMnKv21djjASbydYEElIeePeB/NtYK1Zimd+6der99yDuOFxJFBh4rU+4
	3JdV7wRFXkYcd80EcsbxnwHRtMBJXHCLBa9ih02W5X8d+avSW38kmU783y8/vcC8
	j5ZIf1kSEZWDpeFRtnUhOoI2RY0ssMBTTKIua42EA6uIhKkxWKrP5ygPjZKLgiJK
	7ZUqPMp6WplQqwY3jZa/GOLGQoOd+p3qO703R9ObFw5oE57Wo98+R6NRfxuP1nQh
	kSaEDROS6+b8guzV/onDALGA8ErQ89jjP9sGy10qe4RdLfFRHUC2I0YT1RcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782422216; x=1782508616; bh=eQZPZf4Stx3fDUopijG0M4HX0WFvNBv3IDR
	9LhrURgU=; b=IQEF/5y/P49tiEOqBmYmqXbxAnklnhGali7aZuzeHEKgr9DNBm7
	7H1mDztgx6Z1Th30UqFGnXC9fUZXzAaHi2zlQBEGM1N9Cv9qUBT+nVHsSdCHlJeE
	Gszm7MVJKXh07Sy0S0KBc8CN2yJAVd0hf6MFbIXhSqKWPRgwa3mPOYtGaX2Kp/PR
	pAAsXtLzSOTfksw4apB7IFd6QJk5ZIP72ONnBCrrL0opkFuDarwoOfeDWNszAqWP
	0VtIzuwxcUcuYbZFsiZh/jy5r1JSOcCatF59K0wITpVaVPuekmYNJ65yFr8TSVcH
	mI5lD/49Hj6EQ40GIc7v5dYF0SrBStE1T3Q==
X-ME-Sender: <xms:yJo9ai6VUB_K7YtmPdXb32eTEVM0QlntHwkSZvb22ES2O2H0WODVaw>
    <xme:yJo9ai6Z7YjY_kM7nYZDqpm9YuGexXX35LckJid6xoN6l7sAkhe0n-pqFqyLJOeiV
    bzok8dzYYPiTzgqiCtOnb2tcQU1SRgwxnGW6yF51Se3M6OX5M8USA>
X-ME-Received: <xmr:yJo9ameaG01FbL8AP4lJuLMslX2R-pu-rSZ2ph1N627PC0CIC1wbPjqHcj4ifUg1onsMOdM1OwzfbDyXmxdDV9qpBomqcMqbSs9VH-4>
X-ME-Proxy-Cause: dmFkZTGgzHCaH0FfJF1wBj80u5dMXi+ZmqRcrp8BV8iKizpKedLFt8/gdEF6+vD5S9wzcY
    Av2N13OOtve/f5m+UBCY43Dgdl5U9mzkrOCyEOk92ldjrmeDhAEBG4qd1goiNak0SrrbWN
    SP/YkTrK0+1K5RJDwou123c/O69P7xmJWpo3SgIbxTNBTJte/3c8k9H7SdEy80xUAgeuS1
    inI7+++tH24RWj885WMtUCGfpVN4q793V6cmuNqVrH3kcNJt3JfXJxIF1J4E7iu8Bg1aEo
    kOGPiri5byCxaij7tK2xQ2CsM0SocCV988DIEIglpKzBARpPtZWyB0t9xaXup+0nXJLIav
    4WWXr5QJI03A3N1JS7raZQBmi/tMzSnMggLSNyu5Mo7sTYcJ6eAcTjf123/VUjBPAChTHd
    udAMGSYk7VFciegLGVTgi7rFceUb+ebC0p9ZMDsTdtjK0y+mBw0c9pEOOvl0oLfddb+UDm
    loRf8+NHWXCSCRIfZkCNe1RAAwl5tVNstPwJXce60fxwbCHBcX3VAPn+EgM9WCaklgr4j/
    HgvxOeENLIDJLDJ+m62Pc0yBWrOSjfuXUCTBukyDMdW5XuN6Pjp3EdxzbA9Zr6WytGmue2
    0WyyaIh5KODMzm++NGdYkHW4Hed6rzDcUvccsU3NKLCYzIZ4Oo1oMzvDQ5Zg
X-ME-Proxy: <xmx:yJo9auBVjSNMFBrTzY05cJGiRslMShExHJPoq2oRlDofQ4xg-QSbDg>
    <xmx:yJo9ah8GFjb6TcZtP-iWJMcxiTvx6y0XPv4UF9CZ2bti9Js-jPF_WQ>
    <xmx:yJo9ahLDCqZA16fSl1Xt0TWzb36ld068v8VFmKjAtYre6vAPQPvIEQ>
    <xmx:yJo9aihOWla-uZswRharufXXmtnR6PLT0CN-9HRJMNl_sjANoZ4pyA>
    <xmx:yJo9al8nmjuEfMZlQ_eS9gFi78mKOhaKQnBURw7zrfaGvEN6tLUpwoKS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 17:16:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] branch: suggest <remote>/<branch> on upstream slip
In-Reply-To: <CAHwyqnXZ_eGUPOhq1hXs==uYuYbRBWw120fXRQa=apWKekxVAQ@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 25 Jun 2026 09:44:12 +0200")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<11bcecebf43797a889f08e79401370f43b2917a8.1782338114.git.gitgitgadget@gmail.com>
	<xmqqechvh8m8.fsf@gitster.g>
	<CAHwyqnXZ_eGUPOhq1hXs==uYuYbRBWw120fXRQa=apWKekxVAQ@mail.gmail.com>
Date: Thu, 25 Jun 2026 14:16:54 -0700
Message-ID: <xmqqfr2ae2wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Do we still need the _if_enabled() thing here?  Isn't the caller
>> gated with the same condition in this version?
>>
>> > +     strbuf_release(&remote_ref);
>> > +     exit(code);
>> > +}
>> > +
>> >  int cmd_branch(int argc,
>> >              const char **argv,
>> >              const char *prefix,
>> > @@ -957,6 +980,9 @@ int cmd_branch(int argc,
>> >               if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
>> >                       if (!argc || branch_checked_out(branch->refname))
>> >                               die(_("no commit on branch '%s' yet"), branch->name);
>> > +                     if (argc == 1 &&
>> > +                         advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
>> > +                             die_if_upstream_looks_like_remote(new_upstream, argv[0]);
>> >                       die(_("branch '%s' does not exist"), branch->name);
>> >               }
>
> I think we do, so it will give the advice and tell the user that it
> can be disabled in the standard format.

I was hoping that unconditional advise() should be sufficient, but
the caller there needs to say if_enabled, even though it _knows_
that it is enabled, only to give the turn-off instructions.

I wonder if future readers would be confused just like I was,
without a comment on the callsite of _if_enabled() added by this
patch?

Thanks.
