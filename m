From: "Besen, David" <david.besen@hp.com>
Subject: RE: Amending merge commits?
Date: Fri, 25 Jul 2014 22:23:37 +0000
Message-ID: <22F01493C523F940B4B5E53BB6D0F5352275F25B@G5W2738.americas.hpqcorp.net>
References: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
 <20140725221911.GL12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:25:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAnvj-0002Ld-Pg
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 00:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761162AbaGYWZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 18:25:33 -0400
Received: from g5t1626.atlanta.hp.com ([15.192.137.9]:38929 "EHLO
	g5t1626.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaGYWZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2014 18:25:32 -0400
X-Greylist: delayed 1525 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jul 2014 18:25:32 EDT
Received: from G6W4001.americas.hpqcorp.net (g6w4001.atlanta.hp.com [16.205.80.210])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g5t1626.atlanta.hp.com (Postfix) with ESMTPS id D57A91D1
	for <git@vger.kernel.org>; Fri, 25 Jul 2014 22:25:31 +0000 (UTC)
Received: from G5W5499.americas.hpqcorp.net (16.201.144.179) by
 G6W4001.americas.hpqcorp.net (16.205.80.210) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Fri, 25 Jul 2014 22:23:38 +0000
Received: from G5W2738.americas.hpqcorp.net ([169.254.9.123]) by
 G5W5499.americas.hpqcorp.net ([16.201.144.179]) with mapi id 14.03.0169.001;
 Fri, 25 Jul 2014 22:23:38 +0000
Thread-Topic: Amending merge commits?
Thread-Index: Ac+oVDmfmjED5uGKRamOjUJHcWVPKwAAjvyAAAAhmJA=
In-Reply-To: <20140725221911.GL12427@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.201.12.26]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254272>

Ah thanks, I'll RTFM better in the future.

- Dave

-----Original Message-----
From: Jonathan Nieder [mailto:jrnieder@gmail.com] 
Sent: Friday, July 25, 2014 4:19 PM
To: Besen, David
Cc: git@vger.kernel.org
Subject: Re: Amending merge commits?

Besen, David wrote:

> I think one of my coworkers has stumbled on a git bug -- if you
> amend a merge commit, and then pull, your amends are lost.

This is how pull --rebase works.  It turns your single-parent commits
into a sequence of patches on top of upstream and completely ignores
your merge commits.

There is a --rebase=preserve option that makes a halfhearted attempt
to preserve your merges --- perhaps that would help?  The
git-rebase(1) documentation has more details.

In an ideal world, I think pull --rebase would do the following:

 1. Do the same thing it does today
 2. Behind the scenes, *also* try a 'pull --merge' but don't save
    the result.
 3. Compare the results.  If they differ, show a diff and explain
    to the user what happened.

I may be the only one that wants that, though.

Hope that helps,
Jonathan
