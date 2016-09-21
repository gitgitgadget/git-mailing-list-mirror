Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245E41F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933606AbcIUSST (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:18:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50095 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933024AbcIUSST (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:18:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B06253F7EB;
        Wed, 21 Sep 2016 14:18:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zQtYtxagp/iN
        +d45mQJMDH69Lxc=; b=WKaEmPziE3o0phQvRQAxhxAaxMiPXw2l8rNhe4rjX0se
        ez/fHsVOrJqMltvS8CgXrF7myOhVWv6+CTQxeMVfg3cZU+mUjt2g2Yf6nIFpZlSS
        0swx1yR8huQGNc2gUHghjoaf0q013+nibzskuN8n+o2GTcEPOyRQi6ytOBTcZkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eFTBuc
        cecStffCtYAhtpfBVZ4VD4D5c+UKPXkn0IuVpDCzD+eJ+VrS2SO2JCAwaoSLomVo
        g63wuLLIHmo+bgS6wWkQV6+sN14Y9Kzean/I6IR8XVuEeH3Vu5MhEjbsWBub4sc9
        bwkZQFYc2sR5UarDU20ReTsDPiOmPRdHGH4b0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5EEE3F7EA;
        Wed, 21 Sep 2016 14:18:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B0E03F7E9;
        Wed, 21 Sep 2016 14:18:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH v2 0/3] Fix git-init in linked worktrees
References: <20160908134719.27955-1-pclouds@gmail.com>
        <20160921112939.3444-1-pclouds@gmail.com>
Date:   Wed, 21 Sep 2016 11:18:15 -0700
In-Reply-To: <20160921112939.3444-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 21 Sep 2016 18:29:36 +0700")
Message-ID: <xmqqh99986c8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C49A16FA-8027-11E6-8260-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> v2 requires jk/setup-sequence-update so I could kill my workaround
> patch and avoid conflicts in t0001. And:
>
>  - 1/3 has a few missing words back in its commit message
>  - 2/3, which was 3/3 in v1, no longer has the ugly hacky
>    get_first_git_dir()
>  - 3/3 is a new tiny code improvement after the new 2/3
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
>   init: correct re-initialization from a linked worktree
>   init: do not set core.worktree more often than necessary
>   init: reuse original_git_dir in set_git_dir_init()

Thanks. Will take a look.
