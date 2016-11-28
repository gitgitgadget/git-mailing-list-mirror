Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92321FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 19:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbcK1Tgl (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 14:36:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64912 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752099AbcK1Tgj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 14:36:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD1A954846;
        Mon, 28 Nov 2016 14:36:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=isHZ8w9r+ZwzvSyFBQ1dwGilrYo=; b=U2VTNm
        ub2cdCjYlVc0xQ9dul1saG/XzHbYEvQEGdQXk7F0B3QGV83RG8ItWGEDk0f8bViW
        TWRFIUqoesAociEpUxYQcZHjg8lBs8p3fJ9UdrXeAZpeU8o+7j6NNZFZb/B9gzdl
        mvWoO1HRC6kfb0+wdy7Z9/lk5ymxa3pwxkco8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qdrwi5Cd76xB7U9FCutteBmmJCMLeqYh
        Sbbd90BOL7LEFpfXqakYDMMGJuqQIXUpKTdWwD78NX1Gl2jDb3mfBnBb8yzZKhub
        qiCJ32HWRE1hEA+SUtYxH7UI9Q/9R4dH+X7kp/Mc9WilxN5Os4E+drBivNGJXMbO
        f+gU2lZUWmM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4F5754845;
        Mon, 28 Nov 2016 14:36:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4430454844;
        Mon, 28 Nov 2016 14:36:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH 0/3] Minor fixes on 'git worktree'
References: <20161122100046.8341-1-pclouds@gmail.com>
        <xmqqbmx6nnpg.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D+vyO0LF_A2Wym+PUg=HOTPyDe-1fVwv8zN797pL-rmw@mail.gmail.com>
        <CACsJy8CpySQs07cfioOnoxoH1TALRePGbeVCc45ZqDr43519qQ@mail.gmail.com>
Date:   Mon, 28 Nov 2016 11:36:37 -0800
In-Reply-To: <CACsJy8CpySQs07cfioOnoxoH1TALRePGbeVCc45ZqDr43519qQ@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 25 Nov 2016 20:44:53 +0700")
Message-ID: <xmqq1sxvjt16.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAC4B758-B5A1-11E6-B212-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> An interesting thing maybe worth
> sharing is, if HEAD is broken (the only reason we would fail to create
> "struct worktree" for main worktree), then "git worktree list" from
> main worktree would fail too, because repo setup code fails to parse
> HEAD as well and die().

Yeah, that makes sense.

> That makes the "always show main worktree"
> patch useless, since we won't get far enough to execute
> get_worktrees() in the first place. However, you can still do "git
> worktree list" from a linked worktree, gitdir setup code will not stop
> you (how can it). And the patch is still needed.

Yes.
