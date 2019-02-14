Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5121F453
	for <e@80x24.org>; Thu, 14 Feb 2019 06:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbfBNGcN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 01:32:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60334 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBNGcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 01:32:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6558B59E07;
        Thu, 14 Feb 2019 01:32:08 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=b507t2twQBgB5
        yBY3823tP2Gcpw=; b=h+dh6jsS/aEvKq2MIUwX6Wib05P701n6umaszxhae3pIc
        gi6a8TgmpyRIfkycnPKgLjfYzVY/veP/qnS/69jsODCUmajbspkDymBzdJirOcT5
        McS5A+RydM2cNL+CyiAxXCYBQT7OxXrQijlEdWkh7DMuN+vKvA6hLiIlp6e7L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=VCWRSJf
        tMRMxvuXGnQeoMuqLmJ2yhYdYpeHAvTm19U35HlzytY8gYghHeHmvi4PRCpalKOd
        Ia13J+98q6QLrlZC6OtTIDvekpTK5k51bKrzCI6DRSK4Qz7LGItHHsm/qp+uc4pr
        ss+Yl2O1Jc+EE3KVAi5xSAg+uugHcxYQwzQg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E12259E06;
        Thu, 14 Feb 2019 01:32:08 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3616B59E03;
        Thu, 14 Feb 2019 01:32:05 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 14 Feb 2019 01:32:02 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 0/2] t/lib-gpg: a gpgsm fix, a minor improvement, and a
 question
Message-ID: <20190214063202.GD16125@zaya.teonanacatl.net>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190209140605.GE10587@szeder.dev>
 <20190209230553.GI30548@zaya.teonanacatl.net>
 <20190211195140.GB31807@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190211195140.GB31807@szeder.dev>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 3EEFD406-3022-11E9-8052-D01F9763A999-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=E1bor wrote:
> On Sat, Feb 09, 2019 at 06:05:53PM -0500, Todd Zullinger wrote:
>> SZEDER G=E1bor wrote:
>>> Just curious: how did you noticed the missing GPGSM prereq?
>>=20
>> I just grep the build output for '# SKIP|skipped:' and then
>> filter out those which I expect (thing like MINGW and
>> NATIVE_CRLF that aren't likely to be in a Fedora build).
>>=20
>> Far more manual than the slick method you have below. :)
>=20
> Yeah, but yours show the SKIP cases, too, i.e. when the whole test is
> skipped by:
>=20
>   if check-something
>   then
>         skip_all=3D"no can do"
>         test_done
>   fi
>=20
> I didn't bother with that because in those cases the prereq is not
> denoted by a single word, but rather by a human-readable phrase, and
> becase 'prove' runs those skipped test scripts at last when running
> slowest first, so I could already see them anyway.

Ahh, good points.

>>> I'm asking because I use a patch for a good couple of months now that
>>> collects the prereqs missed by test cases and prints them at the end
>>> of 'make test'.  Its output looks like this:
>>>=20
>>>   https://travis-ci.org/szeder/git/jobs/490944032#L2358
>>>=20
>>> Since you seem to be interested in that sort of thing as well, perhap=
s
>>> it would be worth to have something like this in git.git?  It's just
>>> that I have been too wary of potentially annoying other contributors
>>> by adding (what might be perceived as) clutter to their 'make test'
>>> output :)
>>=20
>> Indeed, I think that would be useful.  At the very least,
>> the .missing_prereqs files look quite handy.  I wouldn't
>> mind the output from 'make test' either, but building
>> packages surely shifts my perspective toward more verbose
>> build logs than someone hacking on git regularly and reading
>> the 'make test' output.
>=20
> The problem with those files is that a successful 'make test'
> automatically and unconditionally removes the whole 'test-results'
> directory at the end.  So a separate and optional 'make test ; make
> show-missed-prereqs' wouldn't have worked, that's why I did it this
> way.
>=20
> I think it would be better if we kept the 'test-results' directory
> even after a successful 'make test', there are some interesting things
> to be found there:
>=20
>   https://public-inbox.org/git/CAM0VKjkVreBKQsvMZ=3DpEE0NN5gG0MM+XJ0MzC=
bw1rxi_pR+FXQ@mail.gmail.com/

Maybe that's something which could be controlled with a make
var, to allow folks like us to keep the tests but clean them
up by default for everyone else?

Though even in the fedora package builds, I don't have
access to poke around in test-results and likely wouldn't
want to make the effort to extract the results and dump them
into the build logs (like ci/util/extract-trash-dirs.sh does
for the trash dirs).

>> I can certainly live with setting '--root' to a shorter path
>> and waiting to see if GnuPG upstream will come up with
>> something a little more friendly to users like us - running
>> gpg in a test suite.
>=20
> Are they aware of the issue?

Yeah, it was filed as https://dev.gnupg.org/T2964, as a
result of the gnupg-users thread you mention below.  There
hasn't been any progress on it since 2017 though, so it's
doubtful that upstream will fix it anytime soon.  If (or
when) it's resolved, I wouldn't be surprised if only gnupg
>=3D 2.3 included the fix.  So we'll probably have numerous
systems with this issue for quite some time.

>   https://lists.gnupg.org/pipermail/gnupg-users/2017-January/057451.htm=
l
>=20
> suggests to put the socket in '/var/run/user/$(id -u)', but that's for
> the "regular" use case, and we should take extra steps to prevent the
> tests' gpg from interfering with the gpg of the user running the
> tests.  Not sure it would work on macOS.  And ultimately it's not much
> different from your GIT_TEST_GNUPGHOME_ROOT suggestion.
>=20
> Then I stumbled on these patches patches:
>=20
>   https://lists.zx2c4.com/pipermail/password-store/2017-May/002932.html
>=20
> suggesting that at least one other project is working around this
> issue instead of waiting for upstream to come up with something.

Heh, the gnupg ticket mentions that the notmuch project
similarly had to work around gpg2's socket handling for
their tests:

    https://notmuchmail.org/pipermail/notmuch/2017/024148.html

>> Though if we do just wait it out,
>> maybe we could/should add a note in t/README or t/lib-gpg.sh
>> about this to warn others?
>=20
> Well, a comment could help others to not waste time on figuring out
> this "path is too long for a unix domains socket" issue...  but now
> they will be able to find this thread in the list archives as well :)

True.  Will they curse us for not adding a comment to save
them some effort or can we just say we were waiting for them
to submit such a patch? ;)

> On a related note: did you happen to notice occasional failures with
> gpg2 on Fedora builds?  I observed some lately in tests like
> './t7004-tag.sh' or 't7030-verify-tag.sh' on the Travis CI macOS
> builds: it appears as if the gpg process were to die mid-verification.
> Couldn't make any sense of it yet, though didn't tried particularly
> hard either.

I have not seen any such failures.  I've done a few dozen
test builds on fedora systems where /bin/gpg is gnupg-2.2
and other than the socket path issues, the tests have all
worked well.  But I'll be sure to mention it if I do run
into any such failures.

--=20
Todd
