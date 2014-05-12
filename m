From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: GIT, libcurl and GSS-Negotiate
Date: Mon, 12 May 2014 20:01:59 +0200
Message-ID: <1399917719.2595.5.camel@centaur.cmartin.tk>
References: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
	 <20140426174718.GC238861@vauxhall.crustytoothpaste.net>
	 <CAPc4eF-aT47aEPmmPPkPRfntTNdNp=c4+OK_CPdq_7YB6rxDug@mail.gmail.com>
	 <20140510210132.GD45511@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>,
	git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon May 12 20:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjuf8-0000vC-LW
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbaELSJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 14:09:12 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:53141 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbaELSJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 14:09:11 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 May 2014 14:09:10 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 54B0BDE05B;
	Mon, 12 May 2014 20:02:06 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id klBIgLUUJUtB; Mon, 12 May 2014 20:02:04 +0200 (CEST)
Received: from centaur.local (p57A971DA.dip0.t-ipconnect.de [87.169.113.218])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 94253DE054;
	Mon, 12 May 2014 20:02:03 +0200 (CEST)
In-Reply-To: <20140510210132.GD45511@vauxhall.crustytoothpaste.net>
X-Mailer: Evolution 3.12.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248715>

On Sat, 2014-05-10 at 21:01 +0000, brian m. carlson wrote:
> On Mon, May 05, 2014 at 12:21:33PM +0200, Ivo Bellin Salarin wrote:
> > Well, I'm on Windows.
> > using `git version 1.9.2.msysgit.0`.
> > 
> > You can find all the exchanges, recorded with wireshark, of the
> > following usecases:
> > * git vanilla (not working),
> > * VisualStudio2013 with libgit (working)
> > * curl (--ntlm, working)
> > * curl (--negotiate, not working)
> 
> Okay, so what it looks like is that for some reason, the server and
> libcurl refuse to connect with Negotiate authentication.  git uses
> CURLAUTH_ANY, and libcurl picks the best choice: Negotiate.  The
> difference between your setup and mine is that I'm using Negotiate with
> Kerberos 5, and you're using Negotiate with NTLM.
> 
> What it looks like is happening is that git is offering Negotiate data,
> and then your server is responding with a 401 Unauthorized.  libgit2
> (presumably using WinHTTP) continues in this case, retrying with a
> longer set of credential containing more data, but git gives up.

While libgit2 does use WinHTTP by default on Windows, Visual Studio
overrides this and uses their own HTTP transport (which makes the .NET
stack to handle it) because of the way the prefer to do things, with
just the one persistent connection to TFS.

But details aside, the code Visual Studio uses to do authentication has
nothing to do with any of the others.

   cmn
