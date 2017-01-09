Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C38A1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163943AbdAIRen (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 12:34:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51971 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1162842AbdAIRem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 12:34:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F41D25E3FF;
        Mon,  9 Jan 2017 12:34:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NVrNUJpIQ4By
        C4Bh1pS0GR2B1CY=; b=S9iSjOulTY5bXH6Pr1H2JlpnHOqSaE3/rG8aXF1NSbbg
        /av+gOrwSuqgssjgvz6oATNYWjwatSvu+CFiUCzr2+x7C7rGPAT0iWViQrXUDPsq
        IZGTJWVp/5NG48HpECu0uh7ZJTNBnlav85GF6xPJsLyV8WMKpw5pAWO2/4Jkuzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VGw8Y1
        Eqznjnycv02ra/SE/I1KKsntCIpaCW/3s5LwoPFkA0prlPptIpam0sjfuF3JtSME
        Ry9FJsdHH1wVhTxp1Yrnj+lxpi0w2R7A1wlkxER9Gm0/xbpI+P57eW0v9f+w/d+4
        XOTbOVPzr5+40MMvC7m3ssmShKEvjNpmgGWI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB15E5E3FE;
        Mon,  9 Jan 2017 12:34:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51EEF5E3FD;
        Mon,  9 Jan 2017 12:34:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] git worktree move/remove
References: <20170108094003.637-1-pclouds@gmail.com>
Date:   Mon, 09 Jan 2017 09:34:39 -0800
In-Reply-To: <20170108094003.637-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 8 Jan 2017 16:39:57 +0700")
Message-ID: <xmqqd1fwuogg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6490EA8-D691-11E6-A412-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This version is the same as nd/worktree-move but with the recursive
> directory copy code removed. We rely on rename() to move directories.

Much simpler ;-)

Will replace; thanks.

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
>   worktree.c: add validate_worktree()
>   worktree.c: add update_worktree_location()
>   worktree move: new command
>   worktree move: accept destination as directory
>   worktree move: refuse to move worktrees with submodules
>   worktree remove: new command
>
>  Documentation/git-worktree.txt         |  28 ++++--
>  builtin/worktree.c                     | 162 +++++++++++++++++++++++++=
++++++++
>  contrib/completion/git-completion.bash |   5 +-
>  t/t2028-worktree-move.sh               |  56 ++++++++++++
>  worktree.c                             |  84 +++++++++++++++++
>  worktree.h                             |  11 +++
>  6 files changed, 335 insertions(+), 11 deletions(-)
