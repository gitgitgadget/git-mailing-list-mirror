From: Matt Pearson <404emailnotfound@gmail.com>
Subject: Re: git diff infinite loop at attempt to diff two specific commits
Date: Sun, 5 Jul 2009 17:21:15 -0400
Message-ID: <706b4240907051421h57c2fd76u1e9b5e1b8c7bcc8a@mail.gmail.com>
References: <b33ba6660907051037ve9e4176s2a1edbda8af4068f@mail.gmail.com>
	 <20090705181208.GA8629@atjola.homenet>
	 <706b4240907051122s784e97abkde5628189956ceb0@mail.gmail.com>
	 <b33ba6660907051309y55bd5472oc665118a1851ddce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Alexander Toresson <alexander.toresson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 23:21:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNZ9P-0005uA-An
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 23:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbZGEVVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 17:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbZGEVVQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 17:21:16 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:63028 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbZGEVVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 17:21:13 -0400
Received: by bwz25 with SMTP id 25so657158bwz.37
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uu+Kqa3o6A/EcnEf1qEK6FLuh8AX6FL91ae2MGa1Q9s=;
        b=K/tmOq/xHVOGdj8YUfL5hgprMxKdmQcmKnCyu+2RBnzEXrRJdGsv0d5RBKDKfR9Lxr
         Zm2ETxDzoPKGqtu1KSlNy/TZx6FTmRNhxHfqBaBSmnu02UOcXMk751ssnFREBqGtHg8P
         +s/SCLuNW/kyUDtC8KvkLnF52vMazUDp8mPek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=utEomFHTs6gaesfyFO7Smi3fY8fgcWomjuKEH8Z+oZFx1qFnXcWN0FSZwCZqPwHZoe
         khxgwsbkYG86VSqPmJVp6A1wX+nXn0LrM8iGKdyO2OSVwpdA4QhnhOylxeprI1KGjmaK
         JLsC/Eds4LFMBrhw1a2bZn6ZT3T2rwSzYtits=
Received: by 10.223.108.211 with SMTP id g19mr1646518fap.39.1246828875381; 
	Sun, 05 Jul 2009 14:21:15 -0700 (PDT)
In-Reply-To: <b33ba6660907051309y55bd5472oc665118a1851ddce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122757>

[ please don't prune the CC list; I've re-added Bj=C3=B6rn ]

On Sun, Jul 5, 2009 at 16:09, Alexander
Toresson<alexander.toresson@gmail.com> wrote:
> 2009/7/5 Matt Pearson <404emailnotfound@gmail.com>:
>> 2009/7/5 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
>>> On 2009.07.05 19:37:44 +0200, Alexander Toresson wrote:
>>>> Hello,
>>>>
>>>> I've got problems with git diff, it hangs in an infinite loop when
>>>> attempting to generate a diff between two specific commits. Comman=
ds
>>>> to reproduce:
>>>>
>>>> git clone git://eulex.zapto.org/nightfall.git
>>>> cd nightfall
>>>> git diff --stat 597711..61a139
>>>>
>>>> (Note that the clone needs to fetch 16mb)
>>>>
>>>> I'm running git 1.6.3.3.
>>>
>>> FWIW, it "hangs" on the save.xml file. The old version is 1.2M, the=
 new
>>> one is 9M. Using the patience diff algorithm to compare them takes =
about
>>> 5 seconds here, while the default algorithm took 6m15s.
>>
>> I can confirm this for the 1.6.0.4 shipped with Ubuntu Jaunty (so th=
is
>> would seem to not be a recent change). Actually, it may be worse: mi=
ne
>> is still running after 8 minutes, and this machine is almost
>> brand-new. Normal diff -u on the two versions of the file finishes i=
n
>> under a second.
>>
>> On an unrelated note, it's usually a bad idea to have files like
>> configure and *.suo in the repo (and possibly this save.xml as well)=
=2E
>>
>
> Ah! I shouldn't really have had that file in version control, I can
> understand that it would be slow to diff a 9mb xml file. On the other
> hand, is there a way to mark the file so git won't attempt to diff it=
,
> but will just dispose of the old contents and use the new contents?
>
> As for the configure file, it's convenient for users to not have to
> have autoconf installed to build it. I don't really know what *.suo
> does nor do I think I added it, so I'll check up on that.
>
> Thank you.

Slow is a relative term; Git is still taking several orders of
magnitude longer than it should even on such a large file (it takes
over 10 times as long as diffing v2.6.11 to HEAD on the kernel tree,
and that patch is ~400 MB). Plus, as I noted above, GNU diff can do it
in less than a second.

You can disable diffing by adding the following line to .gitattributes
(see gitattributes(5)):
save.xml -diff

Having the configure script in the repo pollutes the diffs. Anybody
who's going to check a project out of source control (instead of using
a tarball) will not have a problem running autoreconf once to get
things working. *.suo and *.vcproj.user contain user-specific settings
for the Visual Studio solution and project, and shouldn't be tracked
in git either. You should really create a proper .gitignore for your
project.

Matt
