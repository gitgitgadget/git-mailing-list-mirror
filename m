From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 01:31:13 -0800
Message-ID: <7vejehux3y.fsf@gitster.siamese.dyndns.org>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	<8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
	<7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
	<200711231018.49322.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 10:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvUt7-0006LU-I6
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 10:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbXKWJbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 04:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbXKWJbX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 04:31:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:46946 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbXKWJbW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 04:31:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A9EC32EF;
	Fri, 23 Nov 2007 04:31:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A7AE97D3A;
	Fri, 23 Nov 2007 04:31:39 -0500 (EST)
In-Reply-To: <200711231018.49322.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 23 Nov 2007 10:18:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65882>

Jakub Narebski <jnareb@gmail.com> writes:

> On Thu, 22 Nov 2007, Junio C Hamano :
>> "Santi B=C3=A9jar" <sbejar@gmail.com> writes:
>>=20
>>> Sorry but I do not understand this. I think this two lines could be=
 equivalent:
>>>
>>> git push --bundle bundle.bdl "refs/heads/master:refs/remotes/bundle=
/master"
>>> git bundle create bundle.bdl refs/heads/master ^refs/remotes/bundle=
/master
>>=20
>> Interesting.
>>=20
>> 	$ git push $something ours:theirs
>>=20
>> has defined semantics for any value of $something.
>> ...
>> If bundle.bdl does not exist yet, it is like pushing into a
>> freshly initialized empty repository.
>
> But for that I think "git bundle" should learn new subcommand:
> "git bundle update", which would use refs existing in given
> bundle as prerequisites, and either update bundle (create anew
> or just concatenate next pack) or create incremental bundle.
>
> Something similar to incremental mode or update command of
> archivers...

I was disagreeing with Santi's "'push --bundle' and 'bundle
create' can be equivalent".  They can't be, as "push" is always
"update" and never "create".  So I do not quite get your "But for
that I think"; I think you are just agreeing with me.

Even if we taught "push" to create (which I doubt would happen
due to its security and administrative implications), it would
not make the two any closer to being equivalent.  For them to
become equivalent, we would need to have "push" unlearn how to
update, which would never happen ;-).
