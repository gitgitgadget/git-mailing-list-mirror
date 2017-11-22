Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5C020A40
	for <e@80x24.org>; Wed, 22 Nov 2017 02:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdKVCuY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:50:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65510 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751429AbdKVCuV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:50:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5276CB0539;
        Tue, 21 Nov 2017 21:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8pNSAyB+q7Q1gGtERqleb2+WYsg=; b=b/D3KM
        FhAr2M+bJNCXVbUNFRRrsomy3LhK8JsRlc8L5wZNg5qIOV5CXxJatnavjMPld5Qo
        +8F1ay0zuWEZwR26hun7tvuPjm164lL2zsOaJisNxga+pf1e/9U7iPt/WBEsFBXd
        zVzjZisJ7AQMVw2nUdfuT5tQR87+ky694ab/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jWVz86Dz5fsEG9YmvYGb/OGtHDbBIJtI
        /aTlBj51bl99vzftTKIFbhhkZ/1E+HOJiaH3WfCkpjjzhM+roSSm1U/RnXPZQQ7/
        uA+jAY4SGIKoPTSzNKf4jWJ2pq6nVtVqcKFcStzA+Ro29DDhRDE9S6QZCJfhJNRp
        89zCsW0KJUg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 488B0B0538;
        Tue, 21 Nov 2017 21:50:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABA5EB0537;
        Tue, 21 Nov 2017 21:50:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>
Subject: Re: [PATCH 1/3] Documentation: allow overriding timestamps of generated asciidoc
References: <20171121232935.GM3429@aiede.mtv.corp.google.com>
        <20171121233432.GN3429@aiede.mtv.corp.google.com>
        <20171122005433.kwv4bin6y65xuxm5@genre.crustytoothpaste.net>
        <20171122011531.GQ3429@aiede.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 11:50:19 +0900
In-Reply-To: <20171122011531.GQ3429@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 21 Nov 2017 17:15:31 -0800")
Message-ID: <xmqqlgizvxg4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E143B59C-CF2F-11E7-A064-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> touch -d @SECONDS isn't POSIX compliant, and non-Linux systems don't
>> provide it.  POSIX only allows certain fixed format, and I assume that
>> non-Linux parties (maybe OpenBSD) will want to have reproducible builds
>> as well.
>
> Interesting.  My knee-jerk preference is still to go with this patch
> as-is for now, since the non-portability only triggers when
> SOURCE_DATE_EPOCH is set.

As long as this patch is kept Debian-only, that is a sensible stance
to take.  I am not sure (note: this is different from "I do not think")
if it is also OK for the wider public, though.

I wondered if this affects the dirtyness of the build, regardless of
how file timestamps are mucked with.  It turns out that we do not
use "describe --dirty" in the GIT-VERSION-GEN script, so perhaps
it would be OK.


