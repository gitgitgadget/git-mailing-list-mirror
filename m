From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/4] Add a function to release all packs
Date: Thu, 08 Oct 2015 21:10:46 +0200
Organization: gmx
Message-ID: <991eaf53b382e8156ef9486014c1a4a5@dscho.org>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444131898.git.johannes.schindelin@gmx.de>
 <9953f8ed40d0cf99f1be7cfe2fa0b699b7769645.1444131898.git.johannes.schindelin@gmx.de>
 <xmqq4mi2va9u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:11:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGai-0002Ig-R6
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbbJHTK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 15:10:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:63610 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbbJHTKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:10:55 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M8ehf-1aWIb62nH1-00wFnF; Thu, 08 Oct 2015 21:10:47
 +0200
In-Reply-To: <xmqq4mi2va9u.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:AALyM//SUdkIJ9hpa4dag45r1jdfKfuKLKOsEo0/3XIwVouozpb
 KLOzCkzwSQueF73h1iySWEoj6fJepYpwcDIPvzLu16PqArHlVs6tz4bDEPCKcnGAsHCGqGG
 /bWmqC8nUNfuPuZAFF/Wt7Uz/qB4ZThhmR1tJ8tvTy/QwIpxot6HVfUGjjNw7afk1gUfpLM
 wu7pU4TpJ3P1KPr5y+Dig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZkVq2jPpr3U=:JE0j8Oi7SeDr/8s4xKcvol
 nN78r+GL6AZi6LoCnvVM6Yp0G3BcLAa6yUHGc0hiNa2/t8HDvCPNJdzQsxbHVWZW1lqgoYiGL
 wM5v6hRsX3Fc9Mnf/97rAVL6ek3ue6nnRsk7BkrxQgpwAtWiKjYlZSCQk0nE7ANxxBYGwk4ET
 zHlGK4ptYw4oPRW+g5pVIDn422QhFPPSMQctfZTMhqkohXrPpZGd4f1rLiHaf2IlAoDgoI6Wh
 vSU+F+a1/K2QPQk1PaeoG8eYyh9hX8Mk6HS7snMrpDE4vKUohyXyFOo7x0svlzif99EYFUGR7
 44sLzqUzofpqy7BvkbIM6pTIcxwAkF4HUmJ2yFWyLZAyHS9ToOA081m+BY5yg7ILV4IQ8zy3R
 kj9mezHOIab60PWDy+ccu6RegoMssbOiwwBPvjIL/Zlu9haezF8aR5LsceJq6AhXROArUj0u9
 DQ9Q/FrrSbSX60FQih/kFQfI9Dynu6KJ2EtVWqnyyAB9IVAgGjCJt+g0/43T/tHMFdDPARp08
 KiF/FRcyTA87QNLDxItHQYzZ2qgnD8azEoXl/+lsLlBI71Xhir2cyeFNlWVWTwb1Xuq0XZbAL
 1m1Oo83zR8lOs9egpGp386i0keCngJLmtLUOWg96mLhZFOHoBKEL6YNa594or/7K7SnQoHv/l
 hpxglS+2spTb9OiAsu2oINYS5SpADwO6Kq3I/QgQejtUUsI9jDTE3GuMHLmz0ljoj05zfnzSH
 VonQwAvUrWgKGQ5B85YUBciJtkqqvsgsrNgt7A88Y3SibDauqdezL1//D88dhmviG9Gy8rKA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279263>

Hi Junio,

On 2015-10-07 19:49, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> On Windows, files that are in use cannot be removed or renamed. That
>> means that we have to release pack files when we are about to, say,
>> repack them. Let's introduce a convenient function to close them
>> pack files.
>>
>> While at it, we consolidate the close windows/close fd/close index
>> stanza in `free_pack_by_name()` into the `close_pack()` function that
>> is used by the new `close_all_packs()` function to avoid repeated code.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
> 
> This is the only one that was updated among the four and the change
> looks sensible.  I'd reword the end of the first paragraph of the
> proposed log message, though, to replace "close them pack files"
> with "close all the pack files and their idx files".
> 
> Thanks.

This time I was more clever and checked `pu` before sending off a fixed patch, seeing that you patched this already.

Thanks,
Dscho
