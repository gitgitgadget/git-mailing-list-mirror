Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FAF41F403
	for <e@80x24.org>; Thu,  7 Jun 2018 19:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeFGTDZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 15:03:25 -0400
Received: from avasout04.plus.net ([212.159.14.19]:44760 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeFGTDY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 15:03:24 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id R0BtfMfdZI9T1R0BufS4Hf; Thu, 07 Jun 2018 20:03:23 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Z6vC4kZA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=b85PRglOYvoSmf1xjLMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
 <20180606210300.GA1879@sigill.intra.peff.net>
 <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
 <20180607022353.GA3898@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b244717e-bc96-0c15-5bf0-1ce50fa63cf1@ramsayjones.plus.com>
Date:   Thu, 7 Jun 2018 20:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607022353.GA3898@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCEBqRHlkok4odqEsuj7fsBWzb48eTrL3JsXufiiKbHYBZhU2L/5VYQ5t2+lKT7P+E1PYQep8pPqnUOJngoV7mlqzZREV5M4kc1DcwtEU8mmcG/UAi9p
 3r7BNVhVi5DLMIwi8FUXG2GCgXW9HTSv2xhIeaZFsiU+trkzZVnSwing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/06/18 03:23, Jeff King wrote:
> On Thu, Jun 07, 2018 at 01:16:14AM +0100, Ramsay Jones wrote:
> 
>>> Probably. We may want to go the same route as we did for perl in 
>>> a0e0ec9f7d (t: provide a perl() function which uses $PERL_PATH,
>>> 2013-10-28) so that test writers don't have to remember this.
>>>
>>> That said, I wonder if it would be hard to simply do the python bits
>>> here in perl. This is the first use of python in our test scripts (and
>>
>> Hmm, not quite the _first_ use:
>>
>> $ git grep PYTHON_PATH -- t
>> t/lib-git-p4.sh:        (cd / && "$PYTHON_PATH" -c 'import time; print(int(time.time()))')
>> t/lib-git-p4.sh:        "$PYTHON_PATH" "$TRASH_DIRECTORY/marshal-dump.py"
>> t/t9020-remote-svn.sh:export PATH PYTHON_PATH GIT_BUILD_DIR
>> t/t9020-remote-svn.sh:exec "$PYTHON_PATH" "$GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py" "$@"
>> t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/k_smush.py" <"$cli/k-text-k" >cli-k-text-k-smush &&
>> t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/ko_smush.py" <"$cli/k-text-ko" >cli-k-text-ko-smush &&
>> t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/gendouble.py" >%double.png &&
>> t/t9810-git-p4-rcs.sh:  "$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_k.py" <"$git/$file" >"$scrub" &&
>> t/t9810-git-p4-rcs.sh:  "$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_ko.py" <"$git/$file" >"$scrub" &&
>> $ 
> 
> OK, the first for a feature that is not already written in python
> (leading into my second claim that python is used only for fringe
> commands ;) ).
> 
> Though maybe I am wrong that the remote-svn stuff requires python. I
> thought it did, but poking around, it looks like it's all C, and just
> the "svnrdump_sim" helper is python.

Heh, I was a bit tired last night, so although I knew that
I required python to be installed to run the test-suite, I
could not remember why. As soon as I went to bed, ... :)

I recently installed Ubuntu 18.04, so that I could get a heads
up on any possible problems later this month when I install
Linux Mint 19. In order to get the test-suite to run, I had
to set 'PYTHON_PATH = /usr/bin/python3' in my config.mak file.
(yes, I could have set NO_PYTHON, but you get the idea).

Ubuntu 18.04 no longer installs python2 by default (it has
ported to python3), but presumably you can still install it
as '/usr/bin/python' (I didn't check).

In any event, it was t9020-remote-svn.sh that was failing
which, despite the name, does not depend on 'svn'. As you
already noted, it does run svnrdump_sim.py and the git-remote-testsvn.

> At any rate, I think the point still stands that perl is our main
> scripting language. I'd rather keep us to that unless there's a good
> reason not to.

Agreed. And I see it has come to pass ... :-D

ATB,
Ramsay Jones


