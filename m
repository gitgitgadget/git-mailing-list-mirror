From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 0/4] Add guards to guilt
Date: Mon, 30 Jul 2007 01:32:53 -0700
Message-ID: <873az6cmve.fsf@hubert.paunchy.net>
References: <118569541814-git-send-email-eclesh@ucla.edu>
	<20070730035443.GC22017@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQgl-0006Pf-UA
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 10:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972AbXG3IdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 04:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759537AbXG3IdL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 04:33:11 -0400
Received: from smtp-8.smtp.ucla.edu ([169.232.47.138]:47576 "EHLO
	smtp-8.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbXG3IdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 04:33:09 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.151])
	by smtp-8.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U8X053017004;
	Mon, 30 Jul 2007 01:33:00 -0700
Received: from localhost (adsl-75-26-162-197.dsl.scrm01.sbcglobal.net [75.26.162.197])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U8WxQD016312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 01:32:59 -0700
Received: by localhost (Postfix, from userid 1000)
	id BA71A1E80A8; Mon, 30 Jul 2007 01:32:53 -0700 (PDT)
In-Reply-To: <20070730035443.GC22017@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Sun\, 29 Jul 2007 23\:54\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.47.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54207>

Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

>
> I know I've been bad about forcing even myself to write new regression
> tests. Your patches modify things significantly enough, that I'd like to see
> some regression tests cases to make sure that user's data is not eaten
> (e.g., a bug in the guard setting code could blow away the series file =>
> very bad).
>

Yeah, I'll try and make one.  070-guards.sh to test guilt-guard and
guilt-select plus pushing and popping?

There's also sed -i in a few places. For integrity purposes, are a cp
and sed better?

>> This introduces the command `get_guarded_series`, which just lists
>> patches that are to be applied based on the guards.  It also makes
>>         eidx=`wc -l < $applied`
>> inaccurate if you're using it as an index into get_series.
>
> The index-based patch finding is a bit nasty anyway.
>
>> If you change guards on a patch or select a different guard while
>> patches are applied, some commands might get confused. guilt pop -a will fix
>> everything though.  Usually, it's best to pop -a before fiddling with
>> guards anyway.
>
> Is this a problem with other projects' implementations of guards as well?
> Perhaps printing a warning if a new guard is set when there are applied
> patches would be in order?
>

Yeah, they have this problem too, but tell you so when you select, so
guilt should too. I'll fix that up.  Mercurial also has two options
which do the popping and reapplying for you, which I'll try and implement also.

Thanks a lot for the review.  Things were pretty ugly, but with your
help it should look much better.

	Eric
