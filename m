Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CAD1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 07:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKZS2U (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 13:28:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKZS2U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 13:28:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AE9510EFB6;
        Mon, 26 Nov 2018 02:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N7ToyAoTpDwFeTqWkW2hIuz3svI=; b=bE+TiI
        V0xZqYFi1XMgaaJwj6/UNs4HmEH83/dgAPBHGQLWqpIcvfRb7XwfRezS93pah2LB
        SuvPJ+H9n6LP/F8HI+jTsoUHa3VbrOoy5aEvnWtk09A8cfiLDbwsdsqLHEAdE5v2
        vWNfmc++4Ac2Vya/oTpu2aIuyXxAcIUOywfiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EBOGHm+AMZr5Q4utWWw+0Q38YmynEyPT
        koEM383LUPc+D/0HAp9RFyVKzO3CdNB+xjeXBcmNG+k0ix0G9wJ5xwDrH07aS5os
        Va/dtAhq2EmXmHg9Ll5O8NRHiGQRS1br7oILHsP/mvI2P3fbl9BiPu4qx0s1n6Qs
        SH33uGFWbQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9354410EFB5;
        Mon, 26 Nov 2018 02:35:04 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D820810EFAB;
        Mon, 26 Nov 2018 02:35:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 26 Nov 2018 16:35:02 +0900
In-Reply-To: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 22 Nov 2018 00:20:23 +0900")
Message-ID: <xmqqd0qswau1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA067644-F14D-11E8-9026-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless I hear otherwise in the next 24 hours, I am planning to
merge the following topics to 'master' before cutting -rc2.  Please
stop me on any of these topics.

 - jc/postpone-rebase-in-c

   This may be the most controversial.  It demotes the C
   reimplementation of "git rebase" to an experimental opt-in
   feature that can only be enabled by setting rebase.useBuiltIn
   configuration that defaults to false.

   cf. <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>


 - ab/format-patch-rangediff-not-stat

   The "--rangediff" option recently added to "format-patch"
   interspersed a bogus and useless "--stat" information by mistake,
   which is being corrected.

   cf. <xmqqa7lz43d8.fsf@gitster-ct.c.googlers.com>


The following three topics I do not need help in deciding; they are
all good and will be merged before -rc2.

 - jk/t5562-perl-path-fix

   This is to invoke a perl scriptlet with "$PERL_PATH" in one of
   the new tests, instead of relying on (an incorrect) she-bang line
   in the script file.

 - tb/clone-case-smashing-warning-test

   This enables the test to see the behaviour of "git clone" after
   cloning a project that has paths that are different only in case
   on MINGW (earlier it wanted CASE_INSENSITIVE_FS prerequisite and
   in addition not on MINGW).

 - nd/per-worktree-ref-iteration

   This fixes a "return function_that_returns_void(...)" in a
   function that returns void.


Thanks.
