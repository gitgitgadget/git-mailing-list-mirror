From: Michael Olson <mwolson@gnu.org>
Subject: Re: [PATCH/RFC 0/2] git-svn: Allow certain refs to be ignored
Date: Wed, 21 Apr 2010 09:31:09 -0700
Message-ID: <m2wc8b3bef91004210931xc0a7ec58ycbf18dd37d5e98f0@mail.gmail.com>
References: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com> 
	<7vbpddekwk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 18:31:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4cps-0008J9-IC
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 18:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab0DUQbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 12:31:31 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41134 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab0DUQba convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 12:31:30 -0400
Received: by vws18 with SMTP id 18so111681vws.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 09:31:29 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Wed, 21 Apr 2010 09:31:09 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
In-Reply-To: <7vbpddekwk.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 5cd3acdd2aa29fb2
Received: by 10.220.108.7 with SMTP id d7mr5914895vcp.41.1271867489137; Wed, 
	21 Apr 2010 09:31:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145440>

On Tue, Apr 20, 2010 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Michael Olson <mwolson@gnu.org> writes:
>
>> [svn-remote "svn"]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D https://svn.my.org/svn/root
>> ...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ignore-refs =3D ^refs/remotes/(tags/)?old=
/myorg
>
> Traditionally configuration variable names are spelled camelCase with=
out
> dashes. =C2=A0You probably would want to be consistent.

I was looking at the existing syntax for "ignore-paths", which uses
dashes.  Should that be changed as well?

> Also "refs" and any pathname-like things are traditionally matched us=
ing
> globs and not regexes. =C2=A0It is Ok to deviate if you have a strong=
 reason to
> (and I suspect it would make it easier to write "exclude" patterns li=
ke
> the above example to allow a regex here), but that needs to be promin=
ently
> documented (e.g. "Unlike any other ref-matching configuration variabl=
e,
> this alone uses regex, not glob") to avoid end user confusion.

ignore-paths also uses a regex.  I'm concerned that using globs will
not be expressive enough to represent a regex like (a combination of
the 2 use cases I posted initially):

^refs/remotes/((tags/)?old/myorg|old/bad_branch|old/unlabeled[^/]*|tags=
/(old/bad_tag|releases/another_tag))$

--=20
Michael Olson  |  http://mwolson.org/
