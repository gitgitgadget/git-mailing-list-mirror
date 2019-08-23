Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DCF1F4B7
	for <e@80x24.org>; Fri, 23 Aug 2019 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390269AbfHWQ3B (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 12:29:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60882 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbfHWQ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 12:29:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DABB75897;
        Fri, 23 Aug 2019 12:28:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bgjTnz75fSy4/jgdLK7Xzlt6gtc=; b=Do/idh
        rkn7lHeSmC9Yy8DnFVoLWusSEGlPp5gogsJ3XF7N3WmcXUhQwYFb1nMWNptyMR10
        OVnsjRFDFg/jk3l+/yjvUZ1+cS2R8t8LpsC29Zlx8jPJFHY4FVY3aHNHj9AADJb9
        xkbunuNbSLC3vJS3zaJGhG5yKizPmtKWS2PQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cLpc7qbVQWphi7SYqdRlgi3pb6D9yaMt
        USJCo2yYTrmU+gf6u6+QDfOAiHG2hIZtcWOXFz+TzpFXXlS/+P65OxsGa3wsn9Rv
        GmKTigbzu4uVTIrrtLYAl0S9WGtZzL5EfYlST1Xm/TTonCztgSjYI1y9H/1rYlft
        X9/lpLqyqD4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14F6475895;
        Fri, 23 Aug 2019 12:28:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4214975892;
        Fri, 23 Aug 2019 12:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
References: <20190819214110.26461-1-me@yadavpratyush.com>
        <20190819214110.26461-3-me@yadavpratyush.com>
        <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
        <20190820192944.gzfwnm52fvb5refq@localhost.localdomain>
        <93095b5a-6e15-ce4a-eb9b-22f9528312e1@kdbg.org>
        <20190821214829.2dzat2quo3h2s3z2@localhost.localdomain>
        <nycvar.QRO.7.76.6.1908231500030.46@tvgsbejvaqbjf.bet>
Date:   Fri, 23 Aug 2019 09:28:52 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908231500030.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 23 Aug 2019 15:01:32 +0200 (CEST)")
Message-ID: <xmqqk1b3n8vv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19C0AA70-C5C3-11E9-B8DC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe the direction taken by this discussion merely suggests that the
> design is a bit unfortunate. Why "revert"? Why not "stash" instead? Then
> you don't need to have that annoying confirmation dialog.

Interesting, but it would need a bit more tweak than a simple
"stash" for it to be truly helpful, I would imagine.

The primary purpose of stashing from end user's point of view is to
save some changes, that are not immediately usable in the context of
the corrent work, away, so that they can be retrieved later, with a
side effect of wiping the stashed changes from the working tree. The
command could be (re|ab)used to wipe local changes you have in the
working tree, but that would accumulate cruft that you most of the
time (unless you make a mistake) wanted to discard and wanted to
never look at again in the stash. If done using the same 'stash' ref
that is used by the normal "git stash", the stash entries created by
"git stash" because the user really wanted to keep them for later
use would be drowned among these "kept just in case" stash entries
that were created as a side effect of (ab)using stash in place of
"restore".

But "git stash" can be told to use a different ref, so perhaps by
using a separate one for this "just in case" purpose, with the
expectation that the entries are almost always safe to discard
unless the user made a mistake and take it back immediately
(i.e. "undo"), it would not hurt the normal use of "git stash" *and*
give the "revert" necessary safety valve at the same time.

Thanks.
