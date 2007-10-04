From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 15:39:01 +0200
Message-ID: <4d8e3fd30710040639x62d7b9cbr688aca141849212c@mail.gmail.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	 <20071004125641.GE15339@genesis.frugalware.org>
	 <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 15:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQv7-0003fC-Q7
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 15:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbXJDNjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 09:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbXJDNjG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 09:39:06 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:60594 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbXJDNjD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 09:39:03 -0400
Received: by nz-out-0506.google.com with SMTP id s18so156053nze
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=V7xlnYWoHxEgnXkNAp/CYJ65xz5AmipzNf/9sD5ISmQ=;
        b=ai96vmiyiRLDaMuIuUos/N0qP5AeAIyvxPRM2NF5NIzmp4JeaExXZ/0rGZhz8dfn1QE/hFBys9Q/MmHt/t8Zckn0KBJtzSnGZn1ybpdQP9tcg05HNgHG7p5iywKEKjXGpFlkhAD/4Lu/ZdAfAVUdhEMoOBq48xZxgCx5+31paa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WwzUtsGlohUuzY49pKAsWg6fkfb1HjesJq2NhMqVwlSemTXvJ3vOgWz2gs+c2Ufp8WYGCgt0i7Ix4dx6qgwa4+jqI8btctLHYEIYo67sv/3n8Ir6wspjOj+v8YTI9aB0vJZqIW+CvIdd1VilHXNvubWVNuB0MvftK482WWZ7w34=
Received: by 10.142.178.13 with SMTP id a13mr681199wff.1191505141930;
        Thu, 04 Oct 2007 06:39:01 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Thu, 4 Oct 2007 06:39:01 -0700 (PDT)
In-Reply-To: <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59953>

On 10/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>
> > On Thu, Oct 04, 2007 at 02:27:41PM +0200, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> >> Why do we have the option "--cached" and not "--index"?
> >
> > according to glossary.txt, 'cache' is an obsolete for 'index'. probably
> > this is the reason
> >
> > probably cache.h will be never renamed to index.h, i don't know if diff
> > --cached will be ever renamed to diff --index
>
> Probably never.

Ouch!

> Some commands support both --index and --cached and have
> different meanings.  For them,
>
>  * --index means work on both index and work tree;
>  * --cached means work only on index and ignore work tree.
>
> In the case of "diff --cached", the latter is exactly what's
> happening.  We do not say "git diff-index --index $commit"
> because "git diff-index" (and by extension, when you give only
> one commit to "git diff" as parameter) is all about a commit vs
> your uncommitted changes, so having you say "--index" is just
> silly.  "git diff --cached" is just a shorthand for "git diff
> --cached HEAD".  Because --cached would make sense to no other
> form of diff, its presense by definition means you are talking
> about the one-tree form of diff i.e. compare a commit with your
> uncommitted changes.

I see. But the problem is real. If we cannot solve the problem
changing the code of git we'll need to avoid this kind of
misunderstanding having "better" documentation.

As soon as I'll find some spare time I'll propose a patch to "A
tutorial introduction to git (for version 1.5.1 or newer)".

Thanks!

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://ubuntista.blogspot.com
