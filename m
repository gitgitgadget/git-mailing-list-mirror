From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 1/2] rev-parse: add --prefix option
Date: Fri, 19 Apr 2013 12:25:24 +0100
Message-ID: <20130419112524.GH2278@serenity.lan>
References: <82316c445320b3cec3a35cbc87ad94a04ed26d1e.1366314439.git.john@keeping.me.uk>
 <1366365217-17674-1-git-send-email-artagnon@gmail.com>
 <20130419102207.GF2278@serenity.lan>
 <CALkWK0kbXSfghZ69qypfaFF8orWy-bZLRPXcV5WMc5YQ=-18GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 13:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT9Ry-0004n0-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 13:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968097Ab3DSLZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 07:25:41 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:53966 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968046Ab3DSLZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 07:25:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 04CBC6064EF;
	Fri, 19 Apr 2013 12:25:39 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tZ+u9N+uzzo4; Fri, 19 Apr 2013 12:25:38 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id F19C46064D7;
	Fri, 19 Apr 2013 12:25:35 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D631B161E40C;
	Fri, 19 Apr 2013 12:25:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-LPNx0leP1a; Fri, 19 Apr 2013 12:25:35 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 901AF161E3D6;
	Fri, 19 Apr 2013 12:25:26 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kbXSfghZ69qypfaFF8orWy-bZLRPXcV5WMc5YQ=-18GA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221757>

On Fri, Apr 19, 2013 at 04:45:38PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > I'm not actually sure this is better.  I'm more afraid of the condition
> > for outputting files changing in the future than of passing
> > output_prefix around, so I'd much rather keep that condition in one
> > place.
> >
> > If you really feel strongly about it, I'd prefer to extract the if
> > condition to a function and use that directly when deciding whether to
> > print "--".
> 
> Yeah, it would probably make more sense to extract the conditional.  I
> just thought it was unnecessary to pass the argument around, but feel
> free to go either way on this one.
> 
> > [Also, you introduce a potential segfault via passing a NULL prefix to
> > strlen.]
> 
> Isn't prefix guaranteed to be set by setup_git_directory()?  If I
> wanted to check it nevertheless, I'd probably put in a die("internal
> error") before this line.  Feel free to go either way though.

It looks to me like setup_git_directory() returns NULL if we're at the
top of the working tree so we do need that check.  I suspect that's so
that "!prefix" does the right thing.
