From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 1/5] test-lib: Adjust output to be valid TAP format
Date: Thu, 24 Jun 2010 19:17:55 +0000
Message-ID: <AANLkTinVp6kivNzbdUj-7EXjKrolBqvtsNROo-dCSydn@mail.gmail.com>
References: <1277401489-27885-1-git-send-email-avarab@gmail.com>
	<1277401489-27885-2-git-send-email-avarab@gmail.com>
	<m3mxuknumn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:18:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORrw2-0006LF-4C
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab0FXTR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 15:17:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61668 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab0FXTR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 15:17:56 -0400
Received: by iwn41 with SMTP id 41so1138467iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sk5T4ycB+9ZqEQT3ZfUq/MeudzCobO/atd4+MnjhogA=;
        b=xFU4Kr7I5Ay6KzWAHfdiHyAQ9IVmLy+ijI0YKq1vtBsnamnJvOUo7ICnADIg+8XwNp
         qkzsFZcpOIeIYfJMrbUzPjlWgA0pnWGRFUTM0InVNPvlhrj6UJSjTA4jUh28QVO75fZT
         z+/MidV8lT5qqybwwkFF/djpnpXIc1YRgjF9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dGjDszLsgnLI+5DY8J0J1axXG4xtvR4IiNa/7KoSqj7Bvk/4/FMG1lKNZIbIynN9NJ
         6MciOLjNVx6rrV3YMT3q6inxpNgANDyX88cx5WOxnXknMYbjimz6MiuztLvF8q8s6bKi
         u1FG96oZyGNBw0DD7eYHadkSByw7X2l7jzjXI=
Received: by 10.231.120.76 with SMTP id c12mr11278840ibr.92.1277407075856; 
	Thu, 24 Jun 2010 12:17:55 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 24 Jun 2010 12:17:55 -0700 (PDT)
In-Reply-To: <m3mxuknumn.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149622>

On Thu, Jun 24, 2010 at 18:39, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> TAP, the Test Anything Protocol, is a simple text-based interface
>> between testing modules in a test harness. test-lib.sh's output was
>> already very close to being valid TAP. This change brings it all the
>> way there. Before:
>>
>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>> =C2=A0 =C2=A0* =C2=A0 ok 1: sigchain works
>> =C2=A0 =C2=A0* passed all 1 test(s)
>>
>> And after:
>>
>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>> =C2=A0 =C2=A0ok 1 - sigchain works
>> =C2=A0 =C2=A0# passed all 1 test(s)
>> =C2=A0 =C2=A01..1
>
> This is incomplete information. =C2=A0It only tells us how the output=
 is
> changed for the case when all test_expect_success tests passes. =C2=A0=
This
> commit message doesn't tell us how failing tests looks like, and how
> test_expect_failure results gets translated.
>
> Take for example a following test script:
> -- >8 --
> #!/bin/sh
>
> test_description=3D'this is a sample test.
>
> This test is here to see various test outputs.'
>
> . ./test-lib.sh
>
> say 'diagnostic message'
>
> test_expect_success 'true =C2=A0test' 'true'
> test_expect_success 'false test' 'false'
>
> test_expect_failure 'true =C2=A0test (todo)' 'true'
> test_expect_failure 'false test (todo)' 'false'
>
> test_debug 'echo "debug message"'
>
> test_done
> -- 8< --
>
> This test script output looks like the following (the comments are no=
t
> part of output, but denote color of given line of test output):
> ----
> * diagnostic message =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0# yellow
> * =C2=A0 ok 1: true =C2=A0test
> * FAIL 2: false test =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0# bold red
> =C2=A0 =C2=A0 =C2=A0 =C2=A0false
> * =C2=A0 FIXED 3: true =C2=A0test (todo)
> * =C2=A0 still broken 4: false test (todo) =C2=A0 =C2=A0 # bold green
> * fixed 1 known breakage(s) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 # green
> * still have 1 known breakage(s) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# =
bold red
> * failed 1 among remaining 3 test(s) =C2=A0 =C2=A0 =C2=A0# bold red
> ----
>
> How would the output of this test look like after TAP-ification?
> Would it still provide color output when run on terminal?
>
> This test also generates summary of test run in a file in
> test-results/ subdirectory. =C2=A0Currently such file can be e.g. nam=
ed
> test-results/test_test-8030, and consist of
> -- >8 --
> total 4
> success 1
> fixed 1
> broken 1
> failed 1
>
> -- 8< --
>
> Would TAP-ification change that? =C2=A0Even if there is no change, th=
is is
> worth a sentence or a few words in a commit message.

To all of the above: I could be more verbose in the commit message in
needed, but after you raised similar questions in a previous version
of this series I added this to the above commit message:

    All this patch does is re-arrange the output a bit so that it confo=
rms
    with the TAP spec, everything that the test suite did before contin=
ues
    to work. That includes aggregating results in t/test-results/, the
    --verbose, --debug and other options for tests, and the test color
    output.

I.e. aside from turning "FAIL" into "not ok" and removing the "* "
prefix from lines everything else works exactly as before, that
includes color output and the aggregation in t/test-results/.

I can expand on that paragraph with more examples if you think it's nec=
essary.

Here's how the output from the above test script looks under TAP:

    diagnostic message
    ok 1 - true  test
    not ok - 2 false test
    #       false
    ok 3 - true  test (todo) # TODO known breakage
    not ok 4 - false test (todo) # TODO known breakage
    # fixed 1 known breakage(s)
    # still have 1 known breakage(s)
    # failed 1 among remaining 3 test(s)
    1..4

> P.S. With current output pass / fail results of test_expect_failure
> are justified on ':' separator. =C2=A0This is not the case of TAP out=
put.

TAP output is conventionally not justified, unlike the existing
output. I don't know if anything would break if it were, i.e.:

    ok 1       - foo
    not ok 2   - bar
