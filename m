From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 05 Sep 2009 00:25:56 -0700
Message-ID: <7vljkt7szf.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 09:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjpfH-0002TF-Hq
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 09:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbZIEH0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 03:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbZIEH0H
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 03:26:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZIEH0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 03:26:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F353269A2;
	Sat,  5 Sep 2009 03:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xVyALNce8IsfwuxpUZAG7QOGbWE=; b=Fwjrg8
	O49TNbFK7u8MD4/zZ10mmCMD7p+tVht1FRTR/l8sc6f0n4EhmanJrbXi1ysW12ns
	8jSXGnFS0ngsn3H+rmgTlO+B3Qcuaz3YiQi56M/f5HyvMfgGOy73hQWsjl1Nf38F
	DRquyuK58bWklMqFj5dii2W/Cc4FpqiT0JjUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KD7TaKTBc6/Sxy9VoTETtFjQ4ucUgIU2
	PKeR+qBPASv7rplh0O2XB1hs2epEl9gVaLbN2wfBSVRLmYHTi0PaC1/Pw2H6lD+E
	p3kyUQZz7pL9OwlUyYyk5cQZS2YvxUQ0yX/mDwJ0k+wG7vtor4JBdHe6XUwSovKT
	CF5SPJB0SEw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D10F7269A0;
	Sat,  5 Sep 2009 03:26:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE15A26994; Sat,  5 Sep
 2009 03:25:57 -0400 (EDT)
In-Reply-To: <7v8wgt98ms.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 05 Sep 2009 00\:02\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E6EBD54-99ED-11DE-94E5-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127788>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I suspect it is too late to change it due to compatibility issues. OTOH,
>> I think the intent of v1.7.0 is to allow a few small breakages like
>> these. You could always write an RFC patch and generate some discussion;
>> I'm not 100% sure that there are enough people that agree with us to
>> change the default.
>
> The intent of 1.7.0 is to fix usability glitches and warts that everybody
> has long agreed are problematic.  People have *just started* discussing
> about this---it is not remotely close to "everybody has long agreed are
> problematic" criteria.  It is too late for 1.7.0.

I just wanted to see if I am being fair.  Here are the topics that we may
have in 1.7.0.

 * jc/1.7.0-push-safety

   Prevents gremlin updates from sideways to a repository with a work
   tree, that confused countless new people.  I've resisted this change
   for a long time on the backward compatiblity ground, but it is very
   fair to say that it was long agreed that the benefit from the change
   far outweigh the donesides of having to say "I do want the old
   behaviour" by setting an configuration variable or two.

 * jc/1.7.0-send-email-no-thread-default

   Defaults multi-message send-email to thread shallowly.  This change was
   requested by kernel folks for a long time ago, and discussion on-list
   resulted in a declaration that unless nobody objects 1.6.2 release
   notes will say the default will change in 1.6.3.  We did not hear any
   objection, but the switchover did not happen ;-).

 * jc/1.7.0-status

   Everybody hated that "status $args" being "commit --dry-run $args"
   since 1.4.0 days.  We will give "commit --dry-run $args" in 1.6.5.

 * jc/1.7.0-diff-whitespace-only-status

   We said "diff -w" only affects the appearance but not the exit code, so
   "diff -w --exit-code" never returned success if there were only
   whitespace changes.  It was noticed to be illogical since day one
   of the introduction of --exit-code, but we simply did not bother to fix
   the implementation of -b and -w, since the combination of these two
   options were thought to be unlikely, and we were simply lazy ;-)

I think the first three are clearly 1.7.0 candidates, judging from the
benefit/downside perspective and also from the escape-hatch perspective,
The last one is probably less so, but on the other hand it is of far
lessor impact that we could even roll it out as a bugfix on 'maint'.
