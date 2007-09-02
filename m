From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 17:53:25 +0100
Message-ID: <3f4fd2640709020953k2f5367a0o64870da9d8e04f68@mail.gmail.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
	 <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com>
	 <46DAE025.900@trolltech.com>
	 <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com>
	 <F0525923-6D9B-46AA-9678-8B1263C45FF7@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 18:53:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRshW-0000c2-Ny
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbXIBQx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757497AbXIBQx0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:53:26 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:14647 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085AbXIBQxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:53:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so763133rvb
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 09:53:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SHLqe1XnKAgZJvSy0QCLezjz/trwR2Op0lduSmcIjudFM665ElF9qSgDujzswH/vpxfr+mWT9jwiYEAcgv8fwRNtSTzVdeGpWjGUO/WopurvtMVX2aCWc2IF4vZ5+ZOeIYKPkdUMojeanHu88r44DLuE+XkkasSqbQKS2UH//NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TBpzKZ0pZmvP0q7HAn1qIxFZHnY+Z8pQThn25wy/T//Z76E/aPh8ZwOnwPQoe/DMDQrzpX9GN+rNWwMpDxjVuslPMPbPc9r8Q28Jlopuq1Lr1W9+iIZyHfXPgNqGyensyC9zUPtHz0pmeN+lI+nq0KixxFa0zwsWE+xHGjXQgcI=
Received: by 10.141.74.17 with SMTP id b17mr1618681rvl.1188752005308;
        Sun, 02 Sep 2007 09:53:25 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Sun, 2 Sep 2007 09:53:25 -0700 (PDT)
In-Reply-To: <F0525923-6D9B-46AA-9678-8B1263C45FF7@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57366>

On 02/09/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
>
> On Sep 2, 2007, at 12:33 PM, Reece Dunn wrote:
>
> > You pull a repository that contains executable scripts that are
> > required to work in order to build the system. You then make some
> > modifications to the local repository and run the 'git add .' command.
> > Since this patch is reporting executable bits differently, the mode
> > change is stored as well as the local modifications. Now the changes
> > are pushed upstream (along with the file mode changes).
> >
> > Someone running a Linux machine, pulls your changes. When those files
> > are checked out, the executable state of those scripts has now
> > changed, preventing the Linux user from running those scripts. _That_
> > is what I meant. Or am I misunderstanding how git works in this case?
>
> This is what "git config core.fileMode false" is for.  See git-
> config's man page for information (or Documentation/config.txt).
>
> We already have a way to tell git that the "executable bit" is
> worthless, and any Windows port should use it.

Ok, so as the executable bit is worthless, there doesn't need to be
any special casing in this patch to deal with it.

- Reece
