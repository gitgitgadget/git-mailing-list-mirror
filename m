From: git@goeswhere.com
Subject: Re: [PATCH] gitweb: Add support for gravatar-ssl
Date: Thu, 9 Aug 2012 20:53:10 +0100
Message-ID: <20120809195310.GA29014@goeswhere.com>
References: <20120809184210.GA27795@goeswhere.com>
 <20120809193655.7418D13F8069@mailgw.unict.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 21:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzYnJ-0002wX-LH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 21:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759494Ab2HITxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 15:53:13 -0400
Received: from fau.xxx ([78.47.200.108]:56080 "EHLO reg.goeswhere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759481Ab2HITxM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 15:53:12 -0400
Received: by reg.goeswhere.com (Postfix, from userid 1000)
	id DB3DC2E057F; Thu,  9 Aug 2012 20:53:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=goeswhere.com;
	s=default; t=1344541990;
	bh=+b6Yx92wY8eb5AdnIiagiAQNCcFOUnkdVHWaC35YIJc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=qpwgCddeDvi3JOlYalEywzZm4dME9SCNQIrYkjsfKERZeDKST8sd67o1RKinSCyFG
	 XBPspMfFnhmdm959K25Xo1CVUs7HRYPTAZ7LiMWbGRN9HzLphRxetdziwvyDoqgQ7+
	 3PAYXoEs81nr1WO0p6Qsdx3KZEXRI2gr9mpGhCek=
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120809193655.7418D13F8069@mailgw.unict.it>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203178>

On Thu, Aug 09, 2012 at 09:36:46PM +0200, Giuseppe Bilotta wrote:
> Chris West (Faux) wrote:
> 
> > Teach gitweb to allow 'avatar' to be set to 'gravatar-ssl', switching
> > to the https://secure.gravatar.com url form, to avoid mixed content
> > warnings when serving gitweb over https, with gravatar enabled.
> > ---
> > I'd alternatively propose always using the https:// form of the URL,
> > but it seems significantly slower, so it's probably best to let people
> > pick to continue using the insecure version.
> 
> Rather than introducing a new, separate setting, wouldn't it be better
> to have the gravatar URL be automatically decided based on the current
> gitweb URL? (use the ssl gravar url when the current protocol is https,
> and the standard http url otherwise)

I don't believe it's possible to reliably detect this kind of thing (on
the server side), think ssl terminators / reverse proxies / etc.,
although you can probably get 99% of the way there, which might be good
enough.

An alternative would be to dump some JS on the page to convert the SSL
links to non-SSL links if the page hasn't been loaded over SSL
(according to the browser)?  Or do it the other way around and ignore
the mixed content warnings that ssl users with no javascript will see.

I'd rather just hardcode the https version than do anything with JS.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
