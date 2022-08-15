Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E1C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 14:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiHOOun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHOOuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 10:50:40 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C09955598
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=ecgr6
        1SgumPHRMuZMP/7w5IXnNcQXYvU5LqIxVjJ150=; b=po8WjFdAb8WR4uWI0PZm2
        YE6GmA6DsGth1Zo7VTL/wUF5Q1uFE8ELLlKfxa80JSAsqD34InD/z5OnD3eoOAk8
        zYjI1zz2zr51OMINDf23inHts/myDMtXB67870p76My+IRBFeQs7HgvD/wgrf8EV
        Obr7u2/Xcfez72kxNrkGA4=
Received: from smtpclient.apple (unknown [110.185.173.201])
        by smtp9 (Coremail) with SMTP id DcCowAB3TysGXfpiquhdYQ--.56752S3;
        Mon, 15 Aug 2022 22:49:43 +0800 (CST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 3/3] doc: add documentation for the hide-refs hook
From:   =?utf-8?B?5a2Z6LaF?= <16657101987@163.com>
In-Reply-To: <CAPig+cQ4isWWEkfasdENzZWgUZzmBF9vXMTpM2XcxYaPgQbzSQ@mail.gmail.com>
Date:   Mon, 15 Aug 2022 22:49:43 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B180C0A0-0628-43D7-B73F-3F39A981A2BA@163.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
 <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
 <e737997eb31088a0ebe58c1db0e393a45170eabb.1660524865.git.gitgitgadget@gmail.com>
 <CAPig+cQ4isWWEkfasdENzZWgUZzmBF9vXMTpM2XcxYaPgQbzSQ@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-CM-TRANSID: DcCowAB3TysGXfpiquhdYQ--.56752S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4UKr4ktF17uw1ruryrCrg_yoW5GFy3pF
        W5XF15KF1kAr4jyws3Xw18GrWFyF93t34rGryUJa48ZFZ8AryxCr9F9rnYvFWxZrWvyw45
        Wa1qqw48Xr98Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRaiikUUUUU=
X-Originating-IP: [110.185.173.201]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiPhZeglxBtr289wAAsp
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Aug 15, 2022, at 12:12, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sun, Aug 14, 2022 at 8:56 PM Sun Chao via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> "git upload-pack" or "git recevie-pack" can use "hide-refs"
>=20
> s/recevie/receive/
>=20
>> hook to filter the references during reference discovery phase.
>>=20
>> Signed-off-by: Sun Chao <sunchao9@huawei.com>
>> ---
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> @@ -249,6 +249,54 @@ If this hook exits with a non-zero status, `git =
push` will abort without
>> +This hook would be invoked by 'git-receive-pack' and =
'git-upload-pack'
>> +during the reference discovery phase, each reference and will be =
filtered
>=20
> s/and//
>=20
>> +by this hook. The hook executes once with no arguments for each
>> +'git-upload-pack' and 'git-receive-pack' process. Once the hook is =
invoked,
>> +a version number and server process name ('uploadpack' or 'receive') =
will
>> +send to it in pkt-line format, followed by a flush-pkt. The hook =
should
>> +response with its version number.
>=20
> s/response/respond/
>=20
>> +During reference discovery phase, each reference will be filtered by =
this
>> +hook. In the following example, the letter 'G' stands for =
'git-receive-pack'
>> +or 'git-upload-pack' and the letter 'H' stands for this hook. The =
hook
>> +decides if the reference will be hidden or not, it sends result back =
in
>> +pkt-line format protocol, a response "hide" the references will hide
>> +to the client and can not fetch it even in protocol V2.
>> +
>> +       # Version negotiation
>> +       G: PKT-LINE(version=3D1\0uploadpack)
>> +       G: flush-pkt
>> +       H: PKT-LINE(version=3D1)
>> +       H: flush-pkt
>> +
>> +       # Send reference filter request to hook
>> +       G: PKT-LINE(ref <refname>:<refnamefull>)
>> +       G: flush-pkt
>> +
>> +       # Receive result from the hook.
>> +       # Case 1: this reference is hidden
>> +       H: PKT-LINE(hide)
>> +       H: flush-pkt
>> +
>> +       # Case 2: this reference can be advertised
>> +       H: flush-pkt
>> +
>> +To enable the `hide-refs` hook, we should config hiderefs with =
`force:`
>> +option, eg:
>> +
>> +       git config --add transfer.hiderefs force:refs/prefix1/
>> +       git config --add uploadpack.hiderefs force:!refs/prefix2/
>> +
>> +the `hide-refs` will be called during reference discovery phase and
>> +check each matched reference, a 'hide' reponse means the reference =
will
>=20
> s/reponse/response/
>=20
>> +be hidden for its private data and even the `allowTipSHA1InWant` and
>=20
> s/and even the/even if/
>=20
>> +`allowReachableSHA1InWant` is set to true.
>=20
> s/is/are/
>=20

thanks a lot ! I will update the patches right now.=

