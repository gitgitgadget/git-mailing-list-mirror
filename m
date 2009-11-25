From: Marc Fournier <marc.fournier@camptocamp.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 15:32:04 +0100
Message-ID: <20091125143204.GA9834@lonquimay.wrk.lsn.camptocamp.com>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com>
 <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 15:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDIuk-00034E-BN
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 15:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbZKYOcB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 09:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbZKYOcA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 09:32:00 -0500
Received: from c2cpc15.camptocamp.com ([128.179.66.15]:34541 "EHLO
	mail.camptocamp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934709AbZKYOcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 09:32:00 -0500
Received: from lonquimay.localdomain (c2cpc3.camptocamp.com [128.179.66.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.camptocamp.com (Postfix) with ESMTP id 1392F8064B;
	Wed, 25 Nov 2009 16:32:05 +0100 (CET)
Received: by lonquimay.localdomain (Postfix, from userid 1000)
	id 9DFC4AE563; Wed, 25 Nov 2009 15:32:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133644>

On Tue, Nov 24, 2009 at 04:48:26PM -0500, Avery Pennarun wrote:
> On Tue, Nov 24, 2009 at 2:53 PM, Marc Fournier
> <marc.fournier@camptocamp.com> wrote:
> > I was not able to reproduce this bug in any of the following cases:
> > =C2=A0- if the README file wasn't empty
> > =C2=A0- if modules/cognac is renamed to something else
> > =C2=A0- if modules/cognac doesn't have the same sub-directories tha=
n
> > =C2=A0 modules/mapserver
> >
> > This bug happens using git 1.5.5.6 as well as 1.6.5. It seems to ha=
ppen
> > when git-subtree calls "git merge -s subtree".
>=20
> Yup.  This is basically a bug in "git merge -s subtree": it guesses
> which subtree to merge into, rather than actually taking a prefix
> parameter.  I've been meaning to either submit a patch for this, or
> find a way to work around it.

I see. What sort of criteria does git-merge use to do this auto-guessin=
g ?

I'm hoping to find a way to workaround this problem. I have a couple of
subtrees I'm completely unable to update. The best I found is:
"git rm -fr ..." followed by "git subtree add ..." again.

> This doesn't usually happen once your project is relatively mature
> (ie. doesn't have blank or "default" template files in it) since then
> the auto-guessing gets more reliable.  But there's no good reason to
> do the auto-guessing, so it would be best to do this "properly."

The thing is I use dozens of different "modules" in my project, all mer=
ged
into using git-subtree. All these modules have the same structure, and =
most
of them have quite minimal content and won't really evolve more. In my
case, evolution will mean adding even more modules.

If I understand the thread Nanako Shiraishi pointed us to, a patch
implementing a prefix to "git merge -s subtree" is available somewhere =
but
hasn't been added in any official release yet ?

Marc
