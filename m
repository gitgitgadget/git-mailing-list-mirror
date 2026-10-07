Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C03BB664
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375236; cv=none; b=QHqNNYvmtird4jr/dWtMBLMrqJD4HoqL0bL5x9tJtKvgLfIf7t43eSqwI/10lNm4tfxv+L4ALj/K8ZeETk7gPT4KWOn/JPbaa1fxDBgsAy9ENQkb9UxH8yW3181sRj/EkhLrOAEbXX3yjut4XnpUE5OfOKW1YFr4StwnylBvPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375236; c=relaxed/simple;
	bh=pjAduJb2e9xQkjKLcau8QTHMKpxpQwnh/QMd382YcVw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fWYbvKVgd5AT6yVDp21ZR7oL7JrsXIS/+VcIknEardgJzsnIlj+JLlrDa712nBXm149D8v+o5hImZ/3akNCYgJiqup6GJUEpRJIXx8O1xIiuCPDbvzh6ibgHEV9Sa5iAXB1TKgjwANQgNEDUoQIekxZhiAC3MW9pBtBXIbPLcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=DRiSu2gz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oGjxEMEc; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="DRiSu2gz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGjxEMEc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A4FA1D0021D
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 08:13:45 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 07 Oct 2026 08:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791375224;
	 x=1791461624; bh=xsh2rNXMwH52aSauQ7421E2BLV0/xfuvIttwYIQkcMk=; b=
	DRiSu2gzZfPknEPBtwvuUYGi2by+/hzqYmCLzfpml1sjJOqosciMfb/QLXX4LsV2
	77ETAzOwGWBGwfAmMUYXz6324GbOO0FX5q/TQFG3MqaELZDk9RnYOuBLLfgpmbi+
	ElonMdB+yqtgG1vtJlEe+b+FiN8hMNubjo4AAEV6tJ48E1yJNfl0P4pWrSKKBxc/
	Nk4e6q0BrYC3iq8W4lCs4NXzd6mYKGxnVkKCBfRlsbRh2CNj9JzqwCZG/LJ4kbs3
	7FMH7umu10GuO1FCNj2xVP6uoeD4AmIGy8sIZjyVGpmk3wPXQIVa0bRnK4HSwTbz
	B5m/+k221YHjF/KZYEHbIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791375224; x=
	1791461624; bh=xsh2rNXMwH52aSauQ7421E2BLV0/xfuvIttwYIQkcMk=; b=o
	GjxEMEcmn9jDpG36qxSCz0eIlCEngq0Uv37v6CUmp9m33I5JZgic6omt/oTmX/AT
	+uSGJ05Jd2yUdGh/QL7hOQpvzlmIbby3oBluZxWsYZIq2NpUdMX0/kvYvIav43QR
	LxPEPh1PNDbKQHWYVcyc/wX78IvjV70+/Lwk99zbIc20YzSakt7DyG1NuPp7ujc6
	Gg0lqeGWgmVg8bBhomANW+nr2cTdkIfLW8MNIg+oT20BtHpXGRKcYBPds8ZMfO/X
	9l2otN/pqLF9NS7Y5cFmrC+l1R23nEz0vKpaMJdc1Aanp4sWVR9ezLlG7+OKrnzu
	jzmoJa+BP+Y2Prl6ClRrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791375224; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eDG4wT1m2+KXLOk7PlTarHZwRvwA0Tg92kzwY6Z7K6ZPaPQ
	6W5K24FxJIjh3UWDIwkE1P9WmWKSiF527t55qClDk4QpjMOrE45Dyq0qvswTzC8W
	92IxdOqFggkCI/+vAwkZDr8wQQ+fe6SEuCdyDR9dcCnVaXQLYYX2Kps9XiBmIobC
	tR5rKzW4Yv7WUjKhRvkMrzVkNSu5KYd5VJN4t81ts0Su6fQMZ2YdEJzqyEXPUwcR
	LMKClimnUIO/gMkk2lSH+yAd8JAJ63cvwTEI1r6TgXy8t/RISy+RZLTO5nRbGN41
	PgVNRbz77T6n+1JneqGbnsgaKsFCEsrfhPebBSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kUQ0M+dMokAi7WqdzEItODh7iIduKBKGSJbG69ZC29E=:pjAduJb2e9xQkjKLcau8QTHMKpxpQwnh/QMd382YcVw=;
X-ME-Sender: <xms:eDfGanCbnH7mnLq8g_i9silBHLq84v_k6yVktoZwE2TRB2yR7GJ_RQ>
    <xme:eDfGaoWiI-NSY2OAlm2Ho03InXEn9T5jDJztoqlAty0nuU6wDwUzav_BXIefUiNa3
    7FE-yAFztO7UjsR8PX4tlevshKOdiDE2R82iOK7Mqcxzo9q3Z7C2Aza>
