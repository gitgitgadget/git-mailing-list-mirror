Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BEF1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 17:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfFZRUp (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 13:20:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53969 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZRUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 13:20:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 332E561CDF;
        Wed, 26 Jun 2019 13:20:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AZhlR4xPReXw
        9Eyw864fAiw+39s=; b=Xy1uay8YYOMaGdMid/VX0xhgmv2EegT3WPHlFCEEnGs0
        nBoSdAQwEVesH4cwqjR9Yk7dnj+4bCLxb8OfsCY3l5P0rP2u/ue25PwtdtKtF15X
        5yWhIUoI4bZ72P6dev3L80fgV9OJtG15O1RLjB8FBsmITZp1DQucCE7ESZUiPJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=u913Fk
        8FzryAq7tkBTUr9JNW+XatiSiLNmlv2DoWfSCi3MIe8RQnzTwvxQAEgQGm4dhz2F
        Kjvsx5RU2iIKKSw7pJSwEqC8P2m7rDwPv50SfVTC0OzrPcIAFZSTPFi5MibYokuS
        BSMGjIh4QDHmhN7PJMw9YCf8p4VV+glfhcd3Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BCD661CDE;
        Wed, 26 Jun 2019 13:20:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DEB561CDA;
        Wed, 26 Jun 2019 13:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Kill the_repository in tree-walk.c
References: <20190624095533.22162-1-pclouds@gmail.com>
Date:   Wed, 26 Jun 2019 10:20:38 -0700
In-Reply-To: <20190624095533.22162-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 24 Jun 2019 16:55:27 +0700")
Message-ID: <xmqq5zose00p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B881D2C0-9836-11E9-AE9A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is the continuation of nd/sha1-name-c-wo-the-repository. In that
> series I sealed off one place in sha1-name.c that cannot walk trees
> from arbitrary repositories. With tree-walk.c taking 'struct
> repository *' directly, that check in there can now be removed.

Thanks.

With these queued on 'master', t7814 seems to become flaky (tried
running it with --stress, with and without these patches).  Are we
touching a wrong index file in some codepaths or something?
