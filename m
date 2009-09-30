From: David Brown <davidb@quicinc.com>
Subject: Re: Git push over git protocol for corporate environment
Date: Wed, 30 Sep 2009 16:23:09 -0700
Message-ID: <20090930232309.GA20409@huya.quicinc.com>
References: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 01:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt8W7-0002IZ-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 01:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbZI3XXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbZI3XXH
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 19:23:07 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:13318 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867AbZI3XXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 19:23:05 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5757"; a="24392654"
Received: from pdmz-ns-mip.qualcomm.com (HELO numenor.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Sep 2009 16:23:09 -0700
Received: from msgtransport02.qualcomm.com (msgtransport02.qualcomm.com [129.46.61.151])
	by numenor.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n8UNN9PV008295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 30 Sep 2009 16:23:09 -0700
Received: from huya (huya.qualcomm.com [10.46.166.122])
	by msgtransport02.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n8UNN9hC028895;
	Wed, 30 Sep 2009 16:23:09 -0700
Content-Disposition: inline
In-Reply-To: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129367>

On Wed, Sep 30, 2009 at 04:13:23PM -0700, Eugene Sajine wrote:

> As I understand the best solution here is git protocol (one port only
> on dedicated server and no security as we are in trusted network) with
> read and write access configured for all repos on a dedicated server.
> What do you think I should do? How to enable push over git protocol?

You can pass --enable=receive-pack but it probably isn't what you
want.  Anybody can write anything, anywhere with that, and more
importantly, anybody can delete anything.

When we started with git, we had a single machine that housed the
repos.  It ran a read-only git server, and people used ssh to
push to it.  It doesn't require accounts on the machine, but you
can use git-shell to restrict access.  This is probably a good
way to start out.

Eventually, it's possible to realize that there doesn't need to
be _the_ central server.  There can be several, and different
people in charge of different parts.  Here at least, people never
really adapted to this model.

We're now primarily using Gerrit, but that's a larger step from
process change from CVS.

David Brown
