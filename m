Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5B012047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdHASmJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:42:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56669 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751980AbdHASmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:42:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E37C29E8CA;
        Tue,  1 Aug 2017 14:41:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aWxqod9ZNxZsU3+PjfZl1++dR0U=; b=Q77lg3
        gpMS/qEqILMlj3vGCmHG7qZWHYZGI+H3k10ugdQDaJ61GASPrWo1kyrngo7mEH+w
        vhyUF53grQr2MetWyVrUY5yjBxLhkswQsJX34i5mLbxbxa5dNKbXNBnL/xXPW0Go
        0TC3qtUzv8MKwzXwYvIQOLKGEHW9t8RwHllkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZCuB75YTO8dYDqse2/KRlJTyHKOwcR/6
        Rr3m9gLmh+f3DJbBx6POhseG8fOJW5nV1K5C0609RuMf/uIqY1phmdkQkIjShWsn
        gDySd7lZBNDYQfp4t4YsOqJi+Ui779vdkLwot9/Ua8u9Y4pO31QWf41aS4A/0T1w
        D4zSgRZfeck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBCA59E8C9;
        Tue,  1 Aug 2017 14:41:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 476D29E8C8;
        Tue,  1 Aug 2017 14:41:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Paul Jolly <paul@myitcv.io>, git@vger.kernel.org,
        jacob.keller@gmail.com
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
        <20170512162109.49752-1-paul@myitcv.io>
        <20170512172657.GA98586@google.com>
        <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
        <20170512181950.GE98586@google.com>
        <CACoUkn7i76dEsQa3eoN+7WR8QmsD1pWsRQ0dvhkxzFN0sxTmRQ@mail.gmail.com>
        <20170801181820.GA110646@google.com>
        <CACoUkn46an6rStWhhJfgP-vbRU_+898S-TgDcefN3zL-jyDFJQ@mail.gmail.com>
        <20170801182033.GB110646@google.com>
Date:   Tue, 01 Aug 2017 11:41:57 -0700
In-Reply-To: <20170801182033.GB110646@google.com> (Brandon Williams's message
        of "Tue, 1 Aug 2017 11:20:33 -0700")
Message-ID: <xmqqshhbf7uy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19F5A728-76E9-11E7-BC77-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 08/01, Paul Jolly wrote:
>> > It looks like it was merged to master.  This should be the relevant
>> > commit: 188dce131 (ls-files: use repository object, 2017-06-22).
>> 
>> I was just typing a response to my response. Apologies, I was testing
>> locally with the wrong compiled version of git.
>> 
>> Confirmed fixed for me in e2d9c4613 at least.
>
> Perfect!  Glad to hear that it fixed the problem.

Thanks, both, for tying potentially loose ends.
