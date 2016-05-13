From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pathspec: record labels
Date: Thu, 12 May 2016 23:28:13 -0700
Message-ID: <xmqqtwi2a2v6.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<20160513001936.7623-5-sbeller@google.com>
	<xmqqy47ea5ql.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbaqw9UvYrCWcLtAXaiw5-aSev9gn858zz5Ju0MVfzepQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 13 08:28:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b16aE-0006H3-2V
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 08:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbcEMG2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 02:28:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751155AbcEMG2R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 02:28:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC7E01BEA3;
	Fri, 13 May 2016 02:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/FfTP83yP9I8isu2lwLHfTRwrdI=; b=yHQl22
	fDzsJqe8ban03LiHlwMctXX7Ssegv0Kw9kaHOt8SFYGG8r7NXNzzb9WlG2m1ACn1
	ZstxfopAQvUldHBcEFPWu6Vf83J19uust6x1WZUVJ0Myc6HB8Lf/Z+d1Mu2yv1pi
	zWwqp+AJpn4gijQg/ZlG8xN+Wz5XLkAChjQgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uT9khjz7+P+SnCaGQyocX3yJ0mbBogjJ
	HOJuZmFUeyhMGUZDbK6hRQ3PTQWzplkmzvCFYrvkcZRGhW0rYpfkNCjgpMCKqlYZ
	0yuf4EYWRC21aDlACjOKGHWFMWUavHDnFXiV8nQM+ReAx0gimVOtsIlIXkgfYH9+
	BKzlP3mavVs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1E871BEA2;
	Fri, 13 May 2016 02:28:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 660781BEA1;
	Fri, 13 May 2016 02:28:15 -0400 (EDT)
In-Reply-To: <CAGZ79kbaqw9UvYrCWcLtAXaiw5-aSev9gn858zz5Ju0MVfzepQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 12 May 2016 22:41:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DFDC74B4-18D3-11E6-A1BD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294507>

Stefan Beller <sbeller@google.com> writes:

> Would it make sense to mark a file as
>
>     "follows the labeling system, but has no label" (TRUE)
>     "doesn't follow the labeling system at all" (FALSE)

Isn't the former be "label="

I do not know what you mean by the latter.  I would understand
"pretend this has all the labels under the sun", though.

>>     Ahh, you are making ":(label=...)makefile" to say "paths must
>>     match the string 'makefile' in some way, and further the paths
>>     must have all these labels?  Then falling through is correct.
>
> This is how I understood your initial design idea.
>
>     :(label=C_code)contrib/
>
> gives all the retired C programs.

OK, you probably meant s/C program/shell script/ with a different
label, but I think I got the idea.

> I wonder that you focus on the details already, but not on the grand
> design of things. "Is it actually a sane thing I am proposing here?"
> Though you may be biased as the the high level idea came from
> you. :)

Biased is the primary reason ;-) I trust that other reviewers can
stop me and correct course when I veer off the deep end by myself.

Just like you called this as a "mock", I am treating this as a
testbed to let you try out the "defaultGroup" thing to see how
flexibly you can express common wishes the end users have, i.e.
"does it give us an expressive enough system to replace repo?"
is the question I want this code to help answering.  And that is
why I was trying to make sure it is good enough quickly.

> One of the things I switched last minute and tried to address in
> the cover letter is the semantics of ORing or ANDing the labels
> given within one pathspec item.

That is something we may find out that the other way is more useful,
or your final choice is better, by seeing how easy to express common
patterns of submodule selections.  Perhaps we might end up wanting
both, but as you said, OR can be given by listing the same path with
differnt required-labels so I think what you have is good enough for
us to start experimenting with the higher layer.

One worry I have is that historically pathspec matching and
attribute matching have both been very hard to make it perform well.
The placement of string_list_has_string() and load_labels() at the
leaf level of the pathspec matching logic cannot be helped, but
these calls might turn out to be an unacceptable performance
bottleneck.  But it is a bit too early to worry about that, I think.
