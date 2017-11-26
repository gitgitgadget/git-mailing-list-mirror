Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0922120954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdKZDfq (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:35:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59620 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752017AbdKZDfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:35:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0DE4AE41C;
        Sat, 25 Nov 2017 22:35:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H7ySgmQo9nnyFW+kY2nBdNYURkU=; b=kZcGvX
        g7lnHf8GYlbnZcceOnqJBlevGObyzjR7IgtW5DvjXub6GJ8qHarzSzOs1xcL7FFC
        onAmf/jZOo1OSWzBGVS2Cq1cQnZW+WWgv9hDDXZSA6KcDK2ukRcsCtftEcY2jB+7
        yfSnprvdFnIZVhhcjFOZrMxfeI1ET+EkHUOco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vygJ3gIXOzjw6tbBVJQd0wPY1G8Zpk8f
        bWuBhqXilZ19eZx40M4mq0b8Y5cEPSzF11esxvqWj/5fvPsBba6NSgQU0udqA7UQ
        SlsNoXbGeFOcboD6FWjYzWQMdxHp7ELK1TqOfqlG2zX5PjBwCYgL2wfdqun10602
        W85X3KIw7M8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8AF0AE418;
        Sat, 25 Nov 2017 22:35:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63FAFAE417;
        Sat, 25 Nov 2017 22:35:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
        <20171122223020.2780-1-t.gummerer@gmail.com>
        <20171122223020.2780-5-t.gummerer@gmail.com>
        <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
        <20171125175010.GB14993@hank>
Date:   Sun, 26 Nov 2017 12:35:43 +0900
In-Reply-To: <20171125175010.GB14993@hank> (Thomas Gummerer's message of "Sat,
        25 Nov 2017 17:50:11 +0000")
Message-ID: <xmqqshd1iueo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2558932-D25A-11E7-96D6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Of course that assumes that it's used directly, not in scripts, and
> that users will actually read the output of the command when they
> invoke it.  Maybe these are not safe assumptions to make though, and
> we'd rather not have this on by default then.

None of these is a safe assumption to make.  With a transition plan,
we could change the default eventually, but if this feature is already
used by real users, the proposed change without any transition plan
will hurt them and make them hate us, I am afraid.

