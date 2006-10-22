From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 17:04:11 +0200
Message-ID: <200610221704.12416.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <87zmbozau2.wl%cworth@cworth.org> <845b6e870610220748q681984e8ld371c64a37b99544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Carl Worth" <cworth@cworth.org>, "Jan Hudec" <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 17:04:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gberr-0001s9-2u
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 17:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWJVPEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 11:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWJVPEA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 11:04:00 -0400
Received: from hu-out-0506.google.com ([72.14.214.233]:50413 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750741AbWJVPD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 11:03:59 -0400
Received: by hu-out-0506.google.com with SMTP id 28so816343hub
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 08:03:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R/T+cSppS7aoLhJFGTD4f6Ct44yXrcYqi8P++cQ53AdO38l4g6j+OpVWhUzuAxZTtQ3locBhe1mvWzRvVC6MxNorEPTTW3rnWmk0I5X5/zX84equqhbHZZbRDl2lh+YTvkzEyCIYJk1cboOdtoV3ull/Xmd0yHV0ujY1egL9Q7E=
Received: by 10.66.221.19 with SMTP id t19mr5588166ugg;
        Sun, 22 Oct 2006 08:03:57 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id y7sm2532414ugc.2006.10.22.08.03.57;
        Sun, 22 Oct 2006 08:03:57 -0700 (PDT)
To: "Erik =?iso-8859-1?q?B=E5gfors?=" <zindar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <845b6e870610220748q681984e8ld371c64a37b99544@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29760>

Erik B=E5gfors wrote:

> On 10/22/06, Carl Worth <cworth@cworth.org> wrote:
>>
>>         git log --no-merges mainline..featureA
>>
>> The mainline..featureA syntax literally just means:
>>
>>         the set of commits that are reachable by featureA
>>         and excluding the set of commits reachable by mainline
>>
[...]
>> And this syntax is almost universally accepted by git commands. so y=
ou
>> can visualize a chunk of the DAG with:
>>
>>         gitk mainline..featureA
>>
>> Or export it as patches with:
>>
>>         git format-patch mainline..featureA
>>
>> I haven't been able to find something similar in bzr yet. Does it
>> exist?
>=20
> If I understand you correctly, you'll get the same thing with "bzr mi=
ssing".
>=20
> $ bzr missing ../mainline/
> You have 1 extra revision(s):
> ------------------------------------------------------------
> revno: 2
> committer: Erik B=E5gfors <erik@bagfors.nu>
> branch nick: newbranch
> timestamp: Sun 2006-10-22 16:43:10 +0200
> message:
>   hepp
>=20
>=20
> You are missing 1 revision(s):
> ------------------------------------------------------------
> revno: 2
> committer: Erik B=E5gfors <erik@bagfors.nu>
> branch nick: mainline
> timestamp: Sun 2006-10-22 16:42:53 +0200
> message:
>   hej

That is (roughly) equivalent of
  $ git log mainline...featureA
(which would give all commits which are _either_ in mainline,
xor in featureA, although not separated; --topo-order might help), or
  $ git show-branch mainline featureA

> You can also run "bzr missing" with "--theirs-only" or "--mine-only"
> to get only one way.

That would be equivalent of
  $ git log mainline..featureA
(--theirs-only), or
  $ git log featureA..mainline
(--mine-only).

> To get the patches you can run "bzr bundle ../mainline", but then
> we're back to the discussion that it currently gives a "big patch" fo=
r
> viewing, but when you merge it, you get each revision separately.

What about
  $ gitk mainline..featureA
i.e. showing selected part of DAG in graphical history viewer?

And of course syntax is even more powerfull, e.g.
  $ git log maint master --not next
--=20
Jakub Narebski
Poland
