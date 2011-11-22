From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/3] revert: remove --reset compatibility option
Date: Tue, 22 Nov 2011 17:11:45 -0600
Message-ID: <20111122231145.GE6274@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112046.GG7399@elie.hsd1.il.comcast.net>
 <7vzkfnde05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 00:11:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSzVN-0002dA-J7
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 00:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab1KVXLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 18:11:52 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55950 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab1KVXLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 18:11:51 -0500
Received: by yenq3 with SMTP id q3so767446yen.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 15:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Sk/rMyEKi0lLxdW+Tw+9pLhIarBvwCQ++kErACNvIpM=;
        b=azPsYMCHAgNO5KPfWxZYuG10o/ZzjmxCUpunsd+VO+VLwXyZ9V/ZqkcwalNd3rGhKi
         wlSV83UYAV/PF5UdrOBVkIfYQU/TmbiDax3wL5fpo/zPDYLzJBxhmxsJGK7Gvv+gLXQ5
         rX5LkCo952ir/F9qPO0Vq0jT3LLvlNKxvBN/4=
Received: by 10.236.184.225 with SMTP id s61mr31528759yhm.80.1322003511131;
        Tue, 22 Nov 2011 15:11:51 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q5sm21751508yhm.7.2011.11.22.15.11.48
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 15:11:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzkfnde05.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185813>

Junio C Hamano wrote:

> If we want to reach this point eventually, given that --reset was not in
> any released version, and also given that we are deep in pre-release
> phase, we probably should either just apply the first one (and perhaps
> this one) from the series immediately before 1.7.8 final, or delay the
> final and swallow the entire series.

Makes sense.

> I am not quite convinced that quit is *that* superiour over reset
> though. The description in 1/3 "has a confusing name" does not say why it
> is confusing, either, to help readers agree with the conclusion.

Ok, a few words about this.

I should say that I am not deeply attached to --quit.  If some other
word for "abandon" (or some other concept entirely) is more obvious,
I'd be happy to see it used.  From a couple of days of practice, I can
say that --quit feels fine in a way that --reset didn't, but not much
more.

--reset is a cognate to "git reset", the command to make some
combination of the HEAD, index, and worktree just so.  In other
contexts --- rebooting a machine, resetting an alarm clock --- to
reset something also means to return it to a known state.  By
contrast, the "git cherry-pick --abandon" command is about leaving the
state alone as much as possible while escaping from the context of a
cherry-pick sequence.

How does that do harm, though?  My main fear is that people would not
notice that --reset is the option they want to use and would opt to
"rm -r .git/sequencer" instead, which is a kind of error-prone
wizardry that should not be required.

(I assume cherry-pick --reset was named by analogy with "git bisect
reset", the command to abandon a bisection and return to the branch
you were on before bisection, or a branch or commit named on the
command line.  Which is not analagous to cherry-pick --abandon at
all.  The command people often run, "git bisect reset HEAD", is a
closer analog if you squint right.)
