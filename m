From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: signing commits with openssl/PKCS#11
Date: Wed, 24 Oct 2012 11:46:15 +0200
Message-ID: <5087B8E7.8010306@drmicha.warpmail.net>
References: <1392235.RizYqAYdkC@off17>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mat Arge <argemat1010@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 11:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQxdy-0001iT-4W
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 11:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827Ab2JXJwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 05:52:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58045 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751998Ab2JXJwp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2012 05:52:45 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2012 05:52:45 EDT
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3BCC7208E7;
	Wed, 24 Oct 2012 05:46:17 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 24 Oct 2012 05:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=SFHnWFmUgv911g2jFKfNO+
	7zrJU=; b=j4pmQbKOk6KNDueI5PabwCk3KBQt9loBp4NAZl+CfcwAZ4nvwLcAJj
	0im3zvsSsATu1VJEj9uAy+IHkCe/DNmxrPmQIz26G/W0SAn1VtOCBkFs8tf0gVrH
	JXmuVp/NDEkt/NFakdBFvW+JHLoSD+NWOKltuUeLy4YJY51/110xc=
X-Sasl-enc: 4XIqBrPFkJHGsLVXbQyN5rr3P1p/nItfJqZOyp8MneXl 1351071977
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CA85C482553;
	Wed, 24 Oct 2012 05:46:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <1392235.RizYqAYdkC@off17>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208302>

Mat Arge venit, vidit, dixit 22.10.2012 15:38:
> Hy!
> 
> I would like to sign each commit with a X.509 certificate and a private key 
> stored on a PKCS#11 token. I assume that that should be possible somehow using 
> a hook which calls openssl. Does somebody know a working implementation of 
> this?
> 
> cheers
> Mat
> 

In principle, we have an almost pluggable architecture. See for example
the latter part of the 2nd post in

http://article.gmane.org/gmane.comp.version-control.git/175127

Unless you want to change git itself, you're probably better off storing
your non-gpg signatures in a note (or a self-created signed tag). To
sign the commit rev, you could sign the output of "git cat-file commit
rev" (or of "git rev-parse rev") and store that signature in a note that
commit. To verify, you verify the note against the commit.

Michael
