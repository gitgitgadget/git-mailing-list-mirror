From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Wed, 13 Nov 2013 09:48:33 +0700
Message-ID: <CACsJy8AHjAgSFzZ2R2Nup=GcuQJdaedbGXhRpcCT6HuaaLUtaQ@mail.gmail.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
 <CACsJy8BiBmeYuZ3VVyvocB969sYpdFNCOJ8GYSA2his5Vebg=g@mail.gmail.com> <CAJc7Lbqaas0Czdvcfn8+iceoyxaVSHOaV9jCJsy4mWH+AbV41Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 03:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgQVy-0002tr-GF
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 03:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab3KMCtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Nov 2013 21:49:06 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:37440 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab3KMCtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Nov 2013 21:49:04 -0500
Received: by mail-qa0-f41.google.com with SMTP id k4so3401760qaq.7
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 18:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k0EH7Jdz4Z4L2MHr1sDWEXR4HHqPlwnfS8TT0nPGWCQ=;
        b=a/Otp0PhScz4tFHAHP3pWUJT77Qz0vaIiWCbPP8e83VJPuLPtArF7esDHORPsgQBDW
         /3PvuQ+Dwz3qg753xtCo2cl/ZWqT1aQLlCCnSJqqMX5v3dyLvi5njmkH4IdHbip5020E
         HUsVLgZNmP5AuvnWSS0qNODwci2oX/AQEp4pqBc+RIs5yr7tHg3/zDt0pRK5C3aitwil
         5mOnts/ygsxNWNrV+dzRsH5Y/7XeaE+ooA8SelORndJNfL0ThgMSJ4c3nTaIO8FhgRly
         XirehmSRiKbjgvoe3Itr0/41M08kb+Y3QfA96tk2h3sRWLoY5t2s1uZ9VBjBaccdk6/M
         BvBg==
X-Received: by 10.49.130.8 with SMTP id oa8mr3024578qeb.66.1384310943986; Tue,
 12 Nov 2013 18:49:03 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Tue, 12 Nov 2013 18:48:33 -0800 (PST)
In-Reply-To: <CAJc7Lbqaas0Czdvcfn8+iceoyxaVSHOaV9jCJsy4mWH+AbV41Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237770>

On Tue, Nov 12, 2013 at 9:38 PM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=
=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
> I use linux.
>
> I can't publish repo - it's proprietary, it weights ~300M unpacked,
> and it uses references ~3Gb.
> Error message doesn't contain "remote:" prefix.
> The majority of opened files have name like:
> objects/pack/pack-<hash>.[ pack | idx ]
> They all are from referenced repo.

There's a fix related to too many open packs, 88d0db5 (sha1_file:
introduce close_one_pack() to close packs on fd pressure - 2013-08-01)
but it's only available in v1.5.0-rc0 or rc1. Could you try that
version?

>
> I have disabled gc in the referenced repo - to prevent all local repo=
s
> from breaking. May this be the cause of problem?
>
> On 12 November 2013 18:19, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Nov 12, 2013 at 3:02 PM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=
=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
>>> I get this error message every time I want to do a `git push`.
>>> git version: 1.8.4.2
>>>
>>> Is it a known issue? Do you need additional info to investigate it?
>>
>> What OS do you use? If the repository can be published, please do.
>> Compress the whole .git directory, don't push or anything. Does the
>> error message begin with "remote: "? If not you could try strace and
>> at least identify what files are opened.
>> --
>> Duy



--=20
Duy
