Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC479C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCB16140E
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhENSLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:11:25 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39221 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232649AbhENSLY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 May 2021 14:11:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 727C813A9;
        Fri, 14 May 2021 14:10:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 14 May 2021 14:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:content-transfer-encoding
        :in-reply-to; s=fm3; bh=SNcdWnYuJXqv3XR/URN1Z+d6Trw5VNcEMIFRBSll
        lyQ=; b=XchzOpNtXEuqKItkmICWvcgGOWTHpQadTDy9ACCx8Md9hYkH2R0Nji2c
        YgKojjwnWv/xW8cHAap8kQR/RCc0gkWAy7X96AlJzKPJJ+nw9PcLRkjIi//C0cSC
        BgV9HsXZ8Xol12LjC1g/Wjb8I+yNWcUtn+DU9q5VFU1x+cN2K2wkbx1PR5tHisjd
        nUKtzpiE5dXBdGom72WvysYZemMEW0rVmn652pF/LEGqX7OWMvE9ogdU6FobF7Mu
        wYqajPCFKcSJo0pEx881fXTenHzK1uhyO2pId5t4dQFnV99HqrL0VD3y4edg4NdU
        t5k8/OLIjNzYrvqP7Od5A+vngQaGpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=SNcdWnYuJXqv3XR/URN1Z+d6Trw5VNcEMIFRBSlll
        yQ=; b=RjdP4iQvKWo3vnOodhdHPXK8rvHWHbMJZ/5VSfZe6/HUUTR/QgJuWYedO
        /jwjAquS049z2okcgTyNKZ0O5wg3eCs9bQgYrVCZjWIVukFAzFjqYqAFvWUMfuuT
        tAr+aNur6BCEKJ+t3VlCFEV3xFZG8Ly9WiR0NV+mrJsiiIb/+QMqKQkMBgKDd2Vd
        YXgI6qzZGz9/fVuOIZrGk5v4mPpD/vKrDCKpt/jACmUllmEi+4FYkKTv2tYLSGqy
        NPkMx/5Rly+U67w+25T8NfmZOtKEAmiQlEnjsFP9ogcjCmQoCNgaSaqup5UAHBI+
        fcpMiaBsvPjj5e/WVrhW/3N9NcPXA==
X-ME-Sender: <xms:A72eYCZbW_XGDPceXRX_Ekwp16EvhA3lDen-xhIk5A2eQnI6oBr04A>
    <xme:A72eYFYPyM5A-0m7Ytg6u4NYtCB_I4oqAegT6guaZ6AvtVcH2xIzY7Vfnk5u4RKpC
    FYmit8EF_Rbs9Qe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjfgesth
    ekredttderjeenucfhrhhomhepugifhheslhhinhhugihprhhoghhrrghmmhgvrhdrohhr
    ghenucggtffrrghtthgvrhhnpeegtdehhfefudeghfeftdejjeegleffveefvedutefhud
    egkeelffelvdevieekudenucfkphepudejgedrhedvrdduhedrfeejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprh
    hoghhrrghmmhgvrhdrohhrgh
X-ME-Proxy: <xmx:A72eYM8jnneBHkOvpoS-DYiCByQgptmFcPL4a-ZkiyPLqdzrJvTvZQ>
    <xmx:A72eYEqlOMy94LPlQZ-8FgbEqh0Qh6T6MBdz2eZw5dgUZpWwfs-ydg>
    <xmx:A72eYNqgGqFZHuDuy1bEDuHxr3amnqkMSlkbt9nPVwhp6GX2nqJsQA>
    <xmx:BL2eYMRL2IlBZvwIwFbUA7FnqX08bdigp44y9RaHsfSvW9XTW2yi2w>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 14 May 2021 14:10:11 -0400 (EDT)
Date:   Fri, 14 May 2021 11:10:09 -0700
From:   dwh@linuxprogrammer.org
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <20210514181009.GB16542@localhost>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost>
 <xmqqo8de9wis.fsf@gitster.g>
 <875yzlsngv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yzlsngv.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.05.2021 10:49, Ævar Arnfjörð Bjarmason wrote:
>I agree insofar that I don't see a good reason for us to support some
>plethora of hash algorithms, but I wouldn't have objections to adding
>more if people find them useful for some reason. See e.g. [1] for an
>implementation.

I think Git should not try to do any cryptographic operations at all and
rely on external tools that are implemented properly and hardended.
Implementing cryptography isn't just about translating the algorithm
into code but also getting memory security correct, file handling
correct, input security correct, control flow correct (equal cost
multi-path), etc, etc. Most of the cryptography libraries aren't
designed to be misuse resistant. The only one I know of that has that as
a top-line requirement is Hyperledger Ursa [1].

I would like to see us remove all cryptography code (e.g. digests,
digital signatures, etc) from Git and rely on external tools entirely.
If we store the cryptographic material in a self-describing format that
identifies the associated tool as well as the cryptographic data, then
Git can be completely agnostic.

>But I really don't see how anything you've said would present a
>technical hurdle once we have SHA-1<->SHA-256 interop in a good enough
>state. At that point we'll support re-hashing on arrival of content
>hashed with algorithm X into Y, with a local lookup table between X<=>Y.
>
>So if somebody wants to maintain content hashed with algorithm Z locally
>we should easily be able to support that. The "diversity of naming"
>won't matter past that local repository, any mention of Z will be
>translated to X or Y on fetch/push.

Using self-describing formats allows us to honor history and keep old
object names as they and eliminate all of this added complications you
describe. I think there is a lot of room for errors to creep in when
collaborators have copies of the same repo and they have local mappings
between different hashing algorithms. How is this not setting up for a
combinatorial explosion of data? If the canonical repo uses SHA1 and one
contributor uses SHA2-512, another uses Blake2b-256, and yet another
uses SHA3-384, won't they all have to maintain six different translation
tables for all objects? SHA1 <=> SHA2-512, SHA1 <=> Blake2b-256, SHA1
<=> SHA3-384, SHA2-512 <=> Blake2b-256, SHA2-512 <=> SHA3-384, and
Blake2b-256 <=> SHA3-384? I guess that's your motivation for not
allowing algorithmic agility.

The way around this is to use self-describing formats and external
tools. Git repo copies wouldn't be required to have only *one* algorithm
naming all objects, requiring the translation tables. Instead Git repos
would/could have heterogeneous object names, each one with a single name
generated with a different digest algorithm. Git would simply consider
those names as plain strings and validating those strings requires
talking to the correct external tool, sending the name string and the
object data and reading back the result.

I think this is a much better approach because:

1. It creates algorithmic agility in a way that isn't top-down and heavy
handed.

2. It eliminates the need for all of the translation tables and
round-tripping complexity.

3. It empowers maintainers to decide which algorithms can/must be used
when naming objcts in a given repo. Merge hooks, CI/CD checks and
etiquette guides can be used to enforce this.

4. Git's attack surface becomes smaller (a very good thing) and limited
to doing IPC to external tools correctly and securely (easy) instead of
trying to get cryptography client code correct (very difficult).

One other thing to consider is that there are new tools being developed
that do similar things as Git that do have algorithmic agility and use
self-describing cryptographic primitives. Late-binding trust is now a
best practice and has been for quite some time. Many people rely upon
Git and I think we should keep up with the best practices.

Cheers!
Dave
