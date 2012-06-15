From: perryh@pluto.rain.com
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Fri, 15 Jun 2012 06:03:28 -0700
Message-ID: <4fdb32a0.EloBUowXA1Rtd36K%perryh@pluto.rain.com>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
 <m2sjdynqlf.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: schwab@linux-m68k.org
X-From: git-owner@vger.kernel.org Fri Jun 15 08:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfPmv-0006wW-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 08:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab2FOGNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 02:13:35 -0400
Received: from agora.rdrop.com ([199.26.172.34]:4212 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab2FOGNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 02:13:33 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id q5F6DPxv057703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jun 2012 23:13:26 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id q5F6DPiN057702;
	Thu, 14 Jun 2012 23:13:25 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA07929; Thu, 14 Jun 12 23:04:48 PDT
In-Reply-To: <m2sjdynqlf.fsf@igel.home>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200040>

Andreas Schwab <schwab@linux-m68k.org> wrote:

> perryh@pluto.rain.com writes:
> > How do I get "git blame" to operate "as of" a particular date in
> > the past, without having to manually look up the corresponding
> > SHA1 using "git rev-list"?
>
> You can use any rev-list option, so --until=2011-12-27 should work.

That gets rid of the warning message, but it doesn't produce the
desired results.  Whether specified as

  $ git blame <file> --until=2011-12-27

or

  $ git blame --until=2011-12-27 <file>

the report still includes commits that are much more recent than
2011-12-27, and it omits material that was deleted since then --
material which _is_ included when specifying the SHA1 of the commit
which the --until should have identified.  IOW, the --until seems
to be silently ignored.

I guess this is a bug if rev-list options are supposed to work in
"git blame".  If they are _not_ supposed to work there, I would
claim that the failure to generate an error or warning message (when
I've asked for something that's not intended to work) is a bug.
