From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Tue, 21 Oct 2014 01:44:38 -0700
Message-ID: <20141021084436.GA39148@gmail.com>
References: <1413803017-30489-1-git-send-email-ocroquette@free.fr>
 <xmqq7fzu4rve.fsf@gitster.dls.corp.google.com>
 <xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
 <54455334.8000503@gmail.com>
 <xmqqfvei37qg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Olivier Croquette <ocroquette@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 10:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgV3K-00010A-MF
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 10:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbaJUIoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 04:44:19 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50098 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbaJUIoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 04:44:17 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so931836pab.37
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RYk3wcOmk/kSgFb7hxAanxiXumbAFPH3WibHF/6jwBc=;
        b=D5c8RlKL7it+HHE/ZT1wbxSPyCKUqB3RXazq7qL/0di2fLL0/h6m6zZxPlKWEb8biG
         9R/LYW/7Z3YJZZMuWXeRYJ3dnmh5QPYzxUt9j5FjoD3sR/9jXn3fpzvvgAC14dBgE1bl
         RcLqKF1aZvCue1dQkOYIGf8JxDAjdn2WRkkqXWw9gFclYrJ8Ap8LMYz+R9AlHgyh1y2x
         YYEcz8leg0L1CsRN6pl1DxX5WcivUUPvG/70xui5gf3DkzLxRzT20pNawALF7xflMJ6s
         6HWT4VrOUNS8X7usc70pHpDpZ+Dgtg07oP+xMmoJbZPrVq+l24Z14qGRbNVp9UaP43dm
         YidA==
X-Received: by 10.68.112.193 with SMTP id is1mr33464585pbb.35.1413881056657;
        Tue, 21 Oct 2014 01:44:16 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id cl1sm11135471pbb.92.2014.10.21.01.44.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 01:44:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvei37qg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 20, 2014 at 11:40:23AM -0700, Junio C Hamano wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> >> Perhaps something like this, so that existing users can still use
> >> "bc3" and other people can use "bc" if it bothers them that they
> >> have to say "3" when the backend driver works with both 3 and 4?
> >
> > That indeed sounds like the best approach.
> >
> >> --- a/git-mergetool--lib.sh
> >> +++ b/git-mergetool--lib.sh
> >> @@ -250,7 +250,7 @@ list_merge_tool_candidates () {
> >>   			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
> >>   		fi
> >>   		tools="$tools gvimdiff diffuse diffmerge ecmerge"
> >> -		tools="$tools p4merge araxis bc3 codecompare"
> >> +		tools="$tools p4merge araxis bc bc3 codecompare"
> >
> > Why keep bc3 here?
> 
> I didn't carefully look at the code that uses this list to see if we
> have to list everything or can list just the ones we recommend, and
> erred on the safer side (unlike the one for completion where I
> omitted bc3 as "deprecated").

We should drop "bc3" here.  This is the list of candidates that
is used when no configuration exists.  Listing "bc" twice here
implies that we might try that candidate twice.

Otherwise, this patch looks like the right way to go ~ it makes
"bc" available and keeps compatibility for "bc3".

If we wanted to phase out "bc3" for Git 3.0 we could start
warning inside of the "bc3" scriptlet, but I don't see any
reason to do so a.t.m.

Thanks,
-- 
David
