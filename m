From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared
 repos
Date: Fri, 8 Jan 2016 17:05:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601081704280.2964@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <cover.1452085713.git.johannes.schindelin@gmx.de> <c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
 <xmqq1t9t3vn8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZYi-0002Tc-Ad
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637AbcAHQGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:06:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:54075 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705AbcAHQGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:06:31 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MTSrf-1ag0QT3pFH-00SQfj; Fri, 08 Jan 2016 17:05:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq1t9t3vn8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:E+DnF1cSjIFUtEUPwuNePTPROqWZNqdvrHW9zKKveMwHMzii2jk
 y/h76dphxFUDluJtC31SgROfIdmK9UlLrkpTsNhqH0UfMU4A3JqRcRcsoFGL1EV39Jb37zx
 IarfbSwkUAh7e2/W/uTQ/y2m1PvdS0F3xNU6VIApwBTFUB5gR2MAdmcT6Nu7mEwVzhrbsnZ
 4Pm1y4nYBi9kvNcwpumvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tpurJ/DVK+8=:LfmP1vB89l7bfK4AxhS1EZ
 GRSOtQmxM0ZuopGjNj04ZT+HJfXSt/gjK21EtqmZkmfzAMRMN1Sz/YMmcFNvg6otcu0LfjpH7
 3vbqaRAuBLIRINcdZw3dd2MUL11rkHM+6nEZ2+ste8afLbGYb7JgbP1ge9q4elIjgn2Rcj6fC
 DiTw/Ebxlx9nilMZk+yWhmLtOp+MyrkfrQl2nifCXjXkxis3rK/2IuVWl5Ji60guvaFa1Sx99
 aDhMFye88zjGd2TUwCcdvTi9k1ZKVjRISSh6OzzwNMsEIIxzvemQTNCLzs/UzVBP7rNfDBsjz
 Z4fGxFOxy2EieiAxUqZwKbiiison6/SukmqIPENd/mmcHy1WAiEt0lCkKjInBTcVRIzldzLTx
 +c5G02t2dHxfm1gg1pjAy67v4xIRvTTRfAkh8BtguW6Cb6bkU07lk99GlNAoaAkfFAFgQBm2l
 UYmprNpGnEpYRxnDoiJK+Q1wUi+Lpx6jQHEKyr5LiQhqX36O6hCqeKqophU+QklxJrVbbmFwp
 ohIsVs1XZRdy0IKTu9Z0JvmlvLFgV9H9YaYvIQ2ZbzPS75oBPnLHN2oF6PBptzxs3VHXUrc8U
 FlzVTLzPR4NgiBhhgpVHL7QQIt+qb+Jkox8KSM4ZAJw9KOh2VlVqHNylCJmfIhbVIQTS4rBur
 aq4QIiusTELC1NOP95+fy0txNQdEHQ+giihJW9RbPDvu0MyfdwgvBGAf2+55TD/yv+zrKmYtS
 IENVxq5PYxAPA28XRu1MkVCvyA9dddwzkyVn3sf/WCgoia4DeYPqmKs/4KcPsfz24tD6wDWg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283560>

Hi Junio,

On Thu, 7 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > - git apply, when writing rejected hunks
> 
> Today I may try to apply and leave hello.c.rej; tomorrow you may try to
> apply a different patch and get rejection for the same file.  And you
> would not be able to if my umask is 077.

As I just wrote in my reply to Peff: my experience with .rej files is that
I want to inspect them, and then delete them once I addressed them. I do
not want anybody to interfere with that, as the presence of .rej files
serves also as a TODO list.

> > - git fast-import, when writing a crash report
> 
> I am not sure about this one.  Is the crash report designed to get
> unique filename every time you run?

Yes, the pid is part of the file name. So we're golden.

Ciao,
Dscho
