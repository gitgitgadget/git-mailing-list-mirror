From: Andreas Ericsson <ae@op5.se>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 12:27:06 +0200
Message-ID: <4BD0247A.4080103@op5.se>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com> <20100421221953.GA25348@progeny.tock> <7vwrw0573t.fsf@alter.siamese.dyndns.org> <20100422094153.GA504@progeny.tock> <4BD01E09.8080504@op5.se> <20100422101535.GB625@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>, Kim Ebert <kd7ike@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 12:27:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4tcr-0005av-8N
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 12:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0DVK1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 06:27:12 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34304 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752320Ab0DVK1L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 06:27:11 -0400
Received: from source ([209.85.218.225]) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS9AkfUSjRxCS82GsMKQMdZZzY2w2bpge@postini.com; Thu, 22 Apr 2010 03:27:11 PDT
Received: by bwz25 with SMTP id 25so8276784bwz.8
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 03:27:08 -0700 (PDT)
Received: by 10.87.58.6 with SMTP id l6mr1825324fgk.15.1271932028067;
        Thu, 22 Apr 2010 03:27:08 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l12sm4014760fgb.7.2010.04.22.03.27.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 03:27:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <20100422101535.GB625@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145517>

On 04/22/2010 12:15 PM, Jonathan Nieder wrote:
> Andreas Ericsson wrote:
>> On 04/22/2010 11:42 AM, Jonathan Nieder wrote:
>=20
>>> [1] I do suspect that in the case of failing enter_repo() or missin=
g
>>> git-daemon-export-ok, saying =E2=80=9Ccannot read the specified rep=
o=E2=80=9D would be
>>> fine.  Most of the time, there is not much value in disclosing a mo=
re
>>> detailed reason, anyway.
>>
>> That would make it possible for random attackers to determine whethe=
r
>> a specific user exists on the system, which is very bad indeed.
>=20
> I guess I am missing something.  How would
>=20
> (*) $ git clone git://git.example.com/~u/foo
>      remote: Cannot read the specified repo
>=20
> tell me whether that user existed on the system?  If the daemon gives
> the same message for ENOENT, missing git-daemon-export-ok, EPERM, and
> so on so I cannot distinguish the cases, then I just don=E2=80=99t se=
e the
> problem.
>=20
> If the daemon failed for some other reason, like a flaky network, I
> would see
>=20
>      $ git clone git://git.example.com/~u/foo
>      fatal: The remote end hung up unexpectedly
>=20
> So the extra information could still be helpful, without unwanted
> information disclosure.  In the case (*) I learn definitively that th=
e
> address I specified does not represent a repo I have access to, rathe=
r
> than this being some random, transient unexplained problem.
>=20

So that would be the new error message for everything that fails, then?

One big reason why I'm not bothered with running the git-daemon on a
public server is that it's very simple. If something goes wrong, it
dies without fiddling about.

How would it benefit you if it said "fatal: Something went wrong, but
I didn't crash" instead of just hanging up? If you have the wrong
repo address, you'd still have to check up with whoever gave it to
you to get it right. If it *does* crash, you'd still have to get
hold of the server admin to tell him that it has crashed.

A minor patch to git-fetch, updating the error message with a few
possible reasons would be far better. I don't care about it myself,
but I'm sure such a patch would be a lot easier to get into git.git
than something that adds a lot of complexity to the git daemon.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
