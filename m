From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in 
	write_entry()
Date: Mon, 20 Apr 2009 16:25:29 +0200
Message-ID: <81b0412b0904200725j22de23cajfd4b1cf119e69721@mail.gmail.com>
References: <49EC2F7C.8070209@viscovery.net>
	 <20090420110302.GB25059@dpotapov.dyndns.org>
	 <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
	 <20090420133305.GE25059@dpotapov.dyndns.org>
	 <81b0412b0904200654w1606a31fu227fa535cc14e10d@mail.gmail.com>
	 <49EC845D.6020107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuSf-00052S-35
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbZDTOZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 10:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756112AbZDTOZc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:25:32 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:56862 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbZDTOZb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 10:25:31 -0400
Received: by gxk10 with SMTP id 10so563370gxk.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z57GBlD2SNlcFAqlir9ddjdk4SgW7WP5JbUL/SbaDfY=;
        b=yE5Z8k0g2eXcCjZmZLv0s2HYsTAv50FWkmbvcRZkD5liGujYyRCyNU7kHaHyencLa6
         UoB6E2lbhBtEmMEHh+K13VtGGHGQD616cMH1oEJRaVjvwF5S/r6Bx87lK88BBlXuTbLe
         xXM8d5cnaI38r/tMOeXDFKjs8UBVLRXUVPthI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MiffNOu9TeY+hJhx+bbnT5EIab3SpfD+SdPRZ6/ZUc+HRlo0AqG2CmtMlEpKzQtBgn
         5xDUT007yM0FdVVrwXTOw1KUs2ZcFNeNhHLjZkR8jEI1R/rIJcAmAHvK7lKdup2ZyXzV
         aig08FqPV+I4uZUc1yT4vahPCP/KMaIoZ8lok=
Received: by 10.150.156.5 with SMTP id d5mr6495374ybe.119.1240237529653; Mon, 
	20 Apr 2009 07:25:29 -0700 (PDT)
In-Reply-To: <49EC845D.6020107@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116990>

2009/4/20 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>> 2009/4/20 Dmitry Potapov <dpotapov@gmail.com>:
>>> If the time passed between the creating file and end of writing to it is
>>> small (less than timestamp resolution), you may not notice the problem.
>>> The following program demonstrates the problem with fstat on Windows.
>>> (I compiled it using Cygwin). If you remove 'sleep' then you may not
>>> notice the problem for a long time.
>>
>> And the Windows being as slow as it is, the problem can stay undetected for
>> a long time in a real working code.
>
> You got that wrong: If Windows were slow, the error would have been
> triggered more often and it would have been detected earlier. There you
> have the proof: Windows is fast ... enough :-P

Err, yes. Still a piece of cpp junk
