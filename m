From: Alex Chiang <achiang@hp.com>
Subject: Re: [StGit PATCH v2 3/6] stg mail: make __send_message do more
Date: Thu, 3 Dec 2009 12:30:19 -0700
Message-ID: <20091203193018.GF23258@ldl.fc.hp.com>
References: <20091202003503.7737.51579.stgit@bob.kio> <20091202004616.7737.60382.stgit@bob.kio> <b8197bcb0912012303i3bd1061fhdb391de096996a27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 20:30:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGHNi-0005yB-W7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 20:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbZLCTaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 14:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756772AbZLCTaN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 14:30:13 -0500
Received: from g4t0016.houston.hp.com ([15.201.24.19]:25220 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbZLCTaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 14:30:12 -0500
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id 64A0A1416A;
	Thu,  3 Dec 2009 19:30:19 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g4t0018.houston.hp.com (Postfix) with ESMTP id 3A71310127;
	Thu,  3 Dec 2009 19:30:19 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 19EA6CF0017;
	Thu,  3 Dec 2009 12:30:19 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVs6cX2bFjbd; Thu,  3 Dec 2009 12:30:19 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 05AABCF0007; Thu,  3 Dec 2009 12:30:19 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <b8197bcb0912012303i3bd1061fhdb391de096996a27@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134469>

* Karl Wiberg <kha@treskal.com>:
> Just pointing out a couple of Python tricks you might've wanted to
> use. No need to update the patch, though.
> 
> On Wed, Dec 2, 2009 at 1:46 AM, Alex Chiang <achiang@hp.com> wrote:
> 
> > +        (patch_nr, total_nr) = (args[1], args[2])
> 
> Can be written as
> 
>   (patch_nr, total_nr) = args[1:3]

Thanks, I did it this way.

> or, if args[2] is the last element of the list (which it isn't in this
> case?),
> 
>   (patch_nr, total_nr) = args[1:]

No, ref_id is the last arg, so that won't work.

> > +    for (p, n) in zip(patches, range(1, total_nr + 1)):
> > +        msg_id = __send_message('patch', tmpl, options, p, n, total_nr, ref_id)
> 
> Can be written as
> 
>   for (n, p) in enumerate(patches):
> 
> if you use n + 1 instead of n in the loop body.

That is a little cleaner, but I decided to keep it as zip(). Why?
Because using n + 1 in the loop body will push that line past 80
columns. ;)

It's also the original code (albeit with a simple variable
rename).

I know this isn't the kernel, and that there are plenty of other
lines that are 80+ characters, but if you can keep it short, why
not?

Thanks,
/ac
