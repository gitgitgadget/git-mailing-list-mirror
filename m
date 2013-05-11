From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Sat, 11 May 2013 12:00:17 +0200
Message-ID: <518E16B1.7000505@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org> <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net> <7vy5bm22f8.fsf@alter.siamese.dyndns.org> <518E0741.1060008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun May 12 14:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbV81-0004R7-0d
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 14:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab3ELMLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 08:11:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57206 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088Ab3ELMLl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 08:11:41 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B8AA720A0F;
	Sun, 12 May 2013 08:11:40 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Sun, 12 May 2013 08:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=QuKZkrX1WkOSLIwAnDdkz3
	ccLYM=; b=LjmeGkvma/5GCArBOSjlXgzAiTdt1Xm3sXEpTGsB04tjalQgNkOpdg
	IxzYPzQph1div7PWBVBDo5GBZA0PkYMaOjfB+Co4tsGeznJrsrNr9Zt3FyevNS1v
	B6o8cB1MGAIPcgX/bvzQx+CGQa0cmp4wYhjB4WLvhFK3D/oRGuhtU=
X-Sasl-enc: hYDODIn89IU+ur8+IlsFrcSPNHXKbsRjsreIEF0ZbZ/F 1368360700
Received: from localhost.localdomain (unknown [88.71.228.38])
	by mail.messagingengine.com (Postfix) with ESMTPA id DA2FB2000FD;
	Sun, 12 May 2013 08:11:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <518E0741.1060008@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224044>

Adding to that:

Somehow I still feel I should introduce a new attribute "show" (or a
better name) similar to "diff" so that you can specifiy a diff driver to
use for showing a blob (or grepping it), which may or may not be the
same you use for "diff". This would be a much more fine-grained and
systematic way of setting a default for "--textconv" for blobs.

Of course, some driver attributes would just not matter for coverting
blobs, but that doesn't hurt.

I'm just wondering whether it's worth the effort and whether I should
distinguish between "show" and grep".

So, the sructure would be:

"--textconv" is on by default for diff, show, grep.

diff looks for a textconv driver using the "diff" attribute.
show/grep look for a textconv driver using the "show" attribute.

That way, turning on "--textconv" by default does not affect anyone
unless a user specifies the new attribute!

Also, all commands would behave "the same way" if you have both a diff
and a show attribute set on the same files..

Michael
