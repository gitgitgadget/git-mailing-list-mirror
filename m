Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EDFC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D0B60F4A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbhHZPid (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:38:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58340 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhHZPic (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 11:38:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FEA9149DD0;
        Thu, 26 Aug 2021 11:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bUOZCdMiyzzd
        pkjmJ85hGIhJ6C7t/rN9/PlKkCs78sA=; b=o+ZUDp4LyBXe45WFsp18NiK6+6gL
        QDaNASTGub8O28N5cvbhXMBe6agQqyb6NHSeTQWtt7K0eYbQisv8jKbjcVx7nc2W
        6gr0j0MUqTjd7HGo4N8AweCtp+KKTWqxikcN40hBvVop7Xe1HSar/8yUrTTzUH4t
        Emj3DBhkcwKnCQ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 495D3149DCD;
        Thu, 26 Aug 2021 11:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6AC76149DCA;
        Thu, 26 Aug 2021 11:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: git log --encoding=HTML is not supported
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
        <24330338.EZKKyuarjD@localhost.localdomain>
        <CAGyf7-FhLQKQyCOishyrZHg0J+jk6=aszE3hMoH=L0j+0+TP7Q@mail.gmail.com>
Date:   Thu, 26 Aug 2021 08:37:40 -0700
In-Reply-To: <CAGyf7-FhLQKQyCOishyrZHg0J+jk6=aszE3hMoH=L0j+0+TP7Q@mail.gmail.com>
        (Bryan Turner's message of "Wed, 25 Aug 2021 16:47:49 -0700")
Message-ID: <xmqq5yvsgqt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D680DDA-0683-11EC-BE4F-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> On Wed, Aug 25, 2021 at 4:29 PM Krzysztof =C5=BBelechowski
> <giecrilj@stegny.2a.pl> wrote:
>>
>> Dnia =C5=9Broda, 25 sierpnia 2021 02:57:47 CEST Jeff King pisze:
>> > diff --git a/pretty.c b/pretty.c
>>
>> Please fix the manual for git log.  It should say what encoding is rec=
ognised
>> (namely if supported by iconv(1), except that POSIX character maps of
>> iconv(1p) are not supported), and that an unrecognised encoding is ign=
ored.
>>
>> I would also like to see the HTML encoding supported independently of =
iconv,
>> which seems like a pretty easy thing to do.  Dream on, I guess?
>
> I suspect the answer is less "Dream on" and more "Patches welcome."

Patches are welcomed but not before a proposed design is freshed
out.  I am sure people do welcome the design discussion.

Pieces taken from the contents stored in Git (like "the title of the
commit", "the name of the author of the commit") may need quoting
and/or escaping when they are incorporated into a string to become
parts of "output", and the way the quoting/escaping must be done
would depend on the "host" language/format.  HTML has its own
requirements for how these pieces coming from Git contents are
quoted, but it will not be the only "host" language that needs
quoting.

The requirement for the feature we are "Dreaming on" may be much
closer to the "host language" options (e.g. --tcl, --perl ...) the
"git for-each-ref" command has.  These options tells us to format
each piece of information (e.g. "%(subject)") taken from Git as a
natural 'string' constant in the host language, so that

	git for-each-ref --shell \
	    --format=3D'do_something %(authorname) %(authoremail)'

would write a shell script that calls "do_something" command with
two arguments for each ref enumerated by the command, without having
to worry about whitespaces and quote characters that may appear in
the interpolated pieces.  It is immediately obvious that within the
context of the for-each-ref command, the follwoing would equally be
useful (note: this is already "dreaming on" and does not exist yet):

	echo "<ul>"
	git for-each-ref --html \
		--format=3D'<li>%(authoremail)</li>'
	echo "</ul>"

As we have been seeing efforts to port features around the --format
option between the for-each-ref family of commands and the log
family of commands, I would also imagine that it would be natural
future direction to extend it to the latter and eventually allow

	git log --html \
		--format=3D'<tr><td>%h</td><td>%s</td>...</tr>'

to format each commit into a single row in HTML table, and things
like that.

