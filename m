From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 16:51:25 +0200
Message-ID: <5060736D.5020609@drmicha.warpmail.net>
References: <5060097F.9050203@drmicha.warpmail.net> <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com> <7vipb31o9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGA0X-00054f-JR
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab2IXOv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:51:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49822 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755541Ab2IXOv1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 10:51:27 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C25542088E;
	Mon, 24 Sep 2012 10:51:26 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 24 Sep 2012 10:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=vTItd1RvNz8FI9JeZdwYLQ
	RydJQ=; b=lcjAIO2WZNslDOFuHovnBuUkRLJqPzqVuVmfOi6YJeSslyRXxJpc/N
	Abd/TenqegLKh+MAzC/HjF/STjcI1DxlW4POZ+eBP63Ffx1pEAQSAkeBaWdPSHj1
	mImO6xqffbrPGyob6AXuKZKrD6TyrGrC4GsCJ/SfyKV5KLDWUg/rc=
X-Sasl-enc: wpqIBCyF87jbBXvskc9rAwR4OZnmkvUkXUEeZLjKaeNa 1348498286
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 388ED4827CB;
	Mon, 24 Sep 2012 10:51:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vipb31o9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206278>

Junio C Hamano venit, vidit, dixit 24.09.2012 16:36:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> "~" is a shell feature. Know your shell. If we make an exception for
>> --git-dir, we might have to support --blahblah=~/somewhere.
> 
> Correct but not entirely true.
> 
> When we know --git-dir=<path> must name a path, we should be able to
> do better.  See OPT_FILENAME in >parse-optios.h>, for inspiration.
> 
> MJG's patch later in this thread is conceptually OK but I do not
> think it should introduce a "expand and then setenv" helper that
> won't be useful unless the variable is GIT_DIR.  That pattern does
> not appear that often, and smells like a bad API design taste.

I can't quite parse. My little helper can be used for any path
environment variable, not just GIT_DIR. Granted, there aren't that many
in use.

Do you suggest tilde expansion right in fix_filename() (i.e. for all
OPT_FILE options), or some OPT_FILENAME_EXPANDED which may or may not be
used by some config? There's git_config_pathname() already which does
expansion, of course.

Michael
