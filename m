From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is
 empty
Date: Tue, 18 Nov 2014 17:25:02 -0500
Message-ID: <1416349502.3899.30.camel@mad-scientist.net>
References: <1416073760.9305.174.camel@homebase>
	 <xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
	 <s934mtwo0zv.fsf@mad-scientist.net>
	 <xmqq8uj8wbhl.fsf@gitster.dls.corp.google.com>
	 <1416344066.3899.25.camel@mad-scientist.net>
	 <xmqqegt0usy3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 23:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqrJZ-0001O6-55
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 23:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbaKRWb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 17:31:57 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:37814 "HELO
	gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755204AbaKRWb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 17:31:56 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Nov 2014 17:31:56 EST
Received: (qmail 16233 invoked by uid 0); 18 Nov 2014 22:25:16 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by gproxy2.mail.unifiedlayer.com with SMTP; 18 Nov 2014 22:25:16 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw4 with 
	id HAR91p00Z2qhmhE01ARCtK; Tue, 18 Nov 2014 15:25:16 -0700
X-Authority-Analysis: v=2.1 cv=B+wqjodM c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=5y4faFyK3SkA:10 a=uZvujYp8AAAA:8 a=53uO6-kKsmHYTbg-T2AA:9
 a=QEXdDO2ut3YA:10 a=8Dro3-UE7FAA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=qXC5cNPKLq09mmu2W2Fu1NAjGBR4xvunLSaLyO1ZOUQ=;
	b=ar/Gh3ocFyjrw4eIGtAmH8gHEX22SDQZwkPsI5v2s+6O8FZBP/PL2yflCFIXxXTcIp1zx0rAU7ru4SzLdHnG5Q4Q60kP39KobrvpqRo0JDUav97DxbuSPqzF7/s52qcI;
Received: from [173.9.45.73] (port=35468 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XqrCv-0006QY-BE; Tue, 18 Nov 2014 15:25:09 -0700
In-Reply-To: <xmqqegt0usy3.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2014-11-18 at 12:58 -0800, Junio C Hamano wrote:
> Doesn't the description of the -A option I quoted upthread hint a
> simpler and clearer solution?  I.e. "test $(ls -A | wc -l) = 0"?

Yes, but unfortunately for us the -A flag was added to POSIX Issue 7.
It's not present in the previous version of POSIX, Issue 6:

http://pubs.opengroup.org/onlinepubs/009695399/utilities/ls.html

It came from the BSD world, so it might not be available on older
SysV-derived systems (AIX, HP-UX, even Solaris... I don't have access to
these anymore so I can't say).  Ultimately it's probably more portable
to assume "ls -a" always prints "." and ".." than to assume "ls -A" is
supported.

Cheers!
