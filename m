Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA591FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbcLGUSh (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:18:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54631 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752876AbcLGUSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:18:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3CA356052;
        Wed,  7 Dec 2016 15:18:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k5wYnf492Zs8ZkW5yJkbcbWr348=; b=nmDEHo
        hXWK3LY9XT79eaWofh7hfiULxGBhACFckadCkS9GPJuUs4bHJz6bPmxvH8GGFLvz
        33uyLHJsFFoFVE4Ok2/sCBBj92XkqvGOqPzZgqaTxT3XTqzkvxGwRsWlU4jnuEov
        tmX75E71FC1Z5W2pnri536mqWBU/4ftzKp0pU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ggMpiWHJIr45pc6otd8UGSm3ZqF2s7gx
        l7jSXW3q/9u2p9p8rMSHLy0TANphiDeKaNLnwv5Y9ldbNZ8ISTajwPTOiSSsZRK/
        2OfPoGEIyDv97CaCFDqktrTW/NxlUG3DVVd2zIgDbwSQxwzZKYnfftRhe/SxmOvD
        K9entIWF6C0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB47156051;
        Wed,  7 Dec 2016 15:18:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3459B56050;
        Wed,  7 Dec 2016 15:18:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     vi0oss@gmail.com, "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
References: <20161207184248.6130-1-vi0oss@gmail.com>
        <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
Date:   Wed, 07 Dec 2016 12:18:33 -0800
In-Reply-To: <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
        (Stefan Beller's message of "Wed, 7 Dec 2016 12:09:39 -0800")
Message-ID: <xmqq4m2fxzl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54B2D050-BCBA-11E6-8365-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> This patch makes all not just the root repository, but also
>> all submodules (recursively) have submodule.alternateLocation
>> and submodule.alternateErrorStrategy configured, making Git
>> search for possible alternates for nested submodules as well.
>
> Sounds great!

Is it safe to assume that all the submodules used recursively by
submodules share the same structure upstream?  Does the alternate
location mechanism degrades sensibly if this assumption turns out to
be false (i.e. "possible alternates" above turns out to be mere
possibility and not there)?
