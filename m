From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [msysGit] [PATCH 07/14] Fix __stdcall/WINAPI placement and function
 prototype
Date: Fri, 21 Aug 2009 21:42:44 +0200
Message-ID: <4A8EF8B4.1040100@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com> <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com> <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com> <200908211937.18296.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org, lznuaa@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeZzr-0001fm-Sp
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 21:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbZHUTlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbZHUTlr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 15:41:47 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:54884 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292AbZHUTlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 15:41:46 -0400
Received: by ewy3 with SMTP id 3so915416ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 12:41:42 -0700 (PDT)
Received: by 10.210.20.5 with SMTP id 5mr1341042ebt.59.1250883700972;
        Fri, 21 Aug 2009 12:41:40 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 5sm3479390eyf.38.2009.08.21.12.41.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 12:41:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <200908211937.18296.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126742>

Johannes Sixt said the following on 21.08.2009 19:37:
> On Freitag, 21. August 2009, Marius Storm-Olsen wrote:
>> -static __stdcall unsigned ticktack(void *dummy)
>> +static unsigned WINAPI ticktack(void *dummy)
> 
>> -static __stdcall unsigned run_thread(void *data)
>> +static unsigned WINAPI run_thread(void *data)
> 
> These two are not nice. As I said in an earlier mail: The
> documentation says that the thread function pointer that is passed to
> _beginthreadex must have __stdcall calling convention. Therefore, you
> should not change these to WINAPI.

WINAPI is just a define for __stdcall (since _MSC_VER >= 800 anyways; VC 
6.0 being _MSC_VER == 1200), and won't change.

So, IMO the change is not bad, and makes things less convoluted by using 
the same convention all over.

(And _beginthreadex actually accepts both __stdcall and __clrcall 
calling conventions.)

--
.marius
