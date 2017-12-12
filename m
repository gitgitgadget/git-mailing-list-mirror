Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27201F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdLLT7g (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:59:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54976 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752303AbdLLT7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:59:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EEBEC829C;
        Tue, 12 Dec 2017 14:59:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VVIHT4s5f+GKwIMHjI8E6k5K5D8=; b=qrmeIe
        3GCLXaRoWMOjZG7IYoUn7dCr5JMhmGDd5IBQI2fhbTnexICoclirtvNa8qzRMhgA
        IKYH4adC8SYCYOQJDBTkYsD8+2phFspfEA5Ju5qFQgDl9JTumwq+8zuKlXS9b5v6
        15XrohwVESDmrRJ7yGn5bZzwyekWo3FIAx2Go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A/hlbelwP+t3jmhhw/AZTrcYQNszbZsk
        yqGCC6K7G1p05PN6HrOgfRDZ5dBxLwQlDgrQIsmwXm56V+uuBKRq7SWhwfEcR8q1
        aoP0oBsM+eAbpjnL87W6/HRevVzEln3HZstKDSx2mODH5uvadwUS8T1Nh+RlAMXL
        WVXlBsYCCWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35FF0C829B;
        Tue, 12 Dec 2017 14:59:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CE8CC8299;
        Tue, 12 Dec 2017 14:59:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     dnj@google.com, git@vger.kernel.org, judge.packham@gmail.com,
        kostix+git@007spb.ru, manschwetus@cs-software-gmbh.de,
        max@max630.net, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [RFC PATCH] t/helper: Move sources to t/helper-src; gitignore any files in t/helper
References: <20171212161701.4272-1-dnj@google.com>
        <20171212190026.17671-1-sbeller@google.com>
Date:   Tue, 12 Dec 2017 11:59:33 -0800
In-Reply-To: <20171212190026.17671-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 12 Dec 2017 11:00:26 -0800")
Message-ID: <xmqqbmj31zve.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9BE3956-DF76-11E7-AF5E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Compiled test helpers in t/helper are out of sync with the .gitignore
> files quite frequently. This can happen when new test helpers are added,
> but the explicit .gitignore file is not updated in the same commit, or
> when you forget to 'make clean' before checking out a different version
> of git, as the different version may have a different explicit list of
> test helpers to ignore.
>
> This can be fixed by using overly broad ignore patterns, such as ignoring
> the whole directory via '//t/helper/*' in .gitignore.

If we ignore everything but resurrect *.[ch] with negative exclude
rules, can we do the same without moving things around?
