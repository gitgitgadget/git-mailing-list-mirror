From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git .lock file error
Date: Fri, 1 Oct 2010 01:45:03 +0200
Message-ID: <AANLkTikV=f1ncAxQ1LWzntnOwiBKMfw_D8Mcuh+wCO3+@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
 <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
 <AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
 <AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com>
 <7vbp7fhtt0.fsf@alter.siamese.dyndns.org> <AANLkTinFJ5rSA7Om0ZxhuqzQiqEDvJ+JoEQFpz=NDvxE@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 01:46:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1SpQ-0000jS-In
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 01:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab0I3XpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 19:45:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44161 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0I3XpY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 19:45:24 -0400
Received: by yxp4 with SMTP id 4so978988yxp.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=b4rOizWl5NjguoPWuPUDy0HiwEARJ4RrnDaDj8E2aXo=;
        b=QKTPrbhjCWuc9WWZbqZSWMAKwWQZngs01WD7cr+jW5sH0p3xSB8PJusnbEW6CFghti
         nIxcKiFUhUkZblsRZhgFM/PY0uNWcZj8OZZxLYF60cg3laMpEmPJaXrdH8akpNu+4Jo9
         dKQRgHyvZ+FwfQinPAWLa/iQjiGWOcM8w2bVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=aD6pvFes3RC/4L1m+CLcptO8It6CiZiM5ICAJ00WT/INIrfK4+XyAvgB3AqTtnN+1c
         Zs7EHiufKvy6V3g+BKC5GgY5pMuce7oa25HCviZrAcN03Vch487P225OMVltB6QeMdBv
         4t9kXGSPGGDX9GdB1Pt6Y6D6XLInfloyd+ZZo=
Received: by 10.220.62.197 with SMTP id y5mr1015376vch.189.1285890323573; Thu,
 30 Sep 2010 16:45:23 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Thu, 30 Sep 2010 16:45:03 -0700 (PDT)
In-Reply-To: <AANLkTinFJ5rSA7Om0ZxhuqzQiqEDvJ+JoEQFpz=NDvxE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157722>

On Thu, Sep 30, 2010 at 11:10 PM, Nate Parsons <parsons.nate@gmail.com>=
 wrote:
> On Thu, Sep 30, 2010 at 4:15 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>> > FWIW I think this is more readable, but maybe we want to retry on =
all
>> > platforms:
>> >
>> > =A0 =A0 my $fh;
>> > =A0 =A0 if ($^O eq 'MSWin32' or $^O eq 'cygwin') {
>> > =A0 =A0 =A0 =A0 # Try 10 times to open our lock file, in case Wind=
ows is lagging
>> > =A0 =A0 =A0 =A0 for my $try (1..10) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 sysopen($fh, $db_lock, O_RDWR | O_CREAT);
>> > =A0 =A0 =A0 =A0 =A0 =A0 last if $fh;
>> > =A0 =A0 =A0 =A0 }
>> > =A0 =A0 } else {
>> > =A0 =A0 =A0 =A0 sysopen($fh, $db_lock, O_RDWR | O_CREAT);
>> > =A0 =A0 }
>> >
>> > =A0 =A0 warn "Couldnt open $db_lock: $!\n" unless $fh;'
>
> I agree that this is more readable, although I don't think there need=
s
> to be separate code sections for each OS. If it's a good OS, it will
> only loop once. You would want to die or croak instead of warn,
> though. It needs the lock to continue, right?
>
>> What exactly does "Windows is lagging" mean in the above?
>>
>> Why does sysopen() randomly fail and why does it succeed (sometimes)=
 when
>> it immediately gets retried with the same argument? =A0Is this a sha=
red lock
>> and is used by some other processes that drive git? =A0Why does the =
issue
>> manifest only on Windows? =A0If there are competing processes, would=
n't it
>> exacerbate the situation to run a tight loop to try grabbing the loc=
k
>> without waiting, like the above patch does?
>
> All very good questions, and I don't know most of the answers. I know
> that sysopen() is just a thin wrapper around the 'open' system call,
> so the problem has to be with Windows somehow. It probably doesn't
> happen with other OSes because they're better at files :P
>
> I have verified (to the best of my ability) that this problem happens
> even when TortoiseGit is not running, and I don't have cheetah
> installed, and there are no other 'git.exe's running.

Are you running some anti-virus, or from a Dropbox-folder (or
something similar)? If so, these applications tend to open files for a
short while and then release the file handle. This can some times
cause race conditions with other software, like Git.

I haven't looked into this particular code-path for what kind of
hazards might be, but this sounds very much like one such case to me.
