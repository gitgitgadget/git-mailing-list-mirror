Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5491B1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 09:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeAVJci (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 04:32:38 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53879 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751987AbeAVJZn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jan 2018 04:25:43 -0500
X-AuditID: 1207440d-973ff70000000c05-3d-5a65ae141edc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.DC.03077.51EA56A5; Mon, 22 Jan 2018 04:25:41 -0500 (EST)
Received: from [192.168.69.190] (p54AAE13C.dip0.t-ipconnect.de [84.170.225.60])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0M9PbAb008980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 22 Jan 2018 04:25:39 -0500
Subject: Re: [PATCH] files_initial_transaction_commit(): only unlock if locked
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Mathias Rav <m@git.strova.dk>, git@vger.kernel.org
References: <20180118143841.1a4c674d@novascotia>
 <20180118141914.GA32718@sigill.intra.peff.net>
 <xmqqwp0do5sg.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8328c28a-d93b-1076-20d3-823dbddf7e4c@alum.mit.edu>
Date:   Mon, 22 Jan 2018 10:25:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqwp0do5sg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqCu6LjXK4MEFK4uuK91MFg29V5gt
        vrU8YLX40dLD7MDi8b5XxONZ7x5Gj4uXlD0+b5ILYInisklJzcksSy3St0vgyli3ejF7wQmF
        ir379zI2MJ6S6mLk4JAQMJE4dDaji5GLQ0hgB5PE/kcf2CCc80wSR1q6WLsYOTmEBfwklm5r
        YQaxRQQcJU48uA4WZxYwk1jwYy8rRMMkRomJp1eCFbEJ6Eos6mlmArF5Bewlpj2ZxAZiswio
        SnSt+g/WLCoQITFl7VoWiBpBiZMzn4DZnALWEhs3/2eEWKAu8WfeJWYIW1zi1pP5TBC2vMT2
        t3OYJzAKzELSPgtJyywkLbOQtCxgZFnFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopea
        UrqJERLkvDsY/6+TOcQowMGoxMP7wCg1Sog1say4MvcQoyQHk5Ior10JUIgvKT+lMiOxOCO+
        qDQntfgQowQHs5IIb9oKoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoND
        SYI3fy1Qo2BRanpqRVpmTglCmomDE2Q4D9BwW5Aa3uKCxNzizHSI/ClGXY4bL163MQux5OXn
        pUqJ8/5aA1QkAFKUUZoHNweWnF4xigO9JcxrCTKKB5jY4Ca9AlrCBLTkRg3YkpJEhJRUA2Nk
        w0afiJ05M1PWXyvZ29O1NrFCcd3DuKITGrK7brOpmgS12+zuD4veEdxr3//o4DPVU7aq3Vdd
        V89xnrplmemdO69Uuy93fC03u+WgtfHfhHni624+OfJJZbPop82mGrt0z6x6JfPCXudsQNWS
        iEAhH5m9SpuedNznkPoTW/v/lODlCbk3p7IosRRnJBpqMRcVJwIAv+VydSkDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/19/2018 11:14 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Jan 18, 2018 at 02:38:41PM +0100, Mathias Rav wrote:
>>
>>> Running git clone --single-branch --mirror -b TAGNAME previously
>>> triggered the following error message:
>>>
>>> 	fatal: multiple updates for ref 'refs/tags/TAGNAME' not allowed.
>>>
>>> This error condition is handled in files_initial_transaction_commit().
>>>
>>> 42c7f7ff9 ("commit_packed_refs(): remove call to `packed_refs_unlock()`", 2017-06-23)
>>> introduced incorrect unlocking in the error path of this function,
>>> which changes the error message to
>>>
>>> 	fatal: BUG: packed_refs_unlock() called when not locked
>>>
>>> Move the call to packed_refs_unlock() above the "cleanup:" label
>>> since the unlocking should only be done in the last error path.
>>
>> Thanks, this solution looks correct to me. It's pretty low-impact since
>> the locking is the second-to-last thing in the function, so we don't
>> have to re-add the unlock to a bunch of error code paths. But one
>> alternative would be to just do:
>>
>>   if (packed_refs_is_locked(refs))
>> 	packed_refs_unlock(refs->packed_ref_store);
>>
>> in the cleanup section.
> 
> Yeah, that may be a more future-proof alternative, and just as you
> said the patch as posted would be sufficient, too.

Either solution LGTM. Thanks for finding and fixing this bug.

But let's also take a step back. The invocation

    git clone --single-branch --mirror -b TAGNAME

seems curious. Does it even make sense to use `--mirror` and
`--single-branch` at the same time? What should it do?

Normally `--mirror` implies (aside from `--bare`) that the remote
references should be converted 1:1 to local references and should be
overwritten at every fetch; i.e., the refspec should be set to
`+refs/*:refs/*`.

To me the most plausible interpretation of `--mirror --single-branch -b
BRANCHNAME` would be that the single branch should be fetched and made
the HEAD, and the refspec should be set to
`+refs/heads/BRANCHNAME:refs/heads/BRANCHNAME`. It also wouldn't be very
surprising if it were forbidden to use these options together.

Currently, we do neither of those things. Instead we fetch that one
reference (as `refs/heads/BRANCHNAME`) but set the refspec to
`+refs/*:refs/*`; i.e., the next fetch would fetch all of the history.

It's even more mind-bending if `-b` is passed a `TAGNAME` rather than a
`BRANCHNAME`. The documentation says that `-b TAGNAME` "detaches the
HEAD at that commit in the resulting repository". If `--single-branch -b
TAGNAME` is used, then the refspec is set to
`+refs/tags/TAGNAME:refs/tags/TAGNAME`. But what if `--mirror` is also used?

Currently, this fails, apparently because `--mirror` and `-b TAGNAME`
each independently try to set `refs/tags/TAGNAME` (presumably to the
same value). *If* this is a useful use case, we could fix it so that it
doesn't fail. If not, maybe we should prohibit it explicitly and emit a
clearer error message.

Mathias: if you encountered this problem in the real world, what were
you trying to accomplish? What behavior would you have expected?

Maybe the behavior could be made more sane if there were a way to get
the 1:1 reference mapping that `--mirror` implies without also getting
`--bare` [1]. Suppose there were a `--refspec` option. Then instead of

    git clone --mirror --single-branch -b BRANCHNAME

with it's non-obvious semantics, you could prohibit that use and instead
support

    git clone --bare
--refspec='+refs/heads/BRANCHNAME:refs/heads/BRANCHNAME'

which seems clearer in its intent, if perhaps not super obvious. Or you
could give `clone` a `--no-fetch` option, which would give the user a
time to intervene between setting up the basic clone config and actually
fetching objects.

Michael


[1] It seems like

        git clone --config remote.origin.fetch='+refs/*:refs/*' clone ...

    might do it, but that actually ends up setting up two refspecs and
only honoring `+refs/heads/*:refs/remotes/origin/*` for the initial
fetch. Plus it is pretty obscure.
