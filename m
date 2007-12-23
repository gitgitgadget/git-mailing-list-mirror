From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport: trying to convert freebsd cvs to git
Date: Mon, 24 Dec 2007 10:13:34 +1300
Message-ID: <46a038f90712231313k3d17a30bwa910dd9679851c92@mail.gmail.com>
References: <20071222171801.GE15286@genesis.frugalware.org>
	 <20071223172913.GA9297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	"Stefan Sperling" <stsp@stsp.name>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 23 22:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Y92-000637-Uw
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 22:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbXLWVNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 16:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbXLWVNh
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 16:13:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:2731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXLWVNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 16:13:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1003673ugc.16
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 13:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JtjZkdsAx4og8F0c3IZnKCJpyH0A+H6WENMuIQ5s6Hs=;
        b=Nd2urMCg58BdrqnRrzR9k3Mk5i07iedOgLJy9qJiSd84nQq3xK9e3hJYZ90qBHMYO/+kWtyapAbZF48VIvOVwWANmyBv0swB7tlYGxm0var2TNVHHemTiKKPmaxWMz5gYLiLy7W3zGEkSZemW97VrMse7i68Bt0SVAqRVcCQwb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uas9CDZHwONtGEka4UlHHpaihITtYkOJyjWjidxulV9OPFDjRywfsAzVqlr2b6xW7b6DMNDZAh5Y2OZtmKV39Pi9GQC67fgrkhvvaJ3jUFfAEENfzgqsXGhvWhbPE7K/z6RWD58cy/oNbLmwXUuIQQhdqD5hpdHA9Txy1hFVS/k=
Received: by 10.66.220.17 with SMTP id s17mr2484081ugg.20.1198444414721;
        Sun, 23 Dec 2007 13:13:34 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sun, 23 Dec 2007 13:13:34 -0800 (PST)
In-Reply-To: <20071223172913.GA9297@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69198>

On Dec 24, 2007 6:29 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Dec 22, 2007 at 06:18:01PM +0100, Miklos Vajna wrote:
>
> > then i tried:
> >
> > $ time git cvsimport -d `pwd`/cvs -C src.git src
> > Initialized empty Git repository in /home/vmiklos/git/freebsd/src.git/.git/
> > malformed revision
>
> This is the actual error; everything else is git-cvsimport failing to
> notice the problem and continuing anyway.
>
> I will take a look and see if it is simple to stop the process here and
> produce a better error message.

Indeed. Running verbose will name the branch name that triggers that
error. One thing I find useful is to capture the commandline passed to
cvsps (using ps), stopping cvsimport+cvsps, and running cvsps by hand
with the same commandline (remember to set TZ=UTC in the
environment!), saving STDOUT to a file.

Once you have the file, you can feed it to cvsimport with the -P
parameter (IIRC). Usually cvsimport errors are all about wonky cvsps
output.

For the record, I normally do my initial imports with Keith's
parsecvs, and then run incrementals using git-cvsimport. These
incrementals aren't 100% perfect, so I routinely check for 'drift'.

cheers,


m
