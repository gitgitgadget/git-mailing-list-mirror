From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Misterious warning about file system boundaries [It's a bug, not 
	a mystery.]
Date: Thu, 10 Jun 2010 11:39:00 +0200
Message-ID: <AANLkTimwhDGNTMiOaW8_AGGd4PvFtyILEikePdC4zGDo@mail.gmail.com>
References: <4C0FF7B9.8040007@drmicha.warpmail.net>
	<4C109C4F.1030809@op5.se>
	<4C10AAC4.90405@drmicha.warpmail.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 12:10:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMehz-0007fG-Md
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 12:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763Ab0FJKJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 06:09:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54621 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab0FJKJv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 06:09:51 -0400
Received: by wyb40 with SMTP id 40so839954wyb.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=c5cmBLMeiAu9slqa0axFNXEdk9fX+5tvTlS7uaI03aA=;
        b=l+UH+jJuWeKSkkKkQToEH1qanynWIs4cPq0h+tr7fNsRk2ZaNkOZmhiZ0RlgSgqte5
         QJGqSMU9QJgMVd9YJfz7NeNvXHx643D1mssgBcqOkgOG/5JT1wG2QCRqM00ojv+FqzSZ
         igtzU4qC2RIX0FQDUwtfrsPqd6zFlF1E0p8nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=eGayUKfnLJQUHcNJn3/5UsUOS9x/ZZMtEVn4aAVZ3PLY898tYya/Hh5va+tclnA3c6
         ue6A8z17u+pyAflaXZ3rP9WZiK4FPN7RbuxpYOMIJnMGsatnHsCvBh40xxyaohkp6wDQ
         eRFFSjI40WnWh4Jr0cWloRBsWehrWAyKyPFgk=
Received: by 10.227.146.10 with SMTP id f10mr1742913wbv.212.1276162740944; 
	Thu, 10 Jun 2010 02:39:00 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Thu, 10 Jun 2010 02:39:00 -0700 (PDT)
In-Reply-To: <4C10AAC4.90405@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148851>

On Thu, Jun 10, 2010 at 11:05 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Andreas Ericsson venit, vidit, dixit 10.06.2010 10:03:
>> On 06/09/2010 10:21 PM, Michael J Gruber wrote:
>>> Heya,
>>>
>>> now what is going on here? After upgrading to current next I get
>>>
>>> warning: working tree spans across filesystems but
>>> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.
>>>
>>> in several repos, such as my local git.git repo. That is certainly =
on a
>>> single file system only (ext4 over lvm over luks, all on one partit=
ion,
>>> Fedora 13). I also get this for another repo, but not for every rep=
o. It
>>> goes away when I set the var and comes back when I don't set it, of=
 course.
>>>
>>> Although I haven't bisected this should be due to
>>> 52b98a7 (write-index: check and warn when worktree crosses a filesy=
stem
>>> boundary, 2010-04-04).
>>>
>>> How does the code detect a file system boundary, and where could it=
 go
>>> wrong?
>>>
>>
>> According to the patch, it checks if the device id recorded from sta=
t(2)
>> is the same for all files and, if not, warns about it.
>>
>> It seems that your interpretation of "one partition" differs from th=
at
>> reported by the kernel. Why that is so, I have no idea.
>>
>
> I'm sorry, but "my interpretation"? WTF? This is all on
> /home/mjg/src/git which has no bind mounts whatsoever.
>
> I actually mixed up my / and /home situation above, /home is even
> simpler: single ext3 over luks dm device over single "real" partition=
=2E
> All of this (except for single ext3 part.) should not matter, of cour=
se.
>
> I bisected it just be sure, and it boils down to 9780e62 which is the
> commit merging 52b98a7 to next.
>
> git ls-files|xargs stat -c "%d %D" |sort|uniq
>
> gives
>
> 64772 fd04
>
> which is, in particular, 1 device only. Now, here comes funny. After
> changing write_index() to print the two ce_dev's which differ, i.e.
> printf("%d %d\n", ce->ce_dev, cache[first_valid_ent]->ce_dev);
> =A0I have:
>
> ./git-status -s|sort|uniq -c
> warning: working tree spans across filesystems but
> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.
> =A0 =A0150 64770 64772
> =A0 =A0662 64771 64772
> =A0 =A0 =A01 =A0M read-cache.c
>
> WTF???
>
> git reset --hard doesn't help this.
>
> rm .git/index && git reset does help.
>
<snip>
>
> Also, having git reset --index do the equivalent of "rm .git/index &&
> git reset" might be good to have.
>

Doesn't "git update-index --refresh" do the trick?

--=20
Erik "kusma" Faye-Lund
