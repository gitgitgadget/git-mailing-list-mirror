From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 04 Nov 2009 09:24:47 +0100
Message-ID: <4AF13A4F.5070300@viscovery.net>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>	 <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>	 <alpine.DEB.1.00.0911040031210.4985@pacific.mpi-cbg.de>	 <4AF0E842.2010201@workspacewhiz.com> <16cee31f0911032344m3263730l607c02eb4e9adef5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 09:25:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5bAs-0005pH-Pu
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 09:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbZKDIYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 03:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbZKDIYv
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 03:24:51 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:10293 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbZKDIYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 03:24:51 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5bAd-0001Z1-QD; Wed, 04 Nov 2009 09:24:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 952CBBC81; Wed,  4 Nov 2009 09:24:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <16cee31f0911032344m3263730l607c02eb4e9adef5@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132062>

[please don't cull Cc list on this ML]

Andrzej K. Haczewski schrieb:
>> Pardon my ignorance, but is there a reason to not use Pthreads for Win32?
>>  http://sourceware.org/pthreads-win32/
>>
> 
> Not using pthreads on Windows makes Git:
> 1. faster on that platform

I believe this only if you present hard numbers. My guess is that (for
example) packing objects with two threads is still faster with a slow
pthreads emulation than without threading at all.

> 2. not depend on Pthreads for Win32

Why is this an advantage?

> IMHO that makes Git one step closer to become native on Windows, and
> is a sensible step.

Emulating pthreads on Windows with all its facets is an extremely
difficult task. If exact POSIX conformance is needed, I would choose an
existing package over doing it myself at any time.

Granted, we don't need the esoteric parts (cancelation points), which
would simplify the emulation a lot. But, as I pointed out in my other
mail, even a pthread_cond_wait() is not that trivial to implement with the
Windows API.

-- Hannes
