Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944591F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756365AbcHXQlw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:41:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56908 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754900AbcHXQlu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:41:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4979B3634B;
        Wed, 24 Aug 2016 12:35:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9VvH/agtgXXO
        5PUiiWUbpE2RwV0=; b=oHjXcxNzAb/BOoAc9VazyhkI6tQ50VufEHZYFzdlMT/v
        PFDum8GH1hquVKUYYtHtGi/k7OFLqxvLckYvLn0IFJfhscDml6N7Z+YlQj9Jr+Rx
        RQ6G3r13UvfAPUU1P2QcJs/NPxzxDyA30bLzVwzy6ZqsAA5NMBNWOefxEl6M1h0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LGjBbn
        TNXeVGsP3e/PKmqz/eqAxFhps5K//57CkhNsBjzfvSYL3E8BCXDr3TY4U6M4PVBm
        vgn1VwyHZNdfnDXCw/LvSyv3IxJ2tIRRAdaq3hGp/k5edW9Er+RrGPoQrZvcG7ce
        JvgJRm4Ls8zzpz4Ul9H+6MWOipCfEP2pEe2Pw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 420E03634A;
        Wed, 24 Aug 2016 12:35:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD35836349;
        Wed, 24 Aug 2016 12:35:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout: swap the order of ambiguity check for :/ syntax
References: <20160822123502.3521-1-pclouds@gmail.com>
Date:   Wed, 24 Aug 2016 09:35:29 -0700
In-Reply-To: <20160822123502.3521-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Mon, 22 Aug 2016 19:35:02 +0700")
Message-ID: <xmqq7fb6rupa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C62B916C-6A18-11E6-ACE9-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> It's not wonderful, but it's in line with how git-checkout stops caring
> about ambiguity after the first argument can be resolved as a ref
> (there's even a test for it, t2010.6).

But that is justifiable because checkout can only ever take one
revision.  What follows, if there are any, must be paths, and more
importantly, it would be perfectly reasonable if some of them were
missing in the working tree ("ow, I accidentally removed that file,
I need to resurrect it from the index").  Does the same justification
apply to this change?

