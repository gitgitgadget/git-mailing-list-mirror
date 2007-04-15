From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Sat, 14 Apr 2007 23:50:04 -0700
Message-ID: <56b7f5510704142350w66576704la62648c6f5d990f0@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz>
	 <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
	 <56b7f5510704121132g3961060amb394978bb49093e6@mail.gmail.com>
	 <Pine.LNX.4.64.0704121203290.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David Lang" <david.lang@digitalinsight.com>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, danahow@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 08:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcyZF-0001VE-13
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 08:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXDOGuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 02:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXDOGuH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 02:50:07 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:7749 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbXDOGuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 02:50:05 -0400
Received: by an-out-0708.google.com with SMTP id b33so1338381ana
        for <git@vger.kernel.org>; Sat, 14 Apr 2007 23:50:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sY83qKpyOutwblBlKB32YZiGJ2TZUspMG5Go7AZdy4juSw1X9w7FAtNipUoLR1ZCnpzIRBN4ffBup+sjvavd9Iq5whbXb79xMi+1SxYbS92iVSJ6Uar7EmFd2lKETsr0vIp5rLbL5mq5FnrGQdlUWzddHmaSE2nLsovMzpihkFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZMNmyp/2ciHMFmwtxdxtCm4/p7438itOn7VpVg4YEfvxK1+fdOsjLZft81/RnL1pLs0TZgp+z7oYOYwjR/7aw6ZXnh7/6805ISGrTowg1Bitg0UTR9HdLTQVn7rERSQyS2ddwveJzUUzbHkSK1AzpfYjvBGSHCWQ8bKt4YIIhkk=
Received: by 10.115.14.1 with SMTP id r1mr1601533wai.1176619804215;
        Sat, 14 Apr 2007 23:50:04 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Sat, 14 Apr 2007 23:50:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704121203290.4061@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44489>

On 4/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 12 Apr 2007, Dana How wrote:
> > These arguments all seem pretty convincing to me --
> > maybe the problem is that I'm not a "*developer*" right now.
> > Instead I'm part of a multi-developer *site*.
> The issues for hosting sites are very different from the issues of
> individual developers having their own git repositories, and I agree 100%
> that both alternates and shared object directories make tons of sense for
> hosting.
For clarity I should have written *office* instead of *site* to
describe my situation,
but the mention of a NetApp below indicates no actual confusion occurred.

> As to your two setups: I would suggest you go with the "hidden" shared
> version (ie people use the remote access pull/push to a server, and the
> *server* uses a shared object repository for multiple repositories),
> rather than having a user-visible globally shared object directory. Even
> with sticky bits and controlled group access etc, I think it's just safer
> to have that extra level of indirection.
>
> (Partly because a globally visible shared object directory also implies
> that you'd use a networked filesystem, and I suspect a lot of developers
> would actually be a lot happier having their own development repositories
> on their own local disks, or at least some "group disk", rather than have
> one big and performance-critical network share. Even if you use some
> competent NetApp box and a modern network filesystem, it's just one less
> critical infrastructure piece that needs to be really beefy).
We did go down the local disk route, but after two significant losses of
individuals' work,  it was decreed that (perforce) work trees must be
on the NetApp.  So we already made the investment in beefiness --
for different reasons -- and I need to conform to these decisions for
the moment.

After reliability, the other big criterion (especially with our
penchant for large files)
will be speed. With perforce,  users now see submit={1 copy to server},
sync={1 copy from server}.  In the short term I can't get away with changing
this to submit={copy working to indiv repo, copy indiv repo to shared repo}
and sync={copy shared repo to indiv repo, copy indiv repo to working},
because at first everyone will be trying to emulate what they did in perforce.

So probably I'll start out with either a very small testgroup,
or one shared object repository with sticky/group tricks on the NetApp.
Once git's collaboration advantages are apparent,
I'll switch to the hidden repository model which I prefer as well.
And hopefully these collaboration advantages will also mean people
will commit more often and local disks can come back into favor --
and then the "extra" local repo file copy operations will be less noticeable.

In any event, I have some scripting to do to learn more about our usage
patterns and pushing our datasets throught git.  I also need to finish
the pack-splitting patch (after 64b index goes in). Finally,  before all that,
I'll be out of the country for the next ~10 days...

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
