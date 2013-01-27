From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 27 Jan 2013 08:43:46 +0100
Message-ID: <5104DAB2.5000606@web.de>
References: <201301120650.46479.tboegi@web.de> <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de> <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org> <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org> <51037E5F.8090506@web.de> <7v1ud71uys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 08:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzMud-0005Y5-2B
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 08:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab3A0Hn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 02:43:59 -0500
Received: from mout.web.de ([212.227.15.4]:50664 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756121Ab3A0Hn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 02:43:57 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Lud4y-1UynB42i12-00zip9; Sun, 27 Jan 2013 08:43:47
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v1ud71uys.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:NXI0D1M3TdlUXD4mk5VFopqxr74nYUec1k+VdOugHdK
 R11wTpsQg9wAOlYMWLLzRvvzcvz4m3dWorKDvqQTDCmkcEu8Zk
 bHVQWrBOLhxvBtmirckWQml/IsKZ1WPoHot2S1+5+hIfhggCet
 DIylw2QbOwY7d1eg90Vb8bfMt30btQSTCar/fVhCOdO0rHWNn5
 Ova5eP/FhxvkbAMDmsP6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214684>

On 26.01.13 22:43, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Do we really need  "which" to detect if frotz is installed?
> I think we all know the answer to that question is no, but why is
> that a relevant question in the context of this discussion?  One of
> us may be very confused.
>
> I thought the topic of this discussion was that, already knowing
> that "which" should never be used anywhere in our scripts, you are
> trying to devise a mechanical way to catch newcomers' attempts to
> use it in their changes, in order to prevent patches that add use of
> "which" to be sent for review to waste our time.  I was illustrating
> that the approach to override "which" in a shell function for test
> scripts will not be a useful solution for that goal.
Yes, the diskussion went away.

I would rather see the check-non-portable-shell.pl enabled per default.

It looks as if the "which" command is hard to find, when we want a mini=
mal
risk of false positves.
I can see different solutions:

1) We can make a much simpler expression which only catches the most
common usage of which, like
"if whitch foo".

This will not catch lines like

if test -x "$(which foo 2>/dev/null)"

But I think the -x is not a useful anyway, because which should only
list command which have the executable bit set.

2) We drop the which from check-non-portable-shell.pl

I'll send a patch for 1)
/Torsten
