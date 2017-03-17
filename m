Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB96B20951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdCQWnq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:43:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59515 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751269AbdCQWnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:43:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14C1578B32;
        Fri, 17 Mar 2017 18:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ic8T8Hc4Adlklb+Lw3OTEzeoSng=; b=imDDuO
        XGRN0BdOXuAQ9uLv/p5mkgPHQCa5AnZrRmIc8n39hJ+7yeZx6mhiQ24RlCb6Kzxa
        jdQ9uFYiWTYLHpheezi4n7SONfDKpIytgP/5kRDiwImoj+lIsFrGuNNHARQ5/M5v
        bJzWOBKGFBaX/a8kJXRzkfClIUgvJ8/xTf5Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MW9AG+fubh9u9+mgFF3C3YhOZcxDokBe
        96eK58tDRS5SJ5UMP3Ggog0klpy0VH6blcTPuVwOcb9u2gcxMs0inn1WLHc4Djfa
        FXOLe5xT8wQuDwUAH89IbQV3ybFHy3wTIDq+08xHXE5e+HY2gC0lU9lDC1tEP43k
        61nkxW7BytY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D09378B31;
        Fri, 17 Mar 2017 18:43:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71A5A78B30;
        Fri, 17 Mar 2017 18:43:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
        <20170315225045.15788-1-gitster@pobox.com>
        <20170315225045.15788-3-gitster@pobox.com>
        <9AE7ADCA-97F9-4857-AC55-76C4BD822C25@gmail.com>
        <xmqqy3w48nif.fsf@gitster.mtv.corp.google.com>
        <xmqqshmc8n09.fsf@gitster.mtv.corp.google.com>
        <015A7026-960F-450C-9276-AAC3A0B11207@gmail.com>
        <xmqqd1df961c.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Mar 2017 15:43:42 -0700
In-Reply-To: <xmqqd1df961c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 17 Mar 2017 10:17:35 -0700")
Message-ID: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C86730A-0B63-11E7-BA35-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lars Schneider <larsxschneider@gmail.com> writes:
> ...
>> Following your explanation this patch looks good to me and this fixes the
>> test failure. TBH I never thought about the difference of these commands
>> before. "rev" and "ref" sound so similar although they denote completely 
>> different things.
>
> Thanks for testing.
> ...
> Hence, I would really prefer not to commit mine myself.  I'd rather
> see somebody from git-p4 circle to come up with a version that is
> more in line with the way things are done in the existing code and
> send a tested version for me to apply.

Tentatively I queued my hack together with the name-rev thing on
'pu', and Travis seems to be OK with the result.  

It would be nice if we can "fix" the use of "name-rev HEAD" in "git
p4" sooner rather than later.  If the code truly uses it to figure
out what branch we are currently on and acts on it, as the name of
that function suggests, it may be easy to construct a testcase where
the code without the fix does a wrong thing (e.g. have two branches
pointing at the same commit, and tell "git p4" to act on the one
that sorts later in the "git branch --list" output; the command
would act as if it were working on the other branch), and shows that
the patch fixes that problem.  That would be a bug worth fixing
quickly regardless of the "name-rev" change michael wanted to make.

Thanks.

