From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git annoyances
Date: Wed, 9 Apr 2008 13:08:39 -0400
Message-ID: <32541b130804091008h1a757552o14dd8e937ed19058@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <20080409145758.GB20874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 19:09:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjdnZ-0005cV-Ch
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 19:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYDIRIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 13:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYDIRIl
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 13:08:41 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:52928 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYDIRIk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 13:08:40 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3649518mue.5
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=d3p1kKAd7KXpcTZvla3VF5ZS9W8nyI8sOixM7y3fg38=;
        b=H/51zDkjPWStxy3sAuPUXbY8ckK7m82/wNPhWUcxBmZRiB/NCF7GNGPcVbC9ly5oIH3S80QCUes4WLT7SdhKT1/5NBqzGUBBeipPqudLIyrPCyap2qcUXm42zIjcb0uWKaOJw9MSO0+KoJz46vhIVyvQ8heRrPXHHEvcrUJ0UL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FaOmF3FKZL0XuUIBorJ76ZhjZKWvyDXmVlIWVtAblISYJdzByUxmBbuN0t+IwyFVerEFfbHZJbqIykuZ6gTvWa2xKQlNrC5j4iLx1YeePCAJHoyFOZl8/BsvoJfV8Ag9GP2XG6iEkp2W02lba0AEUU7ylHtOwnrTMmiA2HcA9Ck=
Received: by 10.82.120.18 with SMTP id s18mr572119buc.44.1207760919224;
        Wed, 09 Apr 2008 10:08:39 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Wed, 9 Apr 2008 10:08:39 -0700 (PDT)
In-Reply-To: <20080409145758.GB20874@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79120>

On Wed, Apr 9, 2008 at 10:57 AM, Jeff King <peff@peff.net> wrote:
>  >  $ git-fetch x86/latest
[...]
>   git-fetch <options> <repository> <refspec>
[...]
>  >  $ git-pull x86 latest
[...]
>   git pull ~/linux-2.6-x86.git latest

My co-workers frequently get confused by this too.  The problem is
that "x86/latest" is a locally existing remote branch ref, while "x86
latest" is supposed to be a branch ref on a remote system.

I think the real problem here is that you can't refer to a
remote+branch as a single "word".  If you could, then people could
just learn to use that everywhere and never get confused.

For example, in svn you can talk about
svn+ssh://reposerver/path/to/repo/branches/foo@1234; it's a single
"word" that refers to a particular revision on a particular branch of
a particular server.  It therefore makes sense to talk about copying
from one branch to another, etc, using exactly one word for the source
and one for the destination.

Imagine if "git pull ~/linux/2.6-x86.git:latest" would work; then it
could mean exactly the same thing as "git merge
~/linux/2.6-x86.git:latest" (which would presumably switch to 'pull'
mode automatically).  Or even "git diff master..x86:latest", which
could diff my local master with an auto-fetched x86:latest.

Naturally we'd have to find a new punctuation mark for this, since all
the obvious ones are already used :)

Have fun,

Avery
