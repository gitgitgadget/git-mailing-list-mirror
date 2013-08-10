From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 00:03:00 -0700
Message-ID: <20130810070300.GB3165@elie.Belkin>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <7v38qi4g7r.fsf@alter.siamese.dyndns.org>
 <20130810061720.GA30185@sigill.intra.peff.net>
 <20130810064056.GA3165@elie.Belkin>
 <20130810065252.GC30185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Thorsten Glaser <tg@mirbsd.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 09:03:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V83Cr-0004Ui-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 09:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab3HJHDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 03:03:14 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:47018 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab3HJHDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 03:03:13 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so1396999pdj.6
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rydJuULlkWFmakAsTzINMgqVEhNOzU1X+W1tdy6rGWA=;
        b=PzrTCV9zanXKxzu7UAAvU87ji1CfcrpUrDdFu10wKV4TDdprbTu7oigXW/zPL39isp
         zl8PU+crPY03Pq/LLJxXdioEuny6Omem+/xPyTpp1GRhx2knovpyQs8SyRzB7zsXzl+I
         2Io2RLynfUmkGpCN0nlf1FdiLHrsHQhXmuZe8oPuGBljzybPEszga8WgVntoAqey5qJX
         xJRz1WzvLw9tWv0xM4niRzHtFNR4ypuomOZm+XnOdo2Orpg2+lzcOdWEwBu8P82h3g58
         HCBQncLOmT7e49ICMUx+bp15LyXc+N3/d0bBVWgQBTHSVdOLWtR6KdpTOy7a77EqwFbd
         Hmvw==
X-Received: by 10.66.252.98 with SMTP id zr2mr4280036pac.86.1376118192010;
        Sat, 10 Aug 2013 00:03:12 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id in2sm20956753pbc.37.2013.08.10.00.03.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 00:03:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130810065252.GC30185@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232071>

Jeff King wrote:

> Sorry to be unclear. I meant that treating /etc/mailname and gethostname
> differently might be justified on Debian under the logic "if you have
> /etc/mailname, that is a trustworthy address, and if you do not, then we
> cannot guess at a trustworthy address (because putting it in
> /etc/mailname is the accepted way to do so on Debian)".
>
> But such logic would not extend to other operating systems, where
> /etc/mailname does not have such a status.

I thought that on other operating systems people typically don't have
an /etc/mailname.  How does trusting the file when present hurt?

> I am guessing, too, about what people even put in /etc/mailname. If they
> relay mail from the machine to a smarthost, do they put the individual
> hostname into /etc/mailname? Or do they put in the domain name that
> represents a real deliverable address? If the former, then it is no
> better than gethostname anyway.

Debian policy explains:

	If your package needs to know what hostname to use on (for
	example) outgoing news and mail messages which are generated
	locally, you should use the file /etc/mailname. It will contain
	the portion after the username and @ (at) sign for email
	addresses of users on the machine (followed by a newline).

	Such a package should check for the existence of this file when
	it is being configured. If it exists, it should be used without
	comment, although an MTA's configuration script may wish to
	prompt the user even if it finds that this file exists. If the
	file does not exist, the package should prompt the user for the
	value (preferably using debconf) and store it in /etc/mailname as
	well as using it in the package's configuration. The prompt
	should make it clear that the name will not just be used by that
	package.

So on a properly configured Debian system, /etc/mailname contains
something appropriate to put after the @ sign in an email address
and the sysadmin expects it to be used for that.

As far as I can tell, to the extent that other distros support
/etc/mailname, it is only as a side effect of handling that Debian
requirement.  I don't think e.g. Fedora or Solaris systems typically
will have a /etc/mailname file.

I *am* a bit worried about what people might put in /etc/mailname on
Debian systems when there is no appropriate host to put there (as on
Thorsten's machine).

Jonathan
