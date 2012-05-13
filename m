From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Mon, 14 May 2012 00:13:33 +0200
Message-ID: <20120513221333.GB59647@book.hvoigt.net>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com> <7v1umuznuj.fsf@alter.siamese.dyndns.org> <20120509215815.GC74366@book.hvoigt.net> <7v1umtq9pm.fsf@alter.siamese.dyndns.org> <7vwr4lotjl.fsf@alter.siamese.dyndns.org> <20120513172301.GA58961@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 00:14:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STh3R-0002Kt-S3
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 00:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab2EMWNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 18:13:36 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40211 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752495Ab2EMWNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2012 18:13:36 -0400
Received: (qmail 843 invoked from network); 13 May 2012 22:13:33 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 13 May 2012 22:13:33 -0000
Content-Disposition: inline
In-Reply-To: <20120513172301.GA58961@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197755>

On Sun, May 13, 2012 at 07:23:25PM +0200, Heiko Voigt wrote:
> Here is the simplest approach I could think of (not sure if its maybe
> too simple). On first sight it seems to work (even if I exchange the
> absolute path in alternates with a relative one.
> 
> Please see below.
> 
> Cheers Heiko
> 
> I used the following setup to test:
> 
> mkdir sub_alt &&
> (cd sub_alt &&
> git init &&
> echo a >a &&
> git add a &&
> git commit -m a) &&
> mkdir super &&
> (cd super &&
> git clone -s ../sub_alt sub &&
> git init &&
> git add sub &&
> git commit -m "sub a") &&
> (cd sub_alt &&
> echo b >b &&
> git add b &&
> git commit -m b) &&
> (cd super &&
> 	(cd sub &&
> 	 git fetch &&
> 	 git checkout origin/master) &&
>  git diff --submodule
> )

Junio in case you decide to queue this: I would like to rework the above
code into a proper testcase and add that to the patch. The previous
patch is the state as far as I got today so interested people can test
whether it fixes their issue.

Cheers Heiko
