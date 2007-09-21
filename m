From: "Peter Stahlir" <peter.stahlir@googlemail.com>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 15:28:20 +0200
Message-ID: <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
	 <Pine.LNX.4.64.0709211208440.28395@racer.site>
	 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
	 <20070921125337.GA28456@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 15:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYiYV-0008AD-L1
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 15:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbXIUN2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 09:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756585AbXIUN2W
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 09:28:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:17697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbXIUN2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 09:28:21 -0400
Received: by ug-out-1314.google.com with SMTP id z38so519978ugc
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TewQR01YZ9IXHTlc92VUrQaauQdJPqc2SWGn4d/ywdA=;
        b=sDTmu+o0xh6KKzhsJlf6F8NK1oSH+Og2C8wN5WT7vffs06s89u1/EqXf9P+HjHMRuz0Fm3H3d1A+JIfpijZAD+eSGQdfV0EHvwRS4VZAXtAnx9s/yn8ftO4tnv4c0ifbTc5zXMQ2hWmn5/7irRu3Z2fnRFbKSfzBbcZIno0nXJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aATPNRnA6ayj7UrmXkFQXOrzet3oCjmVMiIGI9P9qCXNlo0M9s64MJ6lpIXPGePMVXTlGXCnoUCwW+uQdKfqYkbh3sSTSbGnch2UeJxNDw9f7HbyhZAkGf6IohcU8uCEBrCpbRQsFRhWf8Y11He3d4r2J9hwWVtQ2NyUOdogZMs=
Received: by 10.78.179.12 with SMTP id b12mr2018837huf.1190381300063;
        Fri, 21 Sep 2007 06:28:20 -0700 (PDT)
Received: by 10.78.140.12 with HTTP; Fri, 21 Sep 2007 06:28:20 -0700 (PDT)
In-Reply-To: <20070921125337.GA28456@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58849>

> > I wonder how big a deltified Debian mirror in one pack file would
> > be. :)
>
> Very, very close to 252 GB, since .deb files are already compressed.

Yes, but if there were deb and tar support in git (to automatically unpack
archives and store the contents), together with the best available
binary diffs I think the repository could be significantly smaller because
files common to all architectures could be deltified,

I did a quick check with 100MB of deb archives; the result was nearly 100MB
as you said.
I also did a quick check with all .so files in my /usr/lib directory; it shrunk
from 50MB to 20MB, the same is achieved with tar + bz2.

But the thing is, I think there is a lot of redundancy in
a) a Debian mirror or
b) your disk at home.

Telling git to handle -for example- deb archives and storing
everything in a pack file would take advantage of redundancy across
_all_ files.
So the /usr/share/doc of all architectures could be compressed.

Right?
