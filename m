From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 0/3] submodule add: allow relative repository path even
 when no url is set
Date: Wed, 08 Jun 2011 09:16:52 -0400
Message-ID: <4DEF7644.1040204@cisco.com>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vipskb0br.fsf@alter.siamese.dyndns.org> <4DED30E0.6090608@web.de> <7vei368ylj.fsf@alter.siamese.dyndns.org> <4DED454B.1050105@xiplink.com> <4DEE923E.9030208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:16:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUId0-0008I6-GV
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 15:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab1FHNQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 09:16:54 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:61678 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab1FHNQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 09:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2030; q=dns/txt;
  s=iport; t=1307539012; x=1308748612;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=5kLpI+Fq2IGuiqpgVOj1qQAokGhJpmzubhicNEYV6Do=;
  b=ghx/Uzvq8yS+BLtb3VhvwAh9VtDvQj+fQ0dHgAeb3FWhcyk+726vUg6I
   E3mohnHzY5qwkwCZWSITQOIS7B+UhA3RVQhfFGneU2QoG0g7pKqr4fTAS
   eAOrVsHFxDZSxGnHa3YrCWczBhgiuEkEA4no3jwU2klwny7w8isilAJkH
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAER1702tJV2a/2dsb2JhbABThEqhZ3eIcaEJjRCQa4Erg26BCgSRG4RNixo
X-IronPort-AV: E=Sophos;i="4.65,338,1304294400"; 
   d="scan'208";a="372612755"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by sj-iport-2.cisco.com with ESMTP; 08 Jun 2011 13:16:51 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p58DGpWG021327;
	Wed, 8 Jun 2011 13:16:51 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DEE923E.9030208@web.de>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110608091652240
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175369>

/(Pardon the duplicate; sending this again from my clean MUA.)
/
Sometime last week, Marc Branchaud wrote:
> I believe your case works smoothly only because in your super-project
> you're careful to make sure you have checked out a branch that
> remotely tracks a something in remotes/public.  If you checked out a
> branch that tracks a different remote you'd get different results.
> This seems fragile to me.

Well, I definitely wasn't careful, but in fact I _was_ on a
remote-tracking branch.  The fact that 'git submodule add' is dependent
on the currently-checked-out branch is a surprise to me.

> When you tried the detached-HEAD scenario, did you get URLs for
> "public:git/sub" or "origin:git/sub"?  Does "origin" just happen to be
> the remote you want to use in any case?

Yes, origin happens to be the remote I want to use.  Actually, any of
the remotes would be fine with me because in this case I want to push to
all of them eventually.  The scenario I was working on was where I am
creating a new repository and new submodules to go in it.  All of my
remotes are clones of my repo collection.

git remote -v
git02    git02:foo/tss.git (fetch)
git02    git02:foo/tss.git (push)
origin    public:bar/tss (fetch)
origin    public:bar/tss (push)

> My fundamental point is that "git submodule add" seems to do confusing
> things with relative paths.  Maybe all that's needed is to clarify the
> documentation.  I'll post a patch.

I definitely agree that 'submodule add' does confusing and unexpected
things.   I only got it to work by carefully contriving the exact steps
required to make it work.  Editing .gitmodules directly would have been
much simpler.

Clarifying the documentation is a good first step. But now that you've
made me look at this more closely, I see there is much more to complain
about and, hopefully, get fixed.

I've run out of time today, though.  I'll follow up with another email
on this thread tomorrow.

Thanks for stirring this pot.

Phil
