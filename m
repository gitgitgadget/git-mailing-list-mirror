From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Tue, 01 Apr 2014 22:23:18 +0200
Message-ID: <533B2036.3050506@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV5Du-0006cb-J5
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbaDAUXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:23:31 -0400
Received: from mout.web.de ([212.227.15.3]:50175 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbaDAUX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:23:28 -0400
Received: from [192.168.178.41] ([79.193.64.116]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MCZtW-1WLhXp3AKw-009Lhl; Tue, 01 Apr 2014 22:23:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5339FBB4.1010101@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ZeLyzqAeygJ2/VyePVrfsxZT3POSvoQRBq4ifJ7cVbB5iIHKMS0
 WxWOfsHYelK+5GEvTnZTUqkaoLKkvKik7Cu8wAZISDbyHedUa2vkVfga6upHREyr5iImYHC
 vZRrZNuF9zMApBsOhRfHvVQGD29NKf3I6VGLtgEXH0kKk8VdRTjt8YNCL8pacLX5xONeZMO
 NKPMfxd5SJaeZsutCmdSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245655>

Am 01.04.2014 01:35, schrieb Ronald Weiss:
> On 1. 4. 2014 0:50, Ronald Weiss wrote:
>> On 31. 3. 2014 23:47, Ronald Weiss wrote:
>>> On Mon, Mar 31, 2014 at 8:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>> As Junio mentioned it would be great if you could teach the add
>>>> command also honor the --ignore-submodule command line option in
>>>> a companion patch. In the course of doing so you'll easily see if
>>>> I was right or not, then please just order them in the most logical
>>>> way.
>>>
>>> Well, if You (or Junio) really don't want my patch without another one
>>> for git add, I may try to do it. However, git add does not even honor
>>> the submodules' ignore setting from .gitmodules (just tested with git
>>> 1.9.1: "git add -u" doesn't honor it, while "git commit -a" does). So
>>> teaching git add the --ignore-submodules switch in current state
>>> doesn't seem right to me. You might propose to add also support for
>>> the ignore setting, to make "add -u" and "commit -a" more consistent.
>>> That seems like a good idea, but the effort needed is getting bigger,
>>
>> Well, now I actually looked at it, and it was pretty easy after all.
>> The changes below seem to enable support for both ignore setting in
>> .gitmodules, and also --ignore-submodules switch, for git add, on top
>> of my patch for commit.
> 
> There is a catch. With the changes below, submodules are ignored by add even if explitely named on command line (eg. "git add x" does nothing if x is submodule with new commits, but with ignore=all in .gitmodules).
> That doesn't seem right.
> 
> Any ideas, what to do about that? When exactly should such submodule be actually ignored?

Me thinks git add should require the '-f' option to add an ignored
submodule (just like it does for files) unless the user uses the
'--ignore-submodules=none' option. And if neither of these are given
it should "fail with a list of ignored files" as the documentation
states.
