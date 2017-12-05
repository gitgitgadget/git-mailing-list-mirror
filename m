Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A1A20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbdLENGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 08:06:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58445 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752042AbdLENGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 08:06:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6643AB02A0;
        Tue,  5 Dec 2017 08:06:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Awl0puWEXlznWQyDA3tIy410vKM=; b=EzYjCm
        /6xJSS+Fz7WHSJV2C0VvtdqSdOr/AgOPRRg3nC2WgEoL8s/8Kagx4L3MANFOGoSr
        H7zNqqYqvhGnzVyYqJWGZSstBCerATFYViI+DuBJems/R5gcIAaTulTYzVLYxe02
        mbbF2ZTGClDlqyMgfgh0nxhCBMV62ZDVp/UN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gV9Tefh7AL5W51LJ/iwu2AtVNhzeYSBe
        E7QFTN3UPUtSxr356WO0kdYgQJ6LpAJkiTXLcrFueYsr7O0mDTkG9aE4PSAxi93i
        9nbCzGPXdXRKK2cXMCFH9bXOCGNXXYHIQJMg1LEU6WyKfGjeSBi3WqYUiFDksL0c
        ProfKViza+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DC9CB029D;
        Tue,  5 Dec 2017 08:06:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C68DBB029A;
        Tue,  5 Dec 2017 08:06:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Abel <rabel@robertabel.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] git-prompt: make __git_eread intended use explicit
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
        <20171201233133.30011-1-rabel@robertabel.eu>
        <xmqqindmml25.fsf@gitster.mtv.corp.google.com>
        <e8d35c35-ffd5-ef10-bc6a-0834c1703995@robertabel.eu>
        <xmqqd13ukohs.fsf@gitster.mtv.corp.google.com>
        <818f414b-76ab-6e1d-0c5c-7f9959223e64@robertabel.eu>
Date:   Tue, 05 Dec 2017 05:06:29 -0800
In-Reply-To: <818f414b-76ab-6e1d-0c5c-7f9959223e64@robertabel.eu> (Robert
        Abel's message of "Tue, 5 Dec 2017 08:01:41 +0100")
Message-ID: <xmqqlgihjpd6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C800646-D9BD-11E7-AAD4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Abel <rabel@robertabel.eu> writes:

> On 05 Dec 2017 01:27, Junio C Hamano wrote:
>> I know all of the above, but I think you misunderstood the point I
>> wanted to raise, so let me try again.  The thing is, none of what
>> you just wrote changes the fact that lack of callers that want to do
>> "multi-line" is IRRELEVANT.
>
> I disagree. The commit comment is meant to give context to the
> introduced changes. One change is the  additional comment for
> __git_eread, which now clearly states that only a single line is read.

I still do not understand why you think the 'next' person would care
about the (lack of )multi-line aspect of the helper.

Let's see how well the proposed log message gives the "context to
the introduced changes" (from your v3).

    __git_eread is used to read a single line of a given file (if it
    exists) into a single variable without the EOL. All six current
    users of __git_eread use it that way and don't expect multi-line
    content.

That does not include anything incorrect; but.

The helper is about (1) reading the first line and (2) reading it as
a whole into a single variable.  Both are already covered by the
first sentence, and there is no need to say 'and don't expect ...",
unless you want to stress something.

And it places a stress on the former, which is a less relevant
thing, WITHOUT giving the same treatment to the latter, which is a
more relevant thing.  After all, this patch is not about replacing
an earlier implementation that did

    $2=$(cat "$1")

with

    read $2 <"$1"

If that were the case, _then_ the fact that the purpose of the
helper is to read from a single-liner file (i.e. we do not expect
the input file to have more than one line) is VERY relevant.

But this is not such a patch.  And after readers read the above,
they find this:

    Therefore, this patch removes the unused capability to split
    file conents into tokens by passing multiple variable names.

And because the previous paragraph placed an emphasis on a wrong
aspect of the context of the calls to the helper function, this
"Therefore" does not quite "click" in the readers' minds.  The
reason why it is OK to remove the multi-variable feature is because
the callers of the helper want to always read the result into a
single variable, but the "no need for multi-variable" that they read
in the first sentence of the previous paragraph is less strong in
their mind by now, because they read an irrelevant (for the purpose
of this "Therefore") mention of "no need for multi-line" aspect of
the helper.

Perhaps

    __git_eread is used to read the contents of a single-liner file
    into a single variable while dropping EOL.  It is misleading to
    use the "read" built-in with "$@", as if some callers would want
    the contents read from the file to be split into multiple
    variables.

    Explicitly use a single variable, and also document that the
    helper only reads the first line (simply because the input files
    are designed to be single-liner files).

would say it the same thing, but with emphasis on the right aspect
of the facts.

I would also rephase the new in-code comment

    # Helper function to read the first line of a file into a variable.

to un-stress "the first line of a file" and place more stress on the
fact that it is designed to read from a single-liner file (there is
a subtle but important distinction between the two).

    # read the contents of a single-liner file into a variable,
    # while dropping the end-of-line from it.

or something like that, perhaps.


