From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about git-cherry and the rev list it's using
Date: Fri, 13 May 2011 18:29:35 +0200
Message-ID: <BANLkTik4Gt8y0kSBcMrROTd67dfxMXO-KA@mail.gmail.com>
References: <BANLkTinMfVE=s+TouyxE-ucf7MHGf1m7HA@mail.gmail.com>
	<4DCB826F.5020406@drmicha.warpmail.net>
	<BANLkTi=qRbpBG_PDPjO_TVEe+nWqrFQ28w@mail.gmail.com>
	<BANLkTi=d+gDhgnmOzUDfHhGJP76JuLHJ2Q@mail.gmail.com>
	<4DCD1254.4050008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 13 18:29:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvFF-0004sd-5v
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 18:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759483Ab1EMQ3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 12:29:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33002 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759041Ab1EMQ3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 12:29:35 -0400
Received: by pvg12 with SMTP id 12so1219262pvg.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tBsalqCzHtlfEvy6rpbhtmJGbEjGILN/tk+fSFgxDhw=;
        b=ABUMetU3p8ExNV+GllD3i86+nRD2RhzCWt2w8BFDdRZwzEzrLw4NN6Mi+PCQCEl2v7
         Z5uXL8r+md3qf9Ibxxck0qHkipTRndFgwBy8bPZRQg62YktNrXRqgdxrj8qc1Z7HIyKx
         VxitMBvoqheT8leZ3WoM1H95ZuC4TVmTnvcfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Bs8cTHudGfwonsoua9uR6HrwJIDHLt/lPJsUZ7HTAs3G2ywG43I1JdHWZa6DeVxVzl
         eG8B9V6QFYD00/fgksIjgkPKf1MBMr+zWyncuswi08YoIKey14LGCiYu0cZOGH8ytxCv
         Hp3Gyc6xc/Ck9+2zxz1nXIzU1XLG7rMyyMZmE=
Received: by 10.142.44.12 with SMTP id r12mr919078wfr.281.1305304175174; Fri,
 13 May 2011 09:29:35 -0700 (PDT)
Received: by 10.142.77.4 with HTTP; Fri, 13 May 2011 09:29:35 -0700 (PDT)
In-Reply-To: <4DCD1254.4050008@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173546>

On Fri, May 13, 2011 at 1:13 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Francis Moreau venit, vidit, dixit 13.05.2011 09:02:
>> On Fri, May 13, 2011 at 8:54 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>>> [ resending to the mailing list too ]
>>>
>>> On Thu, May 12, 2011 at 8:47 AM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Francis Moreau venit, vidit, dixit 11.05.2011 18:11:
>>>>> Hello,
>>>>>
>>>>> I'm using "git cherry old master base" to see if all commits between
>>>>> master and base have been applied in my 'old' branch.
>>>>>
>>>>> So I expect that git cherry is using a list of commits given by : "git
>>>>> rev-list --no-merges base..master".
>>>>
>>>> Not really.
>>>>
>>>> For each commit in "--no-merges old..master ^base" (i.e. "--no-merges
>>>> master ^old ^base"), "git cherry" checks whether there is a patch
>>>> equivalent commit in "--no-merges master..old", and outputs it with + or -.
>>>>
>>>
>>> oh you're right, I missed the case when old has been merged in master.
>>>
>>
>> BTW, can't it be convenient for users if git-cherry also displays the
>> sha1 of the commits which have been merged upstream (the ones with the
>> '-' sign) ?
>
> (I assume you mean the sha1 of the commit as it is in upstream.)

yes.

>
> Well, in general the map "sha1 to patchid" is not one-to-one and may not
> even be two-to-one. So we possibly would have to list more than one sha1
> along with the -1.

just showing the latest one would be nice though.

> Anyways, with the current implementation you can't do
> that, and it is not simple to change (because we may traverse *a lot* of
> commits if base and upstream are far apart or disconnected).

Ah, with my naive view I would have thought that to process the
patch-id of a commit in upstream and compare it, git has the sha1.

>
> Note that "git cherry -v" gives you the subjects so that you can grep
> for those in case they match in your work flow. Same with "git log
> --cherry --oneline" etc..

yes but as you said the subjects must match which is not always the
case (otherwise that would make patch-id unneeded)

Thanks
-- 
Francis
