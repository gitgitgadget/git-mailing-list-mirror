From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC maint-1.7.1 0/4] instaweb 1.7.1 fixes for Debian squeeze
Date: Thu, 2 Sep 2010 18:52:37 -0500
Message-ID: <20100902235237.GA6466@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 01:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrJc4-00079R-LF
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 01:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab0IBXya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 19:54:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36780 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab0IBXy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 19:54:29 -0400
Received: by qyk36 with SMTP id 36so2626353qyk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=z919hr55brGbYqG4CtpEYR0nTzhmUd2xXZUYV53D5hA=;
        b=F+/rTgyUAQ+DOxxbEwdZBdFHW9TiOuuYdeJkWnWWrUCv6eXt5EFomEoBfpZA3fnCSx
         CbmM0zqFfZ37hJPKNnBQvjH6Rrfu2d3tJjq0Hl4MkZg7LgzFo0XUBeM1rbIZMbNMhOHm
         2Fd9hDIDeArduvQbtfowiokLTRJwYUWm0zXGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CgsKfTEwQUX+beiql9D6yHZRCFFWipR5Ey3ZO9xqAVn6IRXMEFgkYwYSc/M/22npN0
         s9ttrXFTv9RLHsRmK3Hd0d2Z6GTNM+d5o84r6bU29+amtWaWco6dhJu/CSXGPRoCnY+l
         XuBh7OHS02k0ck7c8oG1L5QYA3Ftd7w3zrzzk=
Received: by 10.224.19.129 with SMTP id a1mr7182787qab.12.1283471667821;
        Thu, 02 Sep 2010 16:54:27 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm1113823qcq.22.2010.09.02.16.54.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 16:54:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100902223624.GA9613@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155224>

Eric Wong wrote:
>> Uwe Kleine-K=C3=B6nig wrote:
>>> when I start git instaweb on a git repository, I get a crippled vie=
w
>>> (no style sheets, no images) that doesn't include the current proje=
ct.
[...]
> The stylesheet is important and should be fixed.  I don't care about =
the
> logo and favicon (warning: I've never been a fan of logos/icons,
> needless noise IMHO), but if you're willing to help maintain it then
> it's fine by me.

Thanks, Eric; that makes sense.  How about this?

The purpose of this series is the first patch, which allows
old-fashioned instaweb to run even if /etc/gitweb.conf specifies some
layout it does not expect.

I suspect this problem is already fixed in maint by v1.7.2-rc0~55^2~3
(git-instaweb: Configure it to work with new gitweb structure,
2010-05-28; thanks, Pavan!), but users that do not like gitweb version
numbers with a 2 in them will not be able to use that.

Patches 2-4 fix some spurious 404 errors due to missing images,
noticed while debugging.

Patches are against Junio's maint-1.7.1.

Jonathan Nieder (4):
  instaweb: ignore GITWEB_CONFIG_SYSTEM
  gitweb: skip logo in atom feed when there is none
  gitweb: make logo optional
  instaweb: disable logo and favicon by default

 git-instaweb.sh    |    6 +++++-
 gitweb/gitweb.perl |   12 +++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

--=20
1.7.2.2
