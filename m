From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Tue, 04 Mar 2014 01:18:13 -0800
Message-ID: <53159A55.70105@gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>	<CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>	<xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>	<531514D9.4000101@gmail.com>	<xmqq4n3en7un.fsf@gitster.dls.corp.google.com>	<53157B72.3000205@gmail.com> <xmqqvbvul62n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 10:18:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKlUf-00066P-8j
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 10:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbaCDJS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 04:18:26 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33835 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbaCDJSV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 04:18:21 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so5058892pad.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 01:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AXbXbeAlQwpejmneUM/qAgB44k0daYi86bjqAbq3mjw=;
        b=qOntelw2PnvLb/uHdK2BYo906Pt1Ezsk8gU5qj1AjpPwkt56VRJ+6LCNWfj4o/gApB
         JPrEem2cx9bIL66+PouGnvmTJX63USMpkrQguNqehWifc5a5+pkQbPwUiWyiBgm1tTv3
         stFALPWf8ftJKwZOG25KrOMWeC5jGBfONIXuCrhHR8ox6WNR+sJRWK1nkIdfuWX0+c2b
         Q5qfceNxM4R/49tVNM3gNMzEBXU70idwGJ9iyJ05FEoVuAlYY0XELoZZD71RdNzCMY4n
         IK5JEiAr3C7U6t8SOiHVgA7vdPVnm3TcHTyjE3pLpnkIbW7yv4aVTi1yoqN3UNmKPzaN
         tECg==
X-Received: by 10.66.163.138 with SMTP id yi10mr4694828pab.95.1393924700808;
        Tue, 04 Mar 2014 01:18:20 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id om6sm45485298pbc.43.2014.03.04.01.18.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Mar 2014 01:18:20 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <xmqqvbvul62n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243331>

On 3/4/2014 12:29 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobir@gmail.com> writes:
>
>> While it could be done, it looks less obvious than this:
>>
>>      GIT_TEST_ONLY='1 4' ./t0001-init.sh
> If you are thinking about affecting only one test,

Yes, that is the use case: when I am developing a specific feature I 
want to run just one test for that feature over and over, while I am 
working on that specific thing.
Not the whole test suite (like "t0001"), but just the new case that I've 
added to the end, for example.  Plus one or more tests that setup enough 
environment for it.

> then you
> shouldn't be mucking with environment variables in the first place,
> primarily because running:
>
>      $ GIT_TEST_ONLY='1 4' make test
>
> to run test .1 and .4 of all the test scripts would not make any
> sense.

No it does not.  It only makes sense for one test suite.

> I think your "simplicity" argument is a total red-herring.
> Of course if you do not have to say the test script name, your
> specification would be shorter, but that is only because your
> specification is not specific enough to be useful.

In my case it is very useful :)
This is why I am saying that we might be talking about different cases: 
you are talking about the test suite level, while the issue I am trying 
to address an issue at an individual test level.

> Giving that as a command line argument to the specific script, e.g.
>
>      $ sh ./t0001-init.sh --only='1 4'
>
> might make some sense, but the above GIT_TEST_ONLY does not make any
> sense from the UI point of view.

No problem, I guess I can make it look like that - with '--only'.
Maybe '--tests'?  Then the same negation syntax could be used as 
previously discussed.
As well as range syntax.

> There are many reasons that makes me unenthused about this line of
> change in the first place:
>
>   * Both at the philosophical level and at the practical level, I've
>     found that it always makes sense to run most of the tests, i.e.
>     skipping ought to be an exception not the norm. Over the course
>     of this project, I often saw an alleged fix to one part of the
>     system introduces breakages that are caught by tests that checks
>     parts of the system that does not have any superficial link to it
>     (e.g. update the refs code and find a rebase test break).

My main argument is the time.  When testing Git as a whole or a feature 
as a whole there is no reason to skip some tests.
When working on a specific piece I may run the same test 100 times easily.
Here is what I see on my Cygwin:

     $ time ./t0001-init.sh
     [...]
     1..36

     real    0m6.693s
     user    0m1.505s
     sys     0m3.937s


     $ time GIT_SKIP_TESTS='t0001.[36789] t0001.??' ./t0001-init.sh
     [...]
     1..36

     real    0m3.313s
     user    0m0.769s
     sys     0m1.844s

So skipping 34 tests that I am not interested in save a bit more that 
50% of the time.
While it would be really nice if it would be faster, this speedup is a 
pretty simple one.

>   * Even though GIT_SKIP_TESTS mechanism still allows you to skip
>     individual test pieces, it has never been a serious "feature" in
>     the first place. Many of the tests unfortunately do rely on state
>     previous sequences of tests left behind, so it is not realistic
>     to expect that you can skip test pieces randomly and exercise
>     later test pieces reliably.
>
>   * The numbering of individual test pieces can easily change by new
>     tests inserted in the middle; again, many tests do take advantge
>     of the states earlier tests leave behind, so "do not add new
>     tests in the middle" is not a realistic rule to enforce, unless
>     you are willing to clean up existing test scripts so that each
>     test piece is independent from all the previous ones.

Both are true, but do not apply to the TDD case.
Neither they apply to a case when a test is broken and I want to execute 
everything up to that test.

> The latter two makes the ability to skip individual test pieces a
> "theoretically it could be made useful but practically not so much"
> misfeature.  I am very hesitant to see the test framework code
> churned only to enhance its "usefulness" when there isn't any in the
> first place, without first making changes that fundamentally
> improves its usefulness (e.g. to solve "test numbering is not
> stable" problem, you could identify the tests with test names
> instead of numbers to make it more stable, but that is not what your
> patch is even attempting to do).

If you see a way to address my problems, I might be able to code it the 
way you want it to be.

> [...]
