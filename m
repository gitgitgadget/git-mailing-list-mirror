From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 14:37:27 +0200
Message-ID: <vpq1uk9jldk.fsf@bauges.imag.fr>
References: <20120718120307.GA6399@sigill.intra.peff.net>
	<20120718120656.GD6726@sigill.intra.peff.net>
	<vpqd33tjlzm.fsf@bauges.imag.fr>
	<20120718122848.GB11482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:37:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTVg-00021z-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab2GRMhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:37:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43191 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308Ab2GRMhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:37:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6ICZl4T015525
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 14:35:47 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrTVQ-00059N-Ib; Wed, 18 Jul 2012 14:37:28 +0200
In-Reply-To: <20120718122848.GB11482@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jul 2012 08:28:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Jul 2012 14:35:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6ICZl4T015525
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343219749.33073@HLMonkqQPdGb59j+JrO8hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201686>

Jeff King <peff@peff.net> writes:

> I started with a version that did that, but there are two complications:
>
>   1. credential_write needs to know that the 'url' field must come
>      first, as it overwrites the other fields. So we end up
>      special-casing it either way.

Right, I didn't think of that. But you'd have to special-case it only
within credential_run, and not for the caller.

>   2. Git hands us back the broken-down version, which we add to the
>      credential.

We don't add it, but already replace the whole structure. This is
somehow needed because "git credential fill" can remove fields from the
structure (the path attribute is removed with
credential.useHttpPath=false). So, this point doesn't seem problematic.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
