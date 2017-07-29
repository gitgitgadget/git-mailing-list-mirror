Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3E52047F
	for <e@80x24.org>; Sat, 29 Jul 2017 16:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbdG2Q0h (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 12:26:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752633AbdG2Q0g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 12:26:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 216FBA5370;
        Sat, 29 Jul 2017 12:26:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9sbd1xe7mCZhlqhXMhGP3TcD4yk=; b=x9nCRYHLlLfBAXbMqpuK
        6Mo62y/nWSjzkfwKp94l1Im6hCycyWqm43aDAnWHaVXdoKVqCNfhH5+/mIxL3OIf
        dob5jJMtqg/RgySlg4uR9cmvDC1HrUW+dlqL436942bOhKWPBh+eer16mOGYIcnT
        X+m3waAIxRItHqeZEf4KHgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=YqQqvws4fJxO+CYVE4VYIFq/cmjTNRYnE5bg0MRc/dthVu
        weqdK/qk9Kd8Z8HX8zdRqrY64LT9X8OaMWTcWH7ZTyoZb2fPn/jqjEwPnKk1GMhN
        H+NK1q8rkHobNyJJWIzcwL1Te7NXyUfLdVjFhn0vfCDFdJsTrZyuGx3Wq9TPc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19448A536F;
        Sat, 29 Jul 2017 12:26:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64E6BA536E;
        Sat, 29 Jul 2017 12:26:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH for NEXT v3 0/2] sub-process: refactor handshake to common function
References: <20170724213810.29831-1-jonathantanmy@google.com>
        <cover.1501092795.git.jonathantanmy@google.com>
Date:   Sat, 29 Jul 2017 09:26:27 -0700
Message-ID: <xmqqmv7njjkc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC568CD4-747A-11E7-B17F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks for all your comments.
>
> This is now built off "next" to include Lars's changes.

Developing on 'next' to ask for comments is OK, but try to minimize
the dependencies; otherwise you are setting yourself to be taken
hostage by many unrelated topics.

I did a merge of ls/filter-branch-delayed into v2.14-rc1 and then
applied these two on top (with one small style-fix) to see how bad
its dependencies are---I think that is the only topic you need that
is still in flight, so it does not look too bad.

