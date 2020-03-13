Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB95C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5B4206B1
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pEM3Eh29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgCMTaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:30:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62965 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMTaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 15:30:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9222CAF166;
        Fri, 13 Mar 2020 15:30:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lnjuTdTXqlt5
        YEdaqGltIKlEJtk=; b=pEM3Eh29qYmsy38ea5axY/QU38HBgYD/tGm+uOvBxnq9
        U7l2SF1aPzGeENQdrUSnOR/utmMwiIguUtg3qo+2lYEXXWk8hUyqFbyy2ptNvRp1
        vRPRegtC6g7DWkVfqO9hcA6P6qtRMBALlIufdqO6154q1DdSCSkpZARI/NaUvXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aSiYb5
        bm+aez43LzxH9XM+b1+MlJ3kxBLSifAYJJk2nGnwoIzB+qXV1UGnSvF+uNXQBtBa
        a7bFhtvfcg1ctIkIwYgi358gnQ0vxK1gQiia3JwfjHXigfAuNOIG3vB6xsf7leeL
        Ac77A3U/P2ltYWK8RGU2FrvgmWldSj+ZaBaDA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A1C9AF165;
        Fri, 13 Mar 2020 15:30:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F2AE4AF13D;
        Fri, 13 Mar 2020 15:30:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Juan =?utf-8?Q?Jos=C3=A9_L=C3=B3pez_Villar?= 
        <jjoselvill@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request: git config for stash -u
References: <CACTq9vt0c+yX9hp5m84dQ7Y4qWk-RrP=zQ2s4PnNRC1ytGbOmw@mail.gmail.com>
        <CACTq9vuZO_wHhzBKsm=SOTcyXq3e=ur4NmNG9B-g=p5OXMuCNg@mail.gmail.com>
        <CACTq9vvv+_cEv3Epk3tku47qogH0b8oUtVWUEt=tX5UGzxQZ6g@mail.gmail.com>
Date:   Fri, 13 Mar 2020 12:30:02 -0700
In-Reply-To: <CACTq9vvv+_cEv3Epk3tku47qogH0b8oUtVWUEt=tX5UGzxQZ6g@mail.gmail.com>
        ("Juan =?utf-8?B?Sm9zw6kgTMOzcGV6?= Villar"'s message of "Fri, 13 Mar 2020
 10:36:30
        +0100")
Message-ID: <xmqqpndgaw91.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 09DF4B14-6561-11EA-872E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Juan Jos=C3=A9 L=C3=B3pez Villar <jjoselvill@gmail.com> writes:

> I was wondering if a git configuration could be made for including by
> default untracked files to git stash, so every time it runs it is like
> it had the -u flag appended. For example: stash.includeUntracked

It probably won't be just an addition of a configuration variable,
but it would also need to adjust the command line option so that a
configured stash.includeUntracked=3D=3Dtrue can be countermanded from
the command line (e.g. "git stash --no-include-untracked").

Are you interested in running with your idea to implement it?
