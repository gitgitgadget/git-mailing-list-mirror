From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How to fix (and find) many git-* --check errors?
Date: Fri, 8 Aug 2008 15:28:08 +0200
Message-ID: <20080808132808.GA22674@atjola.homenet>
References: <489C40BC.8000008@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Valdemar =?iso-8859-1?Q?M=F8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 15:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRS1r-0001lZ-KU
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 15:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYHHN2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 09:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYHHN2N
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 09:28:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:46391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751651AbYHHN2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 09:28:12 -0400
Received: (qmail invoked by alias); 08 Aug 2008 13:28:10 -0000
Received: from i577BBBF4.versanet.de (EHLO atjola.local) [87.123.187.244]
  by mail.gmx.net (mp067) with SMTP; 08 Aug 2008 15:28:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18OB8pgUUIO203kEBibg/ze2TzMr5pg7DP2aqjTY1
	zKfAOP4LGBF4Cl
Content-Disposition: inline
In-Reply-To: <489C40BC.8000008@sneakemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91665>

On 2008.08.08 14:49:00 +0200, "Peter Valdemar M=F8rch (Lists)" wrote:
> We have > 37000 white space "errors" in HEAD, mostly trailing =20
> whitespace, and I'm looking for a
>
> $ git diff --check | git??? --whitespace=3Dfix
>
> command.
>
> Is there such a beast?
>
> I see that git-apply has a --whitespace=3D<action> option, but I don'=
t =20
> seem to grock how to be able to use it for fixing my working director=
y.

I'd probably do something like:

# Create a commit with an empty tree
rm .git/index
git commit -m tmp

rm -r * (include dotfiles if required, ie. remove all tracked files)

git diff -R HEAD^ | git apply --index --whitespace=3Dfix
git commit --amend -m "Whitespace fixed up"

But probably there's some smarter way than that.

Bj=F6rn
