From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 04/19] fsck: Offer a function to demote fsck errors
 to warnings
Date: Sun, 21 Jun 2015 20:23:22 +0200
Organization: gmx
Message-ID: <8545f1b636f157b280f15c615c1e1756@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
 <bc06c48f005ad1c32dea2edbfa466208@www.dscho.org>
 <xmqqegl5j75m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 20:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6ju3-0000PH-1P
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 20:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbbFUSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 14:23:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:51113 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbbFUSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 14:23:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LrvWY-1YykL41RdO-013hJU; Sun, 21 Jun 2015 20:23:24
 +0200
In-Reply-To: <xmqqegl5j75m.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:t6EWOESQU/a/Ug+6+JiHOYg0bcXTDJfAk3Uq/gW33pSPWR5toKM
 iUzPqfoRno9Xo3N6/DgwSz8NNohKg6LzdXvqMUTZgRmguFz7IEvt0RpoOwICpnKHtuCSVDc
 eUzdYNhKB3JEXRH1tO5Vv7xQqpoL+DcwjQBPCJHSS7ycWsNlobs4L8/4l8Kl9+ZRso8hsfx
 mNbs+TkGXlv4b26Iqq8Hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uVpa3W5sHc8=:8LlNb9KEiCg6bGqi7vFi2a
 c67OFety6cbEffG6P+EYfOSBds9aXnJSDS/DeUcmlE4p/Moq9sj6rsqjBCVhGXmUbYI7di99s
 YiE9BUYm6Zl5EcY9vRcyHtmky812lbXCeMg0Lc5AxCqR2Wd34W2iEcVJXv7lcw4cBc9oJxPIs
 jB/mcfvqDrJLDsltISKvw/CZ1lay6TscXEoEjS7AGHn51F46gSE1d5WPPOamSjiKKGvRE0Zlo
 mcwdC+eT8ee4w65L7fyQjTE1U2EGEVwUPdElZqv5y0PoIO9IcSmVJjCzJhnlkDHLSUcd1KwuV
 K1iYzRuda2O2+QHq8Qbfs1Cua7N8XhJVPElG7NJUbRmvz/7u38c6GA/YgT/yPUW6ebsVXBIDE
 0FsEIo9LIr1NSRv3yq+rE4vYl9nDHufVCaLQb8ort2T3z+ph6u4rF38UQJHxiA4KInoe+TVSD
 DI/XJwIGVI/1KtCgA9vXtjR8TGHd4uv4Syy2Oi1vMjZabte7FvDJW7EwG1kjoE5JeH09MX1Ov
 x69YOEAe/lidCvcf8WCgsKnAjgBEu3CLb3vMxfA99CBerraWHT+KorHe6ltilXq2YigXgEKB4
 GLtDqj8th2gv8RuyyYWFy8bFwCC7uaPv727AY5yKoKqhH7lnMiMV/P1OhcwcYslXAOI/Jmoiy
 tmoC2z3ATM3D3ZIhIFNKhozx1xvExrjQ8kGBCD/PFcZbi62SBHc4lzqcNDBnwGCUM1qw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272273>

Hi Junio,

On 2015-06-21 19:36, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Hmm. I really do not like that kind of thinking, i.e. having to
>> duplicate, then modify data to be able to call the API, only to have
>> to modify the data back afterwards, and eventually having to
>> unallocate the data in all code paths. That feels just very inelegant
>> to me.
> 
> You can see in our codebase that I have avoided touching end-user
> strings by using a substring in place by introducing a new API
> function or using an existing API function that takes <ptr, len> for
> exactly that reason.  There also are cases where we are better off
> if we make a copy upfront at a very high level in the callchain if
> that makes the processing of that string deeper in the callchain
> much simpler without customized helpers that take counted strings.
> 
> And 03/19 and this one taken together, I think it is an example of
> the latter [*1*].
> 
> You not only need to invent counted string comparison in 04/19 but
> also need upcasing byte-by-byte comparison in a loop in 03/19; both
> of which can be made much simpler if you massaged the end-user input
> "foo=error,bar=ignore" into "FOO=error,BAR=ignore" and allowed the
> code to loop over it to turn ',' into NUL while parsing each
> individual piece (i.e. "FOO=error").
> 
> So contrary to what you said in response to my review on 03/19, I
> view this as not "adding complexity" but its total opposite.  It is
> to make the code and logic much less complex by paying the price for
> one copied (and massaged) string.

How about I implement your suggestion tomorrow, then show the diff between the two versions and we can assess what looks to be simpler (i.e. more maintainable)?

BTW I agree about the skip-list feature being the most important outcome of this patch series; It only occurred to me as a useful feature at the very end of my work on the fsck IDs, but then I did not want to throw away all of that previous work ;-)

Ciao,
Dscho
