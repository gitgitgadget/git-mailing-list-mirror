From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Thu, 18 Jul 2013 18:36:50 -0400
Message-ID: <51E86E02.4060208@gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org> <51E4AABD.9010701@web.de> <51E4C400.6000009@gmail.com> <51E82AE0.9050707@ramsay1.demon.co.uk> <51E862FC.4090607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 19 00:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzwol-00018F-50
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 00:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759467Ab3GRWgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jul 2013 18:36:55 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:55230 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759107Ab3GRWgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 18:36:54 -0400
Received: by mail-qc0-f180.google.com with SMTP id a1so2035384qcx.11
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HbwAEgZd8bisfTSEY/qeAjhErz+mac3JfocG5/yuREE=;
        b=A6q0TierPLC+PSDT4UwavrkUyPiePTBtdVCYEC+LPnMZQZAgo24oZdcBenaT70DtiB
         glZrSh7el4YHMLYC/lipomICrKPxHVGJhMvIJaftHXARzRn/f/AJ6LLAlzQ9ivk4GiLN
         xeY8BMzzq84QR/Vd09zAgkt6N5/ulIp4V074UpiBdituatduARz5kPWsRYWGGdSAvLHW
         /1sp8X08PrLOABKQiq6ZAi+skAUzlMuvxHRxM1lU2SKHhmePGbgSPDvKp6w4ciqD9pDF
         JQ6DFez5Dxy6J+mwGNJyPwZPPPegBmXJNUFcYCH0PInFkLJscu86vmlz7SwLoDgFJcWV
         mvsA==
X-Received: by 10.49.71.14 with SMTP id q14mr14456542qeu.90.1374187013468;
        Thu, 18 Jul 2013 15:36:53 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id a8sm19317899qae.11.2013.07.18.15.36.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 15:36:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51E862FC.4090607@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230760>

On 07/18/2013 05:49 PM, Torsten B=F6gershausen wrote:
> On 2013-07-18 19.50, Ramsay Jones wrote:
>>
>> Hmm, that looks good. :-D
>>
>> Torsten reported a performance boost using the win32 stat() implemen=
tation
>> on a linux git repo (2s -> 1s, if I recall correctly) on cygwin 1.7.
>> Do you have a larger repo available to test?
> (I have a 5 years old Dual Core, 2.5 Ghz, 1 TB hard disk, Win XP, cyg=
win 1.7)
> On that machine I can see the performance boost.
> Which kind of computers are you guys using?
>
> SSD/hard disk ?
> How much RAM ?
> Which OS ?
> Is there a difference between Win XP, Win7, Win8?
>
> [snip]
>
>
My previous results were from a Win 7 laptop, 2.7 GHz 2nd generation I7=
,=20
8 Gig Ram, 250 GByte spinning rust drive, all formatted NTFS.

Here's some more results, running WinXP in VirtualBox on my older Linux=
=20
laptop (2.5 GHz Penryn dual core, 500 GByte spinning rust, virtual file=
=20
system is NTFS). First, results using Ramsay's last patch on pu adding=20
the fast_lstat: Timing results are after first doing 5 'git status runs=
'=20
to assure the cache is hot:

% using the fast_lstat and friends...
/usr/local/src/git>time git -c core.filemode=3Dfalse status >& /dev/nul=
l

real    0m0.469s
user    0m0.062s
sys     0m0.436s
/usr/local/src/git>

/usr/local/src/git>time git -c core.filemode=3Dtrue status >& /dev/null

real    0m0.719s
user    0m0.030s
sys     0m0.686s
/usr/local/src/git>

And now the same. but using Ramsay's first patch that removes all win32=
=20
stat stuff and forces everything to go through Cygwin's normal stat/fst=
at:
% stat - with / without core.filemode, no win32 stats
/usr/local/src/git>time git -c core.filemode=3Dfalse status >& /dev/nul=
l

real    0m0.328s
user    0m0.093s
sys     0m0.264s
/usr/local/src/git>

/usr/local/src/git>time git -c core.filemode=3Dtrue status >& /dev/null

real    0m0.625s
user    0m0.124s
sys     0m0.500s
/usr/local/src/git>


Unlike the results on the fast Win7 laptop, the above show statisticall=
y=20
significant slow down from the fast_lstat approach. I'm just not seeing=
=20
a case for the special case handling, and of course Junio has already=20
voted with his preference of removing the special case stuff as well.

Mark
