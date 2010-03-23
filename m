From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4 and git clone
Date: Tue, 23 Mar 2010 19:11:47 +0100
Message-ID: <1a6be5fa1003231111pc98bfbbg299ea0f95a7926a7@mail.gmail.com>
References: <B978892CA0FBD142827E74F92AC4BBD429B2444D4D@HQMAIL03.nvidia.com>
	 <4880E32B-7880-40BF-8AFD-AC00DA457CEE@meyerhome.net>
	 <B978892CA0FBD142827E74F92AC4BBD429B2444D5C@HQMAIL03.nvidia.com>
	 <1a6be5fa1003231038h695ebbf2k8a765b4a9b6e274d@mail.gmail.com>
	 <B978892CA0FBD142827E74F92AC4BBD429B2444D66@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Meyer <ben@meyerhome.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Kistler <tkistler@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 19:11:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu8a4-0004EE-F5
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 19:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab0CWSLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 14:11:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:8625 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab0CWSLu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 14:11:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1130666fgg.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pEx659Nomp/9FRuKU2A6DlKvP8TnJJch6/0pBkm1ZR8=;
        b=uY0M2RenheSF9q9/IBHimmDkBbKOuKPIlLFFVRH3buXU0FlUXQ5trmUO8ExmwNBJR+
         alA7EWtmaGuV/4oiwk3OSsuaj8ltXtB0HZSG3QwRoEr6ltClcUxvhTcMvmxDIzrD1EKc
         usPO7yaHotUO2VE2fNWQyCBs4/caXOMp5rLn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tfuLUyww5RZEoIhg+u1cxaS6cKTyV8AAK5x+s2FqlNuvERfdeQqcgQpEMrVkW6mNUv
         Tt9UMrFaWoNDuoy+VcAdiVjyYhRYFlUXLO3ans9cG2Sz1lHjzUrmyBaDpgYXYGlvOcXp
         rwbjREmFjMNoEICjSQQJeD1UMS449TFbyLlT4=
Received: by 10.204.18.144 with SMTP id w16mr533501bka.54.1269367908139; Tue, 
	23 Mar 2010 11:11:48 -0700 (PDT)
In-Reply-To: <B978892CA0FBD142827E74F92AC4BBD429B2444D66@HQMAIL03.nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143040>

On Tue, Mar 23, 2010 at 7:02 PM, Thomas Kistler <tkistler@nvidia.com> w=
rote:
> That doesn't work for me. You can't submit from B because there are n=
o remotes in that repository and p4BranchesInGit() is looking for remot=
es only.
> You also cannot submit from C because the remotes are named origin/p4=
/master whereas p4BranchesInGit() is looking for ^p4/.

Hmm, ok. Submitting from B doesn't work for me either, as I said in my
previous mail... Tried my recipe now. I get the same problem with C.
The "solution" I found was to run a "git-p4 sync" from C. Then git-p4
will create remotes/p4/master in addition to remotes/origin/*. Then it
worked for me.

-Tor Arvid-

> -Thomas
>
> -----Original Message-----
> From: Tor Arvid Lund [mailto:torarvid@gmail.com]
> Sent: Tuesday, March 23, 2010 10:38 AM
> To: Thomas Kistler
> Cc: Benjamin Meyer; git@vger.kernel.org
> Subject: Re: git-p4 and git clone
>
> On Tue, Mar 23, 2010 at 4:37 PM, Thomas Kistler <tkistler@nvidia.com>=
 wrote:
>> That doesn't seem to work. With --import-local, I can't even submit =
back from the original repository.
>
> Hi.
>
> For me it works in this scenario:
> If your perforce depot is A, you "git-p4 clone --import-local" that
> into B, then git clone B into C. From C you should be able to do
> git-p4 submit.
>
> So, my normal recipe (if anyones interested) is to not use B for
> anything other than importing from p4 and functioning as a clone
> source. Like so:
>
> $ git-p4 clone --import-local //depot/A@all B
> $ mv B/.git B.git
> $ rm -rf B
> $ cd B.git
> $ git config core.bare true
> $ rm refs/heads/master
> $ echo ref: refs/heads/p4/master > HEAD
>
> (Then I have a script that does "git-p4 sync --import-local" every so
> often in this repo)
>
> ... And then on my working computer, I do:
>
> $ git clone user@remote:B.git C
> $ cd C
> $ [work, work, work, git commit]
> $ git-p4 submit
>
> ...And every so often:
> $ git-p4 sync
>
> (Disclaimer: recipe from memory... might not be 100% correct :-/)
>
> -Tor Arvid-
>
>> =C2=A0 =C2=A0$ cd tmp1
>> =C2=A0 =C2=A0$ git-p4 clone --import-local //foo/bar
>> =C2=A0 =C2=A0$ cd bar
>> =C2=A0 =C2=A0$ git checkout p4/master
>> =C2=A0 =C2=A0$ git-p4 submit --verbose
>>
>> Reading pipe: git name-rev HEAD
>> Reading pipe: git config git-p4.allowSubmit
>> Reading pipe: git rev-parse --symbolic =C2=A0--remotes
>> Reading pipe: git cat-file commit HEAD~0
>> Reading pipe: git cat-file commit HEAD~1
>> fatal: Not a valid object name HEAD~1
>>
>>
>> -----Original Message-----
>> From: Benjamin Meyer [mailto:ben@meyerhome.net]
>> Sent: Monday, March 22, 2010 5:15 PM
>> To: Thomas Kistler
>> Cc: 'git@vger.kernel.org'
>> Subject: Re: git-p4 and git clone
>>
>>
>> On Mar 22, 2010, at 7:16 PM, Thomas Kistler wrote:
>>
>>> I'm probably missing something fairly fundamental but I'm running i=
nto problems with cloning a git-p4 repository:
>>>
>>> First, I'm setting up a git-p4 master repository:
>>>
>>> =C2=A0 =C2=A0$ cd tmp1
>>> =C2=A0 =C2=A0$ git-p4 clone //foo/bar
>>>
>>> Then I'm cloning it through git:
>>>
>>> =C2=A0 =C2=A0$ cd tmp2
>>> =C2=A0 =C2=A0$ git clone tmp1/bar
>>>
>>> Finally, I'm trying to submit back to p4:
>>>
>>> =C2=A0 =C2=A0$ git-p4 submit
>>>
>>> This now fails because the remotes/p4/master seems to get lost when=
 doing the "git clone". Is this supposed to work?
>>>
>>> -Thomas
>>
>> There is a -import-local option you can use. =C2=A0Then the p4/maste=
r branch is local and when you do the second clone you will get the p4/=
master branch.
>>
>> -Benjamin Meyer
>> --------------------------------------------------------------------=
---------------
>> This email message is for the sole use of the intended recipient(s) =
and may contain
>> confidential information. =C2=A0Any unauthorized review, use, disclo=
sure or distribution
>> is prohibited. =C2=A0If you are not the intended recipient, please c=
ontact the sender by
>> reply email and destroy all copies of the original message.
>> --------------------------------------------------------------------=
---------------
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
