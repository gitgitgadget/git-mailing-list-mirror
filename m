From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] Re: [PULL] Pull request from msysGit
Date: Thu, 7 Oct 2010 21:18:43 +0100
Message-ID: <AANLkTinSjFDdwqTEU6XzOVHupph0G2ZKM+u3r7t_W3DD@mail.gmail.com>
References: <87ocb9zfbf.fsf@fox.patthoyts.tk>
	<4CAE00C5.1050509@ramsay1.demon.co.uk>
	<4CAE1FE6.9020306@opentext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, sschuberth@gmail.com
To: Peter Harris <pharris@opentext.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 22:18:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3wvW-0002RK-WF
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 22:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab0JGUSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 16:18:45 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51746 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab0JGUSo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 16:18:44 -0400
Received: by qwf7 with SMTP id 7so234912qwf.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QUvTbOYzR+ucp75K0daBmzn8uWX03alSb5+Mfst52fg=;
        b=nRslJC4SoGZwejRMOB0S9ZmUhfvy3n/vtKioLN/oadNYTvru1e9e4jdq4X4wSFFP52
         WmDwaiqyksdsSDAH3WyKmZgwqt+2+bCn6aDhF6LF8cs8dCofxuFme2fFOxIoeL+LSj2N
         Ay7nlnvu3xQb7b9qMGXSVvjZmK5vAmMteiQJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W7e9J1IFLPBWRqTTOpZ3oY8f5Gflp2YA+zDm8vhL9C0F0AuoxIv6bWy7S72LgaoX5t
         vIIxV3yefCVR7cqHbHRmiCeJVRiWoGX1W/NMn99NsgiK+4aLnHON0FnzEpQEgPwLFjIT
         +RkY3w3kZtKmw1Qen0uV1njR7rY7IgVCafsF8=
Received: by 10.229.232.209 with SMTP id jv17mr1173641qcb.63.1286482723932;
 Thu, 07 Oct 2010 13:18:43 -0700 (PDT)
Received: by 10.229.45.203 with HTTP; Thu, 7 Oct 2010 13:18:43 -0700 (PDT)
In-Reply-To: <4CAE1FE6.9020306@opentext.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158450>

On 7 October 2010 20:30, Peter Harris <pharris@opentext.com> wrote:
> On 2010-10-07 13:17, Ramsay Jones wrote:
>> Now, Peter Harris has already submitted a fix for this, which is
>> currently on the work/msvc-fixes branch, which contains:
>>
>> =C2=A0 =C2=A0 358f1be Modify MSVC wrapper script
>> =C2=A0 =C2=A0 38bd27d Fix MSVC build
>>
>> The suggested fix is given in commit 38bd27d. However, I prefer a
>> different solution, which is given below:
>>
>> --- >8 ---
>> diff --git a/compat/mingw.h b/compat/mingw.h
>> index afedf3a..445d1a1 100644
>> --- a/compat/mingw.h
>> +++ b/compat/mingw.h
>> @@ -12,12 +12,6 @@ typedef int pid_t;
>> =C2=A0#define S_ISLNK(x) (((x) & S_IFMT) =3D=3D S_IFLNK)
>> =C2=A0#define S_ISSOCK(x) 0
>>
>> -#ifndef _STAT_H_
>> -#define S_IRUSR 0
>> -#define S_IWUSR 0
>> -#define S_IXUSR 0
>> -#define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
>> -#endif
>> =C2=A0#define S_IRGRP 0
>> =C2=A0#define S_IWGRP 0
>> =C2=A0#define S_IXGRP 0
>> --- 8< ---
>>
>> Note that, for *both* MinGW and MSVC, the deleted #defines
>> are not wanted, pointless and just plain wrong! :-D
>
> I didn't realize that the defines were not wanted for MinGW either.
>
> I heartily approve of removing code rather than just ifdefing around =
it.
> Please use this version of the patch instead of mine.
>
> Peter Harris

The patch in question has been on the msysGit tree for about 10 months
now. Its somewhat disappointing not to have had it spotted before we
pushed it upstream. Are the msvc builders only working against junio's
repository?

Reverting it seems to make no difference to the msysGit build at all -
presumably because S_IRUSR and friends are all defined in the mingw
<sys/stat.h> anyway. Sebastian - can you recall why this got added?
The commit comment is not all that enlightening.

I also wonder why changes to a compat/mingw.h file should affect the
msvc build. As it has it's own compat/vcbuild and headers in there,
surely it should be independent of mingw-gcc compatability headers?

Pat Thoyts
