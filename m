From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 02:04:02 -0700
Message-ID: <7vaazqcry5.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <20091017075551.GA5474@atjola.homenet>
 <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
 <20091017084025.GC5474@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 17 11:04:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz5DC-0000aK-Nx
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 11:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbZJQJEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 05:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbZJQJEU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 05:04:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbZJQJET convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 05:04:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E99E7A97E;
	Sat, 17 Oct 2009 05:04:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MAfWWj/l67nW
	hozLBphWQCiF1Zg=; b=XA+r8OXiiEUZfsdSdhtByOJHGcj2D9NAropYFbSHFpg3
	Y+u2G8g8QPXto+f7gRstLlHn9oMfNsyX/CF8ZfpzRZ2SRYp30n2OaPay07Xu0L2r
	PvE+aKFqUNAJjjqxh6T4+jjYFoYop6jgs1kZfVSYQvKlcNbatoQ3kDwWG41Hs8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gqQrEF
	99qf3KgeINJKvdTXG/zMQ6nCBhlb9lf4uRbzi/rB5YeLcccbNm5WRQRBASjH7D4o
	rmEHTrniFhggugFhRM2+uTnrZJRF5MlpnfWv5LX0Zhlx2FRVN9CZ/ehkXZhYJjJc
	3CB/pB1b3RmPGAJOpLAss2oGqpmoNmrMRln1g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0714D7A97A;
	Sat, 17 Oct 2009 05:04:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 43D607A979; Sat, 17 Oct 2009
 05:04:04 -0400 (EDT)
In-Reply-To: <20091017084025.GC5474@atjola.homenet> (=?utf-8?Q?=22Bj=C3=B6?=
 =?utf-8?Q?rn?= Steinbrink"'s message of "Sat\, 17 Oct 2009 10\:40\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B2F4EB2-BAFC-11DE-864A-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130553>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Interestingly, I irregularly give advice to use "git stash; git
> checkout; git stash apply" instead of "git checkout -m" on #git, as t=
hat
> allows you to try again if you messed up the conflict resolution, and
> even allows you to completely go back to the initial state. Maybe tha=
t
> would be an option?

As I already said many times (here and elsewhere), "up" is an inferior =
and
more dangerous model we would be better off not following if we can.

It is not even entirely CVS/SVN's fault that their "scm up" is an error
prone operation.  They use a centralized model, in which there is _no_ =
way
to record your local modification and run a retryable merge, so they ha=
ve
an excuse to force users to do things in "work, then update without
recording wip anywhere" order.

You can afford to (and it is even more natural to) do things in "work,
save and then merge" order with git.  I simply cannot believe people wh=
o
advocate for helping uninitiated would even think of modelling any "use=
r
friendliness" features around "up" model.

The "save" part of the work-save-then-merge sequence should be made ver=
y
visible to help people get used to the "not up, but work-save-then-merg=
e"
mental model.  I do not think it would help people in the long run to m=
ake
the "save" step less visible by wrapping the sequence into an unreliabl=
e
"up" script, especially because the script would sometimes work but oth=
er
times *has to* force users to know that what is happening behind the sc=
ene
is work-save-then-merge in order to resolve and recover from conflicts
anyway.

> OTOH, it might be easier to just tell the user to do the stash thing
> himself. But I wonder how many users would really know how to get bac=
k
> to the initial state then.

I agree with the first sentence, but I do not understand what "the init=
ial
state" you talk about here in the second sentence, sorry.
