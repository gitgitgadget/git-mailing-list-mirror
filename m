From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 23:21:05 -0400
Message-ID: <9b3e2dc20807162021v30fdedcar6ee104ed6bf4b0a3@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
	 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
	 <7vabghr5br.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com>
	 <7vr69tpoze.fsf@gitster.siamese.dyndns.org>
	 <20080716223205.GK2167@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 17 05:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJK4F-0003oT-8U
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 05:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbYGQDVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 23:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYGQDVH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 23:21:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:48747 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYGQDVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 23:21:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6645080rvb.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 20:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RKrDiGOxVMVLUswJwy62l7DjVSiRv43RX4YJFswgzqA=;
        b=MhnN99+Scq6uc6ZbayfbvElFHtm3vPPkuO48vBNe8n4QNzEiJajZcGRFHYlcqHY4IE
         NAywwhN320gIXzQA0RqaPhDS/niXQ9S2btGacubna4xxD396jb69m7/7v+/+weBPqrvJ
         BJ4+irfkhUVpLNvkPGDnS5C9vJnmtl+5EIrPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DBfqENekN3nYIAwThTWLuAQepK10GCdjZ1DBv0zRh5lMmeQdIy+yVa1v4E6KFh8TdN
         KrwvGyJQRcpSE1Oz363emXGkd1xqLi8J/Fh/dYJ0GnvW6NT2gpCAuhh2YMNnJh82iTRo
         FW010XQT9S1v1MG2XPDJsSCeAFlU51qR98h28=
Received: by 10.141.211.13 with SMTP id n13mr892851rvq.12.1216264865253;
        Wed, 16 Jul 2008 20:21:05 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Wed, 16 Jul 2008 20:21:05 -0700 (PDT)
In-Reply-To: <20080716223205.GK2167@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88801>

On Wed, Jul 16, 2008 at 6:32 PM, Theodore Tso <tytso@mit.edu> wrote:
> So from a pedagogical perspective, what I would probably do is show
> them how to replicate svn-up, and explain to them how this script
> works:
>
> #!/bin/sh
> # git-up
>
> if git diff --quiet && git diff --quiet --cached ; then
>        git pull $*
> else
>        git stash ; git pull $*; git stash pop
> fi

Wouldn't this be confusing if they have a few commits on the local
branch that aren't yet pushed to the remote branch?
They could suddenly have conflicts that have nothing to do with the
working tree, which could throw people off.  Not to mention the
meaningless merges that clutter the gitk display.

I know I was personally pretty confused the first few times this
happened and I had little trapezoidal patterns in gitk showing 2
commits being automerged between the local and remote branches.  This
was before I understood the concepts of local and remote branches.

Perhaps some warning when...

if git diff --quiet origin/master HEAD; then...

Personally I've since learned that git-pull is a command to think
about a little before doing, as opposed to svn up, since you might
have to resolve things you aren't prepared for, and we're trying to
avoid teaching git-reset here.  I've had to untrain myself from using
git-pull, switching to git-fetch/merge more and more often, because I
keep doing stupid 3-commit merges by mistake when I didn't intend to.
Some tracking of what's been pushed and what hasn't is helpful to keep
things in the expected order imho.


Steve
