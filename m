Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2C520133
	for <e@80x24.org>; Tue,  7 Mar 2017 00:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932131AbdCGA3p (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 19:29:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58328 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752233AbdCGA3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 19:29:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81176707DD;
        Mon,  6 Mar 2017 19:16:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=89Kx9T7OaTSJ
        vQLylgl5tPD5H5k=; b=J+K8qgV1oTUnwWpW7BjG9VX9TY6t9fS/8QcJPN61reOv
        GvtdfMGeiAzl9DB4sAeUPdsckkp4NdgzWKLvRV9LyBsnhFRBlXDdm+3EYoa8ez/L
        tR1/sGjYHn528lMECaFQCiJjyIT2A2k+1L+gwvVlYAnR3+sR6ecKbR/Xdt0SuQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RJaGws
        ZTTuvBoi0u/0GjQGPyjLgDnIdjkUDcv9A856uBp6hh4RQIoZ08LjRYe0iLATK+q9
        kfUai95uys8vb4LJNyhh1cmj6/dllhe6PvJWBPIFUhUwTOYBde+W+K7zuydL1tZy
        f/GSoMwd1NGMt28OWRXQN3bR45D8fwZyATMeM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78D1E707DC;
        Mon,  6 Mar 2017 19:16:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5B85707DB;
        Mon,  6 Mar 2017 19:16:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, tom@oxix.org,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
        <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
        <47ad8b6d-0a65-2f8c-dcc5-49a8a8d5ab2a@gmail.com>
Date:   Mon, 06 Mar 2017 16:16:42 -0800
In-Reply-To: <47ad8b6d-0a65-2f8c-dcc5-49a8a8d5ab2a@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 7 Mar 2017 00:59:10 +0100")
Message-ID: <xmqqzigyx7o5.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 583453AA-02CB-11E7-ACE0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Also from what I remember signed commits came before mergetags, that
> is the result of merging a signed tag (storing the signature of
> one of parents of the merge commit to not pollute tag namespace).
>
> And this workflow, from what I know, is quite useful.

The "commit -s" on a merge commit lets you as the integrator to
attest that you made that merge.  The "mergetag" records the
signature by the contributor that says the tip that was merged was
what the contributor wanted to get merged. =20

It is entirely reasonable to sign a merge commit that merges a
signed tag.  They serve two different and unrelated purposes.



