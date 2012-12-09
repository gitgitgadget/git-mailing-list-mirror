From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Sun, 09 Dec 2012 22:05:04 +0100
Message-ID: <50C4FD00.4010003@gmail.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com> <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com> <7vsj7hfw6q.fsf@alter.siamese.dyndns.org> <50C25539.9010206@xiplink.com> <7vobi5fu3c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 22:05:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tho42-0000oa-1b
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 22:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759005Ab2LIVFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 16:05:10 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55650 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759001Ab2LIVFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 16:05:09 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so1205751eek.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=udsIXAA6ld+vnNsa5Ui2TXkkH6I3c5tUW3GWfNRvJlg=;
        b=kk3T02ZLQO9rgq7X/euJdVakHSHNZDnwJKrm3h97VrIIZP+LC4rgmnc5vCMkbyaxho
         w+izsgQGT/ATJP4ohOVXkPE+erETaGhal9tgE+fy7qzIBBeCgGGlPiSqDaadys+q5Uvi
         6W5VVq73XCtuXCLHDRri08VwDfah8FGloA57JJQDJ4NgeFc2HaYBQsfw1SIA2MXipD/E
         eh6L8AiK/8P9wLfpsbzNURpFPCHEYEZ40xjz+3FHolBMLQPMTpPop9V8/1q29yQUNb5m
         ziQLKklWFFnV9KjptsAOV8NvMg+hYsY/3Gm7vlJjaau0xITZ8hekmYhNNuSBvZV4iJVS
         55QA==
Received: by 10.14.223.135 with SMTP id v7mr41839717eep.41.1355087107744;
        Sun, 09 Dec 2012 13:05:07 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id v46sm39233368eep.1.2012.12.09.13.05.06
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Dec 2012 13:05:07 -0800 (PST)
In-Reply-To: <7vobi5fu3c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211241>

Hi Junio, Marc.

On 12/07/2012 10:08 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> It's FreeBSD 7.2, which I know is an obsolete version but I'm not able to
>> upgrade the machine.  I believe FreeBSD's sh is, or is derived from, dash.
> 
> Finally.  Yes, as you suspected, I am perfectly fine to explicitly
> set IFS to the default values.
> 
> I wanted to have specific names to write in the commit log message,
> in-code comments and possibly release notes.  That way, people can
> decide if the issue affects them and they should upgrade once the
> fix is made.
>
The Autoconf manual suggests against unsetting IFS instead of resetting
it to the default sequence for yet another reason: if IFS is unset, code
that tries to save and restore its value will incorrectly reset it to an
empty value, thus disabling field splitting:

    unset IFS
    # default separators used for field splitting
    # ...
    saved_IFS=$IFS
    IFS=:
    # code using the new IFS
    IFS=$saved_IFS
    # no field splitting performed from now on!

Not sure how this is relevant for the Git codebase, but maybe it is
something worth reporting in the commit message of a proposed patch.

Regards,
  Stefano
