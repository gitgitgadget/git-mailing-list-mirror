Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3772BC3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 11:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiLHLu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 06:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLHLuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 06:50:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FF8D645
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 03:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670500151; bh=7SXflLX4HSFk6a4fk9EZcFQ7mmA11doedkJQRmdaOzg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FotBGFJBaFP34AAmQdxnzueOPQ+ESKq8pmnMMRGhnItBP73aMdMm3G9fgtUij/Xnj
         VJjypIM3PUB9Ga0x0A4RLmm6+E8I/BarF0VYmAHVpIrxqbMU/ukrFV1RL+Ogmd+uAY
         KGXkqfqCKoypiYDR9LXr/VUdjA0reDPnVgKUg8CtG2T0oQxLO+OSps/UHaBx8OP+0U
         LvQG21QR0YCgfGKUMki5KN2RZeREok26azRpRiJnvFgHBweuihex7okYKL3WjYWqD1
         ihlSmErkR39OKJDBJkztYN9soaDMKjMFOnqtxIx5BvBdJhgRxtPRlde8IwdBpYa+Tp
         Z8H1McbTP7uTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1p1KO52nYh-007WGe; Thu, 08
 Dec 2022 12:49:10 +0100
Date:   Thu, 8 Dec 2022 12:49:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t1509: fix failing "root work tree" test due to
 owner-check
In-Reply-To: <0efeec8abdb913786c67775cbd79c8e4285ded10.1668999621.git.gitgitgadget@gmail.com>
Message-ID: <n7q85691-5p25-464n-12o7-q4s4opsr2p0o@tzk.qr>
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com> <0efeec8abdb913786c67775cbd79c8e4285ded10.1668999621.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d28RIcwWbuMYyNrfaMhJIIDLrb48t+29heSvZNq3R818SUsPClY
 YKCYfY846tYGzj4iZdujKZyMSUv3QmIRZfTgLMOUHis4Uk+hMevhoIh2Oi58EfGU9qYBBjH
 6SjMNrAYCeWXHYcLc1+OMVT5SKjunPoBJthN9bS0wD5X6adLLGdmPiKDBfeckmuN5sCHkKH
 +MhqUekIIX50mK+e17maw==
UI-OutboundReport: notjunk:1;M01:P0:+CXQIhxqxek=;kVus3B5EYMUUOTHUnkKeIm/mE5s
 SWSlo+ijdqsBGVsEMJ9ye5Yx603wX3clG8EcKrbFsefwcBCdp71oJI6P/XPYy+yqXmGAk5A11
 VlB2t9hMijRV7lBvowSaq1SndXlMvucFzGdMdAJSxq9ktZSsopEpz4dHytDuNcDVRLK28Ofn8
 2LgsYI0vlmC/vzQwGKNavQ0HKcsqH73Ko9E34kIeOTjCcEt+qWHCLvBSSW8RtVQzbD38amKfa
 FpF8wb0aZbzhXpIQ22VhW4TAjOecpzF1lXxO36b7YKDylkp9/n1Sk4XFs2CwwUeAZnb9SNZae
 aF2airWb9xXsAxleadET7Cq+NDcVTRhJwNNAcfoa/QSs070SAslT9EJ5DbVGtGC0j6zm8t+b7
 o+8WNDhfHbXQo+UAGS7K7LqHxwsOcxA61aJlwbXbV7PqhM6581tHsBe+d8tqBqq0K4+Fac73T
 58rKtRJG/eSZ45F6iPSsyK+U8eeKv/2bK5No9rX2VjmmU7J6kCZBsjVIHglQ9JWPGrjFnmt5r
 KOJ+NUqVPxuA2T7wXu5bOmneo5WF6ppZBRCJp7zSEFhhYhlN6AZQCA51oLOMGXJ9OGIfeNNV5
 Tl47DlSRt8mWtKVu7Qs0D/SC9+sPt3vjKVtfAHwO+9klEKPDnjVGgL1A0HrMkvrjmbWeasoeM
 4l2cm7BdhgxCiU82zMaGHcQtjSOcIYbaCIFzl+1xuLycy8O4Z49+4oGYh/RR/guI5NPgQf6Rd
 eGNkTOVjuV8Q8mbCXnFl3AyA6egYe9rbirTG8Qwk+D2pa9mwAypvKwvJ3yrGKwgJneywFHtK2
 UyKQWCZGKpexO5YdNjPXr0SJG8OJSfbp+avJJp2xW4W0GLec3KjUShWBPtDXnd3FoZpYKG3T7
 TTHk8jlIr7B38sOSFcHeEv5PcZUl2CYi4GOBrEfuWDzs9ECa34VA7aP0zRMffBaY4KGxZOQ4f
 mQh/lhIvRHiMSdfHdqUOte9GAm4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 21 Nov 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> When 8959555cee (setup_git_directory(): add an owner check for the
> top-level directory, 2022-03-02) tightened security surrounding
> directory ownership, it neglected to adjust t1509-root-work-tree.sh to
> take the new restriction into account. As a result, since the root
> directory `/` is typically not owned by the user running the test
> (indeed, t1509 refuses to run as `root`), the ownership check added
> by 8959555cee kicks in and causes the test to fail:
>
>     fatal: detected dubious ownership in repository at '/'
>     To add an exception for this directory, call:
>
>         git config --global --add safe.directory /
>
> This problem went unnoticed for so long because t1509 is rarely run
> since it requires setting up a `chroot` environment or a sacrificial
> virtual machine in which `/` can be made writable and polluted by any
> user.

ACK, this is the right thing to do.

Thanks for working on it,
Johannes

>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t1509-root-work-tree.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
> index 553a3f601ba..eb57fe7e19f 100755
> --- a/t/t1509-root-work-tree.sh
> +++ b/t/t1509-root-work-tree.sh
> @@ -221,7 +221,8 @@ test_expect_success 'setup' '
>  	rm -rf /.git &&
>  	echo "Initialized empty Git repository in /.git/" > expected &&
>  	git init > result &&
> -	test_cmp expected result
> +	test_cmp expected result &&
> +	git config --global --add safe.directory /
>  '
>
>  test_vars 'auto gitdir, root' ".git" "/" ""
> --
> gitgitgadget
>
>
