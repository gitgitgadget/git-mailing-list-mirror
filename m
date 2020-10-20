Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4008AC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B2C2076A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iQbVZ2Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391105AbgJTTRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:17:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63472 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgJTTRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:17:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A273F9D2E;
        Tue, 20 Oct 2020 15:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hJLdEcmQqH3moVhG1XDm2yzxOFQ=; b=iQbVZ2
        Lsbkn5Z5+Xxn3Bs8Qeg5NixgIOdJKv/umoAcTsVkYYBSJCSkOKG7BRe2LDDIOGHa
        inwfqTVXd31+L1GiS2fwwl9PDXgJNjQ/vjWpWQSCMcA9a0VQtA1KTgzxYlGLfxII
        dtpuvMXPhoGm3bmsgufOr0QHUf3JwmDQNrOcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yUWqTS2VShpltFEWhsO6rEv2fEKomZZf
        6qgA/rtkzbWsapEQkPQR3z0BP1Ns162EnsQUN5T6JvjORJNukeCNnA/IWLzJZvUs
        JcfuItMwOcOElyB74CETvKczCizaB755bfDxY0PM3HkjJEh/IsjD9IZCTJ6Ky9bq
        YKv7cVLTYP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 405CCF9D2D;
        Tue, 20 Oct 2020 15:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CEEFF9D2A;
        Tue, 20 Oct 2020 15:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Preparing to rewind 'next'
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
Date:   Tue, 20 Oct 2020 12:17:15 -0700
In-Reply-To: <xmqqr1put77h.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 19 Oct 2020 11:13:22 -0700")
Message-ID: <xmqqtuuobtc4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE3A17B8-1308-11EB-AB4B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now 2.29 is out, it's time to clean the desk and to prepare for the
next cycle.  Typically a week after a release, we rebuild the tip of
'next' and it is an opportunity to kick some topics out of 'next'.

Here are the topics that are in next and have been marked as "Will
cook in 'next'" during the pre-release freeze period.  

Please nominate topics that should be kicked out of 'next', either
tentatively to give them a fresh chance to apply minor clean-ups (or
permanently because they are fundamentally wrong---but hopefully
there is no topic in the latter category).

Thanks.

 + ds/maintenance-part-2                                        09-25/10-04    #8
 + sk/force-if-includes                                         10-03/10-04    #4
 + mt/parallel-checkout-part-1                                  10-05/10-05   #20
 + sb/clone-origin                                              09-30/10-06    #7
 + jk/symlinked-dotgitx-files                                   10-06/10-08    #8
 + dl/checkout-p-merge-base                                     10-07/10-08    #4
 + js/userdiff-php                                              10-07/10-08    #1
 + kb/userdiff-rust-macro-rules                                 10-07/10-08    #1
 + rk/completion-stash                                          10-07/10-08    #2
 + dl/checkout-guess                                            10-08/10-08    #2
 + sd/userdiff-css-update                                       10-08/10-08    #1
 + cw/ci-ghwf-check-ws-errors                                   10-09/10-15    #1
 + rs/dist-doc-with-git-archive                                 10-12/10-15    #2
 + rs/tighten-callers-of-deref-tag                              10-12/10-15    #3
 + rs/worktree-list-show-locked                                 10-12/10-15    #1
