From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Fri, 5 Mar 2010 18:32:15 +0100
Message-ID: <201003051832.16001.chriscool@tuxfamily.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org> <7vmxynydac.fsf@alter.siamese.dyndns.org> <7vk4trlhim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 18:33:21 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnbOp-0008Tr-9F
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 18:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab0CERdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 12:33:14 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48466 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab0CERdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 12:33:13 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E7BCD818156;
	Fri,  5 Mar 2010 18:33:06 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0A03F818218;
	Fri,  5 Mar 2010 18:33:04 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vk4trlhim.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141591>

On Friday 05 March 2010 01:49:21 Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> >     $ git branch branch2                        <2>
> >
> > I take it that this is supposed to be "checkout -b branch2".
> >
> >     $ git reset --keep start                    <3>
> >     ------------
> >
> >     <1> This commits your first edits in branch1.
> >     <2> This creates branch2, but unfortunately it contains the previous
> >     commit that you don't want in this branch.
> >     <3> This removes the unwanted previous commit, but this keeps the
> >     changes in your working tree.
> >
> > The above sequence is not very convincing.  After you edited the second
> > time, you create branch2 and that is presumably because you realized that
> > the change in the work tree belongs to a separate topic.  It would be a
> > lot more natural to do this:
> >
> >     $ git tag start ;# we do not have to tag, but just to make the
> >                        remainder of the illustration easier to read...
> >     $ git checkout -b branch1
> >     $ edit	    ;# do the work for the first topic
> >     $ git commit    ;# and commit
> >     $ edit          ;# start working more and then realize that the
> >     		       change belongs to a separate topic, and the previous
> >                        commit is unrelated to that new topic
> >     $ git checkout -b branch2 start
> >     $ edit          ;# continue working
> >     $ git commit    ;# and conclude it
> >
> > so the example makes the use of "reset --keep" look artificial.
> 
> Nah, what was I thinking.  If I rephrase your side note <2> and <3> a
> little bit, everything makes sense.  Perhaps like so:
> 
>     <2> In the ideal world, you could have realized that the earlier
>     commit did not belong to the new topic when you created and switched
>     to branch2 (i.e. "git checkout -b branch2 start"), but nobody is
>     perfect.
> 
>     <3> But you can use "reset --keep" to remove the unwanted commit after
>     you switched to "branch2".
> 
> And it becomes very clear that "reset --keep" is a sensible way to recover
> from this mistake.  No need to do "read-tree -m -u" followed by "reset"
> anymore.
> 
> Do you think I finally understood what "reset --keep" is about?

Yes I think so. Thanks for that.

I will rework the documentation patch according to your remarks and perhaps 
Jonathan Nieder's remarks too.

Thanks both,
Christian.
