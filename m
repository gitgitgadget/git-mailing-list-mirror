From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 02 Nov 2011 11:53:22 +0100
Message-ID: <4EB12122.7010803@drmicha.warpmail.net>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com> <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Wed Nov 02 11:53:38 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLYRt-0005tm-BK
	for lnx-linux-ide@lo.gmane.org; Wed, 02 Nov 2011 11:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab1KBKxg (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Wed, 2 Nov 2011 06:53:36 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58754 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752143Ab1KBKxf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2011 06:53:35 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DFA4620FE9;
	Wed,  2 Nov 2011 06:53:34 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 02 Nov 2011 06:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=A37YnJdafeqNbKaATrHxqL
	OdrNA=; b=HWrVkss0+p3baCrEj25ebn/F9Wdz6TwJnOJrVUXH7RmUKWckYO2kcf
	Z5GMYJJKvs8HpIXvjsxZ5tGGXu05WW7aOonPpLggXKaH7aCJBPjWyRW2nt4v8K3c
	tnntKfMQRwnJbNSS3SPRxIiCc7RxkjfzhpcgzcnuMdykusqSwuBgU=
X-Sasl-enc: LYd+91UGSjdk4U8KllJikXu+i0xoqCcp49C4rK4em5Gz 1320231214
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AF46A8E1008;
	Wed,  2 Nov 2011 06:53:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184627>

Junio C Hamano venit, vidit, dixit 01.11.2011 20:47:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> But what would be nice is that "git pull" would fetch the tag (based on
>> name) *automatically*, and not actually create a tag in my repository at
>> all. Instead, if would use the tag to check the signature, and - if we
>> do this right - also use the tag contents to populate the merge commit
>> message.
>>
>> In other words, no actual tag would ever be left around as a turd, it
>> would simply be used as an automatic communication channel between the
>> "git push -s" of the submitter and my subsequent "git pull". Neither
>> side would have to do anything special, and the tag would never show
>> up in any relevant tree (it could even be in a totally separate
>> namespace like "refs/pullmarker/<branchname>" or something).
> 
> While I like the "an ephemeral tag is used only for hop-to-hop
> communication to carry information to be recorded in the resulting
> history" approach, I see a few downsides.
> 
>  * The ephemeral tag needs to stay somewhere under refs/ hierarchy of the
>    lieutenant's tree until you pick it up, even if they are out of the way
>    in refs/pullmarker/$branchname. The next time the same lieutenant makes
>    a pull request, either it will be overwritten or multiple versions of
>    them refs/pullmarker/$branchname/$serial need to be kept.

If we are interested in commit sigs, the easiest tag-based approach is
to name the sig carrying tag by the commit's sha1. Just like the sig is
tied (in)to a commit in Junio's approach, it would be indexed by it. We
can do that now:

git config --global alias.sign '!f() { c=$(git rev-parse "$1") || exit;
shift; git tag -s $@ sigs/$c $c; }; f'

But a different place rather than refs/tags/sigs/<sha1> will be more
appropriate, so that we don't pollute the tag namespace. (Yes, this is
similar to storing them in notes.) tags have a message etc.

With an appropriate refspec, these sigs can be pushed out automatically
(by the lieutenant).

pull-request as in next will list the expected <sha1> at tip.

git pull needs to learn to (fetch and) use refs/<whatever>/<sha1> to
verify that the tip is signed.

git log --show-signature can do the same tricks as with in-commit sigs.

Some things to decide in this approach:
- Should git-pull (pull sigs and) verify by default?
- Should we worry about overwriting existings sigs? We have union-merge
for notes already, and that would be appropriate for sigs. (Yes, our
tags code does verify multiple concatenated sigs.)

The advantage of tags is that they can be added without rewriting the
commit, of course.

Michael
