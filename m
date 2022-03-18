Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA4C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 17:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiCRRmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiCRRmF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 13:42:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3BA196088
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 10:40:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64DAA18FA85;
        Fri, 18 Mar 2022 13:40:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PvHMy11kQxNt
        F2gw9VUqjduWCeKsi1Cx5hai2ue6hnw=; b=RNxqTW5XjrAEIu6z9nPxOn5kADd1
        sOLOlScYL0xRE4X+Om440wh3CfVg0KLNtCwWU7gwAgRsduku8dUJ6e6Rtx5cmp4M
        Qw7EI9tGERAjhQer80Zoqn3vzfjtww6txERBY2y/oL9sC/vI0ovXgXQZUomMHc0c
        aE+begLzqdn2p/M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D87C18FA84;
        Fri, 18 Mar 2022 13:40:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9C6718FA83;
        Fri, 18 Mar 2022 13:40:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?4oCN7Jqw7Iq57ZuIWyDrjIDtlZnsm5DshJ3Ct+uwleyCrO2Gte2VqeqzvA==?=
         =?utf-8?B?7KCV7IiY66OM7Jew6rWsKOyerO2VmSkgLyDsu7Ttk6jthLDtlZnqs7wgXQ==?= 
        <seunghoonwoo@korea.ac.kr>
Cc:     git@vger.kernel.org
Subject: Re: Possible bug reports for git-credential-libsecret
References: <CAPb83E-Y8grG7MVWqjqPH6SsdZ2JJ62XUeQAe=Wb_zgn0RL90A@mail.gmail.com>
Date:   Fri, 18 Mar 2022 10:40:41 -0700
In-Reply-To: <CAPb83E-Y8grG7MVWqjqPH6SsdZ2JJ62XUeQAe=Wb_zgn0RL90A@mail.gmail.com>
        (=?utf-8?B?IuKAjeyasOyKue2biFsg64yA7ZWZ7JuQ7ISdwrfrsJXsgqzthrXtlanqs7w=?=
 =?utf-8?B?7KCV7IiY66OM7Jew6rWsKOyerO2VmSk=?= / =?utf-8?B?7Lu07ZOo7YSw7ZWZ?=
 =?utf-8?B?6rO8?= ]"'s
        message of "Sat, 19 Mar 2022 02:15:30 +0900")
Message-ID: <xmqqtubv9n1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88BAB206-A6E2-11EC-BD0B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=E2=80=8D=EC=9A=B0=EC=8A=B9=ED=9B=88[ =EB=8C=80=ED=95=99=EC=9B=90=EC=84=9D=
=C2=B7=EB=B0=95=EC=82=AC=ED=86=B5=ED=95=A9=EA=B3=BC=EC=A0=95=EC=88=98=EB=A3=
=8C=EC=97=B0=EA=B5=AC(=EC=9E=AC=ED=95=99) / =EC=BB=B4=ED=93=A8=ED=84=B0=ED=
=95=99=EA=B3=BC ]"
<seunghoonwoo@korea.ac.kr> writes:

> Recently, I noted that the vulnerability patch (CVE-2020-5260) for
> "git credential" is not applied in the "git-credential-libsecret"
> program (./contrib/credential/libsecret/git-credential-libsecret.c).

The code in credential.c touches the data directly obtained from the
outside world.  It opens a pipe to backends like credential-store
and credential-libsecret and feeds the data that is cleansed by the
code you saw in credential.c::credential_write_item() to these
backends.

What these backends write come from these keyring storage systems.
If you look at other backends in contrib/ and also credential-store
and credential-cache, you'll see similar code to give "username=3D%s"
and "password=3D%s" back to us in all of them.

Do you have a reason to suspect that these keyring storage systems
the backends talk with can be as malicious as the data source the
CVE patch tried to protect us against?  If an attacker can already
contaminate the contents of the keyrings these backends read from
and write to, they do not have to use "git credential" as their
attack vector, I would suspect.

So I would think it is natural to expect that the patch you saw is
the only defence you need.

