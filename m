Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B2AA2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbcGFSLu (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 14:11:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755186AbcGFSLt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 14:11:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 031412930F;
	Wed,  6 Jul 2016 14:11:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y0X5gQ5wfeiLrJD9/RIEBh5LBCk=; b=M8Qpk7
	jHBXeFTiqp03ZEcykTMKAGGsIl7auriSEGd+6nb8UaxSWNJW9xZVvdTeUWeen7Cj
	T8NWGHPGx9KXbRlgfC+QsvlDUMHqRQeKef+JkJBMriyS4Io9pkOEnOjrNptbR2R1
	4DeOVa5dJibPbFwv9q4u6ddtEgnr809J92KGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=crSfThyTUjkPnr9VbPfeuvlf1UyfKTuy
	oG0Wl1aqDgmqK6k5A9PhnlWw/RVILZL4kmd9cZCb7cNeEDtX2IkoHTptCOt03Cud
	2qBsesiWSlqpkEeaMYZoadHX5fekH59howF/NKOQOAxY1IXq1VA0iOBDw4TyJ5kc
	vQAMAzVROeE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED2F62930E;
	Wed,  6 Jul 2016 14:11:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 745142930D;
	Wed,  6 Jul 2016 14:11:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Turner <novalis@novalis.org>
Cc:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Subject: Re: [PATCH v14 00/21] index-helper/watchman
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
Date:	Wed, 06 Jul 2016 11:11:40 -0700
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org> (David
	Turner's message of "Sun, 3 Jul 2016 03:57:52 -0400")
Message-ID: <xmqqzipuskkj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1788BAB6-43A5-11E6-BB0B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> This addresses comments on v13:
> removed unnecessary no_mmap ifdef
> add an ifdef in unix-socket
> OS X fix for select()
> test improvement

Thanks.  It seems that what used to be 809fd05a (read-cache.c: fix
constness of verify_hdr(), 2016-06-26) is no longer included in the
series, even though the tightening of the constness seems to still
be OK (i.e. verify_hdr() function takes the parameter hdr and only
uses it read-only).  Do you want me to keep it, or (more likely) did
I miss some discussion that reached the concensus that we do not
want it?
