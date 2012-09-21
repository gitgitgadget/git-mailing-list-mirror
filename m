From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Fri, 21 Sep 2012 09:27:57 -0700
Message-ID: <7vbogz8ho2.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <1348170383-15751-15-git-send-email-git@adamspiers.org>
 <505C15E4.7060108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 21 18:28:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF65P-0002zU-Fg
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 18:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757331Ab2IUQ2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 12:28:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755904Ab2IUQ2A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 12:28:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF14E889F;
	Fri, 21 Sep 2012 12:27:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6sAAuTh4y6nErciZrXgCjfns9k0=; b=blAmuy
	T/0lDX6aGWk9/YzBu7saSxoPKimcb/mWZBNkG7DonI8dG2VMJS72rZptONOjXY90
	nWngQOF7RlBupd4E1QMGOQLf8eJXEsLeejaMm0zZHhXFWZG1Uxny5I3CS5XbDD6H
	/fLHRnWksB6Xg19A8W/wEcrTj5KXfxBxuChho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wCfQOQsT/ttoxWxdEZ/rVbd8K+ISmvM1
	BvDEftAC4tiz0Pks9ltAdUEGGbFUlks9TWB8Giw1RpF0ovCqrWI3+Isy8rUt635K
	XIM6Aj4KYRXSblPc5TzAEi2U20HqWUyUp2gzjb0/fYb5euPonMZN2FGSG4dl7bBI
	BGuHR/6Sfzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C56889D;
	Fri, 21 Sep 2012 12:27:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37DD2889A; Fri, 21 Sep 2012
 12:27:59 -0400 (EDT)
In-Reply-To: <505C15E4.7060108@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 21 Sep 2012 09:23:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E7A1892-0409-11E2-BE39-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206129>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> +For each pathname given via the command-line or from a file via
>> +`--stdin`, this command will list the first exclude pattern found (if
>> +any) which explicitly excludes or includes that pathname.  Note that
>> +within any given exclude file, later patterns take precedence over
>> +earlier ones, so any matching pattern which this command outputs may
>> +not be the one you would immediately expect.
>
> Can I tell from the output of "git check-ignore" whether a file is
> really ignored?  The way I read the paragraph above, the output doesn't
> necessarily show the pattern that determines whether a file is *really*
> ignored.  That makes it sound like the ignore status of the file might
> be different than what I would infer from the output.  If I am
> misunderstanding the situation, then perhaps the explanation in the
> above paragraph can be improved.
>
> On the other hand, if my understanding is correct, then why did you
> choose this (seemingly strange) policy?  It would seem more useful
> either to output the pattern that has the definitive effect on the
> file's status, or to output all patterns that match the file.

Very good point. I didn't look at this patch at all, but I would
guess the patch hooked this into the order in which the existing
ignore mechanism computes the match, and "the first I find" Adam
says is written from implementation point of view.

And that is a wrong way to go about it.

The existing document for the ignore mechanism explains things from
the end user perspective, i.e. within a file, the last matching
pattern determines the fate of the path.  And this debugging aid
should report which pattern from what source determined the fate of
the path, so from the end user perspective, saying "first" is
nonsense.

It just happens that the implementation optimizes by scanning the
list of patterns "backwards" and stops at the "first" hit, which is
the last matching pattern that determines the fate of the path.

The documentation of this debugging aid should use the same phrasing
"git help ignore" uses and say "show the pattern that decides the
outcome", and lose that confusing "Note that" that is not helping
anybody.
