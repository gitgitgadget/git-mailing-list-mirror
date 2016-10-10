Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FDF20989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbcJJTKe (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:10:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59802 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750989AbcJJTKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:10:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE90445AEA;
        Mon, 10 Oct 2016 15:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q7RuF8TEcfP2WlqrsWstD6zC3DQ=; b=nuSinu
        6tlt3ZCB3B5SOlQZEEhW/P42P/ndCrXudqH9FoBYkzpPvXdejE8dbgw/l+jyxch+
        bYFS4D40vitcj7ouxLDqC2mjryjN/cbOZCoqj3CFGlWSCAI6OKn0uzNTIWjcW21B
        skOqL+qj0rw9nhNw6r+yqAqDlyVuBRlDpk8Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W4F2kz673vpDbFlABvkdb+AasKNhBOOj
        zywru3kY86xZyjvxvhBPK/AeJJZlkzp6wrCMRF9lBdg1a6l6n43+O6cN6bjEXg2l
        4CW5BhDaj1xE2Do+VgynALN0OBiCuXRxNknzliGx5JNItQ55EzZKpn8kwYYm/rY2
        z9iB93NWuEA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A668745AE9;
        Mon, 10 Oct 2016 15:10:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 102AE45ADF;
        Mon, 10 Oct 2016 15:10:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] documentation: clarify submodule.<name>.[url, path] variables
References: <20161006235149.10232-1-sbeller@google.com>
        <xmqqpon8f54i.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZiKwOTiJiw4X3uLit2LrBRe_Y1oVn0-HJT-ey15D49Qw@mail.gmail.com>
Date:   Mon, 10 Oct 2016 12:10:30 -0700
In-Reply-To: <CAGZ79kZiKwOTiJiw4X3uLit2LrBRe_Y1oVn0-HJT-ey15D49Qw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 10 Oct 2016 11:35:14 -0700")
Message-ID: <xmqqshs4dnq1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36FE19E0-8F1D-11E6-B41A-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Does it mean "never appears in .git/config, and when it appears it
>> will not be used at all"?  If so we shouldn't even list it here.
>
> I meant:
> Git wont put it into .git/config on its own. If you really wanted to have
> it there, you need to do it yourself.
>
> I assumed you can overwrite the path via the config. It turns out,
> the value from the config is ignored, so it doesn't even make sense
> to put it into the config. Only the value from the .gitmodules file counts.
>
> So with that knowledge, I'll just remove it here, but I'll cross check if it
> is referenced else where enough.

Good.  I do recall we designed this part of the system in such a way
that .path is conceptually uncostimizable (it _is_ part of what the
containing tree already records), and was wondering why it is there
as if it can be overridden.
