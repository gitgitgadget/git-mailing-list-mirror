Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB8D81F463
	for <e@80x24.org>; Mon,  9 Sep 2019 22:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391931AbfIIWBg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 18:01:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60117 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388663AbfIIWBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 18:01:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 875142CE5E;
        Mon,  9 Sep 2019 18:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l9yAGlWfX3fE0QvZoptFUZ200lg=; b=tkyDdz
        /QGKwAJn/YdKEgD7W2YWOqtZPH+mOIDmL6VwkGfeZweA0PSNjlgHHrAB9TYJ4Ek4
        OvRFWMJef7umcV8MC0RrlT2pgm8rwvZS6Srl3og1meESc6aOm0ClOo82R/s2Mj/C
        p3uPz1bJASVfVkqpQXVepKiQw1kBoW31xKldk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y6jinsHa55qxFMZ566ee5M52OGb3kJ0M
        Ti9FDAyen0mhC0P4EC7RlWwkR+SYmEpv7fxJiSc/jmWa/U3/m8/ctZzLlfleOoG6
        shFSNiXMN2yy2InGQl2+MAQvjklIJ/75fHknr6H+SRJLRpSpyPllWSHuROnf4fXk
        bfk8BOEqK1M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F2172CE5D;
        Mon,  9 Sep 2019 18:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E65542CE5C;
        Mon,  9 Sep 2019 18:01:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Gniazdowski <sgniazdowski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Password cannot contain hash
References: <CAKc7PVDT0JXCAW=aON2jXidCgib=SjoUXU6Yh4t+xWB8QW4NPQ@mail.gmail.com>
Date:   Mon, 09 Sep 2019 15:01:32 -0700
In-Reply-To: <CAKc7PVDT0JXCAW=aON2jXidCgib=SjoUXU6Yh4t+xWB8QW4NPQ@mail.gmail.com>
        (Sebastian Gniazdowski's message of "Mon, 9 Sep 2019 23:18:46 +0200")
Message-ID: <xmqq5zm1i0xv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63124DA4-D34D-11E9-949D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Gniazdowski <sgniazdowski@gmail.com> writes:

> Hello,
> if the password contains a hash, then it's impossible to clone a
> repository, either with https or ssh protocols. I've had to use a
> `gitg' GUI to clone such a repo.

Hmph, do you mean that

	git clone https://user:password@hosting.site/repository/
	git clone ssh://user:password@hosting.site/repository/

if the "password" has '#' in it?  Do passwords with colon, slash or
at-sign have the same issue?  Would it help to URI escape the
problematic characters?

It is a separate issue to use passwords embedded in the URLs, but
still, escaping ought to work.


        
