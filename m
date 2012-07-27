From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 00:38:00 -0500
Message-ID: <20120727053800.GC4685@burratino>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SudFg-0008Go-45
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 07:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab2G0FiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 01:38:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47643 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2G0FiF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 01:38:05 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so2802580yen.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D/d7TAuHyOhvcVNg6LcHb4xsSfOBrhjciS/YQG4ADdU=;
        b=sy0CCsjhgeWJKyyQ1+1+YgZzViCxL2OuY1DYOH0SnOM/boQaz4v8ZCZVZNMpfy+zg9
         dJwbZKtw9CoOFrkv7Bmm21O8FmV6bY7QmD4w9ukLofJ7NufZjJ8N5YlgWDgiYIDVJn4n
         QHmIbJZD/MSqJWoIm7P0DX9tE5nfZprV9Wh1qvLPj0uGmbFwV2+DqjQUYGp9fIkErhrT
         PtsCgTqv9WUVQJPEtdlOBlJF9Q2MkD7YztP0UTbIE5PQlw3HZlxVErEii3XWEhvy2XKB
         EcXARdTEI9N3LKPDldVwKpoks/M4Egqao+Owa3eDicnddb/tSvFmzcrdCbfRLGFxC1Ny
         ZTNQ==
Received: by 10.50.47.168 with SMTP id e8mr894440ign.3.1343367484407;
        Thu, 26 Jul 2012 22:38:04 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bj4sm5296996igc.16.2012.07.26.22.38.03
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 22:38:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhast3hpb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202337>

Junio C Hamano wrote:
> "Michael G. Schwern" <schwern@pobox.com> writes:

>> Also it can compile on its own now, yay!
>
> Hmmm.

I agree with Michael's "yay" and also think it's fine that after
patch 3 it isn't there yet.

That's because git-svn.perl doesn't use Git::SVN on its own but helps
it out a little.  So even if we only applied patches 1-3, git-svn
would still work (maybe it's worth testing "perl -MGit::SVN" by hand
to avoid the "it's doubtful" about whether Git::SVN is self-contained
and replace it with a more certain statement?), and patch 4 just makes
it even better.

[...]
> In short:
>
>  - I didn't see anything questionable in 1/4;
>
>  - Calling up ::opt_prefix() from module in 2/4 looked ugly to me
>    but I suspect it should be easy to fix;
>
>  - 3/4 was a straight move and I didn't see anything questionable in
>    it, but I think it would be nicer if intermediate steps can be
>    made to still work by making 4/4 come first or something
>    similarly simple.
>
> If the issues in 2/4 and 3/4 are easily fixable by going the route I
> handwaved above, the result of doing so based on this round is ready
> to be applied, I think.
>
> Eric, Jonathan, what do you think?

I think this is pretty good already, though I also like your
suggestion re 2/4.

I haven't reviewed the tests these introduce and assume Eric has that
covered.

Thanks,
Jonathan
