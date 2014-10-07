From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo
 = bar"
Date: Wed, 08 Oct 2014 00:17:07 +0200
Message-ID: <54346663.7090006@alum.mit.edu>
References: <xmqq61fveg1j.fsf@gitster.dls.corp.google.com>	<20141007212941.GA24508@peff.net> <xmqqiojvczrd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 00:17:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbd4K-0004GL-4w
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 00:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbaJGWRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 18:17:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43361 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895AbaJGWRP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 18:17:15 -0400
X-AuditID: 1207440d-f797f6d000000a4a-bd-54346666394f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FE.66.02634.66664345; Tue,  7 Oct 2014 18:17:10 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C4D.dip0.t-ipconnect.de [93.219.28.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s97MH8VT003417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 7 Oct 2014 18:17:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqiojvczrd.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1E1LMwkxeLab36LrSjeTRUPvFWaL
	Hy09zA7MHs969zB6XLyk7PF5k1wAcxS3TVJiSVlwZnqevl0Cd8aPjSfZCs6JVmz4kNXAuEmg
	i5GDQ0LARGLqw5wuRk4gU0ziwr31bF2MXBxCApcZJbZ27meBcM4ySUz7NZcNpIpXQFti1Z/5
	LCA2i4CqxJ9vl5lBbDYBXYlFPc1MILaoQIDEh84HjBD1ghInZz4BqxcRcJQ48eA6K8hiZgFx
	if5/YGFhgRCJA58fsELs6maUeDLvANguTgFriRdX94LNYRbQk9hx/RcrhC0v0bx1NvMERoFZ
	SFbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghgcu7g/H/
	OplDjAIcjEo8vCu0jEOEWBPLiitzDzFKcjApifIWRZmECPEl5adUZiQWZ8QXleakFh9ilOBg
	VhLhjYwGyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHinpwI1Chal
	pqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiNL4YGKkgKR6gvbog7bzFBYm5QFGI1lOM
	ilLivBtAEgIgiYzSPLixsHT0ilEc6Eth3m8gVTzAVAbX/QpoMBPQ4FX9xiCDSxIRUlINjA3s
	7xvW6czWepttWbj/Hp9UtdlPjsCpCxjOVP8wXbJhZvVmti/OFx7uvdWofKxsyuSmOJMlGyct
	n5eWd9Dn5uyKlHgdVtbLd6OdPv+cf06sYZmE9t2mA08mZ7Yu617PdfL/09QjVfai 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2014 11:53 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Oct 07, 2014 at 01:35:15PM -0700, Junio C Hamano wrote:
>>
>>> Yeah, if we are going to reduce it down to the above implementation,
>>> intereseting things like "test -f $frotz" will become possible and
>>> "cmp-str" stops making sense.  It really is about "We run test and
>>> expect it to yield true.  Report the failure a bit more prominently
>>> under the '-v' option to help us debug".
>>
>> We already have test_path_is_file to do the same thing just for "-f". We
>> could in theory switch all of those to this new, more generic wrapper. I
>> don't know if it is worth doing a mass-conversion, but we could
>> discourage test_path_is_file in new tests. We could also implement
>> test_path_is_{dir,file} on top of this.
> 
> Oh, I wasn't going in that direction when I mentioned "-f"; I just
> wanted to say that 'test "$@"' is clearly about 'test' (/bin/test or
> shell built-in) and less about 'compare string'.  I do not think it
> is necessarily a good direction to go in to replace test-path-is-file
> with the test_cond thing; after all, type specific tests have chance
> to report breakage of expectation in type specifc ways, e.g.
> 
> 	test_path_is_file () {
> 		test -f "$1" && return 0
> 		echo >&2 "expected '$1' to be file"
> 		if test -e "$1"
>                 then
> 	               	echo >&2 "but it is missing"
> 		else
>                 	echo >&2 "but it is a non-file"
> 			ls >&2 -ld "$1"
> 		fi
>                 return 1
> 	}
> 
> But that is also just in theory ;-).
> 
>>> So among the ones you listed, test_verbose may be the least silly, I
>>> would think.
>>
>> Somehow test_verbose seems to me like checking the "verbose" option of
>> the test suite. I prefer "test_cond", but I do not feel too strongly, if
>> you want to override me.
> 
> Hmph, your 'test' in that name is a generic verb "we check that...",
> which I think aligns better with the other test_foo functions.  When
> I suggested 'test_verbose', 'test' in that name was specifically
> meant to refer to the 'test' command.
> 
> Still "test_cond" feels somewhat funny, as "we check that..." always
> validates some condition, but I don't think of anything better X-<.

I like "verbose_test $foo = $bar" because it puts the word "test" next
to the condition, where the built-in command "test" would otherwise be.

We could even define a command

	verbose () {
		"$@" && return 0
		echo >&2 "command failed: $*"
		return 1
	}

and use it like

	verbose test $foo = $bar

Somehow I feel like I'm reinventing something that must already exist...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
