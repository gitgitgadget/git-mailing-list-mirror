From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Dangers of reset --hard (Re: Implicit stashes)
Date: Wed, 30 Jun 2010 11:12:17 -0500
Message-ID: <20100630161217.GE18813@burratino>
References: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
 <20100630051326.GA17497@burratino>
 <1277885972.2498.25.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 18:12:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzu6-00062L-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 18:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871Ab0F3QMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 12:12:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39844 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab0F3QMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 12:12:43 -0400
Received: by gwb15 with SMTP id 15so500481gwb.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JCZFuU2wrxKrzO2Je9242lEW/3nJu+oDW0qSLPoDUoo=;
        b=E3PXmZGOygC7eM+RQWfnzyQwG60sWERb0x9SxGOl35qrxgtBwGI6zmmYKOOeDSj7zw
         JPJxhI62nbhlUwHMwEwBHohL2CA3QOzIOkU+5IRe589kzuWB6tQYb1mgZXQf1MntwcrI
         A/SS0H01VGg1RqQIX6zUXSU8vouUyq6KcXPOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OSam7ELehRjVpn3pE1TpjCz7QYmNkDw48xIw8dGRMgE5IJ+BZl1fLLDxfKrWkO1Hj2
         wX9u5PcrlWbfu5DVg7ei4h+724D51zubKzX+9/mfADEAgXQPswuXSbjufaj0M1ah4T8Q
         /Vj5M0Tt5UVtmw+E8HSnOgPo6/ezycFepdwuk=
Received: by 10.103.80.8 with SMTP id h8mr3649479mul.90.1277914361120;
        Wed, 30 Jun 2010 09:12:41 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm17311479ibk.9.2010.06.30.09.12.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 09:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277885972.2498.25.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149979>

Will Palmer wrote:

> I tend to want "do a git reset --hard, but fail if anything would be
> lost".

At the risk of being redundant: try git reset --keep.  If it succeeds,
you can use git diff --cached HEAD and git diff to check how close it
was to being equivalent to a hard reset.

> The use-case here is that when I reset --hard, I want a
> completely clean copy- but I don't want to accidentally lose anything.

There is one case when I truly want a completely clean copy (including
no untracked files): when I am testing and a bit paranoid.  For that,
I do something like the following:

 ; mkdir /tmp/test-dir
 ; git archive HEAD | (cd /tmp/test-dir && tar -xf -)
 ; cd /tmp/test-dir

and work from there.  I would not be surprised if the needs of your
case are different, though.
