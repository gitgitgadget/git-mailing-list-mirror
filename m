From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git workflow for fully distributed mini-teams
Date: Wed, 16 Sep 2009 18:43:56 +0200
Message-ID: <20090916164356.GB24893@vidovic>
References: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 18:47:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnxf5-00065X-Uw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 18:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759853AbZIPQoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 12:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759819AbZIPQn7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 12:43:59 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:41745 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759841AbZIPQn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 12:43:58 -0400
Received: by ewy2 with SMTP id 2so1593117ewy.17
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=S2hEqmejiuGt+8h/7Y3Z4gpShjxigDjVpKAvgrauQIo=;
        b=VAz3OZU7W0adncn9bLXyUx5LTQ5bmpuMVOhGHCNcnyA6VQiuXObxbdKW2IEj5DHqhJ
         4rQNte1IhcqxZcN0BypCHyOGHz9F7HbuMx3P3jfKK6vxEEn+tpRyVKGF+7pVh2BBEbnR
         trWOifNXsYP6T6sMRigMgpdt4TFeDxNjQsk0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pOpQvSyqWyMPA+A3CXCpyNQgFFhx1/i54uRpL+xBYrY2SlH8Wvjycb+4HdDqGKG7V4
         75m3jcJLh4w5smE1jGNQx9nL5K7CK/QKY4C/REPUrsD5jagyDucXvK1FZF3ZMfpXGK59
         TThNV//9zX7oE+sidj1Tbl9lVHYyV33rHAOaM=
Received: by 10.211.130.19 with SMTP id h19mr10478420ebn.54.1253119440984;
        Wed, 16 Sep 2009 09:44:00 -0700 (PDT)
Received: from @ (91-164-145-100.rev.libertysurf.net [91.164.145.100])
        by mx.google.com with ESMTPS id 28sm733140eye.22.2009.09.16.09.43.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 09:43:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128664>

The 16/09/09, Rustom Mody wrote:
> 
> A's best practices (and invariants) are:
> I (ie A) develop on dev (or other topic branches).
> I only merge onto master; never commit.
> I never work on nor merge onto B and C.
> When B sends me patches I apply them to the B branch likewise for C.
> Thereafter I merge that branch onto dev or master.
> There are no tracking branches because there are no remotes -- no
> central repo. [not clear about this]
> 
> B and C have corresponding practices/behavior.
> 
> So the questions...
> 
> Is there a better way of doing things?
> Can some of these practices/invariants be enforced by scripts/options etc?

What's may be hard here is about "releasing topic". With a "maintainer
oriented workflow", the status of each topic is clear (either "won't
merge as is, needs more work" or "should be good enough, is merged and
aims to be in the next release").

In the fully-distributed workflow you describe, the state of the topics
looks hard to know. Who releases what is not clear.

Also, I see a duplication of the same work for all the developers in a
team: "merge my topics with topics from others". This could be solved
with one more common repository wich could stand as a "virtual
maintainer repository" where each developer could release any topic.
Topics that don't need any more work would have to be merged in a
dedicated public branch ("next"?) for testing, and topics that aren't
good enough into another dedicated branch ("pu"?). So, each developer
would have to push publishable merges into this repository. This way,
everyone could use the merges done by another developer (by doing a
fetch and rebasing of his current work on top of it).

Notice that this is all about "everybody uses the same base for his
current work" (to avoid per-developer scratch on merges) and "don't let
everyone do the same work on his own" (to avoid duplicate work).

> What about checkpointing and restoring from botches?

I think this is be easily doable (against your described workflow) with
good conventions in branch names. Topics like "pending-topicA",
"pending-topicB", etc that would have to be merged (using a script) into
a "all pending topics" branch should do what you want, no?  Restoring
from botches would mean removing the crappy branch and re-execute the
script.

Hope this helps.

-- 
Nicolas Sebrecht
