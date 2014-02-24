From: "Paul Lotz" <plotz@lsst.org>
Subject: RE: difftool sends malformed path to exernal tool on Windows
Date: Mon, 24 Feb 2014 09:44:23 -0700
Message-ID: <000801cf317f$ac1be2b0$0453a810$@lsst.org>
References: <011301cf2c2d$90442810$b0cc7830$@lsst.org> <20140221103821.GA21414@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'David Aguilar'" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHydo-0003co-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbaBXQoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 11:44:25 -0500
Received: from mail.lsstcorp.org ([140.252.15.63]:24656 "EHLO mail.lsst.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbaBXQoY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 11:44:24 -0500
Received: from PaulLaptop ([140.252.119.210]) by mail.lsst.org with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Feb 2014 09:44:23 -0700
In-Reply-To: <20140221103821.GA21414@gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKjFvigrE20EroY6kKNjpOQ6fvyewFLrX1WmRJynPA=
Content-Language: en-us
X-OriginalArrivalTime: 24 Feb 2014 16:44:23.0502 (UTC) FILETIME=[AC19E6E0:01CF317F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242611>

David,

Thanks for the helpful reply.

As you suggested, I modified the .gitconfig file to have:
[difftool "test"]
	cmd =3D echo \"$LOCAL\" \"$REMOTE\"

and ran
$ git difftool -t test

An example of the the resulting console output is:
C:/Users/Paul/AppData/Local/Temp/I8L2Bc_WriteTestParameters.vi Commands=
/StartAutomatedTest/WriteTestParameters.vi

Paul

-----Original Message-----
=46rom: David Aguilar [mailto:davvid@gmail.com]=20
Sent: Friday, February 21, 2014 3:38 AM
To: Paul Lotz
Cc: git@vger.kernel.org
Subject: Re: difftool sends malformed path to exernal tool on Windows

On Mon, Feb 17, 2014 at 03:14:01PM -0700, Paul Lotz wrote:
> From the Git Bash command line, I enter $ git difftool
>=20
> and type =E2=80=98y=E2=80=99 when the file I want to difference appea=
rs.  Git=20
> correctly calls the external diff tool (LVCompare.exe), but the path=20
> for the remote file Git passes to that tool is malformed (e.g.,=20
> C:\/Users/Paul/AppData/Local/Temp/QCpqLa_calcLoadCellExcitation.vi).
> Obviously the \/ (backslash forwardslash) combination is incorrect.

If this is the case then difftool is not the only one with this problem=
=2E

We use the GIT_EXTERNAL_DIFF mechanism to run difftool under "git diff"=
, so it may be that the paths are mangled by "git diff" itself.
I don't really know enough about msysgit to know for sure, though.

What do you see if you create a dummy tool which just does "echo"?

[difftool "test"]
	cmd =3D echo \"$LOCAL\" \"$REMOTE\"

Then run:

$ git difftool -t test

> For the record, I have successfully made calls to LVCompare.exe=20
> manually from a Windows command prompt directly (without Git).
>=20
> The relevant portion of the .gitconfig file is:
> [diff]
>      tool =3D "LVCompare"
> [difftool "LVCompare"]
>      cmd =3D 'C:/Program Files (x86)/National Instruments/Shared/LabV=
IEW=20
> Compare/LVCompare.exe' \"$LOCAL\"  \"$REMOTE\"
>=20
>=20
> For the record, the operating system is Windows 8.1.

Do any msysgit folks know whether GIT_EXTERNAL_DIFF is a known issue?
--
David
