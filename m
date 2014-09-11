From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 6/6] Make sure that index-pack --strict fails upon
 invalid tag objects
Date: Thu, 11 Sep 2014 16:22:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409111620420.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <cover.1410356761.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1409101553140.990@s15462909.onlinehome-server.info> <xmqqoaunf8fv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 16:22:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS5GX-0001eh-9X
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 16:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbaIKOWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 10:22:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:58846 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbaIKOWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 10:22:14 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MN748-1XPsKo3QJk-006j4Z;
 Thu, 11 Sep 2014 16:22:10 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqoaunf8fv.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:rNlmGe2Y+xs51coxW0M03iwNr8LWi6/LxHMuSN2H5xJ4BM+HN3Z
 IZlIJtYuZyJ5I7zSGIguCi/0e6fEVEmZh7fKuD/nd5AZWVd/cobgc540ugE9ZkZHJngC1dD
 T2llp1cRnrucXGdjxnHXJRegVosVdmihVfhUhxhZXR5A5J+mPNeGQziVwZxDvLZNvHQ9LXL
 w2Q7SgokNoHvvQ7R2Tf3g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256839>

Hi,

On Wed, 10 Sep 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +    tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> > +    pack1=$(echo $tag | git pack-objects tag-test) &&
> > +    echo remove tag object &&
> > +    thirtyeight=${tag#??} &&
> > +    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
> > +    test_must_fail git index-pack --strict tag-test-${pack1}.pack 2> err &&
> 
> I had to drop "must fail" from this one (will amend the "SQUASH???"
> again).

Funny. It failed here, but for the wrong reason: index-pack --strict
failed here because the object referenced by the tag object was not in the
pack.

Ciao,
Dscho
