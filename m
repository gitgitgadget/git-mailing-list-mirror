Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BFBC001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjHGUSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHGUSt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:18:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DCC10D8
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:18:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E98345C00B1;
        Mon,  7 Aug 2023 16:18:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Aug 2023 16:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1691439524; x=1691525924; bh=wVR4Qoq4ztks8OAdz3v1962nh
        hDgqjZIduGT81pU2Dg=; b=OyXPyopPeuJl/9xA1SDpHSjlAp+BO/ZIdNvZdmQ0F
        jGWkCIwkRyzjnY3B+q48GSel736aMiwGymmlRioyBdbvdxubewNehtvNTrgtOcrR
        4Q/xeT2gLGht8WKirEglkkBtUl8EYzI0UZjgY7Q8VCUFhZp0ba4OfXn/d1qJdkJN
        SZuH/sNQkflFVd5Kj0Hw7ozT8dBaeMNUU0IeynGmlKVeVlsofBLqMcgco4ylka2/
        F+P1m5GeWdmIJwt0Ab2WuYq95XfPjcdUCQcM1aGoLOFT/5evUrb+bQr8McBBsBb5
        3vyw8sWh7HOXNgZGDdaGplpHF9H+8cvML/R3WZoatgWPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691439524; x=1691525924; bh=wVR4Qoq4ztks8OAdz3v1962nhhDgqjZIduG
        T81pU2Dg=; b=zDazbUfwexPRpBDyGbIIWY0PvWat9kI16sWTJcqZ0tLsb25EP0f
        hLFz8Vmeym7n7Uu1iUOXq4psxAFO53K51B6QB6J6JChVGvZn2kxbDWEU6uCJJtV1
        FDZ6EyPEOCaQs9XRqb3EpJbpOlkcVZMACKGmS4wql4I5Ubcwqgi6VVyYuEDFsipz
        O2cDzh9Tltbt0PunyJWSV1mf/SuY7mVD9RWLxFHnlnDZeDxOf7yBpEO2JlpTrU45
        fh2JMoHvi8dA4WgefqUsMhI6FKkq3vXi088qSsESva3/4E8wPaJYlJ/N2dCa/IZF
        Vx1GN0WX8H43w//i8LafKoN2l3FRAfX9rbQ==
X-ME-Sender: <xms:pFHRZHxXc5IAhaqjwPuFWMnhO8NJ7TYY-1-axly7BxdXRxK0ZZKUog>
    <xme:pFHRZPTD-3Ht97dFga1zZTc0t037_QQid1lE2GDDzZ_fzcVXUG-vcCvvEDyH3seRN
    0RUyBhjbiRVYeWd>
X-ME-Received: <xmr:pFHRZBX_j-56EtsyYlbilGwLeZ0LbD-a_Mi5AC7ZQZLLRVTDj_oXnJtPsjazpZ-aUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesth
    hqmhdthhdtvdenucfhrhhomhepuehrohhokhgvucfmuhhhlhhmrghnnhcuoegsrhhoohhk
    vgesrghltghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvghrnhepvddvjeevvefhie
    ffleefgfegiedtjeffgfeflefhteduhefgheejhfetkeeugeevnecuffhomhgrihhnpehg
    ihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsrhhoohhkvgesrghltghhvghmihhsthhsrdhioh
X-ME-Proxy: <xmx:pFHRZBjmu5SDYRWTZkyMWnRYQp37T5Xh4D90UxB1LzJHL-mn_NzFqQ>
    <xmx:pFHRZJBMHk-EBVPC-kbpDBA3HCbCv95FEtyxW1hVdWWwpzqE5-UHUQ>
    <xmx:pFHRZKKVVt6ZgQfDBi4my_Qk0i47EgnU_8qQQKTzFxWLQdceYiRDSg>
    <xmx:pFHRZG6c8CQGI-RL76gq2iVjwQC-KRxY7ySK5V6r4HVneE5GxCdPwA>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 16:18:44 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Git Commit Notes (fetching/pushing)
