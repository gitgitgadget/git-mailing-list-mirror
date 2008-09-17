From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 06:00:04 -0700
Message-ID: <cfd18e0f0809170600r79d883d3t96abb49e827d3178@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
	 <48D0BEF1.10008@drmicha.warpmail.net>
	 <cfd18e0f0809170338v168c2991ma3964392e44e0194@mail.gmail.com>
	 <48D0E6A3.4040703@drmicha.warpmail.net>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, michael.kerrisk@gmail.com,
	"=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 15:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfwf8-00017i-SR
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 15:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbYIQNAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 09:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbYIQNAH
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 09:00:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:39085 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbYIQNAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 09:00:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3173279rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hkbkbo87+WUHqV/KpMZmJR99alGxhFinqeajQz5PV4w=;
        b=IhT/qxdDf1lZ3+Ct02fyWHzr356cBPKKerixw5FQ7Pvs17Gy1E2sGlQlcoZIcMvVfo
         xnZvbag9DeLtnyWfudunw2XwH3Gc2s4cIIHJdOlj4uEpWF8Md967fb3AtDsj2XXVRWoF
         5gVmoE5J/bqhC3VcdSQnOqqPkdkm9jZIJywpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=wfLkrB/02bdeD6CQUgI8Yev/D2VYqC1FArcLWKgxP+4XcS0LhQoM2QENQmTbI9dt5x
         iMtacldKX/gDaefmfitWg0vDv7xBWExsdy7ZK55/3ZzXs+cAWmhqMy6z9AeHDUIazuNI
         BzGvPcPGnGJzQumVmxodmb+1L1YJdDAeMXJgU=
Received: by 10.140.157.4 with SMTP id f4mr6497663rve.118.1221656405005;
        Wed, 17 Sep 2008 06:00:05 -0700 (PDT)
Received: by 10.141.176.2 with HTTP; Wed, 17 Sep 2008 06:00:04 -0700 (PDT)
In-Reply-To: <48D0E6A3.4040703@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96108>

Michael,

On Wed, Sep 17, 2008 at 4:14 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Michael Kerrisk venit, vidit, dixit 17.09.2008 12:38:
>> Hello Michael,
>>
>> On Wed, Sep 17, 2008 at 1:25 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Michael Kerrisk venit, vidit, dixit 17.09.2008 00:05:
>>>> Hello,
>>>>
>>>> I'm currently trying to import an svn repository, along with its t=
ags,
>>>> into git, and everything seems okay except that after the import I
>>>> expect to have the following structure to my checked out repositor=
y:
>>>>
>>>>     [root-dir]
>>>>         .git
>>>>         <checked-out-files>
>>>>
>>>> But instead I end up with
>>>>
>>>>     [root-dir]
>>>>         .git
>>>>         man-pages               <-- name of my svn project
>>>>             <checked-out-files>
>>>>
>>>> I've tried out a few different command-line flag settings but so f=
ar I
>>>> haven't managed to get the desired layout.  I guess that I'm missi=
ng
>>>> something trivial, but I haven't worked out what it is so far.
>>>>
>>>> The commands I'm using to do the import are:
>>>>
>>>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b=
 branches
>>>> $ git svn fetch
>>>>
>>>> The svn tags are getting imported okay, since:
>>>>
>>>> git branch -a | head
>>>>   tags/man-pages-2.00
>>>>   tags/man-pages-2.01
>>>>   ...
>>>>   tags/man-pages-3.08
>>>>   tags/man-pages-3.09
>>>>   trunk
>>>>
>>>> The following commands show the layout of my svn repo, which is pr=
etty
>>>> much standard:
>>>>
>>>> $ svn list file:///home/mtk/man-pages-rep
>>>> branches/
>>>> tags/
>>>> trunk/
>>>> $ svn list file:///home/mtk/man-pages-rep/trunk
>>>> man-pages/
>>> That's the part that says that your layout is non-standard. What do=
 your
>>>  branches and tags look like? Do they have that superfluous "man-pa=
ges"
>>> part as well?
>>
>> $ svn list file:///home/mtk/man-pages-rep/tags
>> man-pages-2.00
>> man-pages-2.01
>> man-pages-2.02
>> man-pages-2.03
>> ...
>> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.00
>> man-pages
>> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.01
>> man-pages
>> [and so on]
>
> Bingo!
>
>> $ svn list file:///home/mtk/man-pages-rep/branches
>> $
>> (i.e., no branches, since this has been a linear svn repo.)
>
> git-svn converts svn tags into git branches (because they can change)=
=2E
> So you will get a git repo with lots of branches which are subsets (H=
EAD
> commit is in master/trunk) of master/trunk.
>
>>>> $ svn list file:///home/mtk/man-pages-rep/trunk/man-pages
>>>> Changes
>>>> Changes.old
>>>> Makefile
>>>> README
>>>> man-pages-3.09.Announce
>>>> ...
>>>> man7/
>>>> man8/
>>>> scripts/
>>>> $ svn list file:///home/mtk/man-pages-rep/tags
>>>> man-pages-2.00/
>>>> man-pages-2.01/
>>>> ...
>>>> man-pages-3.08/
>>>> man-pages-3.09/
>>>>
>>>> What 'git svn init' command do I need to get the layout that I wan=
t
>>>> for my imported git repo?
>>> It depends on the structure of your branches and tags. My guess wou=
ld be
>>> that you have something like tags/man-pages-2.00/man-pages/ etc., i=
n
>>> which case you would need a special configuration if you want to ge=
t rid
>>> of the "man-pages" part. Tells us your structure, we'll tell you th=
e
>>> config ;)
>>
>> Do you now have enough info above?
>
> Yes, thanks. If you use git-svn init -s (which is equivalent to -T tr=
unk
> -t tags -b branches) you get an "exact" clone of your svn repo in
> reasonable time, as you already noticed.
>
> In order to get rid of the "man-pages" path component you can either:
>
> - remove it after the fact using git filter-branch
>
> or
>
> - remove it during the conversion process
>
> For the latter, do the following:
>
> git svn init -s file:///home/mtk/man-pages-rep/
>
> as usual. Then, before the first fetch, make sure your .git/config sv=
n
> section looks as follows:
>
> [svn-remote "svn"]
>        url =3D file:///home/mtk/man-pages-rep/
>        fetch =3D trunk/man-pages:refs/remotes/trunk
>        branches =3D branches/*/man-pages:refs/remotes/*
>        tags =3D tags/*/man-pages:refs/remotes/tags/*

I guess your solution here was equivalent to Bj=F6rn's, since after I
tried his suggestion, I ended up with an [svn-remote "svn"] that looks
just as you describe.

Thanks,

Michael

> That is, if you used "git svn init -s" you only have to add "/man-pag=
es"
> three times on the left hand side of the refspecs. You can also do th=
is
> using "git config", of course, if you watch out for the shell quoting=
=2E
>
> Cheers,
> Michael
>



--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
=46ound a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
