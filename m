Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C02202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 01:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966977AbdIZBbF (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 21:31:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59587 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965729AbdIZBbE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 21:31:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4DBE9BE2C;
        Mon, 25 Sep 2017 21:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4S7gP6VEqvKe8JDPDbjUI30Uil0=; b=jtB59W
        q6tSk5gjekuUdpQwT3symS+Y1gtEJ+mu7vQJOnjJTaByTjdCye40ghutsA33IElA
        pDssw9AUUclH+YALzzVmAgFzDWgtAoTheuBPk/XAdCDVwzYdlpPKH2uWD35gHZoR
        Ov7FXoyPfFcLRhy39PlLf6EBXOsUm3pYeFc6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ckPviOCvtRnweKDld5Td0MnX3bYButia
        B5eINRygMwWtzO6Ov+ULBaDkPLMeVykLMNB71Y4zSAWRd9SEaSw8X/Apx+fUGR+K
        HaSdImRljLbvf4KibW66nA/DlTtXwjqlng5oLN2vE15IRMekVPZwSS4o37QHRiLs
        P6brHqOIBkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC0F89BE2B;
        Mon, 25 Sep 2017 21:31:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAF709BE29;
        Mon, 25 Sep 2017 21:31:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH] Documentation: consolidate submodule.<name>.update
References: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com>
        <20170925191011.29863-1-sbeller@google.com>
        <20170925191726.GE35385@google.com>
Date:   Tue, 26 Sep 2017 10:30:59 +0900
In-Reply-To: <20170925191726.GE35385@google.com> (Brandon Williams's message
        of "Mon, 25 Sep 2017 12:17:26 -0700")
Message-ID: <xmqqy3p2ckks.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AAADF26-A25A-11E7-AD19-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> +	The method by which a submodule is updated by 'git submodule update',
>> +	which is the only affected command, others such as
>> +	'git checkout --recurse-submodules' are unaffected. It exists for
>> +	historical reasons, when 'git submodule' was the only command to
>> +	interact with submodules; settings like `submodule.active`
>> +	and `pull.rebase` are more specific. It is copied to the config
>> +	by `git submodule init` from the .gitmodules file.
>> +	Allowed values here are 'checkout', 'rebase', 'merge' or 'none'.
>> +	See description of 'update' command in linkgit:git-submodule[1]
>> +	for their meaning. Note that the '!command' form is intentionally
>> +	ignored here for security reasons.
>
> This probably needs to be tweaked a bit to say that the '!command' form
> is ignored by submodule init, in that it isn't copied over from the
> .gitmodules file, but if it is configured in your config it will be
> respected by 'submodule update'.

I do not think gitmodules.txt is the place to say anything more than
what Stefan's patch says above.  Perhaps config.txt should mention
that in addition to what the variable with the same in .gitmodules
can take, it is allowed to use the !command form.

IOW, in config.txt

	submodule.<name>.update::
		Specifies how 'git submodule update' should work on
		the named submodule.  In addition to the values that
		can be specified in (and copied from) `.gitmodules`
		(see linkgit:gitmodules[5]), `!command` form can
		also be used.

or something, perhaps?
