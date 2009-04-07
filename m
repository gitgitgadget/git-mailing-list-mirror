From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GPG signing for git commit?
Date: Tue, 07 Apr 2009 10:55:01 -0700 (PDT)
Message-ID: <m3ljqc1h55.fsf@localhost.localdomain>
References: <1238793954.19982.14.camel@hyperair-laptop>
	<alpine.LFD.2.00.0904031535140.3915@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chow Loong Jin <hyperair@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 19:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrFXM-0001r7-VC
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 19:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820AbZDGRzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 13:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756871AbZDGRzG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 13:55:06 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37066 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbZDGRzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 13:55:04 -0400
Received: by fxm2 with SMTP id 2so2444490fxm.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=8TzBoonKAXURf3DnHjqF8PSgBoroMOszeG3oAFeOvs8=;
        b=XunNCQ9kTM44YisgVRSYyzSbAyv4kTrkBjof4btjUMnCQjTrF6wu1jlYsGzySicC0U
         d5xr99/nFiqQWY5/NlxJNhRdy4o5PY7x20SV1vVaU4SLQcZGf1Yo4sQMGlR/QFm3OuOz
         nQ/Ff/0Azk4Y2Pk4kixaXvEkVG/RDePF1uDso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HbIWE3niXxHWzosMyU0MyqhLlUTbXqc7tPf8Upz0KGi9SsmZFxWEmjKT0nY+br2lo3
         N4luf2g1ZJbGUkTillLtPFtqIKRWbJe2ypXtvP5AjM3FTrDn04U01S5xWH3DICHuB9Zc
         UBT3QZdrsASUF0jM5jdqIAvf2nFhSYcQQs0Ls=
Received: by 10.103.245.18 with SMTP id x18mr78452mur.62.1239126901945;
        Tue, 07 Apr 2009 10:55:01 -0700 (PDT)
Received: from localhost.localdomain (abuz219.neoplus.adsl.tpnet.pl [83.8.197.219])
        by mx.google.com with ESMTPS id y6sm9626806mug.57.2009.04.07.10.55.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 10:55:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n37HvMX0024708;
	Tue, 7 Apr 2009 19:57:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n37HvBvj024701;
	Tue, 7 Apr 2009 19:57:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115971>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 4 Apr 2009, Chow Loong Jin wrote:
> > 
> > It crossed my mind that currently git commits cannot actually be
> > verified to be authentic, due to the fact that I can just set my
> > identity to be someone else, and then commit under their name.

[...]
> Btw, there's a final reason, and probably the really real one. Signing 
> each commit is totally stupid. It just means that you automate it, and you 
> make the signature worth less. It also doesn't add any real value, since 
> the way the git DAG-chain of SHA1's work, you only ever need _one_ 
> signature to make all the commits reachable from that one be effectively 
> covered by that one. So signing each commit is simply missing the point. 
> 
> IOW, you don't _ever_ have a reason to sign anythign but the "tip". The 
> only exception is the "go back and re-sign", but that's the one that 
> requires external signatures anyway.
> 
> So be happy with 'git tag -s'. It really is the right way.

And if you really, really need for some reason (for example
requirement checkpoint, or being paranoid enough) ned to have each and
every commit signed, you can use Monotone instead of Git.  That is
what we recommended IPsec (or something) on #git.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
