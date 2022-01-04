Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE31C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiADMVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:21:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:53419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbiADMVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641298894;
        bh=lNZ8BAtslZEV+OrzU6oKRIdrO0i9mZueldlAKtFo1Kw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bxselfyuiHCyP3fEsuQ50drdjisPYjWuBl6U8dYrVt4+hV4spZNKN2cp+jlwSQ8dl
         ehRw6JbWf2UtT7+rUf3XNkG4AE5la5nng+eqLK82o3mgpY6dmTDys5JRuAWgaRPl5j
         dP9211J232u3FMeebMMEJUk2wqllcD8z3MqLTXlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1n6dgw3qQB-004G7F; Tue, 04
 Jan 2022 13:21:34 +0100
Date:   Tue, 4 Jan 2022 13:21:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     James Limbouris via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, James Limbouris <james@digitalmatter.com>,
        James Limbouris <james@digitalmatter.com>
Subject: Re: [PATCH v4] subtree: fix argument handling in check_parents
In-Reply-To: <pull.1086.v4.git.1638929518657.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201041319300.7076@tvgsbejvaqbjf.bet>
References: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com> <pull.1086.v4.git.1638929518657.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HuRhHT1rChjQFFkzrxkd53ivZREM9fSf1nvhIlwVN3Z4SA+g992
 OkG210KFOlZLYlPCaDxaUzXCZXlMDbF79Zh4LDKbHpp4l4KLa4/89aUsHSp2fgTcVenolhP
 i6wXYtTxAbdzW5PxMM2vTjvykInBJJU4IfebRbQxQtcVP0CUqzamIEg8OEyTmHR7rhUgUpg
 PTYEnMBMCtVCmfYbtedZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:omJH83F1njQ=:zgN2mEw28H2C2ZKm3ylO0e
 qhwwmNbJgrbriv62GMKNohGGrZUaGiTfRlFTLRyhqDoHVujbfcRgWRUlsZACA3aqDtaZz+qqn
 xAmicBhf15ZHsPt36GfSRfXEva2Nca8H9TQY7FJBWVzS+RyHnQLxn9kxT6aApQrko1CRNKnQ3
 k32/TDsEsbYFVRHyw2WPv868SNUm56EQ2hsnx+ioc/ncTIge6e53gRMTFz7F92LTaHQmK4dH7
 1UxM8BxoJO39CQyoxwUQ1quaBqJJFp3RD1VN/uTranmDl5Kr0E6kZOcpnPvYp5BeZZ495X++x
 30216LSHUv5IOe8sOaZR8HEB0Fy8RJCuNfVuxIEV0oAEyPOPpuza0pQ099tAAuSauzLsf+QMY
 NoKEYB7HQdW2nCXJaXA8nfIt54UePUK7B/5gnhQwoeyBHn4kDexKSKPrDY2j3t803tHK90Xgm
 5IHjBHodrduH7dlWeBkK6tG/qEbrcF7WFZStBQ11G2nLw9Djn2+zyxRVzYFYhBrPjaufQypIc
 HrcVlwsX4v1WhT82zjNMrahEV2BU6hb16PQ8oHK7Yu+ynVmSExNikinnWkRV8sHIJmBc9Hxz7
 aTWuPx1TcJQOrL57LCql4l9J0u2G2tGII2ymQEXbYSaNtsnXE9gQrlflSSOSrNhxmTfHle5Xj
 KZqxeTKW1ci88hFaBX0LO4FxioAnMt1ssr83jpJEi9Ngi2iDPgRWOOmmxrVj7ek+I0lU7fTBh
 nOyJei7uz1Fyx7s9GNHO/05P3QWOrUTfg8JLbPNHyeWSrIrASlH9qnQyib+qn1dN9E1xW01yy
 0lnD9m78gQMtq7I3aAC7dgpACr3VwLhzl2U1DbC3+bJOcBatKsuigDk0aB3WHUZEhejiyCPgc
 iXQoVMBU5NJAjWWs9y5+BqCnRU9iJWp5jMBwEpcTSUysi6k8mXyRZAY120PzdOZsisJSCO51w
 Oj5rvTnd7bsTd6ofWAegM0pbVrIyffqhRX2GA9XlHEbphuKFkaxkeRqradf9IWd5y00FORwiS
 6DTiysC2j5o98e4PGOypMGJw6oxf5RlJvNRZrs+s5Gab1okrlTVhLX+SQA1QsccTizIAjfNy2
 CdZ/YiFwkKWTQo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On Wed, 8 Dec 2021, James Limbouris via GitGitGadget wrote:

> From: James Limbouris <james@digitalmatter.com>
>
> 315a84f9aa0 (subtree: use commits before rejoins for splits, 2018-09-28)
> changed the signature of check_parents from 'check_parents [REV...]'
> to 'check_parents PARENTS_EXPR INDENT'. In other words the variable list
> of parent revisions became a list embedded in a string. However it
> neglected to unpack the list again before sending it to cache_miss,
> leading to incorrect calls whenever more than one parent was present.
> This is the case whenever a merge commit is processed, with the end
> result being a loss of performance from unecessary rechecks.
>
> The indent parameter was subsequently removed in e9525a8a029 (subtree:
> have $indent actually affect indentation, 2021-04-27), but the argument
> handling bug remained.
>
> For consistency, take multiple arguments in check_parents,
> and pass all of them to cache_miss separately.
>
> Signed-off-by: James Limbouris <james@digitalmatter.com>
> ---
>     subtree: fix argument handling in check_parents
>
>     > I saw that you sent a v3, but did not see any of this information
>     > (which took a good while to assemble, as you might have guessed) i=
n
>     > the commit message. However, I think that message would make for t=
he
>     > best home for this information.
>
>     Sorry Dscho - it wasn't 100% clear to me which details were required=
.
>     I've rerolled and tried again. Also sorry if I'm not replying to the
>     mail correctly - I'm not actually subscribed to the list, and this s=
eems
>     like the only easy way to get text onto it through gitgitgadget with=
out
>     fighting Outlook.

It is not Outlook you're fighting. It is the decision by the majordomo of
the Git mailing list to drop @outlook.com and @hotmail.com mails. Because
who would use those email addresses, amirite?

In any case, thank you so much for sending the fixed commit, and sorry for
not reviewing it earlier. It looks good to me! With this commit message, I
think it is good to go.

Thanks,
Dscho
