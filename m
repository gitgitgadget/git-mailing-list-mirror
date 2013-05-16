From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 09:17:08 -0700
Message-ID: <7v1u9699x7.fsf@alter.siamese.dyndns.org>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
	<5194921F.4080103@drmicha.warpmail.net>
	<CACsJy8CrGTa2XdfFkkKDQQjF8gM3011RiUE6roe9L7yZZq5J2g@mail.gmail.com>
	<51949B85.40600@drmicha.warpmail.net>
	<CACsJy8D_5YE3w4WNvCA8-fA-y5DV2WqHULqcMYqd7X_SSh_aHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:17:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0rm-00078n-MK
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab3EPQRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:17:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644Ab3EPQRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:17:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64F5A1F13B;
	Thu, 16 May 2013 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHoY7veGqbhhHwqfO1YOv00m9mc=; b=B41aMk
	XMsOrLPN8Gl6+EGwPLDlfeQtdu1PGZD08kCrwVeP1ChIJdEHUaNn6OdblBOglUn4
	I0H9+LynrzumKOQMPxGM9zJcEOMZmmHX+bBdafLC1phC1I9/bb791wN3QVqXo05O
	Ut1Hw95UQsqMtikSlYrHA/hi/MEJWI+znCTQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ERVEJ0x4lA+WQ43qjuIFGsMDznJ0PQSZ
	yiOBgyAB869fukUQNMwNACL4zKCCXcawCLmXxAnXXQTX+zvP8sVz8v5qJlggTFda
	IBRfvc7DaD7oGL2OHwRLZmxE8ESw5KNplU99DqPrFiTt0tW9TB3F8nukMuYVzE1v
	tn6bYDC8APw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 581F01F13A;
	Thu, 16 May 2013 16:17:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B68451F138;
	Thu, 16 May 2013 16:17:09 +0000 (UTC)
In-Reply-To: <CACsJy8D_5YE3w4WNvCA8-fA-y5DV2WqHULqcMYqd7X_SSh_aHw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 16 May 2013 15:56:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F420180-BE44-11E2-9F27-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224590>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, May 16, 2013 at 3:40 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>>> What if I want something in -vvvv except some in -vv? I think to avoid
>>> option explosion, maybe we can adopt --pretty=format:xxx from "git
>>> log" and let the user decideswhat (and how) to display. "pretty" code
>>> learns about alignment already, which may be useful here.
>>> --
>>> Duy
>>
>> Sure, that is the big solution we've been talking about. Unify
>> for-each-ref formats and log formats and use that. After all, "git
>> branch" in list mode really is for-each-ref, and should be transparently
>> so; same goes for "git tag". Think "git rev-list" and "git ref-list"!
>
> Again I forgot about for-each-ref. Sounds like sharing code between
> for-each-ref and branch is a good thing to do. Then just add more
> candy placeholders from git-log like %C(xx). Sounds like a fun topic.
>
>> But I guess we'll be compabeaten ;)
>
> No idea what that last word means :(

Me either, but I agree that "verbosity level" is a bad match for
this kind of thing.

You need to be able to pick and choose what are shown, and the user
preferences are not a linear progression that can be expressed with
a simple number of 'v's.

You may not need the level of flexibility the format string gives
you to choose not just what are shown but how they are shown, but if
we can teach the internal machinery of for-each-ref to compute the
kind of information it does not currently know, reusing the mechanism
will give us the output for free.

What are the current repertoire that we can pick from?

 * HEADness
 * branch name
 * abbreviated object name of the tip commit
 * name of @{u}
   * ahead/behind [*1*]
 * title of the tip commit

So the current "-v -v" format may look something like this:

    %(headness)%(refname:short)%(objectname:short)%(upstream)%(subject)

where

    %(headness) expands to either "  " or "* "
    %(upstream) expands to "[remotes/origin/master: ahead 2, behind 47] "

The more expensive ": ahead 2, behind 47" can be omitted by spelling
%(upstream:short), for example.


[Footnote]

*1* indented because this is dependent of @{u}; showing ahead/behind
    without showing @{u} would not make any sense.
