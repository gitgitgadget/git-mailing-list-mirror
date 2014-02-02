From: John Keeping <john@keeping.me.uk>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 2 Feb 2014 12:24:32 +0000
Message-ID: <20140202122432.GC29976@serenity.lan>
References: <87a9e92424.fsf@fencepost.gnu.org>
 <CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
 <8761ox2240.fsf@fencepost.gnu.org>
 <20140202113141.GB29976@serenity.lan>
 <87wqhdzqo3.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 02 13:25:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9w6l-0008Ag-UL
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 13:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbaBBMYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 07:24:41 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:56872 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaBBMYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 07:24:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 549E26064A5;
	Sun,  2 Feb 2014 12:24:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bNRfMy0V-Bc3; Sun,  2 Feb 2014 12:24:39 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id C77706064E4;
	Sun,  2 Feb 2014 12:24:39 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id BF01D161E4C0;
	Sun,  2 Feb 2014 12:24:39 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8P3Iok-RYwDM; Sun,  2 Feb 2014 12:24:39 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 32E62161E27F;
	Sun,  2 Feb 2014 12:24:34 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <87wqhdzqo3.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241370>

On Sun, Feb 02, 2014 at 12:42:52PM +0100, David Kastrup wrote:
> John Keeping <john@keeping.me.uk> writes:
>=20
> > On Sun, Feb 02, 2014 at 12:19:43PM +0100, David Kastrup wrote:
> >> Duy Nguyen <pclouds@gmail.com> writes:
> >>=20
> >> > The file is for past commits only.
> >>=20
> >> > New commits can contain these info in their messages.
> >>=20
> >> If it's not forgotten.  Experience shows that things like issue nu=
mbers
> >> have a tendency to be omitted, and then they stay missing.
> >>=20
> >> At any rate, this is exactly the kind of stuff that tags are usefu=
l for,
> >> except that using them for all that would render the "tag space"
> >> overcrowded.
> >
> > Actually, I would say this is exactly the sort of thing notes are f=
or.
> >
> > git.git uses them to map commits back to mailing list discussions:
>=20
> But that's the wrong direction.  What is needed in the Emacs case is
> mapping the Bazaar reference numbers (and bug numbers) to commits.

Ah, OK.  I hadn't quite read carefully enough.

I actually wonder if you could do this with notes and git-grep; for
example:

    git grep -l keeping.me.uk refs/notes/amlog |
    sed -e 's/.*://' -e 's!/!!g'

That should be relatively efficient since you're only looking at the
current notes tree.

> While it is true that the history rewriting approach would not delive=
r
> this either (short of git log --grep with suitable patterns), I=A0was
> looking for something less of a crutch here.
>=20
> > Notes aren't fetch by default, but it's not hard for those interest=
ed
> > to add a remote.*.fetch line to their config.
>=20
> If we are talking about measures everybody has to actively take befor=
e
> getting access to functionality, this does not cross the convenience
> threshold making it a solution preferred over others.  But it's proba=
bly
> feasible to configure a fetch line doing this that will get cloned wh=
en
> first cloning a repository.

I'm assuming you'll need some form of tool (at least a script) to
manipulate this feature; it wouldn't be too hard for that to set this u=
p
the first time it's run.
