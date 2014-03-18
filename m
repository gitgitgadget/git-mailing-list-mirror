From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Tue, 18 Mar 2014 12:00:17 +0100
Message-ID: <53282741.5010609@web.de>
References: <20140305003639.GA9474@sigill.intra.peff.net> <5316D922.9010501@viscovery.net> <20140306212835.GA11743@sigill.intra.peff.net> <531973D9.9070803@viscovery.net> <20140314035457.GA31906@sigill.intra.peff.net> <5322A82E.9060808@viscovery.net> <20140318052456.GA17454@sigill.intra.peff.net> <5327FD81.4040508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de
To: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 12:00:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPrlG-0002Z8-6N
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 12:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbaCRLA2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 07:00:28 -0400
Received: from mout.web.de ([212.227.15.4]:53635 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381AbaCRLAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 07:00:24 -0400
Received: from [192.168.178.27] ([79.253.137.91]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LwYs7-1XCB8E2jDr-018Me9; Tue, 18 Mar 2014 12:00:21
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <5327FD81.4040508@viscovery.net>
X-Provags-ID: V03:K0:wTSNjAFQzst+cEXBWcA69ucmkV3KZ4VeKzkUZlu/5Wzkr5v9SGX
 gH+f83v5Ual6agO00Mjg2xBCsLA65jwys7z99SU6JyUclP2+eoBt8q7BPyRwMcdLy2mewRK
 xA3xJV/8Ww1den/cEBkCbULmZL7jnEEs2q3VCmtglQVyiPs2tZhH6KeRv+P8g4CUJxnAzw7
 46aTVfXWzD5GoC1wXp8cQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244350>

Am 18.03.2014 09:02, schrieb Johannes Sixt:
> Cc Ren=C3=A9; do you have any comments regarding grep --function-cont=
ext?
>
> Am 3/18/2014 6:24, schrieb Jeff King:
>> On Fri, Mar 14, 2014 at 07:56:46AM +0100, Johannes Sixt wrote:
>>
>>> Consider this code:
>>>
>>>    void above()
>>>    {}
>>>    static int Y;
>>>    static int A;
>>>    int bar()
>>>    {
>>>      return X;
>>>    }
>>>    void below()
>>>    {}
>>
>> Thanks, this example is very helpful.
>>
>>> When you 'git grep --function-context X', then you get this output =
with
>>> the current pattern, you proposal, and my proposal (file name etc o=
mitted
>>> for brevity):
>>>
>>>    int bar()
>>>    {
>>>      return X;
>>>    }
>>
>> Right, that makes sense to me.
>>
>>> When you 'git grep --function-context Y', what do you want to see? =
With
>>> the current pattern, and with your pattern that forbids semicolon w=
e get:
>>>
>>>    void above()
>>>    {}
>>>    static int Y;
>>>    static int A;
>>>
>>> and with my simple pattern, which allows semicolon, we get merely
>>>
>>>    static int Y;
>>>
>>> because the line itself is a hunk header (and we do not look back a=
ny
>>> further) and the next line is as well. That is not exactly "functio=
n
>>> context", and that is what I'm a bit worried about.

In global context there is no "function context", of course, so the=20
latter makes sense.

"grep --function-context" is about useful context and its implementatio=
n=20
piggy-backs on the hunk header definitions.  If those are useful then=20
the grep output should be fine as well.  IAW: No worries, go ahead. :)

However, I only use the defaults heuristic (which shows just the Y-line=
=20
as well) and don't know C++, so I my opinion on this matter isn't worth=
=20
that much.

Ren=C3=A9
