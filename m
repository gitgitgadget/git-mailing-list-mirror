From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Basic git-archive --remote question
Date: Tue, 25 Jun 2013 15:16:38 +0200
Message-ID: <1372166198.20511.5.camel@flaca.cmartin.tk>
References: <CAGpXXZJifb1KmR8=VZVW+1MKjyo7HOq=OgU_rcHs-vc5ezfG6w@mail.gmail.com>
	 <CAGpXXZJuC09t8-5d=p4KNs9rQ-S347eBNuKcKWFhXZTnkLW0sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 15:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrTGU-0000D1-MX
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 15:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab3FYN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 09:26:22 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:54514 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751869Ab3FYN0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 09:26:21 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2013 09:26:20 EDT
Received: from [IPv6:2001:6f8:1c3c:6a57:a599:f01d:8189:5855] (unknown [IPv6:2001:6f8:1c3c:6a57:a599:f01d:8189:5855])
	by hessy.dwim.me (Postfix) with ESMTPSA id 795AD80478;
	Tue, 25 Jun 2013 15:16:39 +0200 (CEST)
In-Reply-To: <CAGpXXZJuC09t8-5d=p4KNs9rQ-S347eBNuKcKWFhXZTnkLW0sA@mail.gmail.com>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228961>

On Mon, 2013-06-24 at 15:53 -0400, Greg Freemyer wrote:
> I'm trying to create a tarball from a git tag and I can't get the
> syntax right.  The documentation is not very clear.
> 
> Can someone help me?
> 
> == details
> 
> git v1.8.1.4
> 
> The upstream git repo is at: https://github.com/dkovar/analyzeMFT
> 
> Here's a few attempts using git as the protocol:
> 
> > git archive --format=tar --remote=github.com:dkovar/analyzeMFT.git v2.0.4
> 
> Permission denied (publickey).
> fatal: The remote end hung up unexpectedly

Assuming you haven't set up any ssh rules for the github.com host,
you're trying to log in with ssh with your local username, which isn't
going to work.

> 
> > git archive --format=tar --remote=git://github.com/dkovar/analyzeMFT v2.0.4
> 
> fatal: remote error
>    Your Git client has made an invalid request:
>    003agit-upload-archive /dkovar/analyzeMFT
> 

This is the right format. GitHub doesn't allow remote archive requests,
which is why it's complaining.

If you want a tarball from GitHub, you need to download over HTTP from
the links they provide (which you can find e.g. through the web UI).

> 
> The github page also says I can use ssh with git as the user, but that
> complains I don't have the private key (which I don't):
> 
> git archive --format=tar
> --remote=ssh://git@github/com/dkovar/analyzeMFT.git v2.0.4

Using git as the ssh user is the right thing (if you want to talk git
over ssh) with GitHub and a few other sites/hosting programs, as your
public key is used to determine which user is trying to connect without
giving each user an account on the underlying OS.

   cmn
