Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE713CC6B
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480439; cv=none; b=UAyb5tDcOpSdSVKk5xJ85AiRHaKI/Ln0qnDOyLV3CualcNc28Dj7tLkQ+FyMvUVLTinOsfOyhxGxt9o5cgAFOw2RWA3ZPP+L4gWwfM8558PJqgBAaz5WY/KKukVOSHQ/adVuydEpD6QIM+p3VwJZ+87gr78ooc9t9UEIpKGY3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480439; c=relaxed/simple;
	bh=nW2GQ3X236qtotZPb0PKcgCPcA9sZdVuOz5PWVRV5Y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jrGATeDTQ4j1cOplmSLnhiwy6iGWbdNtfZ+M4WuqBRZ8KfC6iMv1+50mO2AdoV/ozwdZHLjmyI8rmgb7Wj5Hx7Y6rRZyWlwA0MTl+P8+lfqjNSiNiQH34wdm7FyLpeH0OaKsieRdXYSDRrL4rzZsxujszND/2vNXJy0qdz3A8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t14Dku/S; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t14Dku/S"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0ED8218853;
	Tue, 26 Mar 2024 15:13:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nW2GQ3X236qt
	otZPb0PKcgCPcA9sZdVuOz5PWVRV5Y8=; b=t14Dku/SgmHryZd/8Dhr+2lblBGC
	K86bh054LoUxSovowsQqZsdUNLWhNWsuNDsGDBJSq/2Hx4KvHu7Hsp1kAMOLPKSa
	y5CONl1/E0mhAJO7O4HtO7zM3evEwDPHhBd3v+ABijNZsW1JvTGucpnxgdEQ0wNK
	OuecVfqh6RXp1uU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 063A518852;
	Tue, 26 Mar 2024 15:13:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A150418850;
	Tue, 26 Mar 2024 15:13:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Git List
 <git@vger.kernel.org>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] improve interactive-patch
In-Reply-To: <eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 26 Mar 2024 19:48:24 +0100")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
	<59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
	<xmqq5xx9dn6q.fsf@gitster.g>
	<eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com>
Date: Tue, 26 Mar 2024 12:13:46 -0700
Message-ID: <xmqqcyrgajrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F8D211B6-EBA4-11EE-93A0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Tue, Mar 26, 2024 at 08:31:41AM -0700, Junio C Hamano wrote:
>
>> 'r'edisplay may work well (and I wonder "r | less" or
>> piping the hunk display to anything in general would be a useful
>> future enhancement).
>
> Yeah.  That's a very good enhancement.
>
> However, I'm not sure how.  Perhaps with the help of git-diff-files(1)?

It is perfectly OK that you are not sure, as I do not think I am,
either.  I am reasonably sure "git diff-files" wouldn't be involved,
though ;-)  It would be more like tweaking fputs() of a strbuf that
was filled by render_hunk() to instead spawn a pager and feed the
same strbuf to it, or something.  IOW, we already have the payload
to show.  We just want a pager involved in its showing so that users
with a huge hunk that does not fit on a page can use "less" on it.

In any case, the future enhancement is not within, and we shouldn't
add it to, the scope of this topic.
