From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:23:52 -0700
Message-ID: <4DB9CCD8.6090701@zytor.com>
References: <20110427225114.GA16765@elte.hu>	<7voc3r5kzn.fsf@alter.siamese.dyndns.org>	<20110428062717.GA952@elte.hu>	<BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>	<20110428093703.GB15349@elte.hu>	<BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>	<4DB93D16.4000603@cs.helsinki.fi>	<BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>	<4DB941CD.2050403@cs.helsinki.fi> <BANLkTikKUuBMDR2-OBYXw7jzs_+1wGacuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, kusmabite@gmail.com,
	Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:26:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFXms-00030L-5L
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 22:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933492Ab1D1U0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 16:26:04 -0400
Received: from terminus.zytor.com ([198.137.202.10]:44495 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab1D1U0C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 16:26:02 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by mail.zytor.com (8.14.4/8.14.3) with ESMTP id p3SKNqpY009705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 28 Apr 2011 13:23:53 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9
In-Reply-To: <BANLkTikKUuBMDR2-OBYXw7jzs_+1wGacuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172403>

On 04/28/2011 05:16 AM, Tor Arntsen wrote:
> On Thu, Apr 28, 2011 at 12:30, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>> Hi,
>>
>> On 4/28/11 1:19 PM, Erik Faye-Lund wrote:
> [alignment issues]
>>
>> Yes, ARM is a problem and I didn't try to claim otherwise. However, it's not
>> "impossible to fix" as you say with memalign().
> 
> MIPS (e.g. SGI machines) also bus-errors on non-aligned data.

On the other hand, MIPS has efficient instructions for accessing
known-unaligned data.

	-hpa
