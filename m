Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDCB1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 00:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbdJLAiq (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 20:38:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62480 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751587AbdJLAip (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 20:38:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6663B4D12;
        Wed, 11 Oct 2017 20:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lQdmulljJwOBQkTsF6L85mq0M+8=; b=hCXH82
        PuARzP5iYoIo2Ey3moC8oQ20dShD1Twgi1aSjUJAcBeDvIYKDu8DHMARZcxwsO5O
        QOyCdc1f6evlhuyiA6v4jz6Kq1zeC9yTC+O2kE79uUQcg4RHnNokCkjenjGhUNzs
        jsY0glYOmqP2j+2wNA0Fl2TkM2wuPE8OrQ2VM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UNdzwIZI0+6f02Tnrd6kZfqByG9+2UFl
        JI5eeghNNvtPHfEVpysjonkfFdd4Hhamge/Afpl+vmIycLIkPZ/3Ac6TH0Ih109B
        XxG5+oqV5dsR4lI55EG5v3buLr2tIqtAhjdrB+dt30vVw05KeKPO8QiFH1C5Hs+c
        /mKybhIysPw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD180B4D11;
        Wed, 11 Oct 2017 20:38:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33410B4D10;
        Wed, 11 Oct 2017 20:38:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: emphasize stash "--keep-index" stashes staged content
References: <alpine.LFD.2.21.1710110443360.11205@localhost.localdomain>
Date:   Thu, 12 Oct 2017 09:38:42 +0900
In-Reply-To: <alpine.LFD.2.21.1710110443360.11205@localhost.localdomain>
        (Robert P. J. Day's message of "Wed, 11 Oct 2017 04:46:30 -0400
        (EDT)")
Message-ID: <xmqq376p42ul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B39D7AD4-AEE5-11E7-8098-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> -If the `--keep-index` option is used, all changes already added to the
> -index are left intact.
> +If the `--keep-index` option is used, all changes already staged in the
> +index are left intact in the index, while still being added to the stash.

I do not think "left intact in the index" is an improvement.  The
primary reason why people use --keep-index is to get a working tree
that has _only_ the changes that are already added to the index and
nothing else, so that the state in the index can be built and/or
tested.  So if you want to add anything to that sentence, it should
stress the fact that changes are left intact "in the working tree".
Adding "in the index" without doing so makes the result even more
confusing, not less, by allowing a mis-read "left intact _only_ in
the index?  so the working tree files are reverted to the HEAD's
version?"

I am still undecided as to the value of saying ", while still being
added...".