From:   Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <xmqq4jlaj0dp.fsf@gitster.g>
Date:   Mon, 7 Aug 2023 14:18:33 -0600
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4230982C-7401-4EC0-907A-85E04074237D@alchemists.io>
References: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
 <ZM/9+YyOAbWWXQtC@nand.local>
 <3A1AEE32-4A0C-445D-A1D8-146CDCA03563@alchemists.io>
 <xmqqwmy7irsd.fsf@gitster.g>
 <2301E39E-B70D-485B-AFA8-F8DA64B366A2@alchemists.io>
 <xmqq4jlaj0dp.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3731.700.6)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hy Junio, thanks.

A few important lessons learned here (in case it helps others):

1. Use `push =3D refs/heads/*:refs/heads/*` when pushing (this is what =
made everything work for me). Especially since my host is GitHub in this =
situation and I don't have control to the remote working tree as you =
point out.
2. Don't use the `+` prefix for fetches and pushes as you point out. I =
didn't realize the value of this prefix until now, especially since this =
seems to be default behavior when cloning a repository so I was mostly =
following the default syntax.

Here's my working configuration based on your feedback:

[remote "origin"]
  url =3D https://github.com/bkuhlmann/test
  fetch =3D +refs/heads/*:refs/remotes/origin/*
  fetch =3D refs/notes/*:refs/notes/*
  fetch =3D refs/tags/*:refs/tags/*
  push =3D refs/heads/*:refs/heads/*
  push =3D refs/notes/*:refs/notes/*
  push =3D refs/tags/*:refs/tags/*

I'm a heavy rebaser (only on feature branches, never `main`) so =
definitely don't wish to clobber work accidentally even when using `git =
push --force-with-lease` or the `push.useForceIfIncludes =3D true` =
configuration setting.

One interesting side-effect that I've noticed with all of these changes =
is that my `branch.autoSetupRebase =3D always` configuration no longer =
knows how to automatically setup tracking for new feature branches when =
using `git switch --create <example>`. Even using the `-t` flag doesn't =
quite work either. I'll need to tinker with this some more.

Otherwise, all of this appears to be working nicely as I can push/pull =
to my repository and then clone the same repository at a different =
location on disk and see all of my branches and notes sync appear =
properly.

Thanks again, this has been great to learn!

> On Aug 7, 2023, at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Brooke Kuhlmann <brooke@alchemists.io> writes:
>=20
>> I ended up using the following configuration in order to
>> explicitly fetch/push branches, notes, and tags:
>>=20
>> [remote "origin"]
>> url =3D https://github.com/bkuhlmann/test
>> fetch =3D +refs/heads/*:refs/remotes/origin/*
>> fetch =3D +refs/notes/*:refs/notes/*
>> fetch =3D +refs/tags/*:refs/tags/*
>> push =3D +refs/heads/*:refs/remotes/origin/*
>=20
> This will push your local branches (e.g. refs/heads/xyzzy) to their
> remote-tracking branches (e.g. refs/remotes/origin/xyzzy) of the
> same name.  Is that what you meant?  It is unclear what kind of use
> you have your remote repository for, and in some use cases, it is
> perfectly valid if a push from here is used as a substitute for a
> fetch from there to arrange the push from here like how you have
> above, to push into refs/remotes/origin/* of a remote repository
> with a working tree.
>=20
> But often, a remote is used as a publishing point (i.e. everybody
> pulls from and only you push into it) or as a central meeting place
> (i.e. everybody pulls from and pushes into it), and in these cases,
> a push refspec would look more like
>=20
> push =3D refs/heads/*:refs/heads/*
>=20
> This is especially true when the remote is a bare repository, or
> hosted at a hosting site you or nobody has access to its working
> tree.
>=20
> Note the lack of leading '+'; that is absolutely essential if you
> are pushing into a central meeting place because you want to avoid
> force pushing that will clobber others' work, and it is also a great
> discipline even if you are pushing into your publishing point
> because those in your downstream will be disrupted if you rewind
> your history.
>=20
>=20

