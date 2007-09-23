From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sun, 23 Sep 2007 12:31:18 +0400
Message-ID: <20070923083118.GB99140@void.codelabs.ru>
References: <20070921214346.GF97288@void.codelabs.ru> <7vlkazh1ji.fsf@gitster.siamese.dyndns.org> <20070921214346.GF97288@void.codelabs.ru> <7v8x6zinjf.fsf@gitster.siamese.dyndns.org> <20070922035434.GA99140@void.codelabs.ru> <7vtzpnf6c9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 10:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZMsN-0007pA-EC
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 10:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbXIWIbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 04:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbXIWIbb
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 04:31:31 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:55107 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbXIWIba (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 04:31:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=D/8zfmavCzRrWIaZuSpxhbnrNXFkLoTMSLqYX2BME+flQOAf91L5on4f7yZ14ArcAK2T9xiQhrXapItMxFh9bJ8vRmt56SL2UVBZXxBbXHE9K5UIPD8axtlbE8Tuwis8Z4RZFeOzIQqG5fJQ+TL0qo7CAUcN3gilxISlVFXccXU=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IZMs7-000EdQ-BK; Sun, 23 Sep 2007 12:31:23 +0400
Content-Disposition: inline
In-Reply-To: <7vtzpnf6c9.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, score=-2.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58954>

Junio, *, good day.

Sat, Sep 22, 2007 at 01:32:38AM -0700, Junio C Hamano wrote:
> > OK, you're right.  Especially if /bin/sh from Solaris and OpenBSD
> > are working and they are not Bash.  But I would not tell that
> > the shell is broken now -- I had not seen the POSIX specification.
> > Does it specifies how the shell should work in this case?
> 
> I have always been assuming it to be the case (this construct is
> not my invention but is an old school idiom I just inherited
> from my mentor) and never looked at the spec recently, but I
> re-read it just to make sure.  The answer is yes.
> 
> Visit http://www.opengroup.org/onlinepubs/000095399/ and follow
> "Shell and Utilities volume (XCU)" and then "Case conditional
> construct".

Yes, thanks for the pointer.

> So, as David suggests, if
> 
>         false
>         case Ultra in
>         Super) false ;;
>         Hyper) true ;;
>         esac && echo case returned ok
> 
> does not say "case returned ok", then the shell has a bit of
> problem.

Correct: the current /bin/sh for FreeBSD does not set zero exit
code if no case patterns were matched.  So, I apologize for my quick
decision on the non-brokenness of the /bin/sh -- it is broken.

I had fixed the shell and filed the problem report.  May be the
change will be incorporated into the future release of FreeBSD.
Meanwhile, I had added workarounds to the other places Junio mentioned
in his follow-up and will try to push this patch to the FreeBSD
port of Git.  The explanation had been changed too ;))

Thanks to all people who helped me to realize what is wrong and where!
-- 
Eygene
