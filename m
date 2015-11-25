From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: branch --set-upstream-to unexpectedly fails with "starting point
 ... is no branch"
Date: Wed, 25 Nov 2015 17:27:50 +0100
Message-ID: <5655E186.8060205@syntevo.com>
References: <5652F2D2.3050902@syntevo.com>
 <15ED3D48-282B-44EF-98C6-EA59F18D633E@dwim.me> <56536224.3050306@syntevo.com>
 <12A15BA3-11C2-426A-87D6-421BA9708A51@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=c3=adn_Nieto?= <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Wed Nov 25 17:27:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1cv2-0003xk-C2
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 17:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbKYQ1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2015 11:27:42 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:52274 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbKYQ1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 11:27:42 -0500
Received: from [91.113.179.170] (helo=[192.168.92.20])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1a1cuw-0008NM-23; Wed, 25 Nov 2015 17:27:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <12A15BA3-11C2-426A-87D6-421BA9708A51@dwim.me>
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281719>

On 24.11.2015 17:58, Carlos Mart=EDn Nieto wrote:
>
> On 23 Nov 2015, at 19:59, Marc Strapetz <marc.strapetz@syntevo.com> w=
rote:
>
>> On 23.11.2015 18:04, Carlos Mart=EDn Nieto wrote:
>>> Hello Mark,
>>>
>>> On 23 Nov 2015, at 12:04, Marc Strapetz <marc.strapetz@syntevo.com>=
 wrote:
>>>
>>>> There is a strange "branch --set-upstream-to" failure for "clones"=
 which haven't been created using "git clone" but constructed using "gi=
t init", "git remote add" and "git fetch".
>>>>
>>>> Following script first creates a "main" repository and then constr=
ucts the clone. Finally, in the clone branches origin/1 and origin/2 wi=
ll be present, however it's not possible to invoke "git branch --set-up=
stream-to" for origin/2 (it works fine for origin/1).
>>>>
>>>> I guess the behavior is related to following line in .git/config:
>>>>
>>>> fetch =3D refs/heads/1:refs/remotes/origin/1
>>>>
>>>> However, I don't understand what's the problem for Git here? Defin=
itely the error "starting point 'origin/2' is not a branch" is wrong.
>>>>
>>>
>>> That is indeed the issue. The configuration which is stored in the =
configuration is a remote+branch pair. If there is no fetch refspec con=
figured which would create the =91origin/2=92 remote-tracking branch, t=
he command does not know which remote and branch that would correspond =
to.
>>
>> Thanks, Carlos, I understand now.
>>
>> My goal is to have a clone which will only fetch specific branches, =
so I guess I have to stick with "refs/heads/1:refs/remotes/origin/1" fo=
r the beginning and for every new branch X add another "refs/heads/X:re=
fs/remotes/origin/X"? Or is there a better way?
>
> If you want fine-grained control over what gets downloaded, you=92ll =
need to restrict either the configured refspecs or the ones which git-f=
etch gets.

Thanks, Carlos. I'll take this approach as it's the safer one.

-Marc
