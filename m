From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] submodule: fix quoting in relative_path()
Date: Wed, 24 Apr 2013 17:28:50 +0100
Message-ID: <20130424162850.GU2278@serenity.lan>
References: <cover.1366314439.git.john@keeping.me.uk>
 <cover.1366314439.git.john@keeping.me.uk>
 <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
 <7vfvyn4g46.fsf@alter.siamese.dyndns.org>
 <20130419074632.GC2278@serenity.lan>
 <7vmwsu31vh.fsf@alter.siamese.dyndns.org>
 <517199AB.50109@kdbg.org>
 <7vehe6z10t.fsf@alter.siamese.dyndns.org>
 <20130424081536.GT2278@serenity.lan>
 <7vehdzgar1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2ZG-0008SV-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409Ab3DXQ3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:29:07 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:46554 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab3DXQ3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:29:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 31E70606587;
	Wed, 24 Apr 2013 17:29:04 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jRKPTEe15LkT; Wed, 24 Apr 2013 17:29:03 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id AAD026064CA;
	Wed, 24 Apr 2013 17:28:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vehdzgar1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222259>

On Wed, Apr 24, 2013 at 09:21:38AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >> > Why not just replace the six-liner by this one-liner:
> >> >
> >> > 		target=${target#"$curdir"/}
> >> 
> >> Simple enough ;-)
> >
> > This seems to have arrived on next without this fix, so here's a patch
> > on top.
> >
> >  git-submodule.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 0eee703..db9f260 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -127,7 +127,7 @@ relative_path ()
> >  	do
> >  		case "$target" in
> >  		"$curdir/"*)
> > -			target=${target#$curdir/}
> > +			target=${target#"$curdir"/}
> >  			break
> >  			;;
> >  		esac
> 
> J6t meant a patch to remove the entire case...esac and replace it
> with a single liner (target=${target#"$curdir"/}).

Ah, I missed the "six-liner" part.  But that doesn't work because we
break out of the do...while loop when "$target" starts with "$curdir/"
and replacing the case statement will remove that.
