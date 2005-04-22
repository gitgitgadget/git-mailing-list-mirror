From: Jon Seymour <jon.seymour@gmail.com>
Subject: [RFC] Is there a need for binary bit in cache/tree entries to properly support Cygwin builds of GIT?
Date: Fri, 22 Apr 2005 18:53:17 +1000
Message-ID: <2cfc403205042201534bef0276@mail.gmail.com>
References: <BAY22-F35C035C6AE6B9A45CDEF61FF2D0@phx.gbl>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 10:49:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOtqH-0007tg-IK
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 10:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVDVIxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 04:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVDVIxX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 04:53:23 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:41449 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261936AbVDVIxS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 04:53:18 -0400
Received: by rproxy.gmail.com with SMTP id i8so604475rne
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 01:53:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hxf1ZWIh3uAQYJSsI9swtqcREJ9W10lenIVPNk5xQ4UdAFPzzvz4gLOccRPC5LO1Xf1lF/Asjnaxc20M4uU1LlX4Pa/Atu/rk/BlEpieho9bvqQoBCh/E4jfy8PqtYDvGyK13HV9nSX2Ww3/FRWJ5uJCKR+JAfoIIbTjqEmsRn0=
Received: by 10.38.11.1 with SMTP id 1mr3217462rnk;
        Fri, 22 Apr 2005 01:53:17 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Fri, 22 Apr 2005 01:53:17 -0700 (PDT)
To: lode leroy <lode_leroy@hotmail.com>
In-Reply-To: <BAY22-F35C035C6AE6B9A45CDEF61FF2D0@phx.gbl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/22/05, lode leroy <lode_leroy@hotmail.com> wrote:
> I wonder if anyone is interested in using git on windows / cygwin.
> It almost compiles out of the box... just this one little thinggy
> that's glibc-specific (struct dirent . d_type)
> 
 
I wonder if a cygwin compile of GIT should be forced to strip CR's
from text files prior to checksum calculations and blob storage.
Otherwise, spurious differences may be introduced into text files that
are somehow munged while checked out in a Windows environment.

There is an argument that this should be done external to the GIT
core, but then every external non-unix tool that interacts with GIT
has to have heuristics to distinguish text from binary and they all
have to have the same heuristics.

So, perhaps there is an argument for using one of the unused "mode"
bits to encode a binary flag and add an option to update-cache that
allows the bit to be flipped if a blob is known to be binary. A cygwin
GIT binary could then be forced to strip CR's from blobs marked as
text, but a unix binary need not change its behaviour.

Regards,

jon.
