Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955C8C32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 05:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308C5217F4
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 05:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="asKBZila"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgADFRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 00:17:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54451 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgADFRw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 00:17:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84699993B5;
        Sat,  4 Jan 2020 00:17:51 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=lFA+NOUvJPvHt
        /1moGkpRKrszwA=; b=asKBZilaiUn+9Dvd2GCjMUc64Cyo2FoJJaIW1tWkWtnLc
        1QmRgPQxFYoc4TRxlUv2KWLoqAF/P1umhrdAVLkuKW3D31PXKpTKJ61dixN9DFI1
        LOAbdYjETaEgT2XjqkVdMbuTpGgoWsq//eOlw7EMq5EGMabDCoZXiq6o3O4XMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=QLAM3WO
        JYK78u+uVdZnFm70b9RksyKwPY9UifbHlwMM/h3/aoCF6YVaicW1ZLTwPZcIb7K2
        BxM7mUN8QoXDjV/dFCJcV8pizx3uwQ0NfRy9wgbLrsn0MhgYvwFDwJIBUiOBGOQ6
        P2UsKtSAYJl2pwYHJNZDYxWWmet2NCY+mmsU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C3C2993B3;
        Sat,  4 Jan 2020 00:17:51 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.198.29])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 41F61993B2;
        Sat,  4 Jan 2020 00:17:45 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sat, 4 Jan 2020 00:17:41 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?iso-8859-1?Q?Fran=E7ois?= WAUQUIER <wokier@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: git checkout -
Message-ID: <20200104051741.GJ9927@pobox.com>
References: <CAFS-fjvhAB5EcfHhfp6HYN57W11tkHOc8K8T3oey8qceutuYsg@mail.gmail.com>
 <20200104004826.GC130883@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200104004826.GC130883@google.com>
X-Pobox-Relay-ID: 8B0BC2F8-2EB1-11EA-A460-8D86F504CC47-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Nieder wrote:
> Hi,
>=20
> Fran=C3=A7ois WAUQUIER wrote:
>=20
>> $ git checkout -
>>
>> I often use this command to go back to previous branch from my history=
.
>> It is quite natural as it uses the same syntax as =E2=80=9Ccd -=E2=80=9C
>>
>> But i found out it is not documented in
>> https://git-scm.com/docs/git-checkout/2.24.0
>> I report this to help others to discover this time saving command.
>=20
> Thanks for reporting!
>=20
> Ideas for what the documentation should say about it?  (Bonus points
> if it comes in the form of a patch against Documentation/git-checkout.t=
xt.
> ;-)  See [1] for more about how that works.)

Not to say that it can't possibly be improved, but it is
mentioned in the git-checkout docs here[1].  The second
paragraph in that section says:

    You can use the @{-N} syntax to refer to the N-th last
    branch/commit checked out using "git checkout"
    operation. You may also specify - which is synonymous to
    @{-1}.

This is also in the git-switch documentation, where it might
be easier to find, as it's very close to the beginning of
git-switch's man page, in the "<start-point>" entry of the
OPTIONS section[2].

Being easy to miss in the git-checkout documentation might
make Duy smile; it shows the benefit of splitting some of
the many features of 'checkout' to the 'switch' command. :)

[1] https://git-scm.com/docs/git-checkout#Documentation/git-checkout.txt-=
ltbranchgt
[2] https://git-scm.com/docs/git-switch#Documentation/git-switch.txt-ltst=
art-pointgt

--=20
Todd
