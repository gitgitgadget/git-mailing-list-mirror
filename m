Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F09F2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 21:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935154AbcJZVRP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 17:17:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51344 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933304AbcJZVRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 17:17:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 333FE49EA2;
        Wed, 26 Oct 2016 17:17:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=356rTEC0scLRqoc+wvZpFc7NOpw=; b=qnWlRg
        GIULuTkQLiBASEwEKJsI8kYmjo9VTjtMSYWmBpKvMbABeiKGGDqDgLyN5MRkhzGa
        2jvC2c0N/o6tX0GgffHEL9LJph2cEdazMc9HtK2CGQhDRcmwluyP1DsOwx1lpQtu
        9cBT8CNtZZFzxsbLBprBwW47uYIYbuSKdByks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kRSzodssB+2s47qLfY9lmVaOdOKiHcTM
        KHWFRt8pF9MmwqHophy7EJOwLgdOKIwR7wnicoMx5tQ49RJSKDiSbFt14rksXiN4
        6ea1WMkmLTzmkG9Q7asDGWmN4gDSSeifdexawfeNjsWPg9aA5uDCBtzgiNktq0wS
        +NiITH/1kD8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A26A49EA1;
        Wed, 26 Oct 2016 17:17:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A19AB49EA0;
        Wed, 26 Oct 2016 17:17:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Mathieu Arnold <mat@FreeBSD.org>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] git-svn: implement "git worktree" awareness
References: <20161013205555.GA599@dcvr> <20161014014623.15223-1-e@80x24.org>
        <20161026200248.GA28105@starla>
Date:   Wed, 26 Oct 2016 14:17:10 -0700
In-Reply-To: <20161026200248.GA28105@starla> (Eric Wong's message of "Wed, 26
        Oct 2016 20:02:48 +0000")
Message-ID: <xmqq8ttabyjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FE8BF0A-9BC1-11E6-B168-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Eric Wong <e@80x24.org> wrote:
>> +Cc Jakub since gitweb could probably take advantage of get_record
>> from the first patch, too.  I'm not completely sure about the API
>> for this, though.
>
> Jakub: ping?
>
> +Cc: Junio, too.  I'm hoping to have this in 2.11.

I somehow was hoping that I can pull this as part of git-svn updates
for the upcoming release without having to even think about it (I
did read the patch when they were posted and did not find anything
wrong with them, fwiw).

>> The following changes since commit 3cdd5d19178a54d2e51b5098d43b57571241d0ab:
>> 
>>   Sync with maint (2016-10-11 14:55:48 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://bogomips.org/git-svn.git svn-wt
>> 
>> for you to fetch changes up to 112423eb905cf28c9445781a7647ba590d597ab3:
>> 
>>   git-svn: "git worktree" awareness (2016-10-14 01:36:12 +0000)

Thanks.
