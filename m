From: Mircea Bardac <dev@mircea.bardac.net>
Subject: Re: possible 'git cp'/how does git detect copies
Date: Fri, 27 Jun 2008 14:16:41 +0100
Message-ID: <4864E839.7000204@mircea.bardac.net>
References: <4864DFB6.3050204@mircea.bardac.net> <8aa486160806270557w20ce622co1099bceec7bc90f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDuw-0004Sn-Tz
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYF0NWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 09:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbYF0NWN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:22:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:61646 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbYF0NWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:22:12 -0400
Received: by wr-out-0506.google.com with SMTP id 69so391441wri.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 06:22:11 -0700 (PDT)
Received: by 10.90.54.17 with SMTP id c17mr1648614aga.74.1214572931136;
        Fri, 27 Jun 2008 06:22:11 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id 34sm1327688agc.9.2008.06.27.06.22.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 06:22:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <8aa486160806270557w20ce622co1099bceec7bc90f9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86559>

Hi,

Santi B=C3=A9jar wrote:
> On Fri, Jun 27, 2008 at 14:40, Mircea Bardac <dev@mircea.bardac.net> =
wrote:
>> I was looking today at duplicating a file but, I soon realized that =
there is
>> no 'git cp' command (this was the "deductive approach to git command=
s",
>> starting from git mv/rm/...). How does "git diff -C" detect copies (=
-C is
>> used for this, according to the documentation)?
>=20
> Did you followed the "See also =E2=88=92=E2=88=92find=E2=88=92copies=E2=
=88=92harder."?

I knew this from before but for some reason I forgot about it when I=20
tried it now. The documentation for "git diff -C" is a bit misleading. =
I=20
have originally tested on git 1.5.2.something and the documentation for=
=20
-C didn't point to --find-copies-harder. I've quickly installed 1.5.6.1=
=20
to test the behavior but not the man pages.

Looking over the online docs for 1.5.6.1, it appears that there is now =
a=20
reference to --find-copies-harder.

Even so, saying just that "Detect copies as well as renames." is not=20
enough, as it assumes that there is no restriction on the detection pro=
cess.

 From --find-copies-harder
"For performance reasons, by default, -C option finds copies only if th=
e=20
original file of the copy was modified in the same changeset." should b=
e=20
moved to -C.

>> On a very simple test, I couldn't see this working. I just copied on=
e file,
>> added it, committed the change, ran "git diff -C HEAD^!". There is n=
o place
>> saying that it's contents is copied from some other file (both files=
 are in
>> the repository now).
>>
>> "git blame -C new_copied_file" also doesn't show the commits for the
>> original file.
>=20
> git blame -C -C new_copied_file

Ah, duplicating the parameter. Looking better over these options I have=
=20
noticed that --find-copies-harder for "git diff" can also be replaced=20
with an extra -C. A little bit of consistency would help: either
"-C -C", either "--find-copies-harder" in both git blame/diff. Removing=
=20
from the documentation the deprecated version but keeping the=20
implementation for backwards compatibility might be a solution.


Many thanks,
Mircea

P.S. I know that patches are encouraged and technically it's pretty=20
simple to create a documentation patch, but I have not yet formed mysel=
f=20
a workflow for sending patches via Git to a maillist (this is a pending=
=20
task for me)

--
http://mircea.bardac.net
