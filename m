From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Wed, 10 Jun 2009 14:17:11 -0700
Message-ID: <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	<c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
	<c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
	<4A2E7EEC.2050807@zytor.com>
	<c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>
	<7viqj5kutl.fsf@alter.siamese.dyndns.org>
	<c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVAe-0005Wg-KT
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 23:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262AbZFJVRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbZFJVRK
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 17:17:10 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59960 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353AbZFJVRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 17:17:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610211711.XZBJ17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Jun 2009 17:17:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2MHB1c0054aMwMQ04MHBzK; Wed, 10 Jun 2009 17:17:11 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=ZlvubiwuF4QA:10 a=BRJNLUJM0I0A:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=MFI62xztkyXRtmhZKsQA:9
 a=B_q4c0R_kYzL_laJC_J8zYKivuAA:4 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com> (Christian Couder's message of "Wed\, 10 Jun 2009 21\:37\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121301>

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Jun 9, 2009 at 10:37 PM, Junio C Hamano<gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> My opinion is that we should not penalize all the people working on
>>> "quite clean" projects and also people working on "not clean" projects
>>> who are able to recover, on the pretence that there are other people
>>> on these "not clean" projects who are not.
> ...
> When I wrote "clean", I just mean with not too many untestable commits.

Ok, then the "opinion" in the above paragraph was simply stating the
obvious: we should have a good "bisect skip".  I obviously agree with that
;-).

In other words, you were not arguing against my observation that your
algorithm would not be much better than randomly picking the next commit
when the best one is untestable, unless the history is linear.  I guess
that was what I was confused with.  I thought you were saying that we
should give preferential treatment to people with linear history. 

> Ok. I started working on optionaly using a PRNG but I am not sure that
> you will want to add another one.

It may still make sense to replace, not add to, that "fixed alternating
distance in goodness space" with a randomized one, for the reasons HPA
stated, especially for avoiding to give a false impression that the magic
constants are picked for some reason.
