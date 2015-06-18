From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Git completion not using ls-remote to auto-complete during push
Date: Thu, 18 Jun 2015 14:12:56 -0500
Message-ID: <CAHd499A5rUvHQBQx3GgoTGnhzOhXEwS4SFGOE=ujGo43nyTe1A@mail.gmail.com>
References: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
	<1434626973-4801-1-git-send-email-szeder@ira.uka.de>
	<CAHd499DeUOqsuSoysaOAAYORk3B=XBXco9yEKdXt8m4XJYFyZw@mail.gmail.com>
	<20150618175536.Horde.csrWs9ln__S_ZM2wEkboXw1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>,
	Git <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 21:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5fFH-0002Oq-OK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 21:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbbFRTM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 15:12:59 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38202 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869AbbFRTM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 15:12:57 -0400
Received: by igblz2 with SMTP id lz2so2329199igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SDvGcBnCNxheU9Tye9jL1OL+vDkxdPyQ2sE/n78EjDI=;
        b=iOyBWb3iMomnhXZ0M/1NKxNzSjc6rvgBvbvSqcMWEQhEAXPtUQ7T4xaBeOrzXS2Cev
         6etl4vIXPJlD4gICFMIla3MlzTYYlf4NQrPiSWSlKiupiRiblVfkFBq9wtl83X+3uHPY
         WFYxXfm4cjxQV7AFi2nFq/INKJ8XDI1g2jmQ8SZleYTC0A4842/Bg8ghabXWayItPK7u
         1spMDWs+1q17oO4WQq1jimBR+QBRIky+to9BpD7La9kUNtbTMNNR6fcKIVUVZtjXosuz
         AeI9ibqabRMUgYEfTZxbOI/iRflhsQQkWjowulxzT9ukz6+swJ5MiDQO/vCEMQR4CZD5
         Hzkg==
X-Received: by 10.42.83.212 with SMTP id i20mr7516026icl.91.1434654776961;
 Thu, 18 Jun 2015 12:12:56 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 18 Jun 2015 12:12:56 -0700 (PDT)
In-Reply-To: <20150618175536.Horde.csrWs9ln__S_ZM2wEkboXw1@webmail.informatik.kit.edu>
X-Google-Sender-Auth: 7pbgofaR7nBaVvRTZzEVVbza7-4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272035>

On Thu, Jun 18, 2015 at 10:55 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
>
> Quoting Robert Dailey <rcdailey.lists@gmail.com>:
>
>> On Thu, Jun 18, 2015 at 6:29 AM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>>>
>>> Quoting Robert Dailey <rcdailey.lists@gmail.com>
>>>>
>>>> I do the following:
>>>>
>>>> $ git push origin :topic
>>>>
>>>> If I stop halfway through typing 'topic' and hit TAB, auto-complet=
ion
>>>> does not work if I do not have a local branch by that name (someti=
mes
>>>> I delete my local branch first, then I push to delete it remotely)=
=2E I
>>>> thought that git completion code was supposed to use ls-remote to =
auto
>>>> complete refs used in push operations. Is this supposed to work?
>>>
>>>
>>> It's intentional.  Running 'git ls-remote' with a far away remote c=
an
>>> take ages, so instead we grab the refs on the remote from the local=
ly
>>> stored refs under 'refs/remotes/<remote>/'.
>>>
>>> See e832f5c096 (completion: avoid ls-remote in certain scenarios,
>>> 2013-05-28).  The commit message mentions that you can "force"
>>> completion of remote refs via 'git ls-remote' by starting with the =
full
>>> refname, i.e.  'refs/<TAB>', however, that seems to work only on th=
e
>>> left hand side of the colon in the push refspec.
>>>
>>> G=C3=A1bor
>>>
>>
>> If that's indeed the case, then completion should work. I have a
>> 'refs/remotes/origin/topic'. Why will auto complete not work even
>> though this exists? Do multiple remotes cause issues (in theory ther=
e
>> is no reason why it should cause problems, since it should know I'm
>> auto-completing a ref on 'origin')?
>
>
> The number of remotes doesn't matter.
> What matters is which side of the colon the ref to be completed is.
>
> You can complete
>
>   git push origin refs/<TAB>
>
> and
>
>   git fetch origin refs/<TAB>
>
> will even list you refs freshly queried via 'git ls-remote'.
> However,
>
>   git push origin :refs/<TAB>
>   git push origin branch:refs/<TAB>
>
> don't work, because there are no refs starting with the prefix ':refs=
/' or
> 'branch:refs/'.
>
> G=C3=A1bor
>

Interesting. So is it just a glaring bug that the git completion
script isn't ignoring the : and anything to the left of it? Or is this
beyond the control of the script?
