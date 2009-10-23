From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect Vs branch
Date: Fri, 23 Oct 2009 11:29:10 -0700
Message-ID: <7vd44ec6bt.fsf@alter.siamese.dyndns.org>
References: <4AE07EEB.2010101@maxim-ic.com>
 <adf1fd3d0910220950s50ccf8efwda891374e6480a30@mail.gmail.com>
 <4AE156A9.9060809@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: =?utf-8?B?R3LDqWdvcnkgUm9tw6k=?= <gregory.rome@maxim-ic.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 20:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1OtB-0003Ts-2L
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 20:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZJWS3O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbZJWS3O
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 14:29:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbZJWS3N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 14:29:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 943E664D3A;
	Fri, 23 Oct 2009 14:29:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RK2fM0lyjeYC
	uAJBYcY8N8YGWb0=; b=GxgsA6yFZzPHawtI2UO3xv7c8Ww5STJDIsdezPp0ldm3
	g1uUgt6EzQyYPspH7pGHBec2iARpQQDv3MKXZhGoz9MO/h9xdf7SXjxlnPybL0sx
	f4R46aJvnChFZ8EhaRKXZc2pQK3xNaoCkkNheL/9EGqxt+25w/lKNrtO5vxX82w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p89JhV
	oHdxek9MKRXw3YlzekUX4i09KWrwOE9S4mjt9X2ZHbYPHam5ARu6Q3BYMuZtVvjD
	c9pn8Ebmf89Xq5aU+c76ROmt9YTWn7pztCAZA1NlX5hvj2lCA6bNJZJf4YO/veDQ
	J9oqkZmLv2bxNLCGIGfdAZYgOfRaASP+XO2I4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5645B64D38;
	Fri, 23 Oct 2009 14:29:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92A5464D37; Fri, 23 Oct
 2009 14:29:12 -0400 (EDT)
In-Reply-To: <4AE156A9.9060809@maxim-ic.com> (=?utf-8?Q?=22Gr=C3=A9gory_Ro?=
 =?utf-8?Q?m=C3=A9=22's?= message of "Fri\, 23 Oct 2009 09\:09\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F7D73E78-C001-11DE-96E2-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131113>

Gr=C3=A9gory Rom=C3=A9 <gregory.rome@maxim-ic.com> writes:

> Thanks Santi but I have a problem, due to the fact that the commit
> which has an impact on my code is in origin/master or
> first-origin/master
>
> When bisect checkout a commit from those branch I have none of my own
> modifications... So I can' test if my code is good or bad excepted if
> I can merge my commits in the bisect branch...
>                                                     =E1=90=81
> first-origin/master  *---A---------B----------------o------C-
>                           \         \                       \
> origin/master              ----------B'----------U-----------C'-
>                                       \           \           \
> master                                 ------------U'----------C''-
>
>
> I generalized the problem but I can give a real example. My problem
> concerns an Linux USB driver for MIPS based SoC. first-origin is the
> official kernel repository and origin/master is the MIPS repository.

So the breakage is about the feature you added on your tree, which neit=
her
of the grandparent upstream nor your direct upstream has. U' worked, C'=
'^1
(i.e. immediately before you merged from your direct upstream at C'')
worked, and C'' doesn't.

This happens when a commit in the upstream (either in your direct upstr=
eam
or its upstream) changed the semantics of a function (or a variable's
value) in such a way that it invalidates some assumption that your code
has been relying on.

You can restate the problem into a slightly different form:

 - If I merge C' to my master (C''^1), it breaks;

 - If I merge U to my master (C''^1), it works;

 - Starting from (U =3D good, C' =3D bad) pair, find the first "bad" co=
mmit,
   where the badness is defined as "when it is merged to C''^1, it
   breaks".

The restated problem is "where in their code did they change something
that breaks my code?"

You do not have to make a merge in the repository you are bisecting in.
=46or example, I would try something along this line:

    $ git clone . ../test-build ;# make a build directory
    $ M=3D$(git rev-parse master^1) ;# before the latest merge
    $ U=3D$(git merge-base $M origin/master)
    $ git bisect start
    $ git bisect bad origin/master
    $ git bisect good $U

This will check out one commit between U and C' (that will include comm=
its
beetween B and C, as they are reachable from C' but not from U) for you=
 to
test.  Since the condition you are testing is "Does the result of mergi=
ng
a commit to $M work?", you check exactly that condition:

    $ H=3D$(git rev-parse HEAD)
    $ cd ../test-build
    $ git reset --hard
    $ git checkout $M
    $ git merge $H
    ... do your testing here ...

And go back to the repository you are bisecting, and tell the result to
bisect to continue:

    $ cd -
    $ git bisect good ;# or bad

And do the same for the next commit to be tested.

The result will tell you which commit in the upstream changed the
semantics of what you were relying on under you, and by examining that
change, hopefully you will know how to adjust your code to the new worl=
d
order the upstream (re-)defines.
