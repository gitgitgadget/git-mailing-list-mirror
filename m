From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without
	(Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Sat, 4 Sep 2010 01:03:48 +0100
Message-ID: <20100904000348.GA7498@n2100.arm.linux.org.uk>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com> <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com> <20100903182323.GA17152@pengutronix.de> <20100903184351.GC2341@burratino> <20100903192907.GA2978@n2100.arm.linux.org.uk> <20100903193309.GC29821@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-sh@vger.kernel.org,
	bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: linux-sh-owner@vger.kernel.org Sat Sep 04 02:04:08 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1OrgEp-000137-G1
	for glps-linuxsh-dev@lo.gmane.org; Sat, 04 Sep 2010 02:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab0IDAEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glps-linuxsh-dev@m.gmane.org>);
	Fri, 3 Sep 2010 20:04:06 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37586 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab0IDAEF (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Fri, 3 Sep 2010 20:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:Sender; bh=1xFjai+nsyX+7Q9
	epuOt3K9CPHEki626EJOTlcpoMcE=; b=GO8dLN0JZXQFF74uVts7T8p24UtN3lc
	VXjmMs9veQ5eGBuAQ7VAGMLupO2QaQYpKZ6akrz0IDz5ijgXX62XNynMW4mLFURV
	AbJj8X/cLJTMb3wS+PFwBK1uwbA/8x7SIw/OTMEDfihyVB1gAq0ckq+6FMMs9Xgm
	eCd78BbX5ocY=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1OrgEY-0006z1-58; Sat, 04 Sep 2010 01:03:50 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1OrgEW-0001yr-Mm; Sat, 04 Sep 2010 01:03:48 +0100
Content-Disposition: inline
In-Reply-To: <20100903193309.GC29821@pengutronix.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155290>

On Fri, Sep 03, 2010 at 09:33:09PM +0200, Uwe Kleine-K=F6nig wrote:
> > git patches include additional metadata for renaming files, which g=
nu patch
> > will not understand.
> >=20
> > If you want GNU patch compatible diffs, don't use -C or -M when gen=
erating
> > patches out of git.
> Still GNU patch should then already fail in --dry-run mode.

And now look at the patch - it touches arch/sh/include/asm/clkdev.h twi=
ce.
Once to remove it and once as a rename.

GNU patch not in --dry-run mode will first remove arch/sh/include/asm/c=
lkdev.h,
and then not have a file to deal with when it tries to patch the rename
part.  Whereas with --dry-run, the file stays around.

As I say, it's because GNU patch doesn't (currently) understand GIT
patches.  I wouldn't call that a bug in GNU patch.
