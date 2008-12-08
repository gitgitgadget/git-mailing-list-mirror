From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Mon, 08 Dec 2008 19:26:03 +0100
Message-ID: <493D66BB.3060907@tuffmail.com>
References: <493A6CEC.4060601@tuffmail.com>	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>	 <493C1F36.7050504@tuffmail.com> <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com> <493C47FD.4080302@tuffmail.com> <493D1CC2.8050407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 19:27:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9kpL-0002CX-Ox
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 19:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYLHS0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 13:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbYLHS0J
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 13:26:09 -0500
Received: from mxout-03.mxes.net ([216.86.168.178]:4372 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYLHS0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 13:26:08 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id 8F59023E406;
	Mon,  8 Dec 2008 13:26:05 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
In-Reply-To: <493D1CC2.8050407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102570>

Michael J Gruber pisze:
> Could it be as simple as a missing "cd cocoon" between git clone and git
> svn rebase? No, you probably did that.

That would be too easy.

> But note that you did not follow Peter's instructions. The point is that
> your clone creates "remotes/origin/trunk" whereas Peter's instructions
> mirror the source, creating "remotes/trunk", which is what git svn needs
> (unless you say "git svn init -s --prefix=origin/" or "git config
> svn-remote.svn.fetch trunk:refs/trunk" etc.). The prefix solution should
> be the best.
> 
> Michael
> 
> P.S.: Peter starts off a different layout (standard svn remotes, which
> need special instructions to be cloned). Ordinary clone + git svn init
> --prefix=origin/ should work fine for the cocoon layout.

This almost worked. Actually, Cocoon repository hosted on Jukka's server does not have local head
named "trunk" so there is no remotes/origin/trunk created during cloning process.

I had to run:

  git update-ref refs/remotes/origin/trunk refs/heads/master

After doing that git svn rebase resulted in:
[really long list of revisions]
r707379 = f61a2d30b6ac5a5136b46fa2b9b5b91e4763feb1
r710118 = 40997fe552e8581b75b08fed41a6b63a33d58bdf
r720135 = a8160766ec40fd7ebf95bfa7cebfa50dfa2f9c3a
r720180 = b094a222bab3671c8277087e7a96589ec76dd5e4
r720182 = 736b8ed6519c64ad120de2ccf08f135062ee09db
Done rebuilding .git/svn/origin/trunk/.rev_map.13f79535-47bb-0310-9956-ffa450edef68
Current branch master is up to date.

Is this expected output?

> P.P.S.: We can't test cocoon unless we have an account on the apache
> server...

I guess this would be a big problem. Getting write-access access to our repository is rather formal
process and I would like to avoid it.

Since it looks I'm much closer to final solution (and better understanding of how our workflow
should look like) I hope any additional account for testing won't be needed.

Anyway, thanks again for your answer!

-- 
Best regards,
Grzegorz Kossakowski
