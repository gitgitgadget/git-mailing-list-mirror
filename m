Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338D4201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964912AbdBQXlg (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:41:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61335 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964862AbdBQXlf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:41:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64680691B8;
        Fri, 17 Feb 2017 18:41:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=7vhteOxjB3NZs//fnFNWJVqsAO4=; b=eqneEa
        mU5NACPz/tFeKjSJNIrpqH4wdhOGzDeiyIko5IT0XTLVyhS7e2EB+yIFYek6ewu2
        4wkKD56Y1yiOokpd9OatMRghq/5uEGPEegohMoUmwGCvtGgSMk/mLLPtgPJG04I5
        6o7ZrkUEq4MtWTZezSAh/Z0jqMXO2Z5w3jhxA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E0C4691B7;
        Fri, 17 Feb 2017 18:41:34 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4753691B6;
        Fri, 17 Feb 2017 18:41:33 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's log
In-Reply-To: <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net> <20170217035800.13214-1-kyle@kyleam.com> <20170217035800.13214-4-kyle@kyleam.com> <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net> <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Feb 2017 18:41:32 -0500
Message-ID: <871suwqtar.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D71A0EE-F56A-11E6-9E70-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=7vhteOxjB3NZs//fnFNWJVqsAO4=; b=pj48QEDBN/SrJzf+zVG1G2yRcELqL1/vFjl6kpg19nwZ/8lfct2pTu2OPAy8Le6wkiPZ5GNe6796HXK0fdhkKO2qQtfh6WoGCYBc8Oi+JBNpiTwmPLV02/1rjPlhUU8AFr5FgyCuvjfIEdcmyxx89+jTYw9Hk6bgI5v5CIRFWFY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

> Do we even want these "internal" delete_ref() invocations to be
> logged in HEAD's reflog?  I understand that this is inside the
> implementation of renaming an old ref to a new ref, and reflog
> message given to delete_ref() would matter only if the HEAD happens
> to be pointing at old ref---but then HEAD will be repointed to the
> new ref by somebody else [*1*] that called this function to rename
> old to new and it _will_ log it.

I know the discussion has developed further, but just a note that I
think the last statement is inaccurate: currently, a rename will not be
recorded in HEAD's log.  "git branch -m" will show a renaming event in
the new branch's log, but the only trace of the event in HEAD's log is
the deletion entry with an empty message.

-- 
Kyle
