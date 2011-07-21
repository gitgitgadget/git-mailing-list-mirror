From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 17:37:17 -0700
Message-ID: <CAJo=hJuS_iYSS8iVWoJ1BiUANsGtYJoYm-WRa863isVNsq=5vw@mail.gmail.com>
References: <20110720221632.14223.qmail@science.horizon.com>
 <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm> <alpine.LFD.2.00.1107201931510.21187@xanadu.home>
 <4E276DF8.8030301@cisco.com> <alpine.DEB.2.02.1107201714140.6412@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>, Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>, anthonyvdgent@gmail.com,
	git@vger.kernel.org, torvalds@linux-foundation.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Jul 21 02:39:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjhIX-0006NF-SJ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 02:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab1GUAhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 20:37:39 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:60933 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab1GUAhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 20:37:38 -0400
Received: by fxd18 with SMTP id 18so2492438fxd.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 17:37:37 -0700 (PDT)
Received: by 10.204.144.194 with SMTP id a2mr2578330bkv.93.1311208657444; Wed,
 20 Jul 2011 17:37:37 -0700 (PDT)
Received: by 10.204.144.195 with HTTP; Wed, 20 Jul 2011 17:37:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1107201714140.6412@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177566>

On Wed, Jul 20, 2011 at 17:18,  <david@lang.hm> wrote:
>
> if it's just locally generated, then I could easily see generation numbers
> being different on different people's ssstems, dependin on the order that
> they see commits (either locally generated or pulled from others)

But this should only happen if the user fudges with their Git sources
and makes Git produce a different generation number.

If the algorithm is always "gen(A) = max(gen(P) for each parent_of(A))
+ 1" then it doesn't matter who merged what commits, the same commit
appears at the same part of the graph relative to all of its
ancestors, and therefore always has the same generation number. This
is true whether or not the commit contains the generation number.

> If it's part of the commit, then as that commit gets propogated the
> generation number gets propogated as well, and every repository will agree
> on what the generation number is for any commit that's shared.

This isn't really as beneficial as you are making it out to be. We
already can agree on what the generation number should be for any
given commit, if you topo-sort the commit DAG, you get the same
result.

> I agree that this consistancy guarantee seems to be valuable.

Its valuable, but its consistent either with a cache, or not.

-- 
Shawn.
