From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Tue, 24 Mar 2015 16:42:17 +0100
Message-ID: <551185D9.6050200@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu> <xmqq7fudld61.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:28:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaRh3-0006tG-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 17:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbbCXPmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 11:42:39 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53262 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753149AbbCXPme (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 11:42:34 -0400
X-AuditID: 12074412-f79e46d0000036b4-7e-551185db4387
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 88.ED.14004.BD581155; Tue, 24 Mar 2015 11:42:19 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9745A.dip0.t-ipconnect.de [79.201.116.90])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2OFgHeR010335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 24 Mar 2015 11:42:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqq7fudld61.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1L3dKhhqcKJFxKLrSjeTRUPvFWaL
	x7cmMDkwe8y9b+lx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGbePPWYtuKNTMb3rOVsD40rl
	LkYODgkBE4kVJ/S6GDmBTDGJC/fWs3UxcnEICVxmlOjYtYcRwjnPJPH5xV12kAZeAW2J1/+8
	QBpYBFQlPk/YwwJiswnoSizqaWYCsUUFgiRe3vrLCGLzCghKnJz5BKxGREBNYmLbITCbWcBI
	YtaNM6wgtrBAuMTSe7OZQMYLCRRJvOiMAAlzClhLHGw9zA5Rriex4/ovVghbXqJ562zmCYwC
	s5BsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQoJWaAfj
	+pNyhxgFOBiVeHgDlgiECrEmlhVX5h5ilORgUhLlne4kGCrEl5SfUpmRWJwRX1Sak1p8iFGC
	g1lJhDcAGCtCvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvPYgjYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaC8P2N7igsRcoChE6ylG
	RSlxXl2QhABIIqM0D24sLBW9YhQH+lKY93ULUBUPMI3Bdb8CGswENPhcPh/I4JJEhJRUA6Pv
	6l3zV/ea5C7a7rP9DFPlk/eycwIY1FtYj1x33Xlms+eucsNZO6+Gq846aBzq4eaYWPg6een/
	1LNRpnF3ep6utPFd/54j6dIaL5WoZ33NUa/42C5dPLD87YXaoClM2tKR/gURgurL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266196>

On 03/19/2015 07:22 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> * It allows leading whitespace.
> 
> This might be blessing in disguise.  Our friends on MacOS may be
> relying on that
> 
>     git cmd --abbrev="$(wc -c <foo)"
> 
> to work "as expected", even though their "wc" gives leading spaces,
> for example.

Yuck. If you'd like, I can make sure to continue allowing leading
whitespace everywhere that it is allowed now. Alternatively, we could
make the parsing tighter and see if anybody squeals. What do you think?

>> * It allows arbitrary trailing characters.
> 
> Which is why we have introduced strtoul_ui() and such.
> 
>> * It allows a leading sign character ('+' or '-'), even though the
>>   result is unsigned.
> 
> I do not particularly see it a bad thing to accept "--abbrev=+7".
> Using unsigned type to accept a width and parsing "--abbrev=-7" into
> a large positive integer _is_ a problem, and we may want to fix it,
> but I think that is still within the scope of the original "better
> strtol/strtoul", and I do not see it as a justification to introduce
> a set of functions with completely unfamiliar name.

It is easy to allow "--abbrev=+7"; I would just need to add NUM_PLUS to
those call sites. Should I do so?

It would even be possible to allow "--abbrev=-0", which is also a
non-negative integer. But it's more work and it seems pretty silly to me.

>> * If the string doesn't contain a number at all, it sets its "endptr"
>>   argument to point at the start of the string but doesn't set errno.
> 
> Why is that a problem?  A caller that cares is supposed to check
> endptr and the string it gave, no?  Now, if strtoul_ui() and friends
> do not do so, I again think that is still within the scope of the
> original "better strtol/strtoul".

The text you are quoting was my argument for why we need wrappers around
strtol() and strtoul(), not for how the wrappers should be named.

The "endptr" convention for detecting errors is fine in theory, but in
practice a large majority of callers didn't check for errors correctly.
This is partly because the "endptr" convention is so awkward.

The existing strtoul_ui() and strtol_i() did check endptr correctly, but
there were only int-sized variants of the functions, and they didn't
give the caller the chance to capture endptr if the caller wanted to
allow trailing characters.

Why did I rename the wrapper functions?

* The old names, I think, emphasize that they take the long-sized
results of strtou?l() and convert them to integer size, which I think is
an implementation detail.
* The new functions will also have long versions. The obvious way to
generalize the existing function names for long variants (srtoul_ul()
and strtol_l()) seem kindof redundant.
* I wanted to change the signature and behavior of the functions, so
knowledge of the existing functions wouldn't be super helpful in
understanding the new ones.

>> * If the value is larger than fits in an unsigned long, it returns the
>>   value clamped to the range 0..ULONG_MAX (setting errno to ERANGE).
> 
> Ditto.
> 
>> * If the value is between -ULONG_MAX and 0, it returns the positive
>>   integer with the same bit pattern, without setting errno(!) (I can
>>   hardly think of a scenario where this would be useful.)
> 
> Ditto.
> 
>> * For base=0 (autodetect base), it allows a base specifier prefix "0x"
>>   or "0" and parses the number accordingly. For base=16 it also allows
>>   a "0x" prefix.
> 
> Why is it a problem to allow "git cmd --hexval=0x1234", even if "git
> cmd --hexval=1234" would suffice?

In some cases we would like to allow that flexibility; in some cases
not. But the strtol()/strtoul() functions *always* allow it.

>> When I looked around, I found scores of sites that call atoi(),
>> strtoul(), and strtol() carelessly. And it's understandable. Calling
>> any of these functions safely is so much work as to be completely
>> impractical in day-to-day code.
> 
> Yes, these burdens on the caller were exactly why strtoul_ui()
> etc. wanted to reduce---and it will be a welcome change to do
> necessary checks that are currently not done.
> 
>> Please see the docstrings in numparse.h in the first commit for
>> detailed API docs. Briefly, there are eight new functions:
>>
>>     parse_{l,ul,i,ui}(const char *s, unsigned int flags,
>>                       T *result, char **endptr);
>>     convert_{l,ul,i,ui}(const char *s, unsigned int flags, T *result);
>>
>> The parse_*() functions are for parsing a number from the start of a
>> string; the convert_*() functions are for parsing a string that
>> consists of a single number.
> 
> I am not sure if I follow.  Why not unify them into one 4-function
> set, with optional endptr that could be NULL?

In the next version of this patch series I plan to include only four
functions, str_to_{i,ui,l,ul}(), named that way to make them more
reminiscent of the functions that they replace. They will take an entptr
argument, but if that argument is set to NULL, then the function will
error out if there are any trailing characters.

> While we are on the topic of improving number parsing, one thing
> that I found somewhat frustrating is that config.c layer knows the
> scaling suffix but option parsing layer does not.  These functions
> should offer an option (via their "flags") to say "I allow scaled
> numbers like 2k, 4M, etc.".

That's a good idea. But I think I will leave that for a later patch
series, if that is OK with you.

Thanks for the great feedback!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
