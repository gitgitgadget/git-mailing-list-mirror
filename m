Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF84208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 16:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754103AbdHUQs4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:48:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753636AbdHUQsy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:48:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8714B08F0;
        Mon, 21 Aug 2017 12:48:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e3kION1ce5jVk6IP+4plSuA/iIY=; b=ZpNUK2
        BSLy70ZSkSMZ9oQNySqY8pWUhH/Z7XC2wpRSewy84GILkHMSKl/fe4xAksFOTn1r
        NURMpRyxCjlrMAXtqU2f2x7JWjTskxqveqba2Hj5kOZTZ/veCo4OQ5SYGv/kWThb
        GIcU3V7VLCfv7KO+5Y5pSDyXB5lcAT9YJSQTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dke6l7tXWL417Wx6VD1pX35vYgfMpRhR
        KWV+NGLKc+b7i6jmrtCs1VF3rSKgieJrRu/xvVM5fqIgS80QS7ionyipLSX+ZUcA
        HFFvGX1chJffYEv+wHVXwTVnE4rUOb4cOi+ojAGgV//ilnSTVJx4NbGdBBtwVi9S
        HnrSamQ9x0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FA95B08EF;
        Mon, 21 Aug 2017 12:48:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 027A8B08EC;
        Mon, 21 Aug 2017 12:48:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
        <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
        <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
        <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
        <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
        <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
        <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
        <20170821160514.GA1618@book.hvoigt.net>
Date:   Mon, 21 Aug 2017 09:48:51 -0700
In-Reply-To: <20170821160514.GA1618@book.hvoigt.net> (Heiko Voigt's message of
        "Mon, 21 Aug 2017 18:05:14 +0200")
Message-ID: <xmqqr2w46f4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D51BC2C-8690-11E7-9E63-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> So I think it is important that there are commits in the submodule so
> its history makes sense independently for others.

I was trying to push the "just like trees" to the logical conclusion
in order to see see if it leads to an absurd conclusions, or some
useful scenario.  I do not necessarily subscribed to Jonathan's
"vision" (I do not object to it as one possible mode of operation,
either).

> Or how would you push out the history in the submodule in your idea?
> Maybe I am missing something? What would be your use case with gitlinks
> pointing to trees?

Not my idea.  But Stefan's message I was responding to said that
object database for the superproject is the same as and mixed with
object databases for the submodules, so it is plausible that push
always happens at the superproject, and a mechanism to be invented
(I mentioned the need for it in the message you are responding to)
to enumerate all the commits bound from submodules to a range of
superproject's commits would identify these trees to be pushed out.

In essense, "just like trees" folks want to use the gitlinks in the
superproject to only specify the tree from the submodule project
that should sit there.  And my point is that such a world view would
lead to no need for branches in the submodule repository, no need
for commits in the submodule repository, and no need for history in
the submodule repository.  Which may or may not be a bad thing.
