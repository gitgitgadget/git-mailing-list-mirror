From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: how to fix the problem correctly?
Date: Wed, 28 Apr 2010 14:30:01 -0400
Message-ID: <s2v32541b131004281130m1c79ff4dp8c02afc8b70bbde5@mail.gmail.com>
References: <w2t76c5b8581004280954r436c1be1g8d6e415bf3596f4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 20:30:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7C1m-0001Mi-4F
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 20:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab0D1SaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 14:30:24 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:36746 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab0D1SaX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 14:30:23 -0400
Received: by ywh32 with SMTP id 32so8644539ywh.33
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RPBRsnRRkx2P7s8ilrXTfkcDQLsjbbNm3surxKJVtdY=;
        b=HNOL9RvsG9L1vAm9RC2cjTnJRZ9BLnAmE3rHFVgnmYix4WpI3A0isGUKADEny9RuaQ
         bjmYtFsfj2LII7QyasAsj1w5UiMv7Evpo2/DWmEB2SIWuHB9p2cTZj7L4Zsjn5gmaGoa
         BgDU7cyLcB63+2PC1YmJGkMl8TA5LvgF57AuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s6QhrSK3g6qgOWa0Ws/1ULEax5H8J34DN9BxyrAn0fOjinUsFiXdJNi1u6DEelmg22
         RquxByXk99SNbkrwP8TqeMLLBQRuYFz0l7E+Ucc0gRHOHOViaB9GnpBwPI47WG4kV92h
         V9kT6f7sG2xNLL3veb2AazR/6vm/+gcrYWP/8=
Received: by 10.150.194.20 with SMTP id r20mr227140ybf.7.1272479421969; Wed, 
	28 Apr 2010 11:30:21 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Wed, 28 Apr 2010 11:30:01 -0700 (PDT)
In-Reply-To: <w2t76c5b8581004280954r436c1be1g8d6e415bf3596f4d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146002>

On Wed, Apr 28, 2010 at 12:54 PM, Eugene Sajine <euguess@gmail.com> wro=
te:
> Between B and C the version of file 1.txt was screwed up (let=92s say=
 it
> was copied into git repo from other location where it was in state A
> (CVS) and then committed by mistake in C, effectively reverting the
> change of this file in commit B)
> Commit C also had changes to files 2 and 3.
> After this commits D and E did not have changes for file 1.txt, only =
2
> and 3 were touched.
>
> When we tried to revert commit C =96 this lead to the code completely
> messed up, with conflicts =96 so this seems to be not an option.
> Rebase also doesn=92t seem to help here
>
> Only two variants I saw:
> 1. Do =93git co A 1.txt=94 and commit the change as F
> 2. Do =93git reset =96soft master=94 and recommit all changes once ag=
ain
>
> Is there a better way?

Virtually any way that works is "correct."  It depends a bit on your go=
als.

Step 1 is certainly the easiest place to start.  If you're then
concerned about making sure your history never showed the mistake
(which is a lofty goal, though rarely very important), you could use
git rebase to 'squash' this new commit into C.  But rewriting history
in git has well-documented dangers, so you should be careful and read
the docs first.

> PS interesting enough =96 CVS keywords helped us to notice the proble=
m
> as master state was imported from CVS.
> In commit A file 1.txt had version ID 1.5 in commit B it was 1.6 ,
> commit C was changing the line back to 1.5
> Is there a way for git to help me to recognize this kind of issue if
> there are no keywords?

Sadly, git doesn't have any magic features for detecting when someone
checks in something stupid :)   But 'git bisect' can be very helpful
in isolating which commit caused a particular problem.  Once you know
you have a problem, it's pretty easy to narrow it down that way.

Have fun,

Avery
