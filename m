Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F57F1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 19:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbdHVTYg (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 15:24:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60030 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753403AbdHVTYf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 15:24:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 814788CE7F;
        Tue, 22 Aug 2017 15:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6x4eDTWqUHDyQfpIHk9CS5ht0hU=; b=KbJUuK
        lJl2Mn4R6QzEf86XWZ6zrhp05QvvYfBMOwi+wfXCOq8E+JyUPqADpVcRmxSzuKKO
        6EAfxPGSNlTKqJPwq18wNn2pnH8oUmnJlRiS1SOslnwqdN/Lm4GRFa4JuuXe00VG
        WlSdlQthDk8+NSoCDJpMZ3/uHkyktuU+cyJhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IYJj0hICSN/tpdD/Gasg746iswnn0bs7
        Do2Wa7sIdFgguMwuYCUHT4mCoF4b6SwUAR8xp4+DBFCIRezLnZoMgtfzd3Qo5Mm/
        Aub8rJr6FEGoM+yk/D/TkbT1WwW7qqbqWg4Y5MZb7hvQ1EeADFGmqoF/XiUBmUY4
        u+QzGKkGTMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A6BF8CE7D;
        Tue, 22 Aug 2017 15:24:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D67938CE7C;
        Tue, 22 Aug 2017 15:24:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Martin Koegler <martin.koegler@chello.at>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: mk-dontmerge/size-t-on-next test failure
References: <fcddd218-e104-0f96-71e6-4522564555f1@kdbg.org>
Date:   Tue, 22 Aug 2017 12:24:32 -0700
In-Reply-To: <fcddd218-e104-0f96-71e6-4522564555f1@kdbg.org> (Johannes Sixt's
        message of "Tue, 22 Aug 2017 19:06:24 +0200")
Message-ID: <xmqqk21v2yof.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8748F6D6-876F-11E7-A99B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> I observe the test failure below in t0040-parse-options.sh. It bisects
> to 1a7909b25eb4ab3071ce4290115618e2582eadaa "Convert pack-objects to
> size_t". It looks like git_parse_size_t() needs a fix. This is on
> Windows, 32 bit. size_t, int and long are all 32 bits wide.

Thanks.  It is very much appreciated for people to peek at the
branch and try on different platforms that I (or Martin) do not use
regularly.

