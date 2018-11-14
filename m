Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127981F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 10:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeKNUOz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 15:14:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65030 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeKNUOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 15:14:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FA8E1193B7;
        Wed, 14 Nov 2018 05:12:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZyAP9y8zNacU
        PjfD4flOeuSqmko=; b=D9a3XIKDLe8ATDkJM1TJuu8iNOW27ZZ2ys0aGyP07f7K
        4To+am6KFjvOACPO1HGzDhzsy+i/k5+btan8wAElc8qA/o35fF0WmCDA+8Jy51Zp
        kmF6fgs/Y1eyELRDVRkJ1HboGFgEiqSXF3qwYk4WtZLtLiOSA94VGBL8KjHf+m4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qXZTNC
        kQDOPb3B7vxR7HcTnyF1cyI+K8HDDybDwHsw/NcxB3PFXCpc48TSyAcDRTlT0tTn
        2JK93sj0/9ObJ8NjRLrlZ+1bsvEgRkAOYmX+mA8jQ6WQeVBMXS+0safRMT+vROMb
        4XwL+DOoha0Hz8ez+aAv/38M1aMAlQTlvVhJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 489971193B6;
        Wed, 14 Nov 2018 05:12:18 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B21D01193B4;
        Wed, 14 Nov 2018 05:12:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] checkout: print something when checking out paths
References: <20181110133525.17538-1-pclouds@gmail.com>
        <20181113182800.26984-1-pclouds@gmail.com>
Date:   Wed, 14 Nov 2018 19:12:16 +0900
In-Reply-To: <20181113182800.26984-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 13 Nov 2018 19:28:00 +0100")
Message-ID: <xmqqo9asm0hr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C4134C0A-E7F5-11E8-90FA-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> One of the problems with "git checkout" is that it does so many
> different things and could confuse people specially when we fail to
> handle ambiguation correctly.

You would have realized that this is way too noisy if you ran "make
test", which may have spewed something like this on the screen.

[19:09:19] t4120-apply-popt.sh ................................ ok     16=
24 ms ( 0.26 usr  0.21 sys +  5.31 cusr  3.51 csys =3D  9.29 CPU)
[19:09:20] t9164-git-svn-dcommit-concurrent.sh ................ skipped: =
Perl SVN libraries not found or unusable
[19:09:20] t1310-config-default.sh ............................ ok      1=
77 ms ( 0.07 usr  0.01 sys +  0.89 cusr  0.66 csys =3D  1.63 CPU)
=3D=3D=3D(   20175;154  1297/?  155/?  6/?  3/3  2/?  4/?  4/?  3/?  5...=
 )=3D=3D=3DChecked out 1 path out of the index
Checked out 1 path out of the index
Checked out 1 path out of the index
Checked out 1 path out of the index
Checked out 1 path out of the index
[19:09:20] t1408-packed-refs.sh ............................... ok      3=
10 ms ( 0.06 usr  0.00 sys +  0.69 cusr  0.52 csys =3D  1.27 CPU)
[19:09:20] t0025-crlf-renormalize.sh .......................... ok      2=
46 ms ( 0.03 usr  0.01 sys +  0.34 cusr  0.22 csys =3D  0.60 CPU)

I am very tempted to suggest to treat this as a training wheel and
enable only when checkout.showpathcount is set to true, or something
like that.
