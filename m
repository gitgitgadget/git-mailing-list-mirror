From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 01/12] git-grep: read config
Date: Thu, 24 Jul 2008 15:16:37 -0400
Message-ID: <76718490807241216qcb587d0k7e0f96c011b545f3@mail.gmail.com>
References: <20080723145535.GA29053@laptop>
	 <20080724171519.GA21043@sigill.intra.peff.net>
	 <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
	 <bd6139dc0807241153v5055e922p69a176b5b706f98e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 24 21:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM6Jr-0001CZ-Hn
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbYGXTQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbYGXTQk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:16:40 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:21947 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbYGXTQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:16:39 -0400
Received: by py-out-1112.google.com with SMTP id p76so2227078pyb.10
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kPGPSQLl5m9Zo/t/YgmMhimCVLRZLv6Alw6GFFX02XE=;
        b=lPDOeaJDNgJKt1cUaQ7OsYyaqF7mbLScBfqIXnJ0JsUJ4+OrMjrq9IJayLJD+CQDBN
         5DtpXhrZLYS8TksDqyNvACjfo+bo71NXZJFewlaQGxlEiXLvylD39+rFcMkE0r0Zh7xj
         8l3MhpDmiqmb34zJ0Z+PPS1R5BCoaQmISQwyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SuehGVX0jMEejOUn8MXg7EqYMTqWI9w/MYhUcGOWUw6JhHs7GnN8Acc5/KPpMnXtNb
         +jV2VMNFBG34q6vJ8/CgXkqThi6yMmJltmtcIJKKuX2zkw9ffLRvKb1BcZ0004X3j4Cl
         nCW2qJvcx+PmAZlxHbOTW201sv+mhpsXUVEfg=
Received: by 10.65.95.12 with SMTP id x12mr1130217qbl.97.1216926997463;
        Thu, 24 Jul 2008 12:16:37 -0700 (PDT)
Received: by 10.150.50.2 with HTTP; Thu, 24 Jul 2008 12:16:37 -0700 (PDT)
In-Reply-To: <bd6139dc0807241153v5055e922p69a176b5b706f98e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89947>

On Thu, Jul 24, 2008 at 2:53 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
> On Thu, Jul 24, 2008 at 8:45 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>
>
> Something went wrong replying here possibly? Or is it just me who is
> receiving empty messages? (At least the 3rd empty mail I see.)

Here's what's going on.

1. Gmail will often send messages as base64 encoded, inline. i.e.:

   Content-Type: text/plain; charset=UTF-8
   Content-Transfer-Encoding: base64
   Content-Disposition: inline

2. Majordomo is dumb dumb dumb and adds the standard list footer to
the message. It should probably either not add the footer to such
messages, or it should do it correctly by base64 decoding them, adding
the footer, then re-encoding. Anyway, what it sends out is:

   [... prior base64 encoded lines elided ...]
   b3V0LCBidXQgSSB3aWxsIHByb2JhYmx5IHN0YXkgYXdheSBmcm9tIGNvbmZpZy4KCi0tIApEdXkK
   --
   To unsubscribe from this list: send the line "unsubscribe git" in
   the body of a message to majordomo@vger.kernel.org
   More majordomo info at  http://vger.kernel.org/majordomo-info.html

3. Gmail is dumb dumb dumb and cannot decode such "corrupted"
messages. They display as completely blank. If you go to gmane you can
see the message is fine. (I think gmane strips the majordomo added
footer.)

I've filed a bug against gmail multiple times about this. No idea if
they'll ever fix it.

I also sent an email to git-owner@vger.kernel.org (which I think was
/dev/null'ed) offering to patch Majordomo, but got no reply.

I wonder if such a mailing list footer is useful in the first place.
Perhaps it could just be disabled.

Anyway, my offer to "fix" majordomo still stands. Perhaps someone
knows who I should contact at vger.kernel.org to find out whether
they're willing to accept a patch.

j.
