From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Wed, 28 Jul 2010 17:11:40 +1000
Message-ID: <AANLkTikcV7BdJ_07yLei9_H_kR2GEOi4707J1gGhS-Mr@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
	<AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com>
	<AANLkTinpGO=TU3+1wZw68tUmPL8yQatPUEJ6uTGynbHq@mail.gmail.com>
	<AANLkTi=WjBHYngSDgowD2+0FT3hG+oDYefp2aUostV3U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:11:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe0ns-000458-2y
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab0G1HLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 03:11:42 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51089 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0G1HLl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 03:11:41 -0400
Received: by qyk8 with SMTP id 8so3304946qyk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LAXPYEV3mkC9q6kUMIzowTlE2af+FFGFtYH+B/jSwOw=;
        b=hzK5wxMgSSBdhsFWI+627aXc3c3t+72UDY2jZhRYaY9BTOEcRjwG0qEvz0Sk9fjAfX
         RvSS3eyPgklJIHCSCA99i/G56MGgvybuqAacdHxh8xJ1qSz7eOLJtflDO4LGHAZrjkN5
         T3ldI6G87rSZKHhy9xU++O+cNWQ8wpTBcSRhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NXzisH1gk+bi/aKPUkL5EAYsjp85hXXzU/QcPFWe9zqj2g2klrcI+w/mNvznixvpK1
         5gw0CpponXi71RgKEi3Z9UjMiBy97lg/d5Xd10dgg4bEChP4PzsRfyY5dZuzBugQLix2
         X14xZ84r6R778PEf8utNUfO79XvkBe8MpX2wU=
Received: by 10.224.89.11 with SMTP id c11mr8154056qam.268.1280301100568; Wed, 
	28 Jul 2010 00:11:40 -0700 (PDT)
Received: by 10.220.101.201 with HTTP; Wed, 28 Jul 2010 00:11:40 -0700 (PDT)
In-Reply-To: <AANLkTi=WjBHYngSDgowD2+0FT3hG+oDYefp2aUostV3U@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152044>

On Wed, Jul 28, 2010 at 1:58 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Wed, Jul 28, 2010 at 1:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> 2010/7/28 Avery Pennarun <apenwarr@gmail.com>:
>>> 2010/7/27 Elijah Newren <newren@gmail.com>:
>>>> 0) Sparse clones have "all" commit objects, but not all trees/blob=
s.
>>>>
>>>> Note that "all" only means all that are reachable from the refs be=
ing
>>>> downloaded, of course. =C2=A0I think this is widely agreed upon an=
d has
>>>> been suggested many times on this list.
>>>
>>> I think downloading all commit objects would require very low
>>> bandwidth and storage space, so it should be harmless.
>> >
>> > In fact, I have a pretty strong impression that also downloading
>> > all *tree* objects would be fine too.
>>
>> Here you go. A pack with only commits and trees of git.git#master is
>> 15M. With blobs, it is 28M. Git is not a typical repo with large blo=
bs
>> though.
>
> Hmm, that's very interesting - more than half the repo is just tree
> and commit objects? =C2=A0Maybe that's not so shocking after all, giv=
en the
> tendency in the git project to use long commit messages and relativel=
y
> short patches.
>
> Was your pack carefully ordered for best deltification?

I did not do any optimization. It's pack-objects' defaults. I only
filtered blobs out and that's what fetch-pack would receive.

>
> Knowing how much of that is commits vs. trees would also be very inte=
resting.

Commits only takes 7.8 MB. Well.. all those commit messages..

> But if so, only saving half the space is kind of disappointing. =C2=A0=
If
> you have a script around for generating this, it would be very
> interesting to compare the results with, say, the Linux kernel repo
> (especially since it seems to be the #1 example of "submodules people
> don't want to check out because they're so bloody huge").

I modified pack-objects.c, show_object() to certain objects. Actually
I started with git-fetch-pack, but you can do

git rev-parse master | git pack-objects --revs --delta-base-offset pack

Then verify what's in the pack with

git verify-pack -v pack-*.idx
--=20
Duy
