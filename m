From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 13:44:10 +0100
Message-ID: <52FB6C9A.30204@viscovery.net>
References: <52FB2268.7080906@viscovery.net> <CABPQNSZAK2d1hSQNG6uoNHoTJGCiq2UnaBP+_RJkPi47xaxGPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 12 13:44:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDZAr-0003dm-0e
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 13:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbaBLMoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 07:44:16 -0500
Received: from so.liwest.at ([212.33.55.18]:34276 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbaBLMoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 07:44:14 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WDZAg-0000EM-OY; Wed, 12 Feb 2014 13:44:11 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6EC8416613;
	Wed, 12 Feb 2014 13:44:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CABPQNSZAK2d1hSQNG6uoNHoTJGCiq2UnaBP+_RJkPi47xaxGPQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241987>

Am 2/12/2014 12:56, schrieb Erik Faye-Lund:
> On Wed, Feb 12, 2014 at 8:27 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
>> the following symptoms. I haven't followed the topic. Have there been
>> patches floating that addressed the problem in one way or another?
>>
>> (gdb) run
>> Starting program: D:\Src\mingw-git\t\trash directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap HEAD
>> [New thread 3528.0x8d4]
>> Bitmap v1 test (20 entries loaded)
>> Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits / 15873b36 checksum
>>
>> Breakpoint 1, die (err=0x5939e9 "Out of memory, realloc failed") at usage.c:97
>> 97              if (die_is_recursing()) {
>> (gdb) bt
>> #0  die (err=0x5939e9 "Out of memory, realloc failed") at usage.c:97
>> #1  0x00487c4c in xrealloc (ptr=0x12b10008, size=837107040) at wrapper.c:109
> 
> ~800 megs is a pretty large allocation for 32-bit systems. What gives?

That's exactly the problem: why would a tiny repository from the test
suite require such a large allocation? (Not to mention that the allocation
ultimately fails in my case.)
