Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42EA200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756113AbcL0TN4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:13:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52279 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754570AbcL0TNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:13:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C51B59B14;
        Tue, 27 Dec 2016 14:13:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=g+YYdc9NFoIqbyRu6lu0+l/azr4=; b=PzF+lemd/HihD3CzBew0
        U3dbbDqa7FUwkpWpOrQbyGVHPduFdMSvwJA4LJT6FngAQEkarw5bFYW/I35eHl/T
        wV47ImlgYCVTxmUllNla/LsJZnAaTLcOUxDsVgelr2irVtDVknbz2YvG0eZhpenk
        I8GsMO1dmcvest00ML6I7QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=M0NJRCLEb4lx6Q6oEj47bzHsx4qKT277WhbVNVrP6h0MFk
        Nqfw+PE7muoQXvggZWr4iDq8bHFQyUWMSYEYY+S4ycuC2hcMw4ezmLGVsFTD/LM4
        Fln+Zax012uGOYw1eHdf0N4ODjen5BKkHe3IXA33UFjawdDqQCeGgSou+8Jqw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0456659B13;
        Tue, 27 Dec 2016 14:13:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6249459B12;
        Tue, 27 Dec 2016 14:13:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 08/21] Documentation/git-update-index: talk about core.splitIndex config var
Date:   Tue, 27 Dec 2016 11:07:37 -0800
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-9-chriscool@tuxfamily.org>
Message-ID: <xmqqpokd9ocw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AA8F914-CC68-11E6-A30B-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-update-index.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 7386c93162..e091b2a409 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -171,6 +171,12 @@ may not support it yet.
>  	given again, all changes in $GIT_DIR/index are pushed back to
>  	the shared index file. This mode is designed for very large
>  	indexes that take a significant amount of time to read or write.
> ++
> +These options take effect whatever the value of the `core.splitIndex`
> +configuration variable (see linkgit:git-config[1]).

Doesn't the "whatever..." clause in this sentence lack its verb
(presumably, "is", right after "variable")?

> +emitted when the change goes against the configured value, as the
> +configured value will take effect next time the index is read and this
> +will remove the intended effect of the option.

It feels somewhat strange to see a warning in this case. 

If the user configures the system to usually do X, and issues a
command that explicitly does Y (or "not-X"), we do not warn for the
command invocation if it is a single-shot operation.  That's the
usual "command line overrides configuration" an end-user expects.

I think you made this deviate from the usual end-user expectation
because it is unpredictable when the configuration kicks in the next
time to undo the effect of this command line request.  And I agree
that it is a very un-nice thing to do to the users if we did not
warn here, if we are to keep that unpredictableness.

But stepping back a bit, we know the user's intention is that with
"--split-index" the user wants to use the split index, even though
the user may have configuration not to use the split index.  Don't
we want to honor that intention?  In order to honor that intention
without getting confused by the configured variable to tell us not
to split, another way is to destroy that unpredictableness.  For
that, shouldn't we automatically remove the configuration that says
"do not split" (by perhaps set it to "do split")?  Doing so still
may need a warning that says "we disabled your previously configured
setting while at it", but it would be much better than a warning
message that essentially says "we do it once, but we will disobey
you at an unpredictable time", I would think.
