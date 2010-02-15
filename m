From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] Make 'git var GIT_PAGER' always print the
 configured pager
Date: Sun, 14 Feb 2010 23:44:47 -0600
Message-ID: <20100215054447.GB22121@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214115959.GB3499@progeny.tock>
 <20100215050007.GE3336@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgtlO-000640-MT
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab0BOFop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:44:45 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:39949 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab0BOFoo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:44:44 -0500
Received: by iwn39 with SMTP id 39so1867818iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 21:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tA5/9C2WhFT2T3XKb4Hqg/g/AZXikBX1s/2n2949kFs=;
        b=IEXJCURB9BKsN1yoIv5nJsu48fDKOigoAnonXxeDg6RijRjTTBtYGW6zQeo5sezosf
         o4x8NUSJsxTgITLNNosdeSpojfmWkQ3hS+aijk7BPpFUHmmM5f00ivbNKuz6/0Bj9sRy
         3yrcbww4Pa/6sqn8Eb7LPOPLpyhLmgffUr2co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ol2ibR0pCXIyK3Afl/62/xkkPMwB7lVPsAhrIVulN/xeHxQpnZjXep3y9X+03hvsIL
         6RUpWeMi5yVaCQNgsHwC+SXXFFD9rr2H8gqeXA2t8aWszmR/2sV+nraHQuuxAHi4nqqk
         bJfU+LzjIsmQV3NeJQ+R93jPPQa3ldhvIcTH8=
Received: by 10.231.149.10 with SMTP id r10mr4268859ibv.63.1266212684074;
        Sun, 14 Feb 2010 21:44:44 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6051013iwn.15.2010.02.14.21.44.42
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 21:44:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100215050007.GE3336@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139984>

On Mon, Feb 15, 2010 at 12:00:07AM -0500, Jeff King wrote:
> On Sun, Feb 14, 2010 at 05:59:59AM -0600, Jonathan Nieder wrote:

>> So avoid tricks with isatty() and just always print the configured
>> pager.
>
> I think this is the right thing to do. But isn't "git am" broken in the
> meantime, as it now always paginates (whereas before, it would never
> paginate)? You fix it later in the series, but is there any test
> breakage in the meantime (not rhetorical, I didn't actually check) that
> would hurt bisectability?

The behavior before dec543 (am -i, git-svn: use "git var GIT_PAGER",
2009-10-30) was to always paginate.  This made some sense, since this
is the (v)iew command in git am --interactive; whether we check or
not, presumably stdout is a terminal.  So for git am, this restores
the older behavior.

There are unfortunately no tests for am --interactive in the test
suite, so test suite runs would detect none of this.

Thank you for your attention to detail.
Jonathan
