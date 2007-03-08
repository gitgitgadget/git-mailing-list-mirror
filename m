From: "David Tweed" <david.tweed@gmail.com>
Subject: Advice on strategy for "temporary" commits
Date: Thu, 8 Mar 2007 14:39:46 +0000
Message-ID: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 15:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPJmp-0002xW-BO
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 15:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbXCHOjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 09:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbXCHOjs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 09:39:48 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:5516 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbXCHOjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 09:39:47 -0500
Received: by nz-out-0506.google.com with SMTP id s1so431506nze
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 06:39:47 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WFCAsgojNvoK4SmDzCfqboi+JmrAopkkNstgWXo4Sp9dCi6I5zXry6Nd50vReb0SR4En51Pt8acURxK0RcAu1fzJNYmtOOgoIEefVE3byB6ppNbT3Qm8jshLMqzpyL3CNxODuRnzd7ONSZP4MHZZW5olnHs1Zz3JljukmEZ7Cmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GGBzogvRxL55PdMbpUXjSDKPwBYYJokXI7t8EIrBAG/4dE276dHfbAJxzJTlSkHoAXPxlfAblvwzjzVn4pKxXyyh9BAEwsh5Kfz510vLNFAUXpWpR7j5WmcJBWSoQ1Uei4cudEGRKEQGaxqPPCODw9QAWehf9vrEbVQxAL/LlD4=
Received: by 10.65.248.19 with SMTP id a19mr936392qbs.1173364786961;
        Thu, 08 Mar 2007 06:39:46 -0800 (PST)
Received: by 10.65.160.2 with HTTP; Thu, 8 Mar 2007 06:39:46 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41744>

Hi,

I've been working with my system taking automatic
hourly git snapshots of (filtered portions of) my home
directory for a couple of months. Being able to look
back to what files looked like mid-afternoon yesterday,
or on 18 Nov, is proving modestly useful. However,
I'm thinking about adding "temporary" commits every
ten minutes which then get discarded after 5 hours-ish
(in addition to the long-term archival hourly commits).
This is motivated by the desire to have finer granularity
for testing/bisecting short-term regressions but not having
ridiculously fine-grained changes clogging up the
archive long-term. (I'm aware that with the commits
being primarily taken on a timed basis I'll have more
non-compiling changes than is usual in a repository, so
that this may not turn out to be useful in practice.)

Looking through the git docs, it looks like the most
natural way of doing this is to make the 10-min commits
(via cron & tagging them under a special tag "temporary
commits only" directory) and then use

git-rebase --onto start-tag end-tag branch

every so often (via cron again) to chop the older
temporary commits between start-tag and end-tag
out of the database.

However, I'm not remotely expert on all the other
things you can do with git, so I'm just checking
there's not a way considered better/safer (eg, a separate
branch or repository).

Many thanks for any insight,
-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
