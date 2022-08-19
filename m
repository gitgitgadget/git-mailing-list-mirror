Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA3AC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 15:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349676AbiHSPbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349193AbiHSPbi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 11:31:38 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E2CB100960
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=61285
        IxISbIWqgNY53ZdUZGaYGbo8XcSzD3+/aP13Es=; b=CWaTN4swNDlehi6V5E8/4
        livPOh2P/7WdG1hCgLf5BNV9hjMKHC0M9fFIqF/93klgJfBpuTpXKNqoCBFF59eM
        ZFlWgRCZSIOjKOKecxOVMt1/U7FjXlq3CSlzl0DAUTGYoNvMcBTb/xCaOZ816Xj3
        B0vyMVTg3Fya+rMlXmeoXU=
Received: from smtpclient.apple (unknown [125.70.13.115])
        by smtp8 (Coremail) with SMTP id DMCowAD3Eh2HrP9irxYHVA--.55179S3;
        Fri, 19 Aug 2022 23:30:16 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4 1/3] hide-refs: add hook to force hide refs
From:   =?utf-8?B?5a2Z6LaF?= <16657101987@163.com>
In-Reply-To: <20220818185111.4062955-1-calvinwan@google.com>
Date:   Fri, 19 Aug 2022 23:30:15 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Sun Chao <sunchao9@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F373DB9D-5C6D-4284-9DD7-D782DE1CDBCE@163.com>
References: <20220818185111.4062955-1-calvinwan@google.com>
To:     Calvin Wan <calvinwan@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-CM-TRANSID: DMCowAD3Eh2HrP9irxYHVA--.55179S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1DKrWkGryxtF1kJw1xAFb_yoWrJw4DpF
        Z8K3WYkw4kJr97A3WkCayxXFW0ka95GFy5Jas8Jryjqwn8XF1IgF9xKa1Y9FWUWrW8Wa1j
        vFWYqwn3Xas0va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsjjPUUUUU=
X-Originating-IP: [125.70.13.115]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiPghiglxBtvDVpQAAs9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Aug 19, 2022, at 02:51, Calvin Wan <calvinwan@google.com> wrote:
>=20
> Hi Sun,
>=20
> A couple of us from the mailing list reviewed your patch yesterday =
during
> review club and I'm going to summarize our thoughts here.
>=20
> Starting with you commit message, it is not entirely clear what your
> series is trying to achieve. While you do attempt to set the scene in
> the first paragraph, it would be better to go into more detail of how =
a
> user would use this hook. Do you already have something like this
> working downstream for you at your company? If so, that would be a =
good
> reference to provide context for readers. If not, try to sell your use
> case better to us by providing examples and anything else this could =
be
> useful for. Your commit message should also have a broad description =
of
> the changes, explain difficult/tricky changes, and dicuss
> tradeoffs/complexity. =20

First, I really appreciate that you spent your precious time reviewing =
my
patches and tell me where is not enough and how to do it. I will check
my patches again and I wish I can update it with better descriptions in
a week (I can do it only in the evening time so it need couple days).

>=20
> As Junio has noted, there is a lot going on here. For example, changes
> you make to pre-existing functionality should come with an =
explanation.
> One way to manage this complexity for reviewers is by splitting up =
your
> changes into more logically different commits.

Yes, Junio had given me some important comments just like yours and I
still very seriously consider how to solve them. I will split up my =
changes
and write more explanations.

>=20
> For your tests, they should show a working example of thie feature, =
the
> motivation behind the feature, and a description of the interface. The

Thanks, will do it.

> structure of the tests is also confusing and there seem to be many
> unnecessary tests. It is OK to be verbose and obvious in tests -- it =
is
> very important for reviewers and others looking at your tests to =
easily
> understand what each test is doing.

Thanks, I will refactor the tests and add more descriptions to make them =
easily
understand.

>=20
>> `hide-refs` to hide the private data.
>=20
> Why is Gerrit being centralized relevant to ref-level access control?

Will explain it in my next new update why I think so.

>=20
>> to the client and can not fetch its private data even in protocol V2.
>=20
> What is the reasoning behind special casing v2 here? Is it possible
> you're confusing remote helper protocol and wire protocol?

I will try to learn about the differences between them and answer the
question here.

>=20
>> +static int lazy_load_hidden =3D 0;
>> +// lazy load hidden refs for protocol V2
>> +void lazy_load_hidden_refs(void) {
>> +	lazy_load_hidden =3D 1;
>> +}
>> +
>=20
> What does lazy_load_hidden do?
>=20
> I know this is a lot to go thru for your first patch series, but =
please
> don't get discouraged! Feel free to ask any questions if you're =
confused
> about any of the feedback. We didn't dive too deeply into the =
specifics
> of your code since we believe there are higher level fundamental =
issues
> you should address first. There has also been similar discussion =
regarding
> differing ACLs within a single repository so it is probably worth a =
read
> here[1].

I will not be discouraged, and I=E2=80=99m very glad and appreciate that =
I can receive
important review notes from Junio and the mailing list. I want to do =
more
contributions to git and wish one day I can help to review other =
patches. But
first I will fix my patches and make it more clearly.

I need to reply first and wishing not making noise, because I think it =
will
take me couple days to resolve the review comments and update the =
patches again.

Thanks again.

>=20
> [1] =
<CAJoAoZmsuwYCA8XGziEA-qwghg9h22Af98JQE1AuHHBRfQgrDA@mail.gmail.com>
>=20

