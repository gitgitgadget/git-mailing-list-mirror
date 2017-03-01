Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FE3B2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 23:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbdCAX3f (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:29:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64393 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753424AbdCAX3d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:29:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 549AE77925;
        Wed,  1 Mar 2017 18:29:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RVJprdRlM2EkaNXXb/Ao6KGrWic=; b=Ci6htr
        HeAkdhrlP/BAX5Qdx+9jVoOoQM4XPjIjedG2GkVSPwmgL7DcUjlIQ5O2aM49eZrD
        eLfrCL3E6o6/IF7J2SKdXA7UudK/swJON5W19I6s+7jPu7wsNzZHuulB9sfpkFsj
        UluTz1KoAPEls7VQaZinlbkDjwIQZJJ3icVI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MQb7vHf688Bsh9gAyw6/y84ERcXhbPcs
        bPl+ogGl9BstxcRB4wJi3ro317EcJaM1WEU73Ii901oqpkN8a4Ym/E3+yMIEJoNv
        v8phjI9pEmtum9aKYbrSlqi7y2aC7BdtFC9+O10F0MUoodmZ5+IRIBW2BHvdqZyH
        +U8Ln7sOy5g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C61077924;
        Wed,  1 Mar 2017 18:29:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF51D77922;
        Wed,  1 Mar 2017 18:29:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Crowe <mac@mcrowe.com>
Cc:     tboegi@web.de, git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
        <20170301212535.GA6878@mcrowe.com>
Date:   Wed, 01 Mar 2017 15:29:01 -0800
In-Reply-To: <20170301212535.GA6878@mcrowe.com> (Mike Crowe's message of "Wed,
        1 Mar 2017 21:25:35 +0000")
Message-ID: <xmqq60jsefuq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAB7A46A-FED6-11E6-A40E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Crowe <mac@mcrowe.com> writes:

> With the above patch, both "git diff" and "git diff --quiet" report that
> there are no changes. Previously Git would report the extra newline
> correctly.

I sent an updated one that (I think) fixes the real issue, which the
extra would_convert_to_git() calls added in the older iteration to
diff_filespec_check_stat_unmatch() were merely papering over.

It would be nice to see if it fixes the issue for you.

Thanks.


