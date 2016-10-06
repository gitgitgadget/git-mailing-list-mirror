Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CBF8207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933553AbcJFStp (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 14:49:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61700 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933163AbcJFStf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 14:49:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8486448D5;
        Thu,  6 Oct 2016 14:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LF8t76iXtPID2O3op4GkFNcgAGM=; b=QdDS8w
        BhwQgfSDrJO3P4QmkSW2xlD60n3SmuFwEJImMs+XkfvO9C1/KPc2dBukTTlMi01b
        GgrUMjArklffMsWqR94PT0ztiuOfMPp2k9Dh2Iw3mZldC0aTZcur07XuCp6G6NIZ
        ukc744zr9/xpWAEBoocd25hSYKopO/+ddxeVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cA7Ho/Jm/0BMHKAoBmJn/cLfbMOtL2tW
        Vb32gPIXk8oFriJDctrwZW3RbcNlMk5MTzWxmMgj/OZCO8p+EtMhoblica/ITDaP
        YpEaQsiOJyUsIjEufx//rSZlRRvV7BJaAYpPt5CtwLlktY84r4v7MilprGuKo+u6
        9Pg9+6P0Ol0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA9E1448D4;
        Thu,  6 Oct 2016 14:49:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F025448D3;
        Thu,  6 Oct 2016 14:49:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ravi \(Tom\) Hale" <ravi@hale.ee>
Cc:     git <git@vger.kernel.org>
Subject: Re: Format for %d includes unwanted preceding space
References: <a3eed8fb-505c-e9c1-6fb6-944d9df2f15d@hale.ee>
Date:   Thu, 06 Oct 2016 11:49:30 -0700
In-Reply-To: <a3eed8fb-505c-e9c1-6fb6-944d9df2f15d@hale.ee> (Ravi Hale's
        message of "Thu, 6 Oct 2016 16:22:08 +0700")
Message-ID: <xmqq1sztl3d1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EFDA4E6-8BF5-11E6-8FC3-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ravi (Tom) Hale" <ravi@hale.ee> writes:

> The log --format="%d" includes preceding space:
>
> $ git log -n1 --format="XX%dXX" HEAD
> XX (HEAD -> master)XX
>
> I know of no other %<token> that is output in this way.

That is primarily because %d predates %[-+ ]<placeholder> mechanism,
I think.  It is too late to redefine what "%d" means and force all
users to update their script to use "% d" instead, unfortunately.


