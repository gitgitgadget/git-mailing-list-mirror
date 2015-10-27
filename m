From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] run-command: factor out child_process_clear()
Date: Tue, 27 Oct 2015 22:29:46 +0100
Message-ID: <562FECCA.6080703@web.de>
References: <562B756F.1020305@web.de>
 <xmqqziz5h3n5.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYopHL5D_7+bJV2P9GeKDHufPDBTo3a8bRL=4B3OmTGjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:30:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBos-0007pV-M4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbJ0VaD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2015 17:30:03 -0400
Received: from mout.web.de ([212.227.15.14]:56399 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbbJ0VaB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:30:01 -0400
Received: from [192.168.178.36] ([79.253.133.32]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LakkS-1aFCuH0qzI-00kKzO; Tue, 27 Oct 2015 22:29:53
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kYopHL5D_7+bJV2P9GeKDHufPDBTo3a8bRL=4B3OmTGjg@mail.gmail.com>
X-Provags-ID: V03:K0:B6XuH/nVQF6fJuibknCKXkzxbUr6GAFgqluh5eFBif7mKPTElnJ
 vOandgiYnvQ22nlVyVL8fMtKYjy67VqIlvT4Dln25p7hY5yiYLGJHKAv+JcGMPMNolEnCbA
 +YRYJooHKDGyC3O2mC4cWj5VRlUQlCWtMksQUYaC9yHlU7UAHsM0ReHnCHLaoewdK+IW1VD
 +5cVCRR15sUBd/IyoTaSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MhSENd/gm5E=:PmGrjmxc+c4BxSlSbreO9a
 +t6s+TW8jaEVjsVwz2KOyfQ7hXjqV2ZBtnMIJVPBExvASn2YWrf/yfDd9VPowAo6IWZbH51Ik
 QKYBoSttEmcXgd+MVEv3PC2/naadrzKBHa7VZIUPgvi8YKEkseyDD60zls43NZyQKp1sgzS/Z
 YNdEXYBRmJx8ow7Ac2cLq9W4KZLMaMCvscvHEEnVS3MA8lgeRUdX5YVTAqQKmkwnXEt1UPqD5
 cYhPARwrGGw8dMqoZYuGJDPEdqdMUYSHrrmv+rAg55Kw80fKDoXQsXemcZF+tu5rkS/HwD5nE
 LalTgKuzqrwXMiTPCUMwWIxeGNflv5zYkt6GJXj4JPTEKRGjADA3uIJBFaQQvQeSMunbre0MC
 LkaWJ8w8yXOiVmeYdT15DdRn8a5BHEQNfFkOwc7aghtwWlJSaF2y/pk2MSRZAg//kfcOjpANW
 r24wg5eIuA2ftkm28qb9h+rIvNml2SvUOPxln8ljJJE8Y0m8bh7Y8bVCevcKneoEGYSQEv3o+
 aEHh9Ikmd0/jFc6aLIbI/GfDijJjlxj50D+PQyU082QsG4crKLWiL7uAqhXAGbD6xZ1Z17scM
 y9VARqf61+rqDGBczG5fj2PnysZDkatFMX2UbVU7v3HLVSvqtglpuHHw/po0JKkUKQ9p/R3FU
 W79qjzrGmhX1nB1ZJwdbGY/y8Mmgf+Eu5c2RJF0/GrazFOrV7vh/rKdMUgIxN6/gBcQag+PAR
 PE+WlKI2YUn2FTY+aZpBO5mjB/wD5zKpZfgYMUsvqn804edKSorx/OIaxn+fYXDupYGVZPpB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280303>

Am 26.10.2015 um 20:23 schrieb Stefan Beller:
> On Mon, Oct 26, 2015 at 11:43 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Avoid duplication by moving the code to release allocated memory fo=
r
>>> arguments and environment to its own function, child_process_clear(=
).
>>> Export it to provide a counterpart to child_process_init().
>>>
>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>> ---
>>
>> Hmm, is this _deinit() Stefan added to his series recently?
>
> Yes. Although you (Junio) take credit for actually using it in these
> places, too. :)

Oh, and it's already in next.  I still like _clear() better (as in=20
{argv,object,ref,sha1}_array_clear(), or string_list_clear(), or ...)=20
than _deinit(), which seems to have been introduced by vcs-svn and isn'=
t=20
a real word.  I'll rebase my patches on top of this series, but probabl=
y=20
not before the weekend.

Ren=C3=A9
