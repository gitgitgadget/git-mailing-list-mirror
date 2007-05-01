From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Tue, 1 May 2007 11:10:47 +0200
Message-ID: <e5bfff550705010210i352ac9eej6ff7a78aae6535c9@mail.gmail.com>
References: <20070429220832.5832.251.stgit@yoghurt>
	 <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 11:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HioNp-0001AL-CS
	for gcvg-git@gmane.org; Tue, 01 May 2007 11:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031612AbXEAJKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 05:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031613AbXEAJKt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 05:10:49 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:35060 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031612AbXEAJKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 05:10:48 -0400
Received: by an-out-0708.google.com with SMTP id b33so1549064ana
        for <git@vger.kernel.org>; Tue, 01 May 2007 02:10:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A1+iY9kFbZbC+UPOmct5c1w91IBCWx82S/CxiwAjlx/lybqFJ3iDz6oaXCu26Lo5+5BguZVbZLuYNzTDw3y/9lDhvwZLF7psKj88A+0/pMRbyBOBJ1ZcXJUm/zWkBU5K4YzmXybojFrdAFP2oyro259NqP5DQGx+h1qFq6hEtXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q87Dqx3vE4xwCHPPYcAYOfr2ebvdQBweErresiP5CgkISzWhrtqfu7b048rB5SrQ+6YX2B+YfpfanNme/kytdZSEx15cq0o6WyrSl1zgaB5kTzctOW18nLVCdZ0utrURaoGVh8vf/n+fO17h4QVUdAwoMZfJk+blqpp08pEOrDQ=
Received: by 10.115.76.1 with SMTP id d1mr2334695wal.1178010647192;
        Tue, 01 May 2007 02:10:47 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Tue, 1 May 2007 02:10:47 -0700 (PDT)
In-Reply-To: <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45931>

On 5/1/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 30/04/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > It's silly to save the stack base in a ref when it can trivially be
> > computed from the bottommost applied patch, if any. (If there are n=
o
> > applied patches, it's simply equal to HEAD.)
>
> The reason I initially had the base ref was to see what's on top of
> the stack when using gitk. I later added refs/patches/<branch>/...
> which are shown by gitk and the base ref would be redundant.
>
> I'm OK with this patch as long as tools like qgit don't rely on this =
ref.
>

It's OK for me. A recent qgit already filters out content of
refs/bases to reduce visual 'noise'.

The only StGit data read directly are patches sha's; qgit walks
recursively all the files called "top" under directory tree

           <git dir>/patches/<current branch>

to get sha list of each applied and unapplied patch in one go.

This is much faster then calling "stg id <patch name>" for all the patc=
hes.

   Marco
