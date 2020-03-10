Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D045C18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007A721D7E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VPApkCjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCJS30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:29:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53676 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJS30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 14:29:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B129BCA9C;
        Tue, 10 Mar 2020 14:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pl1Sy/ywvneK
        ly+COKRVxlAtMRA=; b=VPApkCjPkZnTmPxfVBm3raeXhIifUJaVSfuMsAtD557O
        49+qTCosTcSDT6zLreJ5awXqNUb1EeJXOzKVsEKpjAbi3N255yHypE/jXizAaBCm
        AxsumxMeotlNSGbWfZcNTkDyzI0xYtRmea+19xV2C519amBuJo9wSs76gTXvX6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jIPY8P
        pVm5qF2rx971bZynI+F4AXXXRZr4InetHaa82prb4COeE7e5vPWEh3OEDC8jm9FA
        iSBl2ZUlFeXzo9wnmQUQGEfUj+JcWdUibKUzoBzf/zoLY14/ZYn40Syrw6gzyqfS
        F32tVmduxPdne25OawCdBsOZzkOuHe4seBjCI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52AA6BCA9B;
        Tue, 10 Mar 2020 14:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B981BCA9A;
        Tue, 10 Mar 2020 14:29:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed, 12)
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
        <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
        <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
        <20200310173835.GC3122@szeder.dev>
Date:   Tue, 10 Mar 2020 11:29:21 -0700
In-Reply-To: <20200310173835.GC3122@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 10 Mar 2020 18:38:35 +0100")
Message-ID: <xmqq7dzsjc72.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10CFFEA2-62FD-11EA-AB1A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Here is the SoB and the wordsmithed commit message.
> ...
> Subject: [PATCH] ci: use python3 in linux-gcc and osx-gcc and python2 e=
lsewhere
>
> Python2 reached end of life, and we have been preparing our Python
> scripts to work with Python3.  'git p4', the main in-tree user of
> Python, has just received a number of compatibility updates.  Our
> other notable Python script 'contrib/svn-fe/svnrdump_sim.py' is only
> used in 't9020-remote-svn.sh', and is apparently already compatible
> with both Python2 and 3.
>
> Our CI jobs currently only use Python2.  We want to make sure that
> these Python scripts do indeed work with Python3, and we also want to
> make sure that these scripts keep working with Python2 as well, for
> the sake of some older LTS/Enterprise setups.
>
> Therefore, pick two jobs and use Python3 there, while leaving other
> jobs to still stick to Python2 for now.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Nicely written.  Thanks.
