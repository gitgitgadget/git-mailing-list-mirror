Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEFEC8748
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 08:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbjIJIWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJIWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 04:22:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6EC187
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694334151; x=1694938951; i=johannes.schindelin@gmx.de;
 bh=1fHqQgnmNqWuhDYWcLgcUnu9MeMHNzaqEk+Vz5pELU4=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=CTnbM7sKpGOcoEuLGHgZOKpfkTzNGf1xZIUR9zUjlhmjUl85ZUiR7k9dnNHmzRfpuLJzqUs
 ECu+MFy/1rfwtyjNjeX7zHGIAzq1/plxKalv/En3saui0qndvi+0HFZdknbA7jicQUaYRaQ5X
 TcTfQMKS1YRoU8vVNXZPdjkWl9WkoXpdx3NpFio+JooJcw01eiGnqpeFwxhWzW2GP1jxZbLJ1
 5OqB+Qu4ijNdfpTbegBuo9pBX5nhmb8Kw+ilTQTxDj3WwebKRJvkUwyavI6ie6Zw3ToC39omv
 P2D2Kl/NdC7a/n0mlmoj0sp1AKTZfvT4EExWTXmEISoSMUrCuXCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([46.183.103.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1qaprq3Dvc-004RN6; Sun, 10
 Sep 2023 10:22:30 +0200
Date:   Sun, 10 Sep 2023 10:22:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Todd Zullinger <tmz@pobox.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] completion(switch/checkout): treat --track and -t the
 same
In-Reply-To: <ZPtISYVufU0MazO_@pobox.com>
Message-ID: <4f7d166c-040e-eb7c-ef27-81f9748d44a0@gmx.de>
References: <pull.1584.git.1694176123471.gitgitgadget@gmail.com> <xmqq1qf8vf1e.fsf@gitster.g> <ZPtISYVufU0MazO_@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vutMvaAJGp9jfNP1U4m5QAnL6Vn/hap0vPkUzULsJR/8VLX63Bn
 UaWtvLyY6dOqalluPpJxBuORT/HzkenQEkyyj6jc+w5CDNbacoitsMYLwJpyNRdbfUHLxXN
 3nM1gnWFu718v4HFbOhm6ZohwFL/0IuKE3tomKtVdsVTkZrsbRQhanSTa1irwdNE1yUrstc
 J+8Cc1SRlf1F+w4l6zREQ==
UI-OutboundReport: notjunk:1;M01:P0:uaewRgxVMw0=;PvetSvn8iXFV8oFTwSjLZ6itHw8
 TVNVSURsYnmdN/b26ejmfhINb/wUXb/gNDKVM7kouWlHOXzTyM4GZEletmIfzdZKS0EwxvzeI
 0v7iFs1nYBOISVpbLtq91ueeChicwPo951kD3VNY22WGgmPID7TJcg5Zs3QsH/m6fuJKM0PpN
 +48dZLJKZFReqn8PnZybt6ZbQBzcBNy8RTqnT7uSwmQHcEZQb0pyypyz1IXW3UVwn2Fl7trsW
 yxp5BBa0NkrjGtdexX+mQ8LMjPkzZAIGsZEjmQheWZ6SVMetzwf3B9ZZeyZV1qqeMrYfE5cVe
 J4AqYezZOInrlUW91AOYGxjrL6BZXE+jYET22Z4aj7SYeE1m/U5VX7Ls97f+ynMM0SUEhZqAk
 sYm9sJhjamK1kDb9RxW4Mp0mTogzOHJyoyDRs6XU8H3PnajU/blCoSXW4/0qNadcYqLo9bvzJ
 TetEn/2p1LugJmVopnqdU9fc7bPSfvDal2W532Q1N7CKZ4sDLkqFnRAn8FYtSNnCZqjCxyPe3
 Hjl+oeiBkXR+y1nfEeFaddn72t1OClPiLW4Hk5y375RLflyOS3Q8hQffDYI6nTL93J0KqBhlI
 UcFreZ8wG2+QG4P1n6hCTtnEvqEb/Mnj1nJKTeXxTLKF9vQgQ9xx5eQ6RHi9VRFaO2+nAWXFq
 A2uEWoB8I5DzhEj/Xk9n1lp0F1Pj13JFv5PkMdwaid8Y5U/h19d0L746QofpkjvW8zoJIfGFa
 hVcqE60UXkNA8ZMq2kPmtHCwaOrBhA3gx5mE6rkc2kbe0CvI3QhGp+IbjAS/yZJXbsGPUxdH1
 MZuH6il7okXfzNEKKUkZ+7im4j5H4haqpnF9cjkKW8Hk6OQCEsOJfQRnQo5m3/HHnK06bwbRQ
 96In3kxKFfaN4aRsQAcDZtGXHd6ZcaWLZqVjQmDhA8kMK7nZiXY+2X7i4kMell3+9KdDNctG+
 RBUiWnNKTVox5x4kIexgUQDjAH4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Fri, 8 Sep 2023, Todd Zullinger wrote:

> Junio C Hamano wrote:
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> >> index 8835e16e811..df8bc44c285 100755
> >> --- a/t/t9902-completion.sh
> >> +++ b/t/t9902-completion.sh
> >> @@ -1622,14 +1622,22 @@ test_expect_success 'git checkout - with -d, =
complete only references' '
> >>  '
> >>
> >>  test_expect_success 'git switch - with --track, complete only remote=
 branches' '
> >> -	test_completion "git switch --track " <<-\EOF
> >> +:	test_completion "git switch --track " <<-\EOF &&
>
> Is this new leading ":" intended?  It looks out of place
> (though perhaps I just don't unerstand the context well
> enough).

Thanks for catching this. It is a debugging left-over, when I wanted to
make sure that the `-t` validation I added would run immediately.

I see that Junio helpfully dropped it before merging down to `next`, so I
will refrain from sending a v2.

Ciao,
Johannes

>
> >> +	other/branch-in-other Z
> >> +	other/main-in-other Z
> >> +	EOF
> >> +	test_completion "git switch -t " <<-\EOF
> >>  	other/branch-in-other Z
> >>  	other/main-in-other Z
> >>  	EOF
> >>  '
> >
> > So, this demonstrates that '-t' behaves the same way as '--track'.
>
> --
> Todd
>
