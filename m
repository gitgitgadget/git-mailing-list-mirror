From: <Patrick.Higgins@cexp.com>
Subject: RE: Windows symlinks
Date: Wed, 25 Jun 2008 11:50:03 -0600
Message-ID: <911589C97062424796D53B625CEC0025E46196@USCOBRMFA-SE-70.northamerica.cexp.com>
References: <32541b130806241704y3befda90j78329af2f30d95d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <jnareb@gmail.com>, <git@vger.kernel.org>
To: <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZAs-0001I4-W0
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 19:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYFYRv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbYFYRv7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 13:51:59 -0400
Received: from mx02.cexp.com ([170.131.136.83]:18238 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbYFYRv6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 13:51:58 -0400
Received: from mailgate2.cexp.com (uscobrmfa-se-07.cexp.com [170.131.144.37])
	by mx02.cexp.com (Postfix) with ESMTP id D8F1F1E71BC
	for <git@vger.kernel.org>; Wed, 25 Jun 2008 11:50:57 -0600 (MDT)
Received: from USCOBRMFA-SE-70.northamerica.cexp.com ([10.128.26.36]) by USCOBRMFA-SE-52.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 25 Jun 2008 11:50:57 -0600
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <32541b130806241704y3befda90j78329af2f30d95d2@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Windows symlinks
Thread-Index: AcjWVxcWUouvCH6vRj6yzJopXWPq7gAkrfEg
X-OriginalArrivalTime: 25 Jun 2008 17:50:57.0529 (UTC) FILETIME=[05A38E90:01C8D6EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86310>

> From: Avery Pennarun [mailto:apenwarr@gmail.com]
>
> > Agreed. The first thing we started working on was getting 
> symlinks out of our repositories.
> > Unfortunately, we chose to use them because we are using 
> broken development tools that
> > don't support proper modularity. We found the best way to 
> 
> Perhaps git-submodule would do what you're looking for.

We might be able to get by with them, but submodules appear to be significantly more complex than symlinks, and we sometimes symlink just a file or two if that's all we need. Splitting up submodules to that level of granularity would be hard to manage.

My understanding of the submodule workflow is:

Projects A, B, and C (we actually have about 17 of these) all share common code in project Common. Then, each of A, B, and C adds Common as a submodule. While working on project A, the need arises to modify Common, so the developer changes it there, commits, pushes the change to Common, then commits and pushes the change to A. To update B and C, they would have to change to each of those projects, run a git pull, then git submodule update, and compile and test.

Is that correct? If so, it's a lot more work than letting a symlink propagate the change to all the other projects. Of course, since Windows doesn't have symlinks...
