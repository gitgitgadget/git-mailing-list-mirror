From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Cherry-pick with symlinks fails horribly
Date: Thu, 25 Mar 2010 06:01:44 +0100
Message-ID: <201003250601.44871.chriscool@tuxfamily.org>
References: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com> <201003120448.22821.chriscool@tuxfamily.org> <7vljdyt7h8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufDv-00029B-AI
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0CYFDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:03:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49272 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab0CYFDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:03:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4A58A81802D;
	Thu, 25 Mar 2010 06:02:59 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 29931818039;
	Thu, 25 Mar 2010 06:02:57 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vljdyt7h8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143152>

On Friday 12 March 2010 06:49:23 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Anyway when looking at t/t6035-merge-dir-to-symlink.sh, we can see that
> > there are still 2 broken tests:
> >
> > $ ./t6035-merge-dir-to-symlink.sh
> > ...
> > *   ok 5: do not lose a/b-2/c/d in merge (resolve)
> > *   still broken 6: do not lose a/b-2/c/d in merge (recursive)
> > *   ok 7: setup a merge where dir a/b-2 changed to symlink
> > *   ok 8: merge should not have conflicts (resolve)
> > *   still broken 9: merge should not have conflicts (recursive)
> > * still have 2 known breakage(s)
> > * passed all remaining 7 test(s)
> >
> > So it looks like breakages in this area are known, though perhaps not
> > your particular breakage.
> 
> The above shows that resolve passes the same tests that recursive fails,
> which means that the breakage is likely to be in recursive, and not in
> unpack-trees, as you seemt to have guessed earlier.  

Yes, you are right the breakage is in recursive as it works with resolve.

> If cherry-pick were
> still a shell script, we could easily test that conjecture by letting you
> try running it using resolve instead of recursive, but things like that
> has got a lot harder to do these days since many things were rewritten in
> C (sigh).
> 
> It might not be a bad idea to teach a hidden primarily-for-debugging
> option to "cherry-pick" to let it use resolve instead of recursive for
> cases like this.

I will send an RFC patch series to do that. I used it to check that the test 
case works with the resolve strategy.

Best regards,
Christian.
