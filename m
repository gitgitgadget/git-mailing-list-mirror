From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Listing commits that are _exclusively_ available on a given
 branch
Date: Fri, 23 Mar 2012 12:39:50 -0700
Message-ID: <7v4ntft8c9.fsf@alter.siamese.dyndns.org>
References: <CALKQrge-=XExhwxuC14uynpuuO3W+f4YO4=X7kFUx33F3HtnyQ@mail.gmail.com>
 <20120323170640.GA12881@sigill.intra.peff.net>
 <7vaa37usiv.fsf@alter.siamese.dyndns.org>
 <20120323175007.GA13410@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBAL9-00032A-7l
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 20:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759627Ab2CWTjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 15:39:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757341Ab2CWTjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 15:39:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 911056290;
	Fri, 23 Mar 2012 15:39:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0CKzUfaGvtnUUkDAGt5CG8dgtc=; b=WpIbtw
	zu8lR4zI3escuDJJ89yUqZ/Ya8t87d0KThexWWa0oCJx3mzln8h7s4at25tPyH7z
	JZ64NCW93HR2/YW3FBUZzqG5TZyaVL6KEL66WEkny+I+HjsFGyezcPhq6ilVcRdc
	xG3aqYjjokc1Dn24NOY+QGc0VZ6Z2N74J7CJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5TFFcL6PaAGk4JlXWg8mo7DwvH9kqGw
	WFn38BxFSeQ2+iGwV4RPhe9LuQfRCBJ7OEDhlvUaR8gjawRia2e05hev2ve1+wWp
	Ohoyfat5X5mptPMah00duMfbjgArdWP+lqgVQK2JFexIQweUDlbSuLeirnd8xc8x
	V2NTMYa4BpI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87D1E628F;
	Fri, 23 Mar 2012 15:39:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF1F2628D; Fri, 23 Mar 2012
 15:39:51 -0400 (EDT)
In-Reply-To: <20120323175007.GA13410@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 23 Mar 2012 13:50:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5645C36-751F-11E1-9027-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193797>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 23, 2012 at 10:38:32AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > No, I think that is the only way to do it. The algorithm run by rev-list
>> > in that case should be optimal, so there is nothing to improve there.
>> > Syntactically, it's a little bit of a pain because there is no way to
>> > tell rev-list "--all, except for this one branch" short of using grep.
>> > We could add a new syntax for that, but I'm not sure what it would look
>> > like (or if it would be any easier on the eyes than what you have).
>> 
>> We discussed --exclude-refs="refs/tags/expermental-*" that would affect
>> how --all, --heads, and friends are processed several weeks ago, didn't
>> we?
>
> Gmane seems to be down at the moment, but I think the thread you are
> talking about can be found here:
>
>   http://mid.gmane.org/7v4nuvghfk.fsf@alter.siamese.dyndns.org
>   http://mid.gmane.org/4F391F5C.1000400@alum.mit.edu
>   http://mid.gmane.org/7vaa4meat5.fsf@alter.siamese.dyndns.org
>
> It talks about excluding from the positive side, like:
>
>   git rev-list --all --exclude-ref=refs/heads/foo
>
> That can also be extended to the negative side, like:
>
>   git rev-list refs/heads/foo --not --all --exclude-ref=refs/heads/foo
>
> though it is slightly confusing to read due to the double negation (you
> are "--not" "--exclude"-ing the ref).

The confusion comes only if you do not differentiate two independent
concepts, I think.  --all and --exclude-ref are about what the starting
points of the traversal (i.e. what we would call add_rev_cmdline() and
add_pending_sha1() with), and --not is about the color in which these
pending objects will be painted.

The callpath leading to revisions.c::handle_one_ref() from setup_revisions()
must be revamped, so that "--all" does not immediately put them directly
in the pending array, but later "--exclude-ref" can subtract from the set,
before the starting points are determined and painted in their colors,
once we add --exclude-ref support.
