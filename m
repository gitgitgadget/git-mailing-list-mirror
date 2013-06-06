From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 6 Jun 2013 01:41:05 -0500
Message-ID: <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<51AEE1C3.9020507@viscovery.net>
	<20130605071206.GC14427@sigill.intra.peff.net>
	<51B02D81.3000700@viscovery.net>
	<20130606063754.GA20050@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 06 08:41:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkTsq-0001nj-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 08:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab3FFGlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 02:41:09 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:59346 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab3FFGlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 02:41:07 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so2249038lab.18
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OjCgYnjLSagUJBZLtaJMGTi3CHtMLqdhAS9YQrFzQiE=;
        b=KYfN7pJH5JXlfDthHCUpP5s2phlGv3nvCs6jYSNqwouF2q1P0sB9M4oE34YkpUpZky
         JG/5IxMJ7waPJjK9Ho/D96mX1eYj18cIFsfLVpNmGgU3i5bmXAUSNP4H+QnN7d+PJPum
         Ao7e+I5CG+8Ags5odlfABH2q7h3vOKAq6vDjjQXKYMjVHKf14HAzhn9cqG1oYlOyEpXS
         mG3+7lxul4qsSDCThgBF9G/OA1k1v+AOSbYakSkhutjLJyDFAdYFHWgqW7rMogHLVB+A
         hO+7Cp0BgrMb+xAOGXKdK5OGJfx/gSfHvJnUTVzq+FkGqqmOdTPEbZ419UjSVXoxlWm3
         F+gQ==
X-Received: by 10.112.142.73 with SMTP id ru9mr16625173lbb.22.1370500865431;
 Wed, 05 Jun 2013 23:41:05 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 5 Jun 2013 23:41:05 -0700 (PDT)
In-Reply-To: <20130606063754.GA20050@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226481>

On Thu, Jun 6, 2013 at 1:37 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 06, 2013 at 08:34:41AM +0200, Johannes Sixt wrote:
>
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> The test case depends on that test-sigchain can commit suicide by a call
>> to raise(SIGTERM) in a way that run-command.c::wait_or_whine() can detect
>> as death through a signal. There are no POSIX signals on Windows, and a
>> sufficiently close emulation is not available in the Microsoft C runtime
>> (and probably not even possible).
>>
>> The particular deficiency is that when a signal is raise()d whose SIG_DFL
>> action will cause process death (SIGTERM in this case), the
>> implementation of raise() just calls exit(3).
>>
>> We could check for exit code 3 in addition to 143, but that would miss
>> the point of the test entirely. Hence, just skip it on Windows.
>
> Thanks. I wasn't quite clear on how the signal handling worked on
> Windows, but from your description, I agree there is not any point in
> running the test at all.

Shouldn't we clarify that Git exit codes only work on UNIX-like
operating systems?

-- 
Felipe Contreras
