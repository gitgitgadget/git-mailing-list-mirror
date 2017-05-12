Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F9620188
	for <e@80x24.org>; Fri, 12 May 2017 08:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756117AbdELIdn (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:33:43 -0400
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:48899 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbdELIdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:33:41 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 May 2017 04:33:41 EDT
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 65C5DC87B;
        Fri, 12 May 2017 10:24:50 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 615261000AC;
        Fri, 12 May 2017 10:24:50 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 56D52125EC9;
        Fri, 12 May 2017 10:24:50 +0200 (CEST)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?0KDQsNC50YbQuNC9INCQ0L3RgtC+0L0=?= <anton@smarthead.ru>,
        git@vger.kernel.org
Subject: Re: Git credential helper store flushes randomly
References: <cdedf063-5f53-04c9-5ac0-2acf7e26696e@smarthead.ru>
        <20170512082058.ivvsmzc44cildp7l@sigill.intra.peff.net>
Date:   Fri, 12 May 2017 10:24:50 +0200
In-Reply-To: <20170512082058.ivvsmzc44cildp7l@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 12 May 2017 04:20:58 -0400")
Message-ID: <vpq1srucwj1.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (111)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The only time it should remove an entry is when Git asks it to. And the
> only time that happens is when Git sees the credential rejected by the
> server (e.g., an HTTP 401 even after we fed the stored credential). I
> don't know why that would happen unless there's some non-determinism on
> the server.

I did see a case like this where the server was broken temporarily and
rejected one login attempt. In this case the credential store deletes
the entry for that user, and when the server is repaired, the store
still has the entry deleted.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
