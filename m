Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F59F1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 05:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfHTFuc (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 01:50:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62281 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTFub (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 01:50:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF9FC754FA;
        Tue, 20 Aug 2019 01:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9fmbvMI/uuT7YVZ5ycKADOolXkk=; b=nPIf/e
        nOE44akV0pntQ/HZfVah+wofaIBJycwNvtQLF+y/XLB2/IMd9Vvc6+W6SYqa9hbP
        ucVYL0+ePBcaF5alGpQ2v0Bq7YEaBeyBeSdza4UlAMU0TMrrIWb7NYNY2VPznlxO
        4RXH9PDqE9QnBTHvnnQMGSqNm7elOyPIbmbAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tQPzpwcKN3NHt7wacI6F1m8lfaolzqHF
        z/xdh7LtXtfYnwxaxTMJdqFg4IRe2Bjhfh589Ks1ZxzM9gV6zaIhEH11UBhdPvLV
        AYQBRDLWrS6AS3WgL8+OT7EWZfzmqUOhrbWqgnnurDvcME/jXAKxqDg5ExNmhYmv
        beyGCryMXCA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7D0F754F9;
        Tue, 20 Aug 2019 01:50:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E7FCA754F6;
        Tue, 20 Aug 2019 01:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Fully peel tags via for-each-ref?
References: <CAGyf7-GBx3FSCQTipmkNBtnwMANg5A0FXiiPc2az0NiRLRT+xg@mail.gmail.com>
Date:   Mon, 19 Aug 2019 22:50:24 -0700
In-Reply-To: <CAGyf7-GBx3FSCQTipmkNBtnwMANg5A0FXiiPc2az0NiRLRT+xg@mail.gmail.com>
        (Bryan Turner's message of "Mon, 19 Aug 2019 16:22:05 -0700")
Message-ID: <xmqq8srowfkv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68F993F2-C30E-11E9-86AB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> Is there any way, with "git for-each-ref", to output the "fully"
> peeled SHA of a tag's ultimate target, regardless of how many layers
> must be traversed?

I do not think I wrote it to allow different degree of peeling, not
because I wanted to explicitly forbid a use case for tags that tag
another tag, but simply because I didn't think of anybody using it
and didn't see need to support such tags.

If %(*<stuff>) does not peel fully (I do not recall what I did
offhand), because all other things in Git (like $X~0, $X^{tree},
etc.) fully peel the outer object until they get to what they want,
it may even be OK to declare it a bug and "fix" the notation to
fully peel tags.  I dunno.
