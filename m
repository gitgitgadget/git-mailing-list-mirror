From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: FW: Query on git submodules
Date: Tue, 2 Jun 2015 13:12:19 +0200
Message-ID: <20150602111219.GA7442@book.hvoigt.net>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com>
 <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com>
 <20150526170125.GC31115@book.hvoigt.net>
 <4C328B7D13677A4EAF715D0755A6D7EE25C5AD9E@irsmsx110.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Frawley, Sarah" <sarah.frawley@intel.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 13:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzk7M-0007uk-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 13:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbbFBLMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 07:12:16 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:33698 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958AbbFBLMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 07:12:09 -0400
Received: from [31.17.191.210] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Yzk73-0000pG-Vd; Tue, 02 Jun 2015 13:12:06 +0200
Content-Disposition: inline
In-Reply-To: <4C328B7D13677A4EAF715D0755A6D7EE25C5AD9E@irsmsx110.ger.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270522>

On Wed, May 27, 2015 at 01:20:11PM +0000, Frawley, Sarah wrote:
> Thanks Heiko for getting back to me.
>=20
> Correct when I referred to 10+ layers I meant nested repositories
> which make up a large hierarchy.=A0 Some repositories are repeated
> across the hierarchy.=A0 We check-out submodules to tag versions (as
> opposed to master branch).=A0 If we need to roll out a particular cha=
nge
> across a hierarchy (e.g. 60 repos) then every level in the hierarchy
> needs to pick up new submodule tags.
>=20
> The main 2 issues that we see are:
>=20
> 1. Enforcement of absolute paths in git submodules - I am currently
> trialing using a pre-commit hook to highlight this issue to users so
> that they can fix their submodule urls to relative paths.

So you mean, enforcement of relative paths. Right? It might be a good
idea to put some code in 'git submodule add' that would automatically
use a relative path instead of absolute path if it can calculate one
from the superproject. I think that would help your users even more as
they do not get an error from the pre-commit hook, but just having
everything right after doing the add.

If you want to go that route it should not be that much different from
the hook, since the submodule subcommand code is all bash.

> 2. Slowness Integrating updates to submodule hierarchy -I have been
> looking at ways of automating such a roll out - this can be useful fo=
r
> new project setups or for rolling out an update to all repos and
> quickly integrating it into the submodule hierarchy.=A0 The link belo=
w
> shows something similar however it checks out a master branch of each
> submodule in its hierarchy.
> https://chrisjean.com/recursively-updating-git-submodules/

How about

	git submodule update --init --recursive

? That should do the same as the script written in that blog post. Or a=
m
I missing something?

Cheers Heiko
