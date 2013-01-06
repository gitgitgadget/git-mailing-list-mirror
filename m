From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fast-import(1): reorganise options
Date: Sun, 06 Jan 2013 15:10:48 -0800
Message-ID: <7va9slnc07.fsf@alter.siamese.dyndns.org>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin> <7vy5g6okdi.fsf@alter.siamese.dyndns.org>
 <20130106132915.GG6440@serenity.lan> <20130106135109.GF22081@elie.Belkin>
 <20130106142825.GH6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 07 00:11:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrzNA-0005pE-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 00:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab3AFXKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 18:10:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311Ab3AFXKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 18:10:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4448A795;
	Sun,  6 Jan 2013 18:10:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=895tip9lLAq0cUyKKDJFn6/oCT4=; b=UD9sVF
	h5S6Sjz4S8SkntakCs0eawSBFqf4n9gre3Yxpa/CIgRFckqsprnB78JD3XXIOeWQ
	jTXJYjVKo0PXmwk1NIzOfnwAhI74IhIWvVL5H44fOLJfgM8nTgjy+3kgbi7GaQC7
	mff8/7lAI5llYAHl+4+G/OfMP31wk8bS5/o1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xzX/TwFuJkXiBJyktwakiRevH+piw8X0
	oLfPBxa3Sn9BwxZmESTmrq4ZlyGoLcFxuWXslFDg0BZATYKqfRi1D8R9myGBIdjk
	UrUDFih/uivVsRtsKyo/uVGKa7ftVxzmOFC0rWFN4R5Pf/kHJibPn6ZQILLNmtMv
	jAJ3SpZ6aKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C52F7A794;
	Sun,  6 Jan 2013 18:10:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37532A78F; Sun,  6 Jan 2013
 18:10:50 -0500 (EST)
In-Reply-To: <20130106142825.GH6440@serenity.lan> (John Keeping's message of
 "Sun, 6 Jan 2013 14:28:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FBB58D2-5856-11E2-9D1E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212854>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Jan 06, 2013 at 05:51:09AM -0800, Jonathan Nieder wrote:
> ...
>> Nice description.
>> 
>> > While doing this, fix the duplicate '--done' documentation by taking the
>> > best bits of each.  Also combine the descriptions of '--relative-marks'
>> > and '--no-relative-marks' since they make more sense together.
>> 
>> I'd prefer to keep those as separate patches, if that's manageable.
>
> I'll send a series of three patches if the discussion below seems
> reasonable:
>
> [1/3] remove duplicate '--done'
> [2/3] combine --[no-]relative-marks
> [3/3] reorganize options

Sounds sensible and I like the direction in which this discussion is
progressing.

>> I'd worry that the catch-all toplevel category would grow larger
>> and larger with time, since it's the obvious place to put any new
>> option.
>
> I agree that that's a concern, perhaps '--cat-blob-fd' should be
> combined with '--date-format' and '--done' into a section called
> "Options for frontends" or similar?
>
> And maybe '--export-pack-edges' can move to the performance/compression
> tuning section?  I expect the interested audience would be the same.
>
> That only leaves three options in that section, which seems more
> reasonable.

I'll leave it to others to decide which individual options would
fall into that catch-all category, but the idea you outlined above
sounds sensible overall.

> I realise it's personal taste, but I like the subheadings of the form
> "Options (for|related to) ...", so maybe:
>
> Options for input stream features
> Options related to marks files
> Options for performance and compression tuning

Again, sounds sensible.

>> I like how you put important options like --force on top.  Perhaps
>> the less important --quiet and --stats could be split off from that
>> into a subsection like "Verbosity" to make them stand out even more.
>
> I quite like having the verbosity options near the top since those are
> the ones that are most likely to be of interest to a user, whereas the
> rest are likely to be prescribed by the frontend (or only really useful
> to frontend authors).

I tend to agree with Jonathan that verbosity options are less
important ones than the ones that affect how things work.

Thanks.
