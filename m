Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C5A20988
	for <e@80x24.org>; Mon, 17 Oct 2016 07:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757553AbcJQHKP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 03:10:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57591 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756546AbcJQHKN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 03:10:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86A044076C;
        Mon, 17 Oct 2016 03:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sgmx6fasbkyVXKqj4QZxJ/5UEgk=; b=sahobc
        fVdJeUPDY8N5u7LiHCl3RYiFxYa81BGikLr/6sRB3kVCUqMD2ELhtSBjESoAWDts
        hxeMPn6IE5tsAUp7/Wz7S7j+16iXt0TPnLXZySrvM7t6mjgGvPuXreYGePKAZrM6
        zVa1wmnhEV9Em5yV59d/aerdHHll40bM2N3H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mmbIECC8Bp9U2FcabBNtfc0PSa0agV+X
        qf+GxVF2gQAzANr9/5sGPpdgxjym6WeG5M7iKZHw8Ht7b4OxbZQPQkbYJmO7Jh1h
        ejrexPZvSYNAiSHSXDfmXxa1g8blobPLv4scwsfhNFbU1G06s3yS51gn3XkP0vHq
        Qt07Yy07MuI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DF9C40769;
        Mon, 17 Oct 2016 03:10:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E53E540768;
        Mon, 17 Oct 2016 03:10:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
References: <20161010175611.1058-1-sbeller@google.com>
        <alpine.DEB.2.20.1610121501390.3492@virtualbox>
        <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
        <alpine.DEB.2.20.1610131255001.197091@virtualbox>
Date:   Mon, 17 Oct 2016 00:10:09 -0700
In-Reply-To: <alpine.DEB.2.20.1610131255001.197091@virtualbox> (Johannes
        Schindelin's message of "Thu, 13 Oct 2016 13:11:51 +0200 (CEST)")
Message-ID: <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEB7D14E-9438-11E6-A4B4-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > expecting success:
>> >                 actual=$(git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' '../.') &&
>> >                 test "$actual" = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'
>> >
>> > +++ git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' ../.
>> > ++ actual=C:/git-sdk-64/usr/src/git/wip/t/.
>> > ++ test C:/git-sdk-64/usr/src/git/wip/t/. = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'

This may well be total misunderstanding on my side, but is the
expectation of this test even correct?  If it wants to take "../."
relative to "$LEAD/t/trash utils/.", should't it go one level up
with ".." to $LEAD/t and then stay there with ".", expecting
"$LEAD/t" which is what the above is giving us?

IOW, the above makes me wonder why having one of these as the base

	A - path/to/dir
	B - path/to/dir/
	C - path/to/dir/.

to resolve the relative "../." give different results.  Whether bash
on Windows removes the dot at the end of C to turn it into B, as
long as A and B give us the same result we wouldn't be hitting the
problem, no?

>> >  test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
>> >  test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
>> > -test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
>> > +test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."

>> > The reasons this is ugly: we specifically test for *Unixy* paths when we
>> > use $PWD, as opposed to *Windowsy* paths when using $(pwd).

Just to ensure I am following this correctly, two tests that come
before the one you are touching above have $PWD on the input side
and $(pwd) on the expectation side.  That is what you mean by the
next paragraph, right?  They want to make sure that you honor the
Unixy user input on Windows and still produce Windowsy result, that
is.

>> > We do this to
>> > ensure a certain level of confidence that running things such as
>> >
>> >         git clone --recurse-submodules /z/project/.
>> >
>> > work. And now that does not work anymore.

And I agree from that point of view that having to spell both sides
as $(pwd) would mean you are not testing that "Unixy input to
Windowsy output" expectation, but at the same time, I think you
would want "Windowsy input to Windowsy output" combination also does
produce correct result, which is not tested in the three tests shown
above.  IOW, probably you would want to test both (at least on any
platform where $PWD and $(pwd) textually disagree) for all these
[*1*], and the pair

    "../." taken relative to "$(pwd)/." must be "$(pwd)/."
    "../." taken relative to "$PWD/." must be "$(pwd)/."

test, because of the limitation of your bash, cannot have the latter
half of the pair, so you'd need to comment it out with in-code
explanation, perhaps?  IOW something along the lines of...

 -- >8 -- snip -- >8 --

test_submodule_relative_url "(null)" "$(pwd)/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
test_submodule_relative_url "(null)" "$(pwd)/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."

if test_have_prereq MINGW
then

test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
# This does not work correctly because Win-Bash strips . at the end
# "of $PWD/."
# test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."

fi

 -- >8 -- snip -- >8 --

In any case, I find it more disturbing that we somehow ended up with
a system where these three things are expected to behave differently:

	A - path/to/dir
	B - path/to/dir/
	C - path/to/dir/.

Is that something we can fix?


[Footnote]

*1* It is tempting to update the above test sequence using
    a helper like:

    tsru () {
	test_submodule_relative_url "(null)" "$(pwd)/$1" "$2" "$(pwd)/$3"
	if test_have_prereq MINGW
	then
	    test_submodule_relative_url "(null)" "$PWD/$1" "$2" "$(pwd)/$3"
	fi
    }

    then write the above three tests like so:

	tsru subsuper_update_r ../subsubsuper_update_r subsubsuper_update_r
	tsru super_update_r2 ../subsuper_update_r subsuper_update_r
	tsru . ../. .

    but you would want to disable the MINGW half for only the third
    test, we cannot quite do that.
