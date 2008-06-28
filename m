From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug related to branches using / in name
Date: Sat, 28 Jun 2008 04:42:58 -0700 (PDT)
Message-ID: <m3hcbdiy4k.fsf@localhost.localdomain>
References: <1214509350.28344.31.camel@odie.local>
	<20080627030245.GA7144@sigill.intra.peff.net>
	<20080627035747.GC7144@sigill.intra.peff.net>
	<7vtzfemp4d.fsf@gitster.siamese.dyndns.org>
	<20080628041841.GA9451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-15?q?Simon_Holm_Th=F8gersen?= <odie@cs.aau.dk>,
	git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 13:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCYqi-0006z9-3K
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 13:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbYF1LnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 07:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbYF1LnG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 07:43:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7744 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbYF1LnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 07:43:03 -0400
Received: by nf-out-0910.google.com with SMTP id d3so231584nfc.21
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=vOYBC5Z92mV9Dr3TOTnNeDj5A+xNm47dTQZMwVOfD7o=;
        b=YfhWM3MVM950q7hsl8NHsoHWpoPzPmNPCZL3fhJUu6BYWRyeaQJJAIBjK5S1kgw8vW
         wURjCqWl7ZJyI8tx4zyvuU3q9YQ7jeHSylUU47enY9ZrDyfzyB1Zk7DZIkIqCPG3blGU
         gQPsc8fv3wNMxw8wz3gppM7eGp9xm0aYdOyJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ZkeYfuN4iJ3DbCsUalMVNvjNaRflrksnmRwmV+dgiLn9DbhdzWBjSRAdk1xshtnM3k
         IS2rtrjZGuikAT5QbwNISxo2Rvju5ogsH05woSthqrG0aiB4lhvEq9Yv3A8AMIdSpRqZ
         A4H1ZicAfwjg9daHY5XixMtp/5H4suAdSvs28=
Received: by 10.210.90.10 with SMTP id n10mr2093188ebb.179.1214653380225;
        Sat, 28 Jun 2008 04:43:00 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.220.206])
        by mx.google.com with ESMTPS id y37sm3117152iky.8.2008.06.28.04.42.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Jun 2008 04:42:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5SBgsrg002720;
	Sat, 28 Jun 2008 13:42:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5SBgq8S002716;
	Sat, 28 Jun 2008 13:42:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080628041841.GA9451@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86711>

Jeff King <peff@peff.net> writes:
> On Fri, Jun 27, 2008 at 04:31:30PM -0700, Junio C Hamano wrote:
>> 
>> [...]  After all, tracking branches are meant to accept rewinds and
>> anything that happens on the remote end, and having to run "git remote
>> prune" is not a feature but is a lack of feature in the "git fetch", which
>> may make it look like deletion is somewhat special.
> 
> The one key difference between rewinds and branch deletion is that the
> latter will kill off the reflog, making the history inaccessible. You
> can always still access rewound or rebased work via the reflog.
> 
> If we don't care about this "safety feature", then I definitely agree
> that we should fix the problem rather than hint to the user.

There were some attempts to add some kind of "Attic" to save
reflogs for deleted branches, but IIRC the discussion petered out
after few initial patches because there were some conflict over
details of implementation (the problem being how to deal with D/F
conflicts).

If this makes into git, this trouble will disappear... perhaps
with some stronger marker that branches can dissapear, not only
rewind

        +!refs/heads/*:refs/remotes/origin/*

or

        +refs/heads/*?:refs/remotes/origin/*?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
