Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD761F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 00:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJCAnz (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 20:43:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58177 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJCAnz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 20:43:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81EC384237;
        Wed,  2 Oct 2019 20:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q7dGrWOgVIP/XgWaTYya+n9qazA=; b=cZZSL+
        iKJrFGiZaz/0Gx7A8n92ZyZoLOsQw1mq1agtrlO8H5iN5bL7zHRkeetgQmd2WaPE
        t6rKgUgBWFxIVlDHYXkCcbQesnX8LtQrrfk0Mygs13EQJqanRQnrrbNZHcHOV+cn
        e9gX1JWLJZurszBkE8GYHKnc9JDkP3ISN8OlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KMwT4BeRH6P7oEpUPEOwtPo1XG+AD951
        siH3cvpDnASRjb7Rzax0QAM7SQItiUMGHM94qDRQlN+jokca8IpIeUIkDTG5yxj5
        2yzjBAwaL34R0jrnF1Z1q7FJMW6HeJGfyzPtk2ERtsu96ggA2EUxf2TLQQ+2h3MW
        taKj+RgDsyE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B2D084236;
        Wed,  2 Oct 2019 20:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2D1284230;
        Wed,  2 Oct 2019 20:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] range-diff: internally force `diff.noprefix=false`
References: <pull.373.git.gitgitgadget@gmail.com>
        <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
        <xmqq4l0qewu5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910022229340.46@tvgsbejvaqbjf.bet>
Date:   Thu, 03 Oct 2019 09:43:48 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910022229340.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 2 Oct 2019 22:30:26 +0200 (CEST)")
Message-ID: <xmqqr23ud5ff.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE1C9028-E576-11E9-8977-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> While at it, I invert the logic in v2: instead of forcing a prefix, I
> now force no prefix (and reduce the strip level from 1 to 0 when parsing
> the diff header).

Ah, that approach would also work and may be conceptually cleaner
than requiring a/ and b/ prefix and forcing them.
