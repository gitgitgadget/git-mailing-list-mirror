From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to
 use_wildcard
Date: Thu, 07 Apr 2011 12:44:35 -0700
Message-ID: <7vvcypeti4.fsf@alter.siamese.dyndns.org>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org>
 <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
 <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
 <4D9D9B60.4030404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7v8T-00073z-KP
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab1DGTov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 15:44:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704Ab1DGTou (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 15:44:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C28A4155;
	Thu,  7 Apr 2011 15:46:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tFh+49uRtzKzaTc3eNWtcEKBVVU=; b=jVJm/6
	KCDz1Ea9i/5BC9nI6oXR/aejqWlvCjML3RzRM1FKCORXO5w66ZREjln+rr8UE6XI
	Kpk6iZCm+GD4R+jhGui58VOsZqV58mtILsWBw39YvGWYXugCuCjb39EWiaufBLqH
	Uw8CJz93NGOnELPOOZo5yPqvJPUbo8YoxmRl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wwDPrEx6itpM9o5KrUpCa05UNmlPuDtO
	fci/CdWzrtyKnUsrZDr6PGvmlAEcoGYNr4LOU2gD015Io8n1VSZgH+WZcFJI6odc
	jNb0xeH/w4bUSonPezrxKCpE9fdMYgUV6ck+H6nJZp/75AMw1aitxj2KpVvqCrj1
	LFD77N4JTlo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBEFD414E;
	Thu,  7 Apr 2011 15:46:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8F871414D; Thu,  7 Apr 2011
 15:46:31 -0400 (EDT)
In-Reply-To: <4D9D9B60.4030404@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 07 Apr 2011 13:09:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF2D8028-614F-11E0-B00D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171083>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 06.04.2011 19:13:
> ...
>> I think you meant to say "If we only want to have 'top dir' magic,
>> fundamental support and get_pathspec() conversion are unnecessary", and I
>> agree 100%.
>> 
>> I am actually tempted to add Michael's hack to get_pathspec() only to
>> support the "from the top" (and error out with any other magic---as the
>> approach without a proper restructuring will not work with anything but
>> that particular magic), to get the "add -u" topic going, and let you (or
>> other people who are interested in the pathspec rationalization) later fix
>> it up just a small part of existing issues.
>
> Junio, we're in rc phase ;)

I know ;-).  All the patches I sent out yesterday are to be held until
1.7.5 ships.

Because I doubt that the major restructuring we discussed earlier won't be
ready within the 1.7.6 timeframe, I think it would make sense to ship the
version of "git add -u/-A" update that does not use any confvar but does
suggest the use of ':/' (it seems none of us is totally unhappy with that
notation) or '.', which I think is a far superiour solution, in 1.7.6.

That gives us more time to enhance the magic pathspec for later versions,
but still will give plenty of time to the users for "git add -u/-A"
migration planned for 1.8.0 version bump.  Hooking at the get_pathspec()
level is a compromise to make that happen, as long as we nailed the syntax
right so that we do not have to break people's fingers and scripts when we
redo the logic for the magic pathspec at the right level of the API.

>>  (1) Colon, a run of selected non-alpha (i.e. magic signature), an
>>      optional colon to terminate the magic signature, followed by the
>>      path, e.g.
>> 
>>      - ":/hello.c" is a path from the top.
>> 
>>      - ":!/hello.c" is path from the top but no globbing.
>> 
>>      - ":/!hello.c" is the same as above.
>> 
>>      - ":/::hello.c" is ":hello.c" from the top, the second colon
>>        terminates the magic signature and allows the funny file with a
>>        leading colon to be named.
>> 
>>      - "::hello.c" does not have any magic, is the same as "hello.c".
>> 
>>  (2) Colon, open parenthesis, a comma separated list of words to name
>>      magic, close parenthesis, followed by the path, e.g. these are the
>>      long-hand counterparts to the examples in (1)
>> 
>>      - ":(top)hello.c"
>>      - ":(top,noglob)hello.c"
>>      - ":(noglob,top)hello.c"
>>      - ":(noglob,top):hello.c"
>>      - ":()hello.c"
>
> Do we need the parentheses?

We bracket spelled-out names, e.g. %(refname), ^{commit}, as opposed to
not bracket a short-hand to keep them, eh, short.  Also the fact that ":("
is a very unlikely character sequence to begin a pathname will help avoid
clashing with real pathnames.  Short-form magic mnemonic consists only of
non-alphanumeric, and ":x" for any 'x' that is a non-alphanumeric is also
a very unlikely character sequence to begin a pathname.

> What about these:
>
> :/(noglob)hello.c
> :(top)!hello.c

Not interested.  It is Ok if mnemonic form is a bit complex to explain, as
long as the end result is short to type once the user understands it.  When
a long form is involved, the rule should be as simple as possible to help
people who haven't taken the time to understand the possible complex short
form parsing rules that is necessary to keep the short form short.

> Spelling out xyz would already nail down the syntax quite a bit. It
> seems you accept to break people with files named ":(top)hello.c" but
> not those with files named ":top:hello.c".

I think we actually _do_ break ":top:hello.c", which the yesterday's patch
would parse as a pattern "top:hello.c" that does not have any magic, and
you would need to quote it, i.e. "\:top:hello.c" or ":::top:hello.c", if
you mean ":top:hello.c" is the pattern, I think.

I have considered to tweak the syntax definition further to allow you to
say ":Makefile" (which would parse as a pattern "Makefile" without any
magic with yesterday's patch) and automagically add "top" magic to it,
because "top" would be the most common thing you would want to say, and
because it would make it look similar to "HEAD:Makefile" (the blob object
in HEAD tree) or ":Makefile" (the blob object in the index).  A three
liner patch is attached.

But that would mean that we are not just saying "a colon ':' followed by a
non-alphanumeric is an unlikely sequence".  We would be saying "a colon
':' is an unlikely character to begin a pathname".  I think that is going
a bit too far.  So we probably would not want to do this.

 setup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 820ed05..4ebedd4 100644
--- a/setup.c
+++ b/setup.c
@@ -213,6 +213,9 @@ const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
 		}
 		if (*copyfrom == ':')
 			copyfrom++;
+		else if (copyfrom == elt + 1)
+			/* Special case: ":Makefile" -> ":/Makefile" */
+			magic = PATHSPEC_FROMTOP;
 	}
 
 	if (magic & PATHSPEC_FROMTOP)
