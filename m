Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9157C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbcJDRZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:25:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59469 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752537AbcJDRZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:25:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D7DC42BC4;
        Tue,  4 Oct 2016 13:25:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NF4S78pR4Z32+F+q8v93FHz8KsQ=; b=yOSjac
        r+xAdSmduJe+NeDsIrebz53qrU1Zzz6lXwYQOotbehi99kvQF/3P4OY58/cXlogf
        3gLVP+zBEif+ZgZtJALdlWJtO90ztUoN9oXWNjcu9Soq9hO0DuCwIGNl31Brxhzg
        00u4Nsqx026LMrBfGObGsiP4NHEhmzeJJKAcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lpzFFUCKU6aDN8uGzV0MNtBvNaCSYEz9
        Duv7YnePgLPGDanWfUOWBR1lfQoqvJVHF6aadKwMAg6evuHA+32ae5QvyRI0ATTg
        mDOotVnexvirCsHnoD6HjufBhs1B3+oM508kF2oiKpguKFyRr1bG9X2ARWYZxKEG
        Lvmcp2I0eS8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4660342BC3;
        Tue,  4 Oct 2016 13:25:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1CD642BC1;
        Tue,  4 Oct 2016 13:25:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
        <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
        <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
        <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
        <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
        <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
        <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
Date:   Tue, 04 Oct 2016 10:25:08 -0700
In-Reply-To: <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com> (Jonathan Tan's
        message of "Mon, 3 Oct 2016 17:08:02 -0700")
Message-ID: <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80C73E82-8A57-11E6-97DE-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> One alternative is to postpone this decision by changing sequencer
> only (and not trailer) to tolerate other lines in the trailer. This
> would make them even more divergent (sequencer supports arbitrary
> lines while trailer doesn't), but they were divergent already
> (sequencer supports "(cherry picked by" but trailer doesn't).

Given that we internally do not use the "trailers" for anything
real, anything you decide to do here would be an improvement ;-)
Before, users couldn't even get any of the examples (below, from
your message) recognized as trailer blocks.

>   Signed-off-by: A <author@example.com>
>   [This has nothing to do with the above line]
>   Signed-off-by: B <buthor@example.com>
>
> and:
>
>   Link 1: a link
>     a continuation of the above
>
> and:
>
>   Signed-off-by: Some body <some@body.xz> (comment
>   on two lines)

So I would say it is perfectly OK if your update works only for
cases we can clearly define the semantics for.  For example, we can
even start with something simple like:

 * A RFC822-header like line, together with any number of whitespace
   indented lines that immediately follow it, will be taken as a
   single logical trailer element (with embedded LF in it if it uses
   the "line folding").  For the purpose of "replace", the entire
   single logical trailer element is replaced.

 * A line that begins with "(cherry picked from" and "[" becomes a
   single logical trailer element.  No continuation of anything
   fancy.

 * A line with any other shape is a garbage line in a trailer
   block.  It is kept in its place, but because it does not even
   have <token> part, it will not participate in locating with
   "trailer.where", "trailer.ifexists", etc.

A block of lines that appear as the last paragraph in a commit
message is a trailer block if and only if certain number or
percentage of lines are non-garbage lines according to the above
definition.

The operations done by the codepaths in the core part of the system
are much simpler subset of what "interpret-trailers" wants to
support, namely, 

 - append "(cherry picked from X)" at the end.

 - append "S-o-b:" at the end.

 - append "S-o-b:" unless the same line appears as the last line in
   the existing trailer block.

and these are quite compatible with a simplified definition of what
a logical line is illustrated in the above example, I would think.

I wonder if we can share a new helper function to do the detection
(and classification) of a trailer block and parsing the logical
lines out of a commit log message.  The function signature could be
as simple as taking a single <const char *> (or a strbuf) that holds
a commit log message, and splitting it out into something like:

    struct {
	const char *whole;
	const char *end_of_message_proper;
	struct {
		const char *token;
		const char *contents;
	} *trailer;
	int alloc_trailers, nr_trailers;
    };

where 

 - whole points at the first byte of the input, i.e. the beginning
   of the commit message buffer.

 - end-of-message-proper points at the first byte of the trailer
   block into the buffer at "whole".

 - token is a canonical header name for easy comparison for
   interpret-trailers (you can use NULL for garbage lines, and made
   up token like "[bracket]" and "(cherrypick)" that would not clash
   with real tokens like "Signed-off-by").

 - contents is the bytes on the logical line, including the header
   part

E.g. an element in trailer[] array may say

    {
	.token = "Signed-off-by",
        .contents = "Signed-Off-By: Some Body <some@body.xz>\n",
    }

With something like that, you can manipulate the "insert at ...",
"replace", etc. in the trailer[] array and then produce an updated
commit message fairly easily (i.e. copy out the bytes beginning at
"whole" up to "end_of_message_proper", then iterate over trailer[]
array and show their contents field).  The codepaths in the core
part only need to know 

 - how to check the last item in trailer[] array to see if it ends
   with the same sign-off as they are trying to add.

 - how to append one new element to the trailer[] array.

 - reproduce an updated commit log message after the above.

Hmm?
