From: Christoph Blank <sol@textmode.at>
Subject: Re: Http/s authentication failure with some git versions
Date: Mon, 25 Jul 2011 21:39:51 +0200
Message-ID: <20110725193951.GB20953@tp>
References: <20110725132317.GA21590@tp>
 <20110725163223.GB7071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 25 21:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlR0X-0003jG-N5
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 21:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab1GYTkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 15:40:00 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:48843 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1GYTj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 15:39:59 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so9461864fxd.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 12:39:58 -0700 (PDT)
Received: by 10.223.67.194 with SMTP id s2mr1064055fai.124.1311622797750;
        Mon, 25 Jul 2011 12:39:57 -0700 (PDT)
Received: from tp ([46.207.255.214])
        by mx.google.com with ESMTPS id 28sm3977912fax.3.2011.07.25.12.39.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 12:39:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110725163223.GB7071@sigill.intra.peff.net>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177811>

Thanks a lot for the pointer!
I will upgrade to a newer version

greetings,
Christoph

On Mon, Jul 25, 2011 at 10:32:23AM -0600, Jeff King wrote:
> On Mon, Jul 25, 2011 at 03:23:17PM +0200, Christoph Blank wrote:
> 
> > Following command: 
> > git clone "https://git%40app.example.com:myp...@git.example.com/app-comm 
> > 
> > This works fine with git versions: 
> > 1.7.4.1 
> > 1.7.6 
> > 
> > and fails with: 
> > 1.7.1 
> > 1.7.2.5 
> > 1.7.33 
> > 
> > does anyone know why, or if there was a particular bug fixed? 
> > I don't want to upgrade git on the production systems without a reason..
> > Can't find anything and I'm getting desperate...
> 
> I skimmed through:
> 
>   git log v1.7.3.3..v1.7.4.1 http.c
> 
> and came up with:
> 
>   commit f39f72d8cf03b61407f64460eba3357ec532280e
>   Author: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
>   Date:   Sun Nov 14 02:51:15 2010 +0100
> 
>       Fix username and password extraction from HTTP URLs
> 
>       Change the authentification initialisation to percent-decode username
>       and password for HTTP URLs.
> 
> which seems a likely candidate based on the example you gave. You could
> try cherry-picking that commit onto your older version if you don't want
> to do a full upgrade.
> 
> Now, I happened to know that http.c was where the relevant code lived
> (because I was working on it recently), and limiting my search to
> commits that touched that file made the list quite short. But knowing
> nothing else except a test case that works on some versions and not on
> others, you could always "git bisect", which would find the relevant
> commit for you.
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
