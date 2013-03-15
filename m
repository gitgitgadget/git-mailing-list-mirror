From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 16:52:26 +0100
Message-ID: <514343BA.3030405@web.de>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com> <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org> <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com> <7vmwu6yqbd.fsf@alter.siamese.dyndns.org> <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	git@vger.kernel.org, artagnon@gmail.com,
	robert.allan.zeh@gmail.com, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 16:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGWww-0004Cn-2H
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 16:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab3COPxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 11:53:14 -0400
Received: from mout.web.de ([212.227.15.3]:57019 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab3COPxO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 11:53:14 -0400
Received: from [192.168.209.16] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MV4fx-1UF9Lz3U0T-00YIOz; Fri, 15 Mar 2013 16:52:35
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
X-Provags-ID: V02:K0:MkZa007wb+8cBKeV10NDAwHJASUxXyCYuQonCl0bTtX
 iqNED+KhZHoNrfrGdHrj3WUhhY/Fhl3csNeTMvjQWIpmRig1Iv
 qKkNpHAgrmeyUuywT/n9c0pv3PH+/ZZBwzZUcWW6CQP2BhlJ62
 SN7uU8J/LozSX2iFpsHtyTt/WDg1RHCilDDaWUX0XiQyy0qiYJ
 1YAgifwYA0Hjp/t8tAKdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218246>

On 03/15/2013 01:30 PM, Duy Nguyen wrote:
> On Thu, Mar 14, 2013 at 10:05 PM, Junio C Hamano<gitster@pobox.com>  =
wrote:
>>>> "to speed up by stopping displaying untracked files" does not look
>>>> like giving a balanced suggestion.  It is increasing the risk of
>>>> forgetting about newly created files the user may want to add, but
>>>> the risk is not properly warned.
>>> How about "It took X ms to collect untracked files.\nCheck out the
>>> option -u for a potential speedup"? I deliberately hide "no" so tha=
t
>>> the user cannot blindly type and run it without reading document
>>> first. We can give full explanation and warning there in the docume=
nt.
>> But it makes the advise much less useful to introduce more levels of
>> indirections, no?
> To me the message's value is the pointer to -uno that not many people
> know about. And I don't want it to be too verbose as there'll be fals=
e
> positives (cold cache, busy disks, low memory..), 2-3 lines should be
> max. So indirections are not a concern. You want to speed up, you nee=
d
> to pay some time. Anyway how do you put it to suggest -uno in
> git-status with all the implications?
I was thinking about the documentation, the best patch so far may look
like this:
What we think?
/Torsten


-- >8 --

[PATCH] git status: Document that git status -uno is faster

In some repostories users expere that "git status" command takes long t=
ime.
The command spends some time searching the file system for untracked fi=
les.
Document that searching for untracked file may take some time, and docu=
emnt
the option -uno better.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
  Documentation/git-status.txt | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 0412c40..fd36bbd 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -58,6 +58,13 @@ The possible options are:
  The default can be changed using the status.showUntrackedFiles
  configuration variable documented in linkgit:git-config[1].

++
+Note: Searching the file system for untracked files may take some time=
=2E
+git status -uno is faster than git status -uall.
+There is a trade-off around the use of -uno between safety and perform=
ance.
+The default is not to use -uno so that you will not forget to add a=20
file you newly created (i.e safety).
+You would pay for the safety with the cost to find such untracked file=
s=20
(i.e. performance).
+
  --ignore-submodules[=3D<when>]::
      Ignore changes to submodules when looking for changes. <when> can=
 be
      either "none", "untracked", "dirty" or "all", which is the defaul=
t.
--=20
1.8.2.rc3.16.gce432ca
