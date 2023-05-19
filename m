Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85907C7EE26
	for <git@archiver.kernel.org>; Fri, 19 May 2023 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjESVgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 17:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjESVgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 17:36:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A949D
        for <git@vger.kernel.org>; Fri, 19 May 2023 14:36:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CA56A5C0120;
        Fri, 19 May 2023 17:36:44 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 19 May 2023 17:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684532204; x=1684618604; bh=VV873izQoMXQnJAiWkL0DZRX4
        tg7zkRdIT3n4PAmb5M=; b=fE+Dkq3kC06QzYxbMYwF9/fJShGhr1g7u8a8Ju/Bk
        Oe4KfyVX3FuTvnpX2koFFvz0XFfHi1IMpv0Ib4bTsLSwhHaDct9pkpdOxfkgOwOj
        vcXcjK801z/uhx2k3ERjhdUnyzyT5c+BKB/4MJJ0d0WHwD7yPV8q9Gtb9KUMBR6n
        IpCpQi6yc6d9PKeaifOUkzsCUiqH/M2MFLbwTZBYxHgHxpNvH3tx1MU791Nj0Wc/
        tANz0yA/lVhK7DGA5r2l92AoEgEjoXTSKiFvbECAo2FuO08LxOibgcN103GgZ+3C
        fS9Yl5Q/uPtqPKZ+gYH/myVYw5u0asPe1YwE1OTsHwxiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684532204; x=1684618604; bh=VV873izQoMXQnJAiWkL0DZRX4tg7zkRdIT3
        n4PAmb5M=; b=RMXem5ts6+STeqZDLVRqAnHn2zimWway4QNqrLIyf0lgFYaAtgv
        eT0i0wzrvGFtPjCRtqYSAxgOP1vsiKefz57k+vsFPZExLBC6j9NBQ77soeH1rSup
        33v8sPSoiE46Wqff9tIiA8PFj+Bs7D8z8ih2wKe0S+Tu0c2L+pijg5ZSPT1RvMpW
        FmfvqxHa87cfVMOaTmJ+lQX96Rw6NDgMTtTi1R3Vk13nlniendqa9PmAhxA/afZy
        2KhyGORcl95wYBAUjBsO3JWRZCUc0MgHzDc7Tftl4GGcffhOCRxrY8wvjoO1hr+k
        ng8bSOQWgVGH47fc1rFrBhuCbqe3gi8HymQ==
X-ME-Sender: <xms:7OtnZDtJPdzl1QD6SVbFigxGqJFRcc3WvQ8g-cIBHOTVF2kV_PDHdDI>
    <xme:7OtnZEdMPcrdD-SE8V9QcTOAQePTKzadwQKxFmJgrLPmgj7cySnd-ofU0gnhO-Qzm
    _79-CkX0IG55yRGhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiiecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfeliefg
    kedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:7OtnZGycdQmsDZDXi1T5EfNSrFiGG-jHLu3MGnVFPo5pRW7bp8aVaA>
    <xmx:7OtnZCMOENLVpEfG5U8rGSVu_p_SKU5pjf2wblLhyTDpzXrWLw3lwQ>
    <xmx:7OtnZD87EXylm4Q-iLEQhMH0sRRtZ-UrAeLT5OhsYJGDgwremGIVqA>
    <xmx:7OtnZOmVzvl_eYZ8DMDrbHnBqeTQH0rrRHGw8dhtZhc2MNa2g9fFbA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4FB0515A008E; Fri, 19 May 2023 17:36:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <90871d5e-2838-4026-bd83-ab259f7b18dc@app.fastmail.com>
In-Reply-To: <20230513165657.812-1-philipoakley@iee.email>
References: <xmqq5ybug8s8.fsf@gitster.g>
 <20230513165657.812-1-philipoakley@iee.email>
Date:   Fri, 19 May 2023 23:35:49 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Philip Oakley" <philipoakley@iee.email>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        alexhenrie24@gmail.com, git@vger.kernel.org,
        "Elijah Newren" <newren@gmail.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>, tao@klerks.biz,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH 1/1] doc: Glossary, describe Flattening
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Sat, May 13, 2023, at 18:56, Philip Oakley wrote:
> Clarify the term 'flatten' and the unexpected effects that the user
> may come across, such as discussed in [1] and [2].

Nice to see this effort. I would like more =E2=80=9Clabels=E2=80=9D such=
 as this one to
conceptualize things because sometimes it feels that Git concepts are
just handled bottom-up. Specifically in the case of rebase it seems that
(judging by things like StackOverflow) the pedagogy amounts to
explaining how rebase *works* (without factoring in `--rebase-merges`)
and then explaining how that in turn means that a linearization kind of
=E2=80=9Cfalls out=E2=80=9D of that process. And then it seems that you =
are expected to
remember that bottom-up explanation without putting any kind of label on
it; it=E2=80=99s just what it is.

> +[[def_flatten]]flatten::
> +	Flattening is a common term for the 'linearizing' of a
> +	selected portion of the <<def_commit_graph_general,commit graph>>.
> +	Flattening may include excluding commits, or rearranging commits,
> +	for the linearized sequence.
> +	In particular, linkgit:git-log[1] and linkgit:git-show[1] have a
> +	range of "History Simplification" techniques that affect which
> +	commits are included, and how they are linearized.
> +	The default linkgit:git-rebase[1] will drop merge commits when it
> +	flattens history, which also may be unexpected.
> +	The two common linearization types are chronological (date-time), and
> +	topological (shape) based orderings. Generation numbering is topolog=
ical.

When I first read this I thought, ah, so this is an explanation of how
linearized rebases are born. But this part also mentions history
viewing. Then I thought: does my history viewing (git-log(1)) work the
same as shuffling around changes into new (and linearized) commits? And
can git-rebase-(1) move between chronological and topological and
ordering? But these two things feel different to me (just a feeling,
UX-wise). So after reading this I am left wondering if different parts
of this paragraph apply *only* to history viewing and to rebase
(=E2=80=9Crewriting=E2=80=9D).

Again, this is just how I immediately read this paragraph as a user.

--=20
Kristoffer Haugsbakk
