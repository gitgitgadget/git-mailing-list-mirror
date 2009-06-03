From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] make it possible to skip away from broken commits
Date: Wed, 03 Jun 2009 00:10:12 -0700
Message-ID: <7vbpp5dc8b.fsf@alter.siamese.dyndns.org>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org>
	<7vmy8qe4ru.fsf@alter.siamese.dyndns.org> <4A25EA85.5090208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 09:10:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBkc8-0001X0-Ln
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 09:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbZFCHKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 03:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753238AbZFCHKM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 03:10:12 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64206 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbZFCHKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 03:10:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603071013.USJJ17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jun 2009 03:10:13 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id zKAC1b0094aMwMQ04KACCT; Wed, 03 Jun 2009 03:10:12 -0400
X-Authority-Analysis: v=1.0 c=1 a=jiczcZSvnhMA:10 a=FbtlXE8tIuYA:10
 a=oGMlB6cnAAAA:8 a=dIu3SnmMAAAA:8 a=fL7M6HJXd7qi-BCYpboA:9
 a=ydJOrxCWNi5VsRdIjGc1Jx9LoWEA:4 a=CY6gl2JlH4YA:10 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120588>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> 
>>> This patch series adds a "--ratio=x/y" option to "git bisect skip" so
>>> that it is possible to skip away from an area were the commits cannot
>>> be tested.
>>>
>>> Note that in this series "--ratio=4" means the same as "--ratio=1/4".
>>> But I am not sure if this shortcut is worth it.
>> 
>> Actually my gut feeling is that a tweakable knob itself is worth it,

I meant "is not" worth it.

>> because the user can never tell what the right value should be.
>> 
>> ...  Why not use a constant ratio (or perhaps a pair of alternating
>> ratios) on "bisect skip" without any new options?
>
> I would agree with this assessment....

Thanks for reading what I meant to say, even though I said quite opposite
to what I meant to say ;-)

> When one gets down to a small number of points this could get weird, but
> as long as skip points are filtered (which looks like it's already being
> done) it should converge.

Yes; I think "the next point" selection after "skip" is (or at least can
be handled as) a local thing.  As long as the next point selection is not
too close to the known-to-be-untestable commit we will have a reasonable
coverage over the remainder of the history.  Also I suspect that trying to
be too clever will not help us very much and the end result would be
affected more heavily by the distribution of untestable commits than how
well these next points are chosen.
