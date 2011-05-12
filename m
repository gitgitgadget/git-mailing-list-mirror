From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] Sequencer Foundations
Date: Thu, 12 May 2011 03:41:36 -0500
Message-ID: <20110512084136.GD28872@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <20110511131356.GI2676@elie>
 <BANLkTi=zXWojMOfe9sECUu-X9euCjr4i3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 10:41:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKRSv-0003B0-SB
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1ELIlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 04:41:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36157 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1ELIlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 04:41:42 -0400
Received: by iyb14 with SMTP id 14so1042958iyb.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ivd17C/r/o/geOSJGq8vtD1OHm708uRyRgmj2qwmuYc=;
        b=UUZjD3ltKByJ+6wLD9K8QBxmVzPU2gboO8GYat0mXLHYHxNrtcqS3y1rM7rS/nG1ov
         lXkktX609cYOUMxYoM9TwYKu9eN+naz8xx77v1IH/ls0mA7F+k9v7OieCuGgc2kQe1eP
         tBPSEctgYUNdDxXhRiJHPJsKAvW5fHAJmbeeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H/I9Y1PH3hPRE1zOzc5a2suVaUPT2GSJ8YvoADXWYJ/kC5LlUNS8nCIoctreXW3Uq3
         UpkifjtWfRWkdhrq9/jQ/01PqK2os98pqIndIcq6eDuTIresZktmcx2+1PaF37qwpvc6
         NVYzQmiO5OnESfPlwO4ZOnrVAD+3dIvKEY978=
Received: by 10.42.29.202 with SMTP id s10mr10589221icc.187.1305189701695;
        Thu, 12 May 2011 01:41:41 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id hc41sm431822ibb.30.2011.05.12.01.41.39
        (version=SSLv3 cipher=OTHER);
        Thu, 12 May 2011 01:41:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=zXWojMOfe9sECUu-X9euCjr4i3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173452>

Hi,

Christian Couder wrote:

> I think that the risk at this point might be to overengineer things
> and to lose time, and then we will perhaps find out that we need to do
> some refactoring of the merge_recursive API anyway.

I agree with the general principle... let's see if I understand the
details of what you are saying.

> If we have cherry-pick with --abort, --continue and --skip that just
> works as well or nearly as well (because it's new) as other stuff it
> will be already a very good thing.

Does "other stuff" mean scripts like "git rebase"?  If I understand
correctly, "git rebase" updates the $dotest directory before each
cherry-pick, unlike this series which only updates $dotest after a
failed cherry-pick.

> And with enough tests we will
> hopefully be able to build and refactor safely after that. Maybe we
> will eventually find out that what you suggest is in fact needed even
> for cherry-pick with --abort, --continue and --skip, but for now I
> would prefer trying to make it work with as few changes and work as
> possible.

I suspect that refactoring everything to use error() in place of die()
requires more risky changes and work than updating .git/sequencer/
between cherry-picks.  Of course I can easily be wrong.

Hoping that is clearer,
Jonathan
