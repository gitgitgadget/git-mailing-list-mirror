From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Fri, 4 May 2007 11:36:21 +0200
Message-ID: <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
	 <20070503010312.GF4489@pasky.or.cz>
	 <200705040242.46156.jnareb@gmail.com>
	 <200705040921.33443.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 04 11:36:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjuDD-00074k-Fg
	for gcvg-git@gmane.org; Fri, 04 May 2007 11:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767743AbXEDJgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 05:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767753AbXEDJgY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 05:36:24 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:36367 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767743AbXEDJgX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 05:36:23 -0400
Received: by an-out-0708.google.com with SMTP id b33so773311ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 02:36:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hyudwm3igM5PS0vAMAx9eqgKRXLhwBaYelMcxk7NEeU1cveBKOSoQxvRSCGYTSavWLPjOAHp7eUEsGW6wQ8IkGhBOrlTttIkw2syQRSlZefRXgJdXL2N0EQsihZNC3OJ03irRAv2QM2vx/eFyajB+uFheyCfDjOoOcD6qhz+XB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dppHcF11I8SyhpOZwDI+gB3Lbo5DC520d7WNpEBmSESrsfw5nUJfCK54SxBD9hGk9kwmQ92Npb2L/r9zqgC7s7azaNWstYf4bXwoVvkBMsgFiQTKr562YThlM0xlltFPL1S2nrDRWYTHOPpdMa4XCMKgxywZQqgs6KYR/y13Hvk=
Received: by 10.100.43.9 with SMTP id q9mr2469591anq.1178271381923;
        Fri, 04 May 2007 02:36:21 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 02:36:21 -0700 (PDT)
In-Reply-To: <200705040921.33443.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46153>

On 5/4/07, Johan Herland <johan@herland.net> wrote:
> 1. "Reverts": Mark a commit as reverting another commit. This could be
> used by git-log to cancel out pairs of commits, resulting in a cleaner
> view of history. It can help blame/annotate. There are probably other
> tools that can benefit from this information also.
>
> 2. "Cherry-Pick": When cherry-picking a commit onto another branch, you
> should be able to tell git which commit you are cherry-picking
> (git-cherry-pick would of course do this automatically). This could
> enable git to make smarter decisions when merging the two branches: If
> the cherry-picked commit would cause a conflict with the original
> commit, git can either skip it (since it knows that one version of this
> patch is already present), or it can at least present the conflict to
> the user with some more context than what is available today. Not to
> mention how this information could be used by blame/annotate.

These are completely useless after the first "git gc --prune" or "git clone"
unless these tools taught to preserve the reverted or cherry-picked commits
(and all their history). And if you are about to teach them that, please notice
that as for now cloning and repacking does not even look at the
objects contents.
You'll absolutely kill their performance.
