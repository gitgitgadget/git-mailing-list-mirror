From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 30 Jul 2008 14:33:51 -0400
Message-ID: <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com>
References: <488772BC.80207@workspacewhiz.com>
	 <alpine.DEB.1.00.0807232041570.8986@racer>
	 <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no>
	 <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
	 <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no>
	 <20080725140142.GB2925@dpotapov.dyndns.org>
	 <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
	 <20080729134619.GB7008@dpotapov.dyndns.org>
	 <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
	 <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Joshua Jensen" <jjensen@workspacewhiz.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGVx-0000KK-ND
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 20:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbYG3Sdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbYG3Sdy
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:33:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:57341 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYG3Sdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:33:53 -0400
Received: by yw-out-2324.google.com with SMTP id 9so90322ywe.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x78qDzzm7C8X/lijKZPT5w/TJLyHnlFFeZ1ftUEBY3w=;
        b=F2Tx9mS5sjE8YI3sNfkE+zWdlqE5UkgpV713dJBmS7K2wI3bWzhhtIcPLhR6RVxAdF
         uLw8ht3r1LB9FUOBkvRyLziv6xfcXUDnej9yPRpJ81LvH7vTfDP92s6D3X3gFjfaxGz7
         kI70dEa2s04EpoMM808wjjZM3TmsQD1lePflk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l4+U4D79QXvGOmgRgzXJWmgX3SsnIsTmcIDOOu6zIvvINklDJT3QdEIBbtGkBrZzb7
         g6ozNGWIj6BxpubxIxh0d+JcPHUt/Dc8bprditWxTR5255DSmTwSoqH3NA71ulUZWZa7
         7oYleeqrM9CIow06y3pitOQ629kJCxvCzNPCk=
Received: by 10.114.182.15 with SMTP id e15mr8979050waf.186.1217442831586;
        Wed, 30 Jul 2008 11:33:51 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 30 Jul 2008 11:33:51 -0700 (PDT)
In-Reply-To: <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90828>

On 7/30/08, Steffen Prohaska <prohaska@zib.de> wrote:
>  On Jul 29, 2008, at 11:17 PM, Eyvind Bernhardsen wrote:
> > I think the real penalty is that with autocrlf enabled, Git no longer
> > stores exactly what I committed.
>
>  Git does *never* exactly store what you committed.  Git compresses
>  your data and creates packs containing many of your individual
>  files in a single pack.

This is not really an argument; making perfectly reversible changes as
part of the storage process, then reversing them as part of the
retrieval process, doesn't count as not storing what I committed.

>  What matters is that git gives you exactly back what you committed.  It
>  does so with core.autocrlf=true, unless you check out with a different
>  setting for autocrlf.

You can tell that this statement isn't quite true because if you have
a file with mixed LF and CRLF line endings, which I do (thanks,
Windows!) then CRLF->LF conversion is not a reversible operation.
Interestingly LF->CRLF still is (because an LF->CRLF'd file will never
have a bare LF, and on such a subset of files, CRLF->LF is
reversible).

Also note that core.autocrlf=input is *definitely* not a perfectly
reversible operation.

And so here's the problem: svn hands you a file.  It may or may not
have CRLFs in it, and the line endings may actually be a random mix of
LF and CRLF, as I am actually experiencing at the moment in a
particular repository at work.  If core.autocrlf is anything other
than "false", git will modify the file, and git-svn won't be apply the
diff on the next revision.

It's conceivable that core.autocrlf=true will work if your svn
repository is pure and svn hands you files only with CRLF endings.
It's somewhat unlikely that most svn repositories are in that state
(remember: it has to be perfect in *every revision* for git-svn to
work).

So anyway, I can't see how git-svn can possibly work in the general
case if core.autocrlf is anything other than false *at git-svn fetch
time*.  And that's what I do, and it works great, modulo a bunch of
stupid CRLFs that sneak into the repo via svn, but those can be fixed.
 Someday we'll stop using svn, and git-filter-branch can fix them all
retroactively so that "blame" will work right.

Perhaps git-svn needs to actually ignore the core.autocrlf setting?

Have fun,

Avery
