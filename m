Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B8B1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 19:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933448AbcJTTxz (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 15:53:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51719 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933216AbcJTTxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 15:53:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 860A148B49;
        Thu, 20 Oct 2016 15:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LO+a+q5Uv9/TjTA0DonwptQuaUQ=; b=v5aNtX
        Jb0iEHeuvq/nKLNxBWjhL3vm39bIAexfi2TgFaAUupJnuaPlsCzr+UrCDfOrBTOi
        m8ZZ+jcakNAaHHcD8w94uaX6OnC16pc+Lbc2vmxsxz3QgWtnz2YyvCSOeN/BwwYJ
        3Q7DI1olG1PfIf87AT/w72IC/R+KT6Cca1KlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nt1xDdBuPY1x6pq4QqXOKyClbudb7Ias
        IBmb6Io5QUrhoE/rkRwUoQXfVTSzhDWp7rW6cKMxywsTZqM5ukkROxeaiAgtvzsN
        GPlgqmeSRa1F+2gKUp5RcvWTAzdlabXrs+/P49wc97jB1mJvHl5/JSHu3f4lsuOj
        QcRpTLnIf9U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E16D48B48;
        Thu, 20 Oct 2016 15:53:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2BE848B46;
        Thu, 20 Oct 2016 15:53:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
References: <20161018210623.32696-1-sbeller@google.com>
        <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
        <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
        <xmqq60opnolz.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
        <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY4u-k8v3g5Jmod4acwJ81AnJYeYMQZ2tarx6UMGj8Xew@mail.gmail.com>
        <xmqqzilyg6tk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZyCXKnt9kTbnD8KrnsjJVb_7juW2epmdP9XqcRGfg=GA@mail.gmail.com>
Date:   Thu, 20 Oct 2016 12:53:50 -0700
In-Reply-To: <CAGZ79kZyCXKnt9kTbnD8KrnsjJVb_7juW2epmdP9XqcRGfg=GA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 20 Oct 2016 12:34:13 -0700")
Message-ID: <xmqqvawmg5kh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECD6CFBC-96FE-11E6-9A12-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> My thought was to fix it nevertheless, such that the url recorded as
> remote.origin.url is always the first case (no l or /. at the end).
>
> If we were to add this fix to clone, then it may be easier to debug
> submodule url schemes for users as the submodule url would then
> be a concatenation of remote.origin.url and the relative part.
>
> That seems easier to understand than ${remote.origin.url%%/.} +
> relative path, maybe? (Because then the user doesn't need to guess
> or remember historical behavior that is wrong on how this)

Are you declaring that trailing / or /. will now be illegal?  If you
are declaring that, then I agree that new codepaths no longer have
to worry about "strip / or /. before concatenating" and will
simplify things for them.  But otherwise, such a "fix" also would
have an effect of hiding bugs from codepaths.  They still need to be
prepared to see any of the three variants and cope with them
correctly, right?
