Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E087BC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B114C2075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gJl2B49I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgEFVIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:08:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:34629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbgEFVIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 17:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588799324;
        bh=9672VyhiiDmWcDJHvMrNvEH8rXb8fC7NMkBOZvqzPDw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gJl2B49IZit4OQ9Xyq7ZWZSFCTRLSPr+MaLEyG1P/XT2fst+LvXpjc3R8zGTiBw6n
         aLq66awLHmAG+hkGitP/H4zaCilDr7T2I66MjTOqOmeAp+IZru3eeJr2UJJi1MhQSf
         NUlhmdk2nou/YL90UD6VPXsj0ZSdCnoz3af9R+iU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([89.1.213.224]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1jfofS2Cog-00S5iv; Wed, 06
 May 2020 23:08:44 +0200
Date:   Wed, 6 May 2020 23:08:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 2/3] fetch-pack: in protocol v2, in_vain only after
 ACK
In-Reply-To: <eb18faea2d00d9b09d3fcc79646cc7556023c258.1588031728.git.jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.2005062304410.56@tvgsbejvaqbjf.bet>
References: <cover.1587775989.git.jonathantanmy@google.com> <cover.1588031728.git.jonathantanmy@google.com> <eb18faea2d00d9b09d3fcc79646cc7556023c258.1588031728.git.jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aUxqFhbbPNT9D54nOI7sKYzQkTKJK59KT8bQ9pbfJZ4fY0ra2mj
 gE6ny9PXDPwmHpetlr4lXbKoCEZx9z7dIUmPphUmzLpaUQ+E42i2JlF5ypIbqIqeW1EoPti
 bUfuulOXT8svDhnSpzzn8AQNVIC8x6t+IizPOtAXDUSadCZi+nnz53CXMSDjEPL+T+Nx4ns
 TmlvPmHBAtYVrQYrUcmcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rzb3lY+legw=:/uCUF90N7AeaD21O8e7fBw
 K33pQpMhdN1Ik7YqLY21JBNSsqw6+bqJP01S3i6RG/AxlrMyVNmEeb4WtFniXp7vIc2lqJHtY
 jYA/m5mKUB/YbZwqbaYSSkYTBb+Q7IdedwgW4nIyxeg2rlkakgECddhACXuP/+6gv0NW/pvYf
 gITkIdvEnzGrxqU8S7/PXwuxFrIkLyu5WqkAfiYelADrSC7FzOA0aeYu6D0Yb9k76Pzd+4/fG
 FYCHWyS3ZiFsozMI3z8rkFVJ2BzyzhttEDQtmvlnuwlTib8VVR+VqLzutyRsgVcabXYp4bj/K
 O3kRNgwgp3rFQEmLqovKAWH3flv0krZi9jec4u2yItl7/SnPTq32e4A90v2csmHPIoxjx0YjS
 Ky65xrcbTcqX//hbaNkwTeXTxaTnS4yykhDhxOqH7LfYiYIHXcbEj1mj3gHOViuuCDXgZ++IN
 Thqe/qA+aWux1Fjz6KC9ZAVnzfiWhXEoMbnL4EbQFdDYxOpuYYBy2Ies0qNIqv+TUA35eNUPn
 0eQrkqhdIBZpRxhqSV7aQq7m+2TAocUmOSoALEoo+C4d3j/vwueVGpAeDbZJRWdgH7NgiT1EM
 jMRnoUaZGljHAJlkUOxE3ZyX+ASV9dspS71zLOeJix/99WxsROEu9F6BiuM2XQiHBztvkqGyJ
 Lj/PgnVQChviKvm0i2D2HOLr1eeklSsBpJNqGGnxvPEf5X6nF3RN27S+9tV4FlgeUnhzjqbai
 BOzn/tfxFagOhzetG5kKEGhmrQYBBYlkuk/UbepDygyZDh/+Nz9LmYLauPmRc1fZPGR4p9S2L
 91OQgUmrdd9WnYVqi1/8SJP5iViS/Iy1OmvnQ9Kst4FICQkl8K2IFSRuCq6+53c7zCc4QMqI3
 lh75YuYdlrCg3cT8evb/B8Lt9GcO1rGUcHMXJTiwwEUvEX8twGJItmg8kzC1BI0qcFOTkMCDE
 mbBUPNsSZFqfQ9UgGdHToAmR+gw0dfYYVjvcGpaupEv3g3zCibCTzvNcsl/bE0eqVzs471CWm
 LeQrYSzvBClQwIQMB2BjVeFrNBtd7oMxyebFLJbnkORfOd5GfP5DokZ+93mhPU3we8fIs2C6x
 /gYLeS5JUS7IKBrzDmY3N7Oy5JIUf8gfX5QZL+PrKXkRXe9wiXb5uBOZlDp4R8SusuVFweefm
 RzEhz33P6HqC18Q3qfrw6qEGD547zapvy4wC4CodMg4R1E7wBIEb6GtIxzZjHfMC+SGIZcZkt
 ag+sesP/9PMcSCZLD
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 27 Apr 2020, Jonathan Tan wrote:

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index baa1a99f45..961cd6beec 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -385,6 +385,24 @@ test_expect_success 'clone shallow with packed refs=
' '
>  	test_cmp count8.expected count8.actual
>  '
>
> +test_expect_success 'in_vain not triggered before first ACK' '
> +	rm -rf myserver myclient trace &&
> +	git init myserver &&
> +	test_commit -C myserver foo &&
> +	git clone "file://$(pwd)/myserver" myclient &&
> +
> +	# MAX_IN_VAIN is 256. Because of batching, the client will send 496
> +	# (16+32+64+128+256) commits, not 256, before giving up. So create 496
> +	# irrelevant commits.
> +	test_commit_bulk -C myclient 496 &&
> +
> +	# The new commit that the client wants to fetch.
> +	test_commit -C myserver bar &&
> +
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C myclient fetch --progress ori=
gin &&
> +	test_i18ngrep "Total 3 " trace

