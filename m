From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Date: Wed, 1 Jun 2011 14:23:57 -0500
Message-ID: <20110601191623.GA9836@elie>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
 <7voc2hh3t5.fsf@alter.siamese.dyndns.org>
 <B85A65D85D7EB246BE421B3FB0FBB593024D2D22DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Nori, Sekhar" <nsekhar@ti.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRr1c-0007cY-A8
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759161Ab1FATYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:24:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48949 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759128Ab1FATYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:24:10 -0400
Received: by ywe9 with SMTP id 9so60420ywe.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jpq8CI/LXCLiEWSWx/ytxcqrzbMhkGVd8rINBmQXYT4=;
        b=WBsZ5heqLJV7V2MpDs8r1MNKw/InSJhBKp6q2XaSV6zXsH3d8WkgV5G2d8OCMPoOIb
         ZsC0B51oQJ14PRpDWfBu1qQfC2HKShu5Lev7ka8vH6fz0t6GgcrcaDWJG0ez+IyJNP4a
         D395R/7VNBN7NoyWK3DmBWky74ZajJuuvDyvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=apx1KC3sGV8Omb2AMg1XLGNEdQW1mY1lPcnwwuX9uCoJvM7h3PBdsxq8LHSrlN+mMo
         hNu71iYasxqcqls4RefEt1RZRJpv/i1ZnIXI4gaS0yUfpMYMUasFmzcCRbUXBxCCBW0Q
         HDcrEWBR1P/hEgMQ8UeFjjU+j4QhK+JlheAwg=
Received: by 10.150.114.11 with SMTP id m11mr6367853ybc.426.1306956249845;
        Wed, 01 Jun 2011 12:24:09 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id a21sm533721ybf.15.2011.06.01.12.24.08
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 12:24:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D2D22DE@dbde02.ent.ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174894>

Nori, Sekhar wrote:
> On Wed, Jun 01, 2011 at 22:44:30, Junio C Hamano wrote:

>> Also if it doesn't have to be a conscious act, what value does such a
>> boilerplate have? Such a project may be better off not using sign-off at
>> all to begin with.
>
> Its hard to argue against this. All I would say is it is probably
> much safer to enable sign off by default when accepting a patch
> than when preparing to send it. Yet, we have format.signoff but
> no am.signoff. On any project with conscious sign-off rules, one
> would never accept a patch without a sign-off from the original
> developer.

In that case, just the first sign-off should be enough and there is no
need to record the later ones, no?

In practice, with format.signoff hopefully people read the patches
they are sending out before mailing them.  It is very easy to remove
the sign-off in an MUA or by editing patch files before running
"git send-email" if it was inappropriate.  On the contrary, importing
patches en masse with "git am" is a common operation and I suspect
looking over the new history in detail before a "git push" is rare, so
the possibility of someone forgetting that an "[am] signOff" variable
is in effect is much more dangerous.

That said, I am all for giving people rope as long as there is some
legitimate use case documented to explain how not to hang themselves.
Could you say more about the example that motivated this?  What
benefit would this provide to motivate not using "git am -3sc" (which
contains the -s on the commandline as a reminder)?

> So, just making it easier to accept patches which are already
> signed-off should be okay, I guess?

A related idea seems interesting: would a --check-sign-off option that
prevents applying a patch unless the last sign-off matches the email
sender be useful?  Unfortunately individual people sometimes use
different addresses for the From and Signed-off-by lines in some
projects (like git and the Linux kernel) so I don't think I'd use such
a thing but in a more controlled environment I can imagine it might be
nice.

Thanks.

Sorry for the longwinded message; still, hope that helps.

Regards,
Jonathan
