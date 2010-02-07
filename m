From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Sun, 7 Feb 2010 11:48:19 -0600
Message-ID: <cccedfc61002070948m2491b1e2ua633f125f3573ff9@mail.gmail.com>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com> 
	<alpine.LFD.2.00.1002051539080.1681@xanadu.home> <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com> 
	<alpine.LFD.2.00.1002051634380.1681@xanadu.home> <cccedfc61002060553w464d5d9drd582b3b3c3f35227@mail.gmail.com> 
	<alpine.LFD.2.00.1002061935180.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Feb 07 18:51:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeBHw-0006RM-3Q
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 18:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab0BGRsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 12:48:41 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:39006 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab0BGRsk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 12:48:40 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1170744eyd.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 09:48:39 -0800 (PST)
Received: by 10.216.87.133 with SMTP id y5mr3005562wee.139.1265564919190; Sun, 
	07 Feb 2010 09:48:39 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002061935180.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139241>

On Sat, Feb 6, 2010 at 7:16 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 6 Feb 2010, Jon Nelson wrote:
>
>> Last night, the repo size was 153G after removing some commits and
>> objects by way of git filter-branch.
>> I'm using "du -sh" in the .git directory to determine the disk usage=
=2E
>>
>> Before: 136G
>> git repack -dAl
>> After: 153G
>
> Why are you using -A instead of -a ?

As it turns out, I've been using both -a and -A. I suspect -A is a
typo on my part.

>> Then, just to make sure of some things, I changed nothing and simply
>> re-ran "git repack -dAl".
>> After: 167G
>
> Could you run 'git count-objects -v' before and after a repack in suc=
h
> cases as well?

Yes.

>> [pack]
>> =A0 =A0 =A0 =A0 packsizelimit =3D 256m
>
> Why are you using this?

I didn't want my pack files to be too huge. I've bumped that up to 2G.

>> pack.packsizelimit=3D2M

My ~/.gitconfig normally uses 2M for easy rsyncing. In this repo I
thought the value was overridden by the project's config (which was
specifying 256m and now specifies 2048m).

Suboptimal or not, it still doesn't explain why the repo grows with eac=
h repack.

Now running:

 git count-objects -v ; git repack -ad ; git count-objects -v


--=20
Jon
