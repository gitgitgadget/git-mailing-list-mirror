From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git filter-branch can "forget" directories on case insensitive filesystems
Date: Wed, 26 Jan 2011 01:58:09 +0100
Message-ID: <AANLkTikO+dSwRS-x0UUB35iSFK3iE9cMZ6ae6go=MHHY@mail.gmail.com>
References: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com>
 <4D3F38E9.9060902@googlemail.com> <201101252256.03644.j6t@kdbg.org>
 <4D3F5C42.4040300@googlemail.com> <AANLkTimvwNs9EkV1GweT7VCdzvcz5J5_0pCUA44urQYH@mail.gmail.com>
 <4D3F69D2.800@googlemail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: smaxein@googlemail.com
X-From: git-owner@vger.kernel.org Wed Jan 26 01:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhtiX-0003Ml-35
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 01:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab1AZA6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 19:58:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45584 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1AZA6b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 19:58:31 -0500
Received: by bwz15 with SMTP id 15so745324bwz.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 16:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8zEesjV9eGt4Dp5mf9qdASDOzmdmvqI7Gp6zKmPv054=;
        b=uDThdPO/tfw61YMnwkDFMK27gTniAQ9ulhEEs8NfpD5NMgkYfER0XantjLN7Q7ARPn
         UIHYAEQILU8Wy7VRP3XCUg3D+iDW4XrchAL4V8LE0d0z4rkF39MFcr3tKodLGjDWcWKB
         JrfpBmlutVxfnHhkSvg67gIdbJn34nj43+v8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=oLubStzl3gfnFr5O1rk2PiFZF5u3byzl9z1hvHeTCyZngnZCI2XDs/zWbxQfiM357A
         BCythRrf1c7k4WHGEcgnO8+yM8LojemqQNgVzRi+X1k989B9AUk7fUeId5HqL+Zln5KN
         B8V4p+XiwuB4Qr/inWz03GTbNs7SrqIsEAU20=
Received: by 10.204.63.211 with SMTP id c19mr5881846bki.21.1296003509564; Tue,
 25 Jan 2011 16:58:29 -0800 (PST)
Received: by 10.204.120.197 with HTTP; Tue, 25 Jan 2011 16:58:09 -0800 (PST)
In-Reply-To: <4D3F69D2.800@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165492>

On Wed, Jan 26, 2011 at 1:24 AM, Simeon Maxein <smaxein@googlemail.com>=
 wrote:
> Am 26.01.2011 00:31, schrieb Erik Faye-Lund:
>> On Wed, Jan 26, 2011 at 12:26 AM, Simeon Maxein <smaxein@googlemail.=
com> wrote:
>>> Am 25.01.2011 22:56, schrieb Johannes Sixt:
>>>> On Dienstag, 25. Januar 2011, Simeon Maxein wrote:
>>>>> In my opinion this is a quite serious issue, because files are lo=
st
>>>>> without any indication to the user. As of git 1.7.3.1 (tested on
>>>>> Windows/NTFS with msysGit this time), the problem still exists. P=
lease
>>>>> give it a look. Fullquote of the problem description / steps to
>>>>> reproduce follows.
>>>>>> mkdir testdir
>>>>>> echo 'abc' >testdir/testfile
>>>>>> git add testdir
>>>>>> git commit -m foo
>>>>>> git rm -r testdir
>>>>>> mkdir testDir
>>>>>> echo 'abc' >testDir/testfile
>>>>>> git add testDir
>>>>>> git commit -m bar
>>>> Please retry with current release condidate of 1.7.4; it has some
>>>> core.ignorecase improvements w.r.t. directories. It could well be =
that your
>>>> problem is fixed.
>>>>
>>>> -- Hannes
>>> Thanks for the suggestion. The directory doesn't vanish anymore wit=
h
>>> 1.7.4, so a big Thank You to the developers for improving this. Whe=
n
>>> rewriting the second commit ls still prints testdir as lowercase th=
ough.
>>> More of a nitpick, but it would still be neat to have it right.
>>>
>> This part is correct behavior =A0- git's internal representation is =
case
>> sensitive. So git's record of the file is still 'testdir', even i
>> you've deleted it and created a new called 'testDir'.
> A normal checkout for those commits results in "testdir" for the firs=
t
> one and "testDir" for the second one, so git does store the name
> difference. I would intuitively expect the trees prepared during
> filter-branch to be consistent with the result of a checkout.
>

I'm sorry, I misread what you wrote (I read the 'git rm testDir' as
'rm testDir').

The reason the old folder name is output appears to be that "git
checkout-index -f -u -a" (called from git-filter-branch) doesn't
change the directory name when the directory is already there. But to
be honest, I'm not really sure if it should or not. I'm too tired to
think it through right now ;)
