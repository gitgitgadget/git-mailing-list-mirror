From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Which VCS besides git?
Date: Wed, 3 Mar 2010 14:31:05 +0200
Message-ID: <94a0d4531003030431t3ce62d0g9b8458fe5a8a54ef@mail.gmail.com>
References: <201003021455.52483.karlis.repsons@gmail.com>
	 <m3y6ialn3z.fsf@localhost.localdomain>
	 <201003021622.22196.karlis.repsons@gmail.com>
	 <201003030241.16959.jnareb@gmail.com>
	 <94a0d4531003030358q276a8e9bue086a8ec06aba395@mail.gmail.com>
	 <80fx4hbo4f.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?Q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>,
	git <git@vger.kernel.org>
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 13:31:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmnjU-0008Du-U8
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 13:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab0CCMbI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Mar 2010 07:31:08 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:40486 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab0CCMbG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 07:31:06 -0500
Received: by iwn34 with SMTP id 34so1252588iwn.15
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p0vSy0rREgI2FAWOjz0TLE37/yd6jMDx680fEGaKcrI=;
        b=JmDRL8Fu7pIIMxjgNMpJmbotIPb38PVWUOjMXSUyVkhfkcWjOvLiy+FdlwQJ9WkHol
         f/OLkPo44KY3tM3sBoPEtZBXjZaq1Hu4FrTmY+eLF766cLTqQPb9gPEe9jcj73jPkI6S
         lsBx7kXh6J6nwMArnKPRn1Bmg2pwHG2ThnpHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hpulY0GtCqFjA73I7Ztbp2ZY6gwfhSj/0gT7IHquYzVDcc9PrVTgbs+25zMltzK/sr
         ydoZn3ZXu84R/yQG08L1Zfz0bp4BDOE5/fije3IR/AxjFTwzGYAbNA4dD0AIcps80zRW
         JGjN6+wwBT1jqFB3fBpczdjMQ9eCsx4teMqUo=
Received: by 10.231.154.207 with SMTP id p15mr115044ibw.91.1267619465936; Wed, 
	03 Mar 2010 04:31:05 -0800 (PST)
In-Reply-To: <80fx4hbo4f.fsf@tiny.isode.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141450>

On Wed, Mar 3, 2010 at 2:12 PM, Bruce Stephens <bruce.stephens@isode.co=
m> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> [...]
>
>> That's not exactly correct. Monotone works very differently; a
>> revision doesn't include the ancestry, that's handled in a separate
>> structure, so the revision hash doesn't tell you anything about the
>> ancestry.
>
> Not so. =C2=A0Long ago that was the case (ancestry was via certs), bu=
t that's
> not been the case for a long time. =C2=A0There are (in retrospect) ob=
vious
> advantages in including the ancestry in the hash.

Ah, I looked quickly ad one db and still saw 'revision_ancestry' being
used. I guess they decided to keep the information redundant.

>> In fact, a revision doesn't contain anything, the data is handled by
>> "certs", and certs can be added later.
>
> Revisions lack date, author, branch, commit message, but include
> ancestry and the actual changes (which files/directories have changed
> and how).
>
>> For example, it's possible to clone a repository and then add a seco=
nd
>> commit message to a bunch of revisions. The revision hash doesn't
>> change. Instead, they ensure security by signing every piece of data
>> about a commit (commit date, author, commit message). So it's possib=
le
>> to have multiple commit dates, authors, messages, etc. each signed b=
y
>> a different person.
>>
>> I'm not really fond of this approach :P
>
> It has the nice feature that many people can create merges, and if th=
ey
> create exactly the same merge (from exactly the same parents) then on=
ly
> one revision results (just with multiple certs decorating it).

Yeah, I'm aware of the reasoning, but IMO it's too much complexity for
almost no gain. It's much easier to just 'git fetch' and synchronize
the changes.

Anyway, good to know they updated the ancestry handling :)

--=20
=46elipe Contreras
