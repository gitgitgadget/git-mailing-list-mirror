From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Sat, 10 Mar 2012 08:13:55 +0100
Message-ID: <4F5AFF33.7090900@lsrfire.ath.cx>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch> <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 10 08:14:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6GVG-00020B-LY
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 08:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab2CJHOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 02:14:06 -0500
Received: from india601.server4you.de ([85.25.151.105]:39303 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab2CJHOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 02:14:04 -0500
Received: from [192.168.2.105] (p4FFD8E16.dip.t-dialin.net [79.253.142.22])
	by india601.server4you.de (Postfix) with ESMTPSA id 029832F8042;
	Sat, 10 Mar 2012 08:14:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192771>

Am 06.03.2012 14:15, schrieb Thomas Rast:
> 8c912ee (teach --histogram to diff, 2011-07-12) claimed histogram dif=
f
> was faster than both Myers and patience.
>
> We have since incorporated a performance testing framework, so add a
> test that compares the various diff tasks performed in a real 'log -p=
'
> workload.  This does indeed show that histogram diff slightly beats
> Myers, while patience is much slower than the others.
>
> Signed-off-by: Thomas Rast<trast@student.ethz.ch>
> ---
>
> The 3000 is pretty arbitrary but makes for a nice test duration.
>
> I'm reluctant to put numbers into the message, since the whole point
> of the perf test framework is that you can easily get them too.  But
> here's what I'm seeing:
>
>    4000.1: log -3000 (baseline)          0.04(0.02+0.01)
>    4000.2: log --raw -3000 (tree-only)   0.49(0.38+0.09)
>    4000.3: log -p -3000 (Myers)          1.93(1.75+0.17)
>    4000.4: log -p -3000 --histogram      1.90(1.74+0.15)
>    4000.5: log -p -3000 --patience       2.25(2.07+0.16)

Just a data point: --histogram is slightly slower for me:

    Test                                  this tree
    -----------------------------------------------------
    4000.1: log -3000 (baseline)          0.07(0.07+0.00)
    4000.2: log --raw -3000 (tree-only)   0.35(0.31+0.04)
    4000.3: log -p -3000 (Myers)          1.50(1.40+0.08)
    4000.4: log -p -3000 --histogram      1.54(1.48+0.05)
    4000.5: log -p -3000 --patience       1.79(1.71+0.06)

(baseline with -3000)

Ren=E9
