Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6C720281
	for <e@80x24.org>; Wed,  1 Nov 2017 11:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbdKALMH (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 07:12:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28146 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751638AbdKALMH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2017 07:12:07 -0400
X-IronPort-AV: E=Sophos;i="5.44,327,1505772000"; 
   d="scan'208";a="298858198"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 01 Nov 2017 12:12:05 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Payre Nathan <second.payre@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH 2/2] send-email: quote-email quotes the message body
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
        <20171030223444.5052-3-nathan.payre@etu.univ-lyon1.fr>
        <0db6387ef95b4fafbd70068be9e4f7c5@BPMBX2013-01.univ-lyon1.fr>
Date:   Wed, 01 Nov 2017 12:12:05 +0100
In-Reply-To: <0db6387ef95b4fafbd70068be9e4f7c5@BPMBX2013-01.univ-lyon1.fr>
        (Junio C. Hamano's message of "Wed, 1 Nov 2017 06:40:00 +0000")
Message-ID: <q7h9shdyw8vu.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hmmm.  I have a strong suspicion that people want an option to
> trigger the feature from just 1/2 but not 2/2 some of the time.
> Sure, removing the unwanted lines in the compose editor may be easy,
> but it feels wasteful use of user's time to include the lines of
> text from the original only to have them removed.

So, that could be

  git send-email --in-reply-to=message-id  # message-id is not a file
  => existing behavior

  git send-email --in-reply-to=file
  => populate To:, Cc:, In-Reply-To: and References:

  git send-email --in-reply-to=file --quote
  => in addition to the above, include the quoted message in the body

(perhaps --quote should be --cite, I'm not sure which one looks best for
a native speaker)

This also leaves room for

  git send-email --in-reply-to=message-id --fetch [--quote]
  => download the message body from e.g. public-inbox and do the same as
     for --in-reply-to=file

(which doesn't have to be implemented now, but would be a nice-to-have
in the future)

-- 
Matthieu Moy
https://matthieu-moy.fr/
