From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 4/3] gitweb: Incremental blame (proof of concept)
Date: Thu, 11 Dec 2008 02:22:03 +0100
Message-ID: <200812110222.04663.jnareb@gmail.com>
References: <20081209223703.28106.29198.stgit@localhost.localdomain> <20081210200908.16899.36727.stgit@localhost.localdomain> <7v3agvy1v3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 02:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAaH1-0001LN-5c
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 02:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbYLKBWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 20:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbYLKBWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 20:22:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:39661 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbYLKBWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 20:22:08 -0500
Received: by nf-out-0910.google.com with SMTP id d3so154531nfc.21
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 17:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VrCitkwOxio0StNaYa+axNpxBbVkkEmmPiihmKXIOIw=;
        b=OaS46fMmeWqxa+xHWhGrdzaLH97OOAuHpCP3TS6ZGCmctqaVpe2ZhDBT9Pvp7m8+qv
         Xd5i0SZuyuC02A4oqkIIKSvLmRdZctARdRtJ/+3JXV3UsJOgrr875CzjOoZQ3b6eB7Ap
         eKt7zZA/2FziSX/6+b+9txsp+vflXddQzMIUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EKBzGnenNx/miIJbUz/LG1tpLL37ROmNhNs4e4nBO3ko0RkR/vqVc+B+64Knqu1wP7
         k/gd0aW4xVPd5b+stz/ipteNudTQfQvk2nEIUrk0LvMSlfF1bur8zfONu6vJpvrarCAt
         mv7x8+wwZG/3l5TzWUTQsK9qjWIGqc+BXzGpo=
Received: by 10.210.121.8 with SMTP id t8mr2447706ebc.143.1228958525063;
        Wed, 10 Dec 2008 17:22:05 -0800 (PST)
Received: from ?192.168.1.11? (abxf60.neoplus.adsl.tpnet.pl [83.8.255.60])
        by mx.google.com with ESMTPS id y37sm466856iky.16.2008.12.10.17.22.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 17:22:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3agvy1v3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102764>

On Thu, 11 Dec 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > NOTE: This patch is RFC proof of concept patch!: it should be split
> > onto many smaller patches for easy review (and bug finding) in version
> > meant to be applied.
> 
> Hmm, the comments an RFC requests for would certainly be based on reviews
> of the patch in question, so if the patch is known to be unsuitable for
> reviewing, what would that tell us, I wonder ;-)?

Well, you can apply patch and test how it works, for example if
JavaScript code works in other browsers that have JavaScript and DOM
support (Firefox, IE, Opera, Safari, Google Chrome)... Or what
features or what interface one would like to have...

> Among the 700 lines added/deleted, 400 lines are from a single new file,
> so what may benefit from splitting would be the changes to gitweb.perl but
> it does not look so bad (I haven't really read the patch, though).

There are a few features which could be split in separate commits:
 * there are a few improvements to gitweb.css, independent of 
   incremental blame view, like td.warning -> .warning
 * adding to gitweb writing how long it took to generate page should
   be made into separate commit, probably made optional, use better
   HTML style, and have some fallback if there is no Time::HiRes

 * progress report could be made into separate commit; I needed it to
   debug code, to check if it progress nicely, but it is not strictly
   required (but it is nice to have visual indicator of progress)
 * 3-coloring of blamed lines during adding blame info was added for
   the fun of it, and should probably be in separate commit
 * adding author initials a'la "git gui blame" while nice could also
   be put in separate commit, probably adding this feature also to
   ordinary 'blame' output

[...] 
> > Differences between 'blame' and 'blame_incremental' output:
> 
> Hmm, are these by design in the sense that "when people are getting
> incremental blame output, the normal blame output format is unsuitable for
> such and such reasons and that is why there have to be these differences",
> or "the code happens to produce slightly different results because it is
> implemented differently; the differences are listed here as due
> diligence"?

Actually it is both. Some of differences are _currently_ not possible
to resolve (parent commit 'lineno' links, split group of lines blamed
by the same commit), some are coded differently (title attribute for
sha1, rowspan="1", author initials feature), and some are impossible
in incremental blame at least during generation (zebra table) or does
not make sense in 'blame' view (progress indicators).

> > P.P.S. What is the stance for copyrigth assesments in the files
> > for git code, like the ones in gitweb/gitweb.perl and gitweb/blame.js?
> 
> There is no copyright assignment.  Everybody retains the own copyright on
> their own work.

Errr... I'm sorry, I haven't made myself clear. I wanted to ask what
is the best practices about copyright statement lines like

  // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>

and other results of "git grep Copyright": should it be added for
initial author, for main authors... I guess not for all authors.

> > P.P.P.S. Should I use Signed-off-by from Pasky and Fredrik if I based
> > my code on theirs, and if they all signed their patches?
> 
> I think that is in line with what Certificate of Origin asks you to do.
 
I was bit confused because Petr Baudis in his patch used Cc: and not
Signed-off-by: to Fredrik Kuivinen...
-- 
Jakub Narebski
Poland
