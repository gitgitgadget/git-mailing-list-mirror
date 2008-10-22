From: Andreas Ericsson <ae@op5.se>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 11:54:48 +0200
Message-ID: <48FEF868.2010802@op5.se>
References: <20081022061730.GA5749@elte.hu> <48FEE5B3.9060202@op5.se> <20081022090010.GC4369@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Oct 22 11:57:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsaSE-0002UM-7z
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 11:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYJVJzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2008 05:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbYJVJzF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 05:55:05 -0400
Received: from mail.op5.se ([193.201.96.20]:41556 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbYJVJzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 05:55:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1FF4C24B0009;
	Wed, 22 Oct 2008 11:48:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.915
X-Spam-Level: 
X-Spam-Status: No, score=-3.915 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.484, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QtyNGJwirZgh; Wed, 22 Oct 2008 11:48:31 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7F3F01B8006D;
	Wed, 22 Oct 2008 11:48:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081022090010.GC4369@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98854>

Ingo Molnar wrote:
> * Andreas Ericsson <ae@op5.se> wrote:
>=20
>> I imagine you'd want to use it to find out which branches you can (o=
r=20
>> can't) merge, and in that case you need to know about all the topics=
=20
>> which have the commit. Assuming you don't go crazy cherry-picking an=
d=20
>> criss-cross merging, it should only list a few. The output is not as=
=20
>> fancy as below, but it should be faster than the appended script (by=
=20
>> several orders of magnitude).
>=20
> i solved that particular problem quite well, based on suggestions in =
a=20
> thread earlier on the git-list. I'm using git branch --no-merged:
>=20
>  earth4:~/tip> time todo-merge-all
>  merging the following updated branches:
>  merging linus ... ... merge done.
>=20
>  real    0m2.865s
>  user    0m2.580s
>  sys     0m0.228s
>=20
> that work step used to be over a minute! There are 233 topic branches=
 at=20
> the moment and 18 integration branches. Kudos for making this go real=
ly=20
> fast in 1.6.0.
>=20
> the thing i'm after is to see the originator branch of changes. "git=20
> name-rev" was suggested by Santi B=E9jar in this thread and that is=20
> exactly what i need - i'll try to integrate it into some git-log-ish=20
> output tool.
>=20
> One thing i noticed is that 'git name-rev' can be quite slow for cert=
ain=20
> commits:
>=20
>  earth4:~/tip> time git name-rev 948f984
>  948f984 tags/tip-safe-poison-pointers-2008-05-26_08_52_Mon~1
>=20
>  real    0m2.181s
>  user    0m2.068s
>  sys     0m0.092s
>=20
> Which seems natural since it might have to dive back into history and=
=20
> cross-reference it to all names. (there's 400 branches and 450 tags i=
n=20
> this tree, so i'm certainly pushing things!)
>=20
> But if i use that in my git-log-line summary tool it might become=20
> quadratic overhead (or worse) very quickly, with minutes of runtime.
>=20

What's the timing for "git branch --contains 948f984" ?

"git name-rev" parses a lot more just to be able to print a pretty
short-name (the reversed "git describe") for you to use.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