X-ME-Proxy-Cause: dmFkZTFQW+l3xg5/rXQHaAgtqPM1ecaKa0CMvdqqkx3GB3IMcWAoMiplIf1Lp7JnH0R/y+
    Y2da3scg+kubGDNmO9eRvO919zx/gl9uWExVAqbvqX8qdLx/WYPppdMM6/dyN1SV3WTo9j
    xTO9VlrC+WPEKkDV8YV2/sGjdcX8ff/UFpXrlKyoECoq4BgmAYpR9BwnCmxjdTHcJv+FHl
    NPfnLCCky4Zzu+V9WBnItJeZDFX4+UEHe9HscIyJxGBAtzRJxoyqtR/8klKpugqnsdpDEg
    P6hOn5nn7ByFyuHDOha/eLoo5rZzU3RoJAzT5mNshRbD1dt/BhWmqmAA33DFCIzGnrv8Tz
    G7DjYQ9PYaxnJfaw73ZN9Lia7Vdfx/yLzNmXZWRsQYc15Hq9k4sl1+ld5cwTJJquFWhU4n
    t8pCyyNMyCIcLnHTo4wdPXFblqMqrHBJRfXWVTxBB6zsU9t4JJOlo/a2CXXmBT1qd0E6d/
    naDPPy5yPebxkj3OPAbjyrUdgkVSd51XWTOt0Ygv7f03Ca/2jgkcZ+R2FdXYTdvU8jWxMg
    ejJM38y6vO6nMRgplaedMrLL3yyWCeC9g0kuFeJXei0IrkhlObFxCJhjgr3QQ2sUh1iuQr
    5HQcnNSQ/ZpiVRbzdmMHmZVGsyoMDUz5bSo5JHX6ihLkl64Au6bod5UtOIsw
X-ME-Proxy: <xmx:eDfGahqSOV1Peu8AhVUAXrRldaqC2gyU7mLF74AXO0FQjDA3AGsDgA>
    <xmx:eDfGahef3n__KWOkoWgMI0CDfcUIHu5wqA_5ev5qvKiXe9cVgm5okg>
    <xmx:eDfGaoqcLb0ffRXR7KyA-gSQ4qwKsWk-EORX9fipVjtYINOTgiPWYA>
    <xmx:eDfGaqHw3dCEeM7SKmmX79s-75IWTw5XQAG08i1gO8vttCPwuW7YuA>
    <xmx:eDfGanPM59KU4TOXIUhN873UpXtjcke8edRUxGwRhv2fe06CsV9-XQ0E>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96D5A780075; Wed,  7 Oct 2026 08:13:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKh1_XIvpk3w
Date: Wed, 07 Oct 2026 08:13:22 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Julia Evans" <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <99bc9624-47a5-469d-bcae-8daa9b01581a@app.fastmail.com>
In-Reply-To: <ea29fe74-7f76-440c-9597-fdbc173be90f@app.fastmail.com>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
 <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
 <ea29fe74-7f76-440c-9597-fdbc173be90f@app.fastmail.com>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate the docs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I recall only relatively recently learning that `-h` is not just a
> shorter way to type `--help`.

I just learned that recently too!

> Okay, so now we don=E2=80=99t have to list out every guide that might =
be of
> interest. That=E2=80=99s cool.
>
> I see that this would conflict with my topic
> kh/doc-gitbreaking-changes7.[1] Just would since my topic hasn=E2=80=99t
> been integrated yet (RFC). I use the old style of mentioning the
> new gitbreaking-changes(7) (=E2=80=9Csee <here> for ...=E2=80=9D. I wi=
ll remove
> that change in order to stay consistent with this topic.

> =F0=9F=94=97 1: https://lore.kernel.org/git/CV_gitbrchanges7_please.d1=
c@m5gid.xyz/

That makes sense to me, thanks! I saw that topic and funnily I've
been working on moving most of the content of `gitworkflows`
in the other direction (from the user facing manual pages to
the internal-only docs).

>>
>>      * mention the git help push form too
>>      * mention you can get HTML docs with git help --web push at the =
end to
>>        advertise git help's great features, and remove
>>        https://git.github.io/htmldocs/git.html since
>>        https://git-scm.com/docs has a nicer view and 3 different opti=
ons is
>>        a lot.
>
> Nitpick: Okay, but with the current commit message I don=E2=80=99t rea=
lly
> understand why the git.github.io link is gone. I have to guess that it
> is an effective duplicate of git-scm or something since git-scm does
> remain after this change.

Yep! It has the same content as https://git-scm.com as far as I know,
but without a lot of the nice features (a table of contents, an overview
of all the documentation, search, etc).
