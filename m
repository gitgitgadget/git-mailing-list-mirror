From: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Subject: Re: 'git replace' and pushing
Date: Fri, 26 Nov 2010 16:16:39 -0500
Message-ID: <AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
	<4CEE2060.4020507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 26 22:16:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM5ev-0008VB-PW
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 22:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab0KZVQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 16:16:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36954 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0KZVQk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 16:16:40 -0500
Received: by wwa36 with SMTP id 36so2521758wwa.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 13:16:39 -0800 (PST)
Received: by 10.227.141.201 with SMTP id n9mr2891056wbu.185.1290806199198;
 Fri, 26 Nov 2010 13:16:39 -0800 (PST)
Received: by 10.227.154.10 with HTTP; Fri, 26 Nov 2010 13:16:39 -0800 (PST)
In-Reply-To: <4CEE2060.4020507@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162278>

On Thu, Nov 25, 2010 at 3:37 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Cory Fields venit, vidit, dixit 24.11.2010 05:33:
>> I am having some trouble understanding how a replaced object (commit=
)
>> should behave when pushed to a remote repo. Here's my scenario:
>>
>> We are moving from svn to git. Our svn repo is huge, and most of the
>> history is useless. To save space, I would like to do a 50/50 split =
so
>> that when the repo is cloned, 50% is seen by default, and the
>> historical 50% can be seen by fetching the replacement history. I've
>> done this by creating a phony snapshot at 3 then using a 'replace' t=
o
>> put the others on top. The history is purely linear.
>>
>> 1---2---3---4---5
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\---4-=
--5
>
> I assume the "other" 4 goes off 3 (you're not using a monospaced font=
,
> are you?).
>

I used a monospace font, but gmail decided not to use it. Sorry for tha=
t.

> Also, the other 4 should have no parent, otherwise you've not cut-off
> any history.

I created a "fake" 4 that consists of the full working tree at 4 with n=
o parent.
As I mentioned, everything looks fine locally.

>
>>
>> When the replacement is in place, the repo is half size (commit-wise=
)
>> as expected. The problem is that 'git push' does not honor the
>> replace. So when I push, all objects go with it, which defeats the
>> purpose. The only way that seams to work is doing a filter-branch an=
d
>> replacing the other way.
>>
>> Is this by design? I would really like a way to split the repo witho=
ut
>> breaking hashes for the developers that have already begun using git
>> svn.
>
> It is by design since a replace creates a "fake history", and this
> should not be created behind a users back.
>
> The 5 is not rewritten, and it's ancestry contains the whole history.=
 If
> that is the commit your developers have already and that you want to
> preserve then there's not much you can do.
>
> You could try to push or pull your replacement refs first (refs/repla=
ce)
> but I don't think this will change what objects the push of 5 will
> transfer. Just have a try.

I tried this to no avail.

I realize that allowing replacements to be pushed "behind users backs",=
 so
I guess not respecting it makes sense.

But is there no way that I can pull this off without rewriting hashes?

Thanks,
Cory
