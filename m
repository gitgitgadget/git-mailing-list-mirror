From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Re: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 16:14:24 +0400
Message-ID: <20080416121424.GA3133@dpotapov.dyndns.org>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 14:15:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm6Xt-00058p-P8
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 14:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759665AbYDPMOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 08:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758934AbYDPMOl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 08:14:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:27856 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbYDPMOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 08:14:40 -0400
Received: by ug-out-1314.google.com with SMTP id z38so905587ugc.16
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=82/OSAOUhFbTrzyxwCl5HJ8VhQHHtyFHlAEr3pN3A+k=;
        b=Bzm+5WOkED7GE+TuAlW0Bi93g3V/UWkMMKlDrRFW0cGPqV8gfWcc1NWd1tB3vTZFRyvgfxyhvYCcInC1/8Ip5G7hAY3nNk8hk3TkEiARP5g5HMOC8rLO4BJ/vHuwQhbI1udF6xDQP6D61/YrqdM1HL+xIoXIvLy2OG426TwNl0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=On8oTJz6CUGu/HurIviboFSKUk4qFHJ64f1GthVycTKMua2+KyrxL6l9AGsYe05TQ1uICbYqmbnt06mnZr89gd5/5Gm51xxKQNZ5CxNcbY4O98QsEAom5ydwdfc0CuyE1h3tqzrhXn6Z6W7bEHqfb/PP1L8X04FCq12mTqxWUMI=
Received: by 10.67.106.13 with SMTP id i13mr6862998ugm.49.1208348075176;
        Wed, 16 Apr 2008 05:14:35 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id x33sm3572365ugc.68.2008.04.16.05.14.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 05:14:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79695>

On Wed, Apr 16, 2008 at 01:48:13PM +0200, Brian Foster wrote:
> 
>  now, showing that I am indeed essentially a git newbie,
>  WTF is a "graft"?  I don't recall running into the term.

info/grafts::
	This file records fake commit ancestry information, to
	pretend the set of parents a commit has is different
	from how the commit was actually created.  One record
	per line describes a commit and its fake parents by
	listing their 40-byte hexadecimal object names separated
	by a space and terminated by a newline.

Basically, you use it if you want to modify the history in your
repository. It is often used after importing to Git from some
other repository if you want to make some adjustment to history.
So, you edit info/grafts, then use gitk to verify that you got
what you want, and after that you run git-filter-branch to actually
overwrite the history.

info/grafts should never be used during normal work.


>  the goal is to put things into a sane state so any new
>  clones are healthy.  there's only one(?) existing clone,
>  which may or may not be(? become?) an issue.

If you run git-filter-branch then you'll change "fake" history
to the real one, and after that the repository can be cloned.
Please, make sure that you have a backup before any further changes.

Dmitry
