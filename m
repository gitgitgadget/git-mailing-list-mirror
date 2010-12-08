From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: how to have real (existing) submodules?
Date: Wed, 08 Dec 2010 17:25:09 -0500
Message-ID: <201012082225.oB8MP939010091@no.baka.org>
References: <20101208205846.GW29789@cs-wsok.swansea.ac.uk>
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Wed Dec 08 23:25:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSRv-0006k0-N6
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab0LHWZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:25:17 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:49360 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab0LHWZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:25:16 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id oB8MP9q6023807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Dec 2010 17:25:11 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id oB8MP939010091;
	Wed, 8 Dec 2010 17:25:09 -0500
In-reply-to: <20101208205846.GW29789@cs-wsok.swansea.ac.uk>
Comments: In reply to a message from "Oliver Kullmann <O.Kullmann@swansea.ac.uk>" dated "Wed, 08 Dec 2010 20:58:46 +0000."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163228>


In message <20101208205846.GW29789@cs-wsok.swansea.ac.uk>, Oliver Kullmann writ
es:

    I thought that "git submodule" would solve the problem, but now I
    realised that these submodules are not "real", but they only
    contain a bit of meta-data (this should really be said directly in
    the documentation).

    So my hope, that I can have one super-repo, where I say, e.g.,
    "git submodule foreach pull", get the full super-repo, copy it on
    a memory stick, and then by pulling from that copy I get
    everything into another super-repo, from which I distribute the
    sub-repos, seems not so easily realisable with git?

gitslave may work for you better than git-submodules in this specific
use case.  http://gitslave.sf.net

In your example, you would create an organizational super-project git
module which is primarily a container for the .gitslave file which
tells the system how to access the various git repos and their on-disk
path names.

Given your diverse repo locations, it sounds like you will not be
using the feature which allows the pathnames of the slave repos to be
relative based on the URL to the super-repo (though you could have a
mixture of relative and absolute URLs if that would help your
functionality).

You would then run `gits pull` to issue a `git pull` against every
slave repo, and likewise `gits push` or `gits push home` or whatever.
(remotes would best work if your gitslave system has relative URLs).
While the super-project cannot be bare, the slave-repos could be bare
if that would help your data transfer functionality.

If certain slave repos would not be accessible in all locations, there
are options to bypass the errors you will get attempting to contact
the unreachable repos.

If you have any questions, please let me know (here, private email, or
on #git).

					-Seth Robertson
