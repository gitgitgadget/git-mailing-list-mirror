From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Some issues working with empty/bare repositories...
Date: Tue, 4 Mar 2008 21:51:02 +0000
Message-ID: <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com>
	 <20080303081021.GA6578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 22:51:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWf34-00039o-Eh
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 22:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbYCDVvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 16:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756186AbYCDVvE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 16:51:04 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:31139 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352AbYCDVvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 16:51:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so655446rvb.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 13:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tCU7a16ImcF70qhj/uaihx1khrbfr/eTAUfi1FqWiDw=;
        b=Fkl3qDbR41EzzXO1pXQ7VsKRknW+Lq7FeroeC5W0FeGvp+Lra5kxF6vYCFdDpjqlC1+G2AVTDAjd0ykKbOQOFxWTkC4USeAFEqgXSyIe+cWmLl5L5Okv5BTSDlL9x8gW4xaUBCz6vunZXeMok88eMsjgVlyfIB7ewzDeTM3dkrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l933Xn+dD18STME+wTO7vB2P5NeB9gwywGBSP3PWDs6sOZSUuQLyj60tfKdh3Sio5Yg8w/RoMqSWQtRFBFfQeb7J6iBs0hNEN4q2el7P+tJMO5iulC1hRs/9ywWi2yVsmtrzUgIobB7nBJDhTBsjANYenK03lPEkzSOJ+HZ95ns=
Received: by 10.141.71.8 with SMTP id y8mr1005133rvk.63.1204667462507;
        Tue, 04 Mar 2008 13:51:02 -0800 (PST)
Received: by 10.141.23.10 with HTTP; Tue, 4 Mar 2008 13:51:02 -0800 (PST)
In-Reply-To: <20080303081021.GA6578@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76143>

On 03/03/2008, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 01, 2008 at 07:40:39PM +0000, Reece Dunn wrote:
>
>  > Consider the following workflow:
>  >
>  >     $ mkdir foo
>  >     $ cd foo
>  >     $ git --bare init
>  >
>  >     $ git log
>  >     fatal: bad default revision 'HEAD'
>  >
>  > This message is confusing for a newbie. Displaying "no commits" would
>  > make more sense here.
>
> The tricky thing here is that "git log" doesn't know we have no
>  commits in the repo; it only knows that HEAD is bogus. But it may be
>  that we can just say something like:
>
>   fatal: unable to resolve HEAD; do you have any commits?

That would be better. The current message would indicate something
like a corrupt repository (or at least the metadata to the
repository).

>  >     $ git clone foo bar
>  >     Initialized empty Git repository in /home/reece/bar/.git/
>  >     $ ls -a /home/reece
>  >     . .. foo
>
> As of 1.5.4, this now says "fatal: cannot clone empty repository". There
>  has been work recently on a C version of clone which tries to match the
>  sequence of "init && remote add && fetch && checkout" more closely. I
>  haven't looked closely, but I suspect it may just work (by which I mean
>  create an empty repo with origin config pointing to the parent repo).

I have verified that behaviour with 1.5.4. Having an empty repository
(possibly with a warning issued about cloning an empty repository)
with the origin pointing to the parent repository is what I would
expect to happen.

>  > It appears from the git output (with the inconsistently capitalized
>  > git - see --version output above) that the clone succeeded, but it
>  > does not create bar/.git/, even though it said that it did.
>
> It did create it...it just deleted it afterwards without telling you. :)

:)

Thanks,
- Reece
