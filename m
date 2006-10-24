From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: renames in StGIT
Date: Tue, 24 Oct 2006 11:16:20 +0200
Message-ID: <20061024091620.GB29265@diana.vm.bytemark.co.uk>
References: <20061022013943.GA16341@diana.vm.bytemark.co.uk> <b0943d9e0610230947j79449a4dm8736f480f039c230@mail.gmail.com> <20061023125344.f82426ad.seanlkml@sympatico.ca> <20061024081732.GA29265@diana.vm.bytemark.co.uk> <b0943d9e0610240148s15d6ec5ch6114360a603fcd71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 11:16:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcIOg-0000Fd-U5
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWJXJQb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 05:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWJXJQb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:16:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:52238 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S965121AbWJXJQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 05:16:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GcIOS-0007v8-00; Tue, 24 Oct 2006 10:16:20 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0610240148s15d6ec5ch6114360a603fcd71@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29950>

On 2006-10-24 09:48:44 +0100, Catalin Marinas wrote:

> Actually, it might not be a big performance impact. For diff
> generation in the export and mail commands, we should have a flag.

Agreed.

> The push operation might not need a flag since it will only checks
> renames if all the other operations failed. A push with merge
> detection has the steps below (if one succeeds, push is finished):
>
> 1. check (exact) patch merges by reverse-applying the diff
> 2. apply the diff with git-diff | git-apply since this is faster
>    than a three-way merge
> 3. try a three-way merge between head, bottom and top
>
> Step 3 above is handled per file by the
> stgit.gitmergeonefile.merge() function. This is the place where we
> should have the rename detection. Since, the majority of the patches
> don't rename files and, in most cases, the push finishes at step 2,
> it is probably safe to extend this function and the users won't
> notice a speed difference.
>
> I'll add it to the TODO list.

Sounds good. I had a feeling it ought to be basically free in the
majority of cases, so I'm glad to learn I'm right. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
