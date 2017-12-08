Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEDF20C39
	for <e@80x24.org>; Fri,  8 Dec 2017 18:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbdLHSVX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:21:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752235AbdLHSVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:21:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B43ABABC72;
        Fri,  8 Dec 2017 13:21:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RPHXEuOT9eJu
        4DwY8XQUWqYYAqk=; b=iDqR/4lbRfTUBMV0yAYWPE2nO37JRH32xB3KiwSJoRUC
        eHAy7yNen82+g6rF0clBf5Q3zIz1/awraU3QWQEfPg5ZTB6CcM57l3FM1hwk06F4
        iKUGMUKPsDudOQTbARRhH4MlKfHIH/j3OkNRdq+pNx7o8U2/z6jntX+sjEqWkXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sUd1nQ
        QknGnDiExLj6fXOxi+8IKT3eeZ/I9lTWFBH0eA08LFJUqeYolKCkDqIMa2wz9gss
        RAvc/khp9NBA0OshHP5CzmSozzJpwcvssn6kTelrSepumc4d90Z2zLYGbtvap3bc
        6jujLZuI4L/zPNYMUUfIB1GFBdTrm1cudeUTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD50BABC71;
        Fri,  8 Dec 2017 13:21:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 250DEABC70;
        Fri,  8 Dec 2017 13:21:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, ashishnegi33@gmail.com
Subject: Re: [PATCH v1 1/2] t0027: Don't use git commit <empty-pathspec>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
        <20171208174633.9903-1-tboegi@web.de>
        <xmqqpo7p84vz.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 08 Dec 2017 10:21:19 -0800
In-Reply-To: <xmqqpo7p84vz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 08 Dec 2017 10:13:20 -0800")
Message-ID: <xmqqlgid84io.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97425C74-DC44-11E7-A6E4-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> tboegi@web.de writes:
>
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> Replace `git commit -m "comment" ""` with `git commit -m "comment"` to
>> remove the empty path spec.
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>>  t/t0027-auto-crlf.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This looks a bit strange.  The intent seems to commit all changes
> made in the working tree, so I'd understand it if it replaced the
> empty string with a single dot.
>
> I also thought that we deprecated use of an empty string as "match
> all" pathspec recently, and expected that this to break.
>
>     ... goes and looks ...
>
> Indeed, 229a95aa ("t0027: do not use an empty string as a pathspec
> element", 2017-06-23) does exactly that.

OK, I think I can safely omit this patch, because

 (1) when 2/2 is queued on top of tb/check-crlf-for-safe-crlf,
     because ex/deprecate-empty-pathspec-as-match-all is not yet in
     the topic, an empty pathspec still means "match all" and
     nothing breaks; and

 (2) when tb/check-crlf-for-safe-crlf plus 2/2 is merged to any
     branch with ex/deprecate-empty-pathspec-as-match-all, the topic
     already fixes what this 1/2 tries to

Thanks for being thorough, though.