This just failed in one of the Pipelines I monitor:
https://github.com/git-for-windows/git-sdk-64/runs/648253955?check_suite_f=
ocus=3Dtrue

The short of it is:

=2D- snip --
[...]
packet:     sideband< \2Enumerating objects: 4, done.
packet:     sideband< \2Counting objects: 25% (1/4)\15Counting objects:  5=
0% (2/4)\15Counting objects:  75% (3/4)\15Counting objects: 100% (4/4)\15C=
ounting obj
packet:     sideband< \2ects: 100% (4/4), done.Compressing objects:  50% (=
1/2)\15Compressing objects: 100% (2/2)\15Compressing objects: 100% (2/2), =
done.T
packet:     sideband< \2otal 3 (delta 0), reused 0 (delta 0), pack-reused =
0
packet:     sideband< PACK ...
packet:  upload-pack> 0000
packet:     sideband< 0000
++ return 1
error: last command exited with $?=3D1
t/t5500-fetch-pack.sh:388: error: not ok 43 - in_vain not triggered before=
 first ACK
#
#		rm -rf myserver myclient trace &&
#		git init myserver &&
#		test_commit -C myserver foo &&
#		git clone "file://$(pwd)/myserver" myclient &&
#
#		# MAX_IN_VAIN is 256. Because of batching, the client will send 496
#		# (16+32+64+128+256) commits, not 256, before giving up. So create 496
#		# irrelevant commits.
#		test_commit_bulk -C myclient 496 &&
#
#		# The new commit that the client wants to fetch.
#		test_commit -C myserver bar &&
#
#		GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C myclient fetch --progress orig=
in &&
#		test_i18ngrep "Total 3 " trace
=2D- snap --

In other words, that `test_i18ngrep` assumes incorrectly that "Total 3"
will be found in the trace, but the sideband is totally allowed to cut
through it and deliver it in different packets.

This makes t5500 flaky.

Ciao,
Johannes

> +'
> +
>  test_expect_success 'fetch in shallow repo unreachable shallow objects'=
 '
>  	(
>  		git clone --bare --branch B --single-branch "file://$(pwd)/." no-refl=
og &&
> --
> 2.26.2.303.gf8c07b1a785-goog
>
>
>
