Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE02C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD2B222C3
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vs0TgRMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCJRYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:24:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62624 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgCJRYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 13:24:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B1BAB308E;
        Tue, 10 Mar 2020 13:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pXE8SmZqqUE9jefy7zGmzXuQ9Y8=; b=Vs0TgR
        MyjkPUT1qDQQHJYEzbq/kOb0UySJ2ZQq3m0hASqJBtgYEfMlVjOKDPa3IcA2egVI
        6riHHTkpLmN7WOw8KyM/8fJYP1xZQ1XMe8G3AB+bNmqzegd7w1npiRfDeef7g6i2
        fva1X+9B4Xl57zxqEaJm9+L/nhqokc5NsrivE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CEtM/xl3VgHR347E92HOTqiSOJRbyOjd
        SgblowH8xQjlgMjOyEVnx+4rpNqOE0G1mZmcEIFzrCgNH19mp3/TsNQc71rIbRb2
        +gPNeBhGg1QbdYcq30y/+s5hGDQy/+vfOIfEu6s+W2Ou9D7QPLA2TibLsJo1ILvE
        V7yZsGSJUj4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 129F4B308D;
        Tue, 10 Mar 2020 13:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42A09B308A;
        Tue, 10 Mar 2020 13:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/3] Teach ref-filter API to correctly handle CRLF in messages
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
        <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 10:24:34 -0700
In-Reply-To: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Tue, 10 Mar 2020 02:24:50 +0000")
Message-ID: <xmqqo8t4jf71.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03C3830E-62F4-11EA-B43B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The function find_subpos in ref-filter.c looks for two consecutive '\n' to
> find the end of the subject line, a sequence which is absent in messages
> using CRLF. This results in the whole message being parsed as the subject
> line (%(contents:subject)), and the body of the message (%(contents:body))
> being empty.

To be honest, I suspect that it is not a bug in the parser that
parsed out %(contents:subject), but a user error that left the log
message in CRLF endings ;-).

So "correctly handle CRLF" is probably a tad unfair to those who
wrote the current ref-filter code; a description that is more fair
to them is probably along the lines of "handle malformed log
messages more gracefully", I would think.

> Moreover, in copy_subject, '\n' is replaced by space, but '\r' is untouched,
> resulting in the escape sequence '^M' being output verbatim in most terminal
> emulators:
>
> $ git branch --verbose
> * crlf    2113b0e Subject first line^M ^M Body first line^M Body second line
>
> This bug is a regression for git branch --verbose, which bisects down to
> 949af06 (branch: use ref-filter printing APIs, 2017-01-10).

I am not sure where you want to go with this.  Whether it is shown
in the ^X notation (and some terminals even reverse color to
highlight them), or it is shown literally (i.e. causing the next
byte to overwrite the same line starting from the left-edge), you
would be annoyed either way, no?  I suspect that the latter would
annoy you even more.  Isn't what "most terminal emulators" do,
i.e. to show it in the ^X notation instead of emitting it literally,
a good thing?  IOW, "resulting in ..." is not correctly telling us
what you think is wrong---you don't have to blame terminals.

It is not limited to CR, and is not limited to control characters at
the end of the lines, no?  If you had "\a" (or "\r") in the middle
of the title, either the current or the old code would ring a bell
(or cause the next character to appear at the end of the same line)
or when piped to "less" you'd see "^G" (or "^M") in the liddle of
the line.

The old code used pretty.c::pretty_print_commit() mechanism;
pretty.c::format_subject() uses pretty.c::is_blank_line() to trim
whitespaces at the right end while trying to notice where the first
paragraph break is, so any whitespace at the end of first paragraph
break is removed, and each end of line got replaced by a SP, but it
did not do anything special to control characters in the middle of
the lines (and it didn't do anything to the control characters in
the middle of the line, either).  So while the old code happened to
cleanse CR at the end of the lines, it wasn't doing enough.

I think fixing _that_ is (and should be) outside the scope of this
series, of course.

>  2:  c68bc2b3788 ! 2:  aab1f45ba97 ref-filter: teach the API to correctly handle CRLF
>      @@ -1,26 +1,49 @@
>       Author: Philippe Blain <levraiphilippeblain@gmail.com>
>       
>      -    ref-filter: teach the API to correctly handle CRLF
>      +    ref-filter: fix the API to correctly handle CRLF

API is not changed (i.e. the callers do not have to do anything
special); only the implementation.

	ref-filter: handle CR at the end of the lines more gracefully

perhaps?

>           The ref-filter API does not correctly handle commit or tag messages that
>           use CRLF as the line terminator. Such messages can be created with the
>           `--verbatim` option of `git commit` and `git tag`, or by using `git
>           commit-tree` directly.
>       
>      +    This impacts the output `git branch`, `git tag` and `git for-each-ref`
>      +    when used with a `--format` argument containing the atoms
>      +    `%(contents:subject)` or `%(contents:body)`, as well as the output of
>      +    `git branch --verbose`, which uses `%(contents:subject)` internally.

In other words...

	When a commit or a tag object uses CRLF line endings, the
	ref-filter machinery does not identify the end of the first
	paragraph as intended by the writer, because it only looks
	for two consecutive LFs and CR-LF-CR-LF does not look like a
	blank line that separates paragraphs to it.  "git branch",
	"git tag" and "git for-each-ref" all rely on the messages
	split correctly into "%(contents:subject)" and
	"%(contents:body)" placeholders and ends up showing
	everything as the subject.

Now based on what I hinted in the far-above part, there can be two
valid solutions here.

 * recognize CRLF as a valid line ending, but still retain ^M in the
   message.  The replacement for "%(contents:subject)" would still
   end with "^M", and we add LF to it, which makes the resulting
   output end with CRLF and all is well.  This will keep "\a" and
   "\r" in the middle of the line in the output.

 * strip CR and any control character other than LF from everywhere.
   This will cleanse "\a" and "\r" in the middle of, or anywhere on,
   the line, so that "%(contents:subject)", "%(contents:body)" and
   "%(contents)" all are "clean".

I am not offhand sure which one is better (I haven't read the patch
to see which one you chose to implement).

>      +    The function find_subpos in ref-filter.c looks for two consecutive '\n'
>      +    to find the end of the subject line, a sequence which is absent in
>      +    messages using CRLF. This results in the whole message being parsed as
>      +    the subject line (`%(contents:subject)`), and the body of the message
>      +    (`%(contents:body)`)  being empty.



>      +    Moreover, in copy_subject, '\n' is replaced by space, but '\r' is
>      +    untouched, resulting in the escape sequence '^M' being output verbatim
>      +    in most terminal emulators:
>      ...
>      +    This bug is a regression for `git branch --verbose`, which
>      +    bisects down to 949af0684c (branch: use ref-filter printing APIs,
>      +    2017-01-10).
>      +
>      +    Fix this bug in ref-filter by hardening the logic in `copy_subject` and
>      +    `find_subpos` to correctly parse messages containing CRFL.

The above few lines may need revising (based on what I said to the
cover); --- even if they don't, CRFL here needs to become CRLF ;-)

Thanks for working on this.
