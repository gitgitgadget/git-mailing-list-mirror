Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E6BC04A94
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 14:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHGOER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjHGODw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 10:03:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA663C0E
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 07:03:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 49AC13200932;
        Mon,  7 Aug 2023 10:02:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 07 Aug 2023 10:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1691416978; x=1691503378; bh=DKczb9oRm9V+7o02h2SbQKKCl
        PZE69WwLT1WF84/dnA=; b=wfIp2Bftbhf1/MSwmObicwg/KwqMO3i5sEkw3aXvW
        6DJxSWrpv7BJMoKuCSEfrZ87eP1nDSOWEpqhSBlvQjkccUFR4onp0BwzHOWO0SE0
        OAay3SoCaafYHfxZqXEIi7/GKHLE75fHDPihaOhFptim0YwZb+cHEfrH0cIQHc+H
        AkS15kJ9L6qFgIMQbpKqjk6Ae66zEOPcTdF7SV5lQFWdjfsKRdWoNc0dbE9tlXUv
        iuIRj+LbkeTbARjumMbh1gETw+FEfuta1ZNSmaggSGFiLhlUOVR75LVPLMpw4exQ
        oZP76HiJA3pqQx3z1ML8ss84Ow3ogKdaw35yG61uaYeLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691416978; x=1691503378; bh=DKczb9oRm9V+7o02h2SbQKKClPZE69WwLT1
        WF84/dnA=; b=kNZDwY5MBT+VgDh6p2lrCyDWmqo30tbbg4Dj5R7OuWlxzVganEc
        bxKklVYdxPTCfXY9bK5mzYPeghQ4+y7vqF4wxplZLRWAGS1JsWn0rS/xhi7+egSM
        iax632ElfzNd9ckH/krLgu8GgXkmaIPl4uzJyl4lxM5NyOcaEd6S+RllEE2wvRjh
        9HZ9ZEeBfu6beTJerf6ZGM0H/eMDjfcNN6Ki1HHFypDl07twPvs224UOJQMfn+W3
        b2F2mHGBLBfdLGz++aoU6zlxdmXATh/4l5iIupADGMLZnzZ9k7yWGpjvyfygDcvx
        4VhXIhaGUbaarp23QSpUvARt4XTW668ZBfg==
X-ME-Sender: <xms:kvnQZCd04X7gektGa6WG6H7JW35N7hVQkArIT_H1g4z2wOvM-JWbTg>
    <xme:kvnQZMOaQ8JE6R3509OZSXmKxD7TtGES3FLLigC8Pw_LjHVxApoT3WKYBMLvsvAri
    wJRgrJH1WvHPYAF>
X-ME-Received: <xmr:kvnQZDhv-DB2koClqxv1p3pqbSzWleNQEnSULGwGJOI0feJv2MxmlhQ01qhqCZSZpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurheptggguffhjgffvefgkfhfvffosehtqh
    hmtdhhtddvnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgv
    segrlhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpedvvdejveevhfeiff
    elfefggeeitdejfffgfeelhfetudehgfehjefhteekueegveenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:kvnQZP8WN2r41B-8zdsYD4ibtZSL1hiz9EdCAj4JEugSqNMyorEDtw>
    <xmx:kvnQZOuodUmYyAI_xmERZ_FCvynJVe095vfvBCVxSKIKtc8IpdfGkg>
    <xmx:kvnQZGGqZgDfsNDpFPzWg8lq_0Zk_fnJUQO32cKBfyJgd6U0Q1SB6Q>
    <xmx:kvnQZDVjlLfmPstGL-MVG2merRxajDP4IAAsSB6RoegGr8MXxARuXA>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 10:02:57 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Git Commit Notes (fetching/pushing)
From:   Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <xmqqwmy7irsd.fsf@gitster.g>
Date:   Mon, 7 Aug 2023 08:02:46 -0600
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2301E39E-B70D-485B-AFA8-F8DA64B366A2@alchemists.io>
References: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
 <ZM/9+YyOAbWWXQtC@nand.local>
 <3A1AEE32-4A0C-445D-A1D8-146CDCA03563@alchemists.io>
 <xmqqwmy7irsd.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3731.700.6)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio. Yep, I see where I went wrong now and learned something =
new in the process.

I ended up using the following configuration in order to explicitly =
fetch/push branches, notes, and tags:

[remote "origin"]
	url =3D https://github.com/bkuhlmann/test
	fetch =3D +refs/heads/*:refs/remotes/origin/*
	fetch =3D +refs/notes/*:refs/notes/*
	fetch =3D +refs/tags/*:refs/tags/*
	push =3D +refs/heads/*:refs/remotes/origin/*
	push =3D +refs/notes/*:refs/notes/*
	push =3D +refs/tags/*:refs/tags/*

The only problem is my feature branch never shows up on the remote. If I =
amend my commits, rebase them, and/or update the commit notes, the =
changes, once pushed, don't show up on the remote repository. I do see =
this in the output:

To https://github.com/bkuhlmann/test
   709004099276..1eefe6a1101c  refs/notes/commits -> refs/notes/commits
 + a966604d7864...e0a75df6084f release -> origin/release (forced update)

Seeing "forced update" in the output is strange because I'm using `git =
push` and not `git push --force-with-lease`.

Am I still missing a configuration setting that I should be aware of? =
I'm not getting errors but the output is odd.


> On Aug 6, 2023, at 7:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Brooke Kuhlmann <brooke@alchemists.io> writes:
>=20
>> ... o why default branch push behavior is being
>> ignored/overwritten.
>=20
> The root of your confusion lies around here, I think.  The "default"
> branch push behaviour is given only when you do not customize.  Once
> you add customization, you would specify _exactly_ what you want.
>=20
> In other words, the customization is NOT something you tell Git to
> do _in addition to_ what it does anyway (otherwise you would not be
> able to configure _away_ what is usually done by default when you do
> not want to see it done).
>=20

