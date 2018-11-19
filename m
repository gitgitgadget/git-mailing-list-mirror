Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE4D1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 01:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeKSMLn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 07:11:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57390 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeKSMLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 07:11:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 956B3122062;
        Sun, 18 Nov 2018 20:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cnwfQpMq48nM
        a/t3nkPigAFG8KI=; b=Upf8T6b7aB85/eHMnVK2HRt3AwJ9iQSztICotDN3p3VC
        uws6LCRrGQcT6sisjP31mEe78i3wMjMLNstQJsrNrUQMmYsTBAcNtuR92zP7T5dK
        pF5xDq67LylvUFmROWEKJdaie+Grgj7FG9k3lqKwRSmKwA2B7aRm+owkaoPn3V0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Qe45iQ
        VcVCKCwsnptQb6WEykPMzQL2ftB6U5tuTRsLOg0Al1FUfOJjOtRmVjY/t9ejiO7D
        7b8H+eH+CN48NkU0kI5yEJ7V1r00WZTKhzveBwHaXwaeUwKch6YsGARoqkHZzwQO
        WKa1ky/rd9GQMX6R+Ef1Jve2mJh5nn7X85qOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E8F3122061;
        Sun, 18 Nov 2018 20:49:41 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B541122060;
        Sun, 18 Nov 2018 20:49:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Make :(attr) pathspec work with "git log"
References: <20181118164800.32759-1-pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 10:49:40 +0900
In-Reply-To: <20181118164800.32759-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 18 Nov 2018 17:47:55 +0100")
Message-ID: <xmqqo9aleszv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 615B4F30-EB9D-11E8-8370-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> But this also reveals an interesting thing: even though we walk on a
> tree, we check attributes from _worktree_ (and optionally fall back to
> the index). This is how attributes are implemented since forever. I
> think this is not a big deal if we communicate clearly with the user.

This is pretty much deliberately designed to be so; the set of the
attributes in HEAD may be stale but by taking the contents from the
working tree the user can work it around.

> The main patch is the last one. The others are just to open a path to
> pass "struct index_state *" down to tree_entry_interesting(). This may
> become standard procedure because we don't want to stick the_index (or
> the_repository) here and there.

Yup.

