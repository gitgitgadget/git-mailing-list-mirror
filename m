From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/3] checkout: introduce --detach synonym for "git
 checkout foo^{commit}"
Date: Tue, 8 Feb 2011 04:26:05 -0600
Message-ID: <20110208102605.GA29660@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
 <20110208005238.GB24340@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 11:26:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmkm2-0007sp-Kj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 11:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab1BHK0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 05:26:13 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32866 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1BHK0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 05:26:12 -0500
Received: by iyj8 with SMTP id 8so3125899iyj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sjET+f8KansxvAT9Dxeg88u6s8AK5m5NVqTtt9B2c/M=;
        b=tGmvAfQyRYjrvjfcW0cuXi0a/lBoCkIg3OEL5O6r+OIyvlsAu8DDDmwFS+Dm1IurFO
         /l1Q2ir+jA1/dQf3YFH7nR2OZ9ivwWtpCa2ip8qTOK1/xUzhtQ5lbdq6Laje0UAiossi
         N4Ez4aY7Tol9jBIKEYczSykZbIiePRDGSiyQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AY2RpCwBgNOyTQke9KYDP+dYDF/oZinCMAE5Ml7dNQi5KhCZ923k8+VVz+jwayJLS+
         KVhnSWdhDKUsOWhiStutLWf+LEmed+RKOO6Cnv7ZJRVeKIRzTpFlEo2uNIw5wTxAKU0Y
         apGdil7OHONvmAD7EXYNxg25i7Ur4eDcn0RBs=
Received: by 10.42.213.135 with SMTP id gw7mr19025632icb.7.1297160771617;
        Tue, 08 Feb 2011 02:26:11 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id u9sm4660196ibe.20.2011.02.08.02.26.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 02:26:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110208005238.GB24340@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166345>

Jonathan Nieder wrote:

> Two of the new tests fail. :)

... and here's a reroll fixing them.  Applies on top of the old
uk/checkout-ambiguous-ref (0cb6ad3, 2011-01-11).

Patch 1 is an irrelevant cleanup, for while I have your eyes on this
code. :)

Patch 2 introduces the --detach option, taking care to error out in
special cases.

Patch 3 is another cleanup, to make the effect of patch 2 more clear.

Thanks again for your help.
Jonathan Nieder (2):
  checkout: split off a function to peel away branchname arg
  checkout: rearrange update_refs_for_switch for clarity

Junio C Hamano (1):
  checkout: introduce --detach synonym for "git checkout foo^{commit}"

 Documentation/git-checkout.txt |   13 ++-
 builtin/checkout.c             |  265 +++++++++++++++++++++++----------------
 t/t2020-checkout-detach.sh     |   95 ++++++++++++++
 3 files changed, 262 insertions(+), 111 deletions(-)
 create mode 100755 t/t2020-checkout-detach.sh
