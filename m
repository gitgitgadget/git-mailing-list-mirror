From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: Problem completing remotes when .git/remotes exits
Date: Wed, 26 Sep 2012 03:26:33 +0200
Message-ID: <20120926012633.GE10144@goldbirke>
References: <505A2330.9040800@kdbg.org> <20120925230045.GA13266@goldbirke>
 <20120926010938.GD10144@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 03:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGgOi-0006ee-Ju
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 03:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866Ab2IZB0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 21:26:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:56619 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab2IZB0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 21:26:35 -0400
Received: from localhost6.localdomain6 (p5B130672.dip0.t-ipconnect.de [91.19.6.114])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lr6Nr-1Tu7sw3Lkp-00eeAW; Wed, 26 Sep 2012 03:26:33 +0200
Content-Disposition: inline
In-Reply-To: <20120926010938.GD10144@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:nhl7C3f7FN59GL8YWcmXw1L/ACiG4U7V+lEMTnb2Jij
 85OsfSiQIMDEtMWmVeghHLKvIK/wcKybL7IL3i2Ztj1YdxCLSP
 7FzpaOlJldQXz6Ae6ySE6PxNDQKnJ7AwEWS/MOBZAnD2v1S2nF
 YqxFvk3iSiWPjwR7Frzb/etLBsbezXr5/oTxCvD1ASg+S4w/I8
 tDprbgqE/5vDIVAfi4gLJiiaZPo5NbLqzpOoho/bS2kVqlttQr
 SXq2gPLhwt8wPr1KRdxfGKScpNd/Zk84ADzs3jPlvZR1qxHJ/R
 KxXRHLjQtz1V4i9fThGac62qQRyRXTDO3OkcpTYhlgW5hYT/De
 70j93uwVm1Gi/sfwHmzk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206390>

On Wed, Sep 26, 2012 at 03:09:38AM +0200, SZEDER G=E1bor wrote:
> On Wed, Sep 26, 2012 at 01:00:45AM +0200, SZEDER G=E1bor wrote:
> > But then it got me thinking...  Notice how much effort we spend jus=
t
> > to get the list of remotes?  We could just run 'git remote' directl=
y
> > instead...
>=20
> Actually, we can't, because 'git remote' doesn't seem to list remotes
> stored under .git/remotes.  Is that intentional?

Looks like a bug, as it seems to have been lost in translation in
211c8968 (Make git-remote a builtin, 2008-02-29).

list_remote() in git-remote.perl looks for remotes in config and in
=2Egit/remotes/, too.  The builtin implementation uses
remote.c:for_each_remote() from the start, which only looks at the
config.
