From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Sun, 01 Mar 2015 15:22:11 -0800
Message-ID: <xmqqr3t8fgm4.fsf@gitster.dls.corp.google.com>
References: <54EDBEC2.8090107@peralex.com>
	<CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
	<20150225143116.GA13567@peff.net>
	<xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
	<20150225185128.GA16569@peff.net>
	<xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
	<20150225191108.GA17467@peff.net>
	<20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
	<xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
	<20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 00:23:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSDCi-0000uq-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 00:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbbCAXWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 18:22:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752064AbbCAXWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 18:22:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEDC43D282;
	Sun,  1 Mar 2015 18:22:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLwUAa6oFduxo8PHSo/QBMgcENU=; b=T0zouy
	PuDjXUT6XwU6W0XIgXJx96kIS0x+q8F/SrN7jT6h1AguvOhzQ2axxBXEruPAIprt
	jdFTxhu1g9f4eknKeJVt+NU/xczyu9mCikhiIPb/TlYnF/nKFPWEz2BohdBY8OcX
	/nUTy57pmEeoYIaiAMyhbHlUMcgtbkrU3QlC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cbLXI+47r49QOGRRCGAvx3lukw8So3Gx
	FUEFlCwp4dhQYJfmMJ5rBh3S1ZNJLVKcBPrh0JDoPo9ZjEr6ANDwZ7PIX5YAtzB9
	ljn8ht3XLAjUELNrQoTJCp2UH3XWYQpQiZpa1Xm6C/PrT1UU3pNb+t0UNHrxz8sE
	TVQnnz4q1gA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D750D3D281;
	Sun,  1 Mar 2015 18:22:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48E953D27F;
	Sun,  1 Mar 2015 18:22:12 -0500 (EST)
In-Reply-To: <20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com>
	(Trevor Saunders's message of "Sun, 1 Mar 2015 08:03:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA2A03FC-C069-11E4-B517-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264567>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

>> ...  For these "per-invocation" differences, attributes
>> to declare permenent/inherent nature of the contents is much less
>> suited than per-invocation inclusion/exclusion mechanism based on
>> pathspecs, I would think.
>
> I think that makes some amount of sense, however typing stuff like
> --exclude=ChangeLog all the time is not terribly easy on the hands.
> Would it make sense to instead add a config variable grep.exclude?

I do not think it makes much more sense for at least three reasons.
for one thing, It still goes against "per-invocation" nature of what
is being done.  Your "for this invocation I do not want ChangeLog"
does not have to be limited to 'grep'.  And also "I end up having to
give these pathspecs all the time" is not limited to negative ones.

We have magic pathspecs, like "This pattern is used to match the
string case-insensitively", "This pattern specifies that the path
should *not* match it", etc.  How about adding a new feature that
lets you say "This is a short hand to giving these pathspecs" and
call that "pathspec macro"?

If you get tired to keep having to type

    $ git log -- Documentation/ ':!Documentation/technical/'

every time you want to check the end-user facing documentation
pages, you could for example say (I am using a made-up 'macro'
pathspec magic that is introduced by ':*' followed by a <macro
name>):

    $ git log -- ':*userdoc'

and the same macro specification could be used for all the other
things that take pathspecs (grep, add, diff, etc.).

You could then have something like this to define your own "nolog"
macro:

    [pathspecMacro]
        nolog = ':!ChangeLog' ':!ChangeLog.*'

to shorten your invocation of "grep" by appending it when you want
to exclude some files, i.e.

    $ git grep -e pattern -- \*.c ':*nolog'

and the same pathspec macro can be used in other places, not just
"grep".  Wouldn't it make more sense?
