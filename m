Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080971F453
	for <e@80x24.org>; Sat,  9 Feb 2019 23:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBIXGB (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 18:06:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63196 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBIXGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 18:06:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42EF91377D1;
        Sat,  9 Feb 2019 18:05:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=IS5euT2KE12YK
        n5NVeKfMdEAxJg=; b=DQawt+6vZoIbBWQ/RxTtRZGVpiGENCmwGZanitU6FDMhK
        zz4n3xZ297D8B3b3TP+8miMQU1stQv9C4tA6d118rEZ1aMfFkw6NWMy4dfdd0UVt
        oTmIUy7K+UvEb3TGMhwwH+2l4/V5glqGkL922igzv1pfZu7qNzkjRlcZHN6iFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=i+vQPYE
        QWhczrnSs7B/DkK3itQuehWvPHSLKOHCk4sfq3JhjAGJxCANnDzXBSJdvOgj/UX7
        1shVvDXusl06L5eLfjLkNwaRdrN9A0xCvgpyVpyvvsmH1xgxZmDSYUqnmcRdaqgp
        7+WjI8rkKy/XF8dP+WYdtoQgPb0uDZuWxJms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39DCA1377D0;
        Sat,  9 Feb 2019 18:05:56 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF8921377CF;
        Sat,  9 Feb 2019 18:05:55 -0500 (EST)
Date:   Sat, 9 Feb 2019 18:05:53 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a
 question
Message-ID: <20190209230553.GI30548@zaya.teonanacatl.net>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190209140605.GE10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190209140605.GE10587@szeder.dev>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 4151803E-2CBF-11E9-A9F6-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=E1bor wrote:
> On Thu, Feb 07, 2019 at 10:17:44PM -0500, Todd Zullinger wrote:
>> Looking through the build logs for the fedora git packages, I noticed =
it
>> was missing the GPGSM prereq.
>=20
> Just curious: how did you noticed the missing GPGSM prereq?

I just grep the build output for '# SKIP|skipped:' and then
filter out those which I expect (thing like MINGW and
NATIVE_CRLF that aren't likely to be in a Fedora build).

Far more manual than the slick method you have below. :)

> I'm asking because I use a patch for a good couple of months now that
> collects the prereqs missed by test cases and prints them at the end
> of 'make test'.  Its output looks like this:
>=20
>   https://travis-ci.org/szeder/git/jobs/490944032#L2358
>=20
> Since you seem to be interested in that sort of thing as well, perhaps
> it would be worth to have something like this in git.git?  It's just
> that I have been too wary of potentially annoying other contributors
> by adding (what might be perceived as) clutter to their 'make test'
> output :)

Indeed, I think that would be useful.  At the very least,
the .missing_prereqs files look quite handy.  I wouldn't
mind the output from 'make test' either, but building
packages surely shifts my perspective toward more verbose
build logs than someone hacking on git regularly and reading
the 'make test' output.

>> I don't know if there are other packagers or builders who run into thi=
s,
>> so maybe it's not worth much effort to try and have the test suite cop=
e
>> better.  It took me longer than I would have liked to track it down, s=
o
>> I thought I'd mention it in case anyone else has run into this or has
>> thoughts on how to improve lib-gpg.sh while waiting for GnuPG to impro=
ve
>> this area.
>=20
> I stumbled upon this when Dscho inadvertently broke a test script on
> setups without gpg last year; sorry for not speaking about it.  I
> noticed it in our Travis CI builds on macOS, because it (macOS itself
> or Homebrew? I don't know) defaulted to gpg2 already back then, and to
> make matters worse its sun_path is on the shorter end, and the path
> to the build dir on Travis CI includes the GitHub user/repo as well.

Heh, I figured it was a rather specific group of folks that
might run into this.

>> A GIT_TEST_GNUPGHOME_ROOT var to set the root path for the GNUPGHOME
>> dirs in the tests is one thought I had, but didn't try to put it into
>> patch form.  Setting the --root test option is probably enough control
>> for most cases.
>=20
> A potential issue I see with GIT_TEST_GNUPGHOME_ROOT is that there are
> several test scripts involving gpg, and if GIT_TEST_GNUPGHOME_ROOT is
> set for the whole 'make test', then they might interfere with each
> other when they happen to be run at the same time.

Yeah, I was envisioning that var as something which set the
base dir, under which the normal test directories would
live.  Basically, like setting --root, but only for the
GnuPG bits.

I'm not impressed by that idea (and I'm even less so after
realizing how it would most likely make it harder to gather
up the results in the CI scripts).  I mainly tossed it out
in the hope someone would reply with a better method. ;)

> In the meantime I came up with a '--short-trash-dir' option to
> test-lib, which turns 'trash directory.t7612-merge-verify-signatures'
> into 'trash dir.t7612'.  It works, but I don't really like it, and it
> required various adjustments to the CI build scripts, notably to the
> part in 'ci/print-test-failures.sh' that includes the trash dir of
> failed test scripts in the build log.

I can certainly live with setting '--root' to a shorter path
and waiting to see if GnuPG upstream will come up with
something a little more friendly to users like us - running
gpg in a test suite.  Though if we do just wait it out,
maybe we could/should add a note in t/README or t/lib-gpg.sh
about this to warn others?

--=20
Todd
