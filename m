Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A0820958
	for <e@80x24.org>; Wed, 29 Mar 2017 17:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbdC2RLc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 13:11:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64965 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbdC2RLc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 13:11:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87F7F857CF;
        Wed, 29 Mar 2017 13:11:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fTVRQtca1ZQeK2Xo80pX49y6h24=; b=MHCp6R
        Z712OjEVLnE6gO1Rr++qOXjRVrufYI5IiW0Sph8aM2iF03Nw2m2nGCLR4VAg2Ha3
        GAA88BbznlR1eP67CSin7sVDmhEMTagqQUgVt5er3MVHimH/5xUP3kNsFR3JQwIr
        4AIp2gKL0z55EJ116seCaWZkgmMsp94VfMGe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f5CPSD+CHCN/Z9lSpeVGot1kwFE4bL5H
        5NwDuaAiDoPPNwdgCPghxFkYHMiZmnLT92H/boTTKfq2WVkdxX6guFwB+p9sHJBz
        PTJ5Mjwu9yRacysaKR1yAcpkenjeTrUnFYXGhTIMs7nw88A3OMg9h7na/IfJ5X1X
        ExzHnKX2HWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 800B8857CE;
        Wed, 29 Mar 2017 13:11:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB7B6857CA;
        Wed, 29 Mar 2017 13:11:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-compat-util.h:735:13: error: conflicting types for 'inet_ntop'
References: <CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com>
Date:   Wed, 29 Mar 2017 10:11:28 -0700
In-Reply-To: <CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com>
        (Jeffrey Walton's message of "Wed, 29 Mar 2017 05:19:17 -0400")
Message-ID: <xmqqbmskatz3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C026D684-14A2-11E7-BC02-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> Some more 2.12.2 testing on Solaris 11.3 x86_64:
>
> $ make V=1
> gcc -o credential-store.o -c -MF ./.depend/credential-store.o.d -MQ
> credential-store.o -MMD -MP -I/usr/local/include -m64 -m64 -I.
> -D__EXTENSIONS__ -D__sun__ -DUSE_LIBPCRE -I/usr/local/include
> -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
> -I/usr/local/include -I/usr/local/include -DNO_D_TYPE_IN_DIRENT
> -DNO_INET_NTOP -DNO_INET_PTON  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H

Looking at config.mak.uname, nothing in SunOS section seems to set
NO_INET_NTOP or NO_INET_PTON.  Why is your build setting them?
