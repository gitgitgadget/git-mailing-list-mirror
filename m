From: Salikh Zakirov <salikh.zakirov@gmail.com>
Subject: Re: git branch performance problem?
Date: Sat, 13 Oct 2007 02:32:22 +0900
Message-ID: <20071012173221.GA5475@makoto.usen.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri Oct 12 19:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgONJ-0002fm-Sh
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 19:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbXJLRc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 13:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXJLRc1
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 13:32:27 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:6873 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbXJLRc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 13:32:26 -0400
Received: by rv-out-0910.google.com with SMTP id k20so853458rvb
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        bh=NGcDDwF8mZFjBzQeLiVbrtJswdg6nAXhriYeC3wbEZQ=;
        b=bwnabUHOuzHOTPSi1eOG8JURlAdqCz1DGI0Dc4WRAKccl5VnGX96uWnHtGBD3jIpyPT4t66wiGE/Cwgxee0oEo8rxw6kfdNdbBMePBZlYwH49IiMfM4ZqyGhvqv8x5WzL04dasYhccE2mVREzusjxo3tU0fSxu/AcqTS9E39ZrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=sEaTEp/ojydYcZyoMYYXxEkX/aUtX9xwXJXIuQ6lq8YbRHCvnVhBIXFb/TRwYHwIH/wkI1vr5cGxU1Y0fEKhvPFUUEAvNukqiZi+0/fNaJjtWFnhls3gxvKXLCbJOKaGAAzOUxPfcegMYAbI0tNKEgSkoSOeMVr/Ep8Vq2CTfRE=
Received: by 10.141.154.5 with SMTP id g5mr1653147rvo.1192210345558;
        Fri, 12 Oct 2007 10:32:25 -0700 (PDT)
Received: from makoto ( [221.115.75.108])
        by mx.google.com with ESMTPS id k41sm1732152rvb.2007.10.12.10.32.24
        (version=SSLv3 cipher=OTHER);
        Fri, 12 Oct 2007 10:32:25 -0700 (PDT)
Received: by makoto (sSMTP sendmail emulation); Sat, 13 Oct 2007 02:32:22 +0900
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60698>

Han-Wen Nienhuys wrote:
> For cherrypicking convenience, I would still appreciate it if there
> was a mechanism similar to alternates that would allow me to view
> objects from an alternate repo; objects found through this mechanism
> should never be assumed to be present in the database, of course.

There exist a script contrib/workdir/git-new-workdir,
which creates a new working copy that literally shares the same object store.
It will share both object store and branches, so some care must be taken:
branch which checkout out in one shared working directory must never be
updated
(committed or pulled into) from the other shared working directory.

Said that, I personally find this trick very useful for browsing code 
from different branch and quick bug fixing.
