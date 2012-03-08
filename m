From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Thu, 8 Mar 2012 12:57:02 +0100
Message-ID: <CAJh6GrFKJw1506c6nOzh+EcNe7E_UM=NxV_yBPWx9BUCdpAvAg@mail.gmail.com>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <1331203358-28277-2-git-send-email-domq@google.com> <87399jnyxh.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5byR-0005iE-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296Ab2CHL51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 06:57:27 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:49165 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757011Ab2CHL5X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 06:57:23 -0500
Received: by wejx9 with SMTP id x9so255557wej.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 03:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=F5oWSoHQ3XG5g9bOLX19I0ciO4M0adCMiG5XnUKbhyI=;
        b=Q0Jq8qd3/lkHk7/i0CfYaAPVsdkK6hLngCVkcN4LpSYxVZ2M9Q66rWjD8XI5SM2Lfk
         YVmnRVIp6wa+X/nlh0I1X12qPm9zRy5TQdVoVS7bqSYjjHez+CqJfKJxtjScHhNz3vzD
         xDPCnRBuG/q5dkL07pWX2rejRCalgP69We2Ff50oV+y+kSOxquvoyfFLIzGoAxpzpx4P
         U9Vljb5jqM58ncEwuK6m9/e6STpFs6WSRV4FaHtuzLin+k6FugjY9QMkM9bWLXsaak5c
         5ksEeVryrIH23fqPo4unLTNslUut5s2L9V8T8bSP1Mblp+1tAq1cM7DpSWN1Cp61z1YS
         J2Eg==
Received: by 10.180.88.199 with SMTP id bi7mr12122551wib.12.1331207842531;
        Thu, 08 Mar 2012 03:57:22 -0800 (PST)
Received: by 10.180.88.199 with SMTP id bi7mr12122540wib.12.1331207842447;
 Thu, 08 Mar 2012 03:57:22 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Thu, 8 Mar 2012 03:57:02 -0800 (PST)
In-Reply-To: <87399jnyxh.fsf@thomas.inf.ethz.ch>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQn+C9/+iXazDGwOjCsWbRaPcFfbZcQMPYfjJLYMll7ZX2cCvqaH5hcCEopfOKkHWeOTWUv4JYz3/x2VwnKx3tsQ+IafbsCw9l/l4Q7Wa7Y92S+U2m7qqOT7zIFGDyN/wzloLDLqL2HZVXAu91u8tG+mltJv5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192577>

On Thu, Mar 8, 2012 at 11:56 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> On a general note: you are submitting a completely new feature touchi=
ng
> a heavily-used tool (and code path) during -rc0 time. =A0As a rule of
> thumb: Don't do that. =A0If you do it, don't Cc Junio unless it's his=
 area
> of code.

[- gitster]
Sorry about that, I skimmed Junio's "What's cooking in git.git (Mar
2012, #03; Mon, 5)" and I thought I was in the "high value/damage
ratio" category.

> Hum.  I'm not sure yet if I find that very useful, since frequently t=
he
> names will just be 'topic', 'topic~1', ...., 'topic~N'

Exactly, and when rebasing a branch with merges, the "foreign" commits
will stick out which is what I want.

> The --no- version is implicitly always supported, see gitcli(1).

Do you mean I should omit it from the doc?

>> +configuration variable `rebase.interactivenamerev`, this option can=
 be
>
> You should spell it in a more readable way such as
> rebase.interactiveNameRev.

Will do.

>> - =A0 =A0 shortsha1=3D$(echo $sha1 | cut -c1-7)
>> + =A0 =A0 if test t =3D "$name_rev"
>> + =A0 =A0 then
>> + =A0 =A0 =A0 =A0 =A0 =A0 rev=3D"$(git name-rev $sha1 | cut -d\ =A0-=
f2)"
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 rev=3D$(echo $sha1 | cut -c1-7)
>> + =A0 =A0 fi
>
> In the spirit of your previous patch, wouldn't it be faster to run 'g=
it
> name-rev --stdin' within the pipeline?

I fear that it would also substitute hashes on the right-hand side (in
the commit messages), and also I would be piping data from and to git
name-rev from the same process which is a recipe for deadlocks.

> In line with the --autosquash concern, please write a test that uses
> both option (and verifies that *both* work!).

Will do.

--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
