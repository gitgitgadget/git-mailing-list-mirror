From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs Monotone)
Date: Thu, 31 Jul 2008 17:10:50 -0400
Message-ID: <32541b130807311410w6884c303i9f89fea3887f934b@mail.gmail.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
	 <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
	 <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
	 <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
	 <20080731205400.GA7911@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	"Git Mailinglist" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfRC-0005fl-AW
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbYGaVKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 17:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbYGaVKx
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:10:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:13618 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbYGaVKw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 17:10:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so453571ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 14:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IwkZnnwEEu4mfmCFA9V3VyQBaYZH09LXIUWuG3RG9Os=;
        b=xd1keqZuJi0oFY26MWqcbICnXyullPXdwsGB/lhsrFTwNp+IJzq+mQVxmPNuIA1Ind
         LsDBc1DqrGTfa2QrD/Hx9wvy7IcS6bVL49H6FfWL1LqyhNAKxDv+RN1t/N8YZFrmakkp
         WUdV3wguDL+s0ak0d81e3YzFFGSComn5Tsicc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BWdREvAwc73zgAd6OvuYRCuIM/+a7T64OoN597a9G2uGu/fvoTQbVFrt15G/KsdNKu
         gTG/cJoj5ulK31Eesf3krnOujvTwuB+ObJJEdVlROD2Fz4cDzRUQGP58MwIvh97bChOQ
         6wZE+ra8N3WwIvPaH4EYPGhGmbzbykchChHpg=
Received: by 10.151.147.17 with SMTP id z17mr1923784ybn.74.1217538650631;
        Thu, 31 Jul 2008 14:10:50 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Thu, 31 Jul 2008 14:10:50 -0700 (PDT)
In-Reply-To: <20080731205400.GA7911@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90992>

On 7/31/08, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
>  Maybe even better:
>
>  mkdir local-mirror
>  cd local-mirror
>  git --bare init
>  git remote add -f --mirror origin <central-repo-over-network>
>
>  A cronjob (or whatever) could keep the local mirror up-to-date and t=
he
>  other repos can fetch from there. Pushing would need to go to a
>  different remote then though.. Humm... Maybe not worth the trouble f=
or a
>  bit of additional object sharing.

What would be *really* great is if we could find a way for multiple
local clones to share the same objects, refs, and configuration - ie.
without pushing and pulling between them at all.  Then they could
*all* point at the remote upstream repo through "origin", and
pushing/pulling with that repo would update the objects and refs for
all the local repos.

I'm not sure of the best way to do this, though.  In particular, it
seems like having multiple work trees checked out on the same ref
could be problematic.

Is that just what git-new-workdir is for?  (It seems to be
undocumented so it's hard to tell.)  And what about this
=2Egitlink/.gitfile stuff I've heard about?  Could I use that to have
multiple work trees share the same .git folder?

Thanks,

Avery
