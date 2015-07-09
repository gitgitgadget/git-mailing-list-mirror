From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of
 .gitmodules values
Date: Thu, 9 Jul 2015 21:41:30 +0200
Message-ID: <559ECE6A.2070802@web.de>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
 <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
 <CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
 <20150709120900.GA24040@book.hvoigt.net> <20150709154903.GA14320@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 21:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDHha-0006HY-JN
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 21:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbbGITln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 15:41:43 -0400
Received: from mout.web.de ([212.227.15.3]:55704 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbbGITll (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 15:41:41 -0400
Received: from [192.168.178.41] ([79.211.105.204]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MZAp2-1ZRVA03rdU-00KzBt; Thu, 09 Jul 2015 21:41:33
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <20150709154903.GA14320@peff.net>
X-Provags-ID: V03:K0:hVPmLqyw5sGJ1MR9S62anb9mm/Q701K7H4cRGjtaLdsVEVqOdTc
 gUVfZ++cnt/LtwoPithq9yQrcVHJBmFECVuVwDXdmXjPA7nOH7mRk1LAQAt7rggTy/EiyuL
 paEi/kJWtQOaa5huwpXDgLWv6pfTM4IbT0uhgwway4e3PjZqqdirmLFg+41SAcJej4kG5L0
 xj9DSCbAN/hs2fvRibdfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uD9MtVyzKGg=:QD5IEwyEJBja57FDonl4DJ
 vvUVyVFkx9OP+Jr3Bb5VH1tw80iqN77RAFthtbR5qc4Wcz8lLXcyfJyASeFo4mpQt+K5MC1SK
 Bev7Oc2dA67L2Nvqa2/xHK9SFQ2XuVxPu5JMCp6wU7J7UKpjvwKBCysgGumP7hHSWdy3mBGAz
 3HDBRgnhAUhurg2uAMsLgIV4vSG4P/0WiaZPw+FWAD31pCOwusbP87CQ6Z8ZO4vQ8py8avgxx
 ZsICYySyS7pQHIhfAEpEHzEhKccSqC/Zzho1Xd0m4sRPYTrbd9VSOHPS1PNggaUyuLcvNPDW1
 sDiUd85A0YuNrMwrC54EuLs7bBDJEpmHNj31nZrwbvrYRgTfendSAbtXMJWJuNz5/g9GNlaI0
 zEtE0ZJMlQvPGRvRjY3JhQ5MsW4KtbGHAVH6HtDM99gvxmDTfFA5OmrABHycqZ2du8S0FsQwB
 1vOWtRnoWdyTSThkP2fCKJHzgjAuO+DcRiGf4SDjXrfJOwDsFLNpIqU39sHe4ppy069BksTPw
 DsgF1YSkfj7eV6Q67yEBPp/GQsVqylUr8bF5uHKn5mAwh4B30KNjQTDPbJ2gh09HPWnzFxEvq
 TVSC+nHBOC8XV7O6Ea8U4KJk0zGy/HKWhSI8Sufb4g0GVRIcBTmBExDu+vdiMArZS/VEtI5Qc
 yLPL0E9Um/37o3HEuy4peTxMjfbvZF1qL59xsKE1rn59Ra92nryJvpZHYStojVopwnSw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273773>

Am 09.07.2015 um 17:49 schrieb Jeff King:
> On Thu, Jul 09, 2015 at 02:09:01PM +0200, Heiko Voigt wrote:
>
>>> Instead of test-submodule-config.c to test this new module, it could
>>> be useful to implement these as extensions to rev-parse:
>>>
>>>      git rev-parse --submodule-name [<ref>:]<path>
>>>      git rev-parse --submodule-path [<ref>:]<name>
>>>      git rev-parse --submodule-url [<ref>:]<name>
>>>      git rev-parse --submodule-ignore [<ref>:]<name>
>>>      git rev-parse --submodule-recurse [<ref>:]<name>
>>>
>>> Has this already been considered and rejected for some reason?
>>
>> No that has not been considered. But I am open to it if others agree
>> that this is a sensible thing to do. We should be able to adapt the
>> existing tests right?
>
> How does git-submodule access this information? It looks like it just
> hits "git config -f .gitmodules" directly. Perhaps whatever interface is
> designed should be suitable for its use here (and if there really is no
> more interesting interface needed, then why is "git config" not good
> enough for other callers?).

The git-submodule script doesn't need this and is fine using plain old
"git config", as by the time it is run the .gitmodules file is already
updated in the work tree. Heiko's series is about adding infrastructure
to allow builtins like checkout and friends to access the configuration
values from the .gitmodules file of the to-be-checked-out commit when
run with "--recurse-submodules". And yes, if we want to expose this
functionality to users or scripts some day "git config" looks like the
best place to do that to me too.
