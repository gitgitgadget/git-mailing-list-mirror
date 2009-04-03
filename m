From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] Re: [PATCH] Add custom memory allocator to MinGW and 
	MacOS builds
Date: Fri, 3 Apr 2009 21:12:11 +0000
Message-ID: <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com>
	 <49D61B35.8060508@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: marius@trolltech.com
X-From: git-owner@vger.kernel.org Fri Apr 03 23:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpqhv-0002Dz-Oq
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 23:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582AbZDCVMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 17:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755760AbZDCVMP
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 17:12:15 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:53808 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbZDCVMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 17:12:14 -0400
Received: by ewy9 with SMTP id 9so1147452ewy.37
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hZDOUheaIIbmteojva7dwZs9gdUxtjNUEv/B69fnNGg=;
        b=d3Mnq+7iakrgpunuPq2u8EFGmmDQ6Ik2M/mxSALEq2T7/jDU1H1l/upcKCU6GRF3dM
         R4kn70eb2beu+EAHR0hdOy0dDsm1o1KkAJlnNWA5mmvZ1gnzNduBbyFruWyV0wd63jTq
         dNne3QZZ96nId50RuEeA/IdugmSvEB88OpNgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q8WQIoVGC4oNBnnwUBV8K8yUedViYAfa3qFOAvyGswKyhsnJvEcce/7SxbLYLE2ojT
         KLzIDS4XqXWZp/2d5p2yflEyjSuAdgvuqS47F1abErto1BSdaeQL8fmWGyhufuxoW4JQ
         rjCqbGzElLSlTLyTYpK1MZWoz+8uPDBfPCtg4=
Received: by 10.216.44.211 with SMTP id n61mr570308web.133.1238793131227; Fri, 
	03 Apr 2009 14:12:11 -0700 (PDT)
In-Reply-To: <49D61B35.8060508@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115561>

2009/4/3 Marius Storm-Olsen <marius@trolltech.com>:
>
> Marius Storm-Olsen said the following on 03.04.2009 15:52:
>> The standard allocator on Windows is pretty bad prior
>> to Windows Vista, and nedmalloc is better than the
>> modified dlmalloc provided with newer versions of the
>> MinGW libc.
>
> Actually, it just struck me that it's probably the synchronization
> primitives which are better on Vista than XP, and not the memory
> manager? (Since mingw 4.3.3-tdm on XP and Vista most likely use the
> same dlmalloc fork?) ^shrug^
>
> Anyways, not that I haven't tried to 'tune' nedmalloc in any way, just
> ensured that it compiles with the different MinGWs which I
> benchmarked. So, if anyone feels like it, maybe we can squeeze more
> performance out of it by tweaking it.

The difference on Windows Vista is that the low fragmentation heap is
the default memory allocator. On Windows XP you need to enable it
specifically for an application. So a possible alternative to this is
just to enable the low fragmentation heap. (done via GetProcessHeaps
and HeapSetInformation Win32 API calls).

Pat Thoyts
