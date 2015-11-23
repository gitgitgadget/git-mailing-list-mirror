From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: branch --set-upstream-to unexpectedly fails with "starting point
 ... is no branch"
Date: Mon, 23 Nov 2015 19:59:48 +0100
Message-ID: <56536224.3050306@syntevo.com>
References: <5652F2D2.3050902@syntevo.com>
 <15ED3D48-282B-44EF-98C6-EA59F18D633E@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=c3=adn_Nieto?= <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:00:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0wLR-0006r8-2a
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 20:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbbKWTAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 14:00:04 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:36382 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbKWTAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 14:00:03 -0500
Received: from [91.113.179.170] (helo=[192.168.92.20])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1a0wKv-0002pv-IC; Mon, 23 Nov 2015 19:59:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <15ED3D48-282B-44EF-98C6-EA59F18D633E@dwim.me>
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281594>

On 23.11.2015 18:04, Carlos Mart=EDn Nieto wrote:
> Hello Mark,
>
> On 23 Nov 2015, at 12:04, Marc Strapetz <marc.strapetz@syntevo.com> w=
rote:
>
>> There is a strange "branch --set-upstream-to" failure for "clones" w=
hich haven't been created using "git clone" but constructed using "git =
init", "git remote add" and "git fetch".
>>
>> Following script first creates a "main" repository and then construc=
ts the clone. Finally, in the clone branches origin/1 and origin/2 will=
 be present, however it's not possible to invoke "git branch --set-upst=
ream-to" for origin/2 (it works fine for origin/1).
>>
>> I guess the behavior is related to following line in .git/config:
>>
>> fetch =3D refs/heads/1:refs/remotes/origin/1
>>
>> However, I don't understand what's the problem for Git here? Definit=
ely the error "starting point 'origin/2' is not a branch" is wrong.
>>
>
> That is indeed the issue. The configuration which is stored in the co=
nfiguration is a remote+branch pair. If there is no fetch refspec confi=
gured which would create the =91origin/2=92 remote-tracking branch, the=
 command does not know which remote and branch that would correspond to=
=2E

Thanks, Carlos, I understand now.

My goal is to have a clone which will only fetch specific branches, so =
I=20
guess I have to stick with "refs/heads/1:refs/remotes/origin/1" for the=
=20
beginning and for every new branch X add another=20
"refs/heads/X:refs/remotes/origin/X"? Or is there a better way?

-Marc
