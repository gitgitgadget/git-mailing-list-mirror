Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A31E20966
	for <e@80x24.org>; Thu, 30 Mar 2017 22:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934207AbdC3W6B (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 18:58:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56710 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932323AbdC3W56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 18:57:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F802707FF;
        Thu, 30 Mar 2017 18:57:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jAPZuNslqPAdtLdM0r2vNkqqZHk=; b=tdEIO7
        KKXftHzZDrB+p6jOERv1yP194LycnusbdGmelvkV3srvcoJIgWisrghaeZihysRS
        7Pj4DbkNkJsfRZWOkBIF1f60sScu/r+EIemLN+lpxPUS13XsxracElD4O2MKBy5q
        hHnwNbfYcFxDXCk0dFkVJFreDuaXnW0dPpKU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I3FTGiDNnvtw/cqAc36SjO9idwfAuICy
        jFbxUyNzLKB+De50lAGpakkhujHYlT98tiCr7a5ZrsJIgJdrtVAmdSrud4fZ2BaW
        7smGLoioMd5lom7zf8SULBcapjiQ5pyqqNutMrKpycf6XiU+HpYxiUZxuEe2Y5JH
        1UBRHwGmhuE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 990F1707FE;
        Thu, 30 Mar 2017 18:57:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DE82707FD;
        Thu, 30 Mar 2017 18:57:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nate Mueller <nate@retailnext.net>
Cc:     git@vger.kernel.org
Subject: Re: Issue with 2.11.0 and GIT_EXEC_PATH with multiple entries
References: <CAJF7t-dqSa7tmQqNEWmg_VZ=+832nsZ-3JmSGA03qK6aY5eNTQ@mail.gmail.com>
Date:   Thu, 30 Mar 2017 15:57:39 -0700
In-Reply-To: <CAJF7t-dqSa7tmQqNEWmg_VZ=+832nsZ-3JmSGA03qK6aY5eNTQ@mail.gmail.com>
        (Nate Mueller's message of "Thu, 30 Mar 2017 15:39:04 -0700")
Message-ID: <xmqqo9wi1ifw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4723CC2E-159C-11E7-8C4B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nate Mueller <nate@retailnext.net> writes:

> This fails for me because my GIT_EXEC_PATH is set to
> "/Library/Developer/CommandLineTools/usr/libexec/git-core:/Users/nate/.git-exec".

That environment variable is designed to hold a single path, not
like $PATH that lists multiple places in a colon separated list.
