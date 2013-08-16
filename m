From: Hiroshige Umino <hiroshige88@gmail.com>
Subject: Re: [PATCH] cherry-pick: allow "-" as abbreviation of '@{-1}'
Date: Sat, 17 Aug 2013 00:17:37 +0900 (JST)
Message-ID: <20130817.001737.1890599379619259228.xxx@gmail.com>
References: <1375506913-3390-1-git-send-email-hiroshige88@gmail.com>
	<87wqo33v4f.fsf@hexa.v.cablecom.net>
	<7vmwowm7bc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: trast@inf.ethz.ch, hiroshige88@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 16 17:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VALmq-0001SE-V4
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 17:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab3HPPRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 11:17:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60017 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab3HPPRy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 11:17:54 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2111100pbb.33
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:message-id:to:cc:subject:from:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oRAv9jLLZL8UgVkjnz5BRZYRYR3Ysb+Az6aPUpHkzXc=;
        b=VzsMgjZUDVddmLJp+uoQlqzMvzeqb4sgUgWx59woz0w/qEL5mHeL8WdBYVcx/SGLMw
         3YDa760q6J0UFTvsg+A5js13SwNnxgxAn7cqp0IGN9GMvdmaCm2x4b+lefi+lMnGYdj6
         y2LheYwwaFgz3GpnR96hAgFVG5Wtng/6/Jqu0xvGMVW8QYVSUoIBc93uuvHF6B2fQAgL
         XgrwVtNqihN+pT6hlZrkIgmJixh0sUzv9+ZrRBckTTFXoU9cSU6tV+yKbSaP09bHMRtO
         FaSLvTCLhluUqd4VZvUxZFEwlOWmakn8KTI3c2BKW5wsR/MpiDmyUsI6TeV46w2/ua4D
         E6Eg==
X-Received: by 10.66.232.39 with SMTP id tl7mr3611612pac.140.1376666273974;
        Fri, 16 Aug 2013 08:17:53 -0700 (PDT)
Received: from localhost (e0109-106-188-145-137.uqwimax.jp. [106.188.145.137])
        by mx.google.com with ESMTPSA id z14sm2733173pbt.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 08:17:52 -0700 (PDT)
In-Reply-To: <7vmwowm7bc.fsf@alter.siamese.dyndns.org>
	<87wqo33v4f.fsf@hexa.v.cablecom.net>
X-Mailer: Mew version 6.5 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232434>

Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
> 
>> Hiroshige Umino <hiroshige88@gmail.com> writes:
>>
>>> As "git cherry-pick -" or "git merge -" is convenient to
>>> switch back to or merge the previous branch,
>>> "git cherry-pick -" is abbreviation of "git cherry-pick @{-1}"
>>> to pick up a commit from the previous branch conveniently.
>>
>> The first line is confusing.  Did you mean to invoke the existing 'git
>> *checkout* -' and 'git merge -' functionality as a reason why 'git
>> cherry-pick -' should exist?
> 
> I think that is what was meant.  Just like "-" abbreviation is handy
> for users of "checkout" and "merge", "cherry-pick" might.

Yes I meant so and it would be useful at least for me.
I don't know the usage of cherry-pick (pick up a commit from the previous
branch) is comon or not but it may be also good for consistency.


Thomas Rast <trast@inf.ethz.ch> wrote:
> What other commands could reasonably use the '-' shorthand?

I've wanted '-' shorthand only for commit, merge and cherry-pick
but 'git diff -' may make sense.
What do you think of this and other candidates?

> Do you have to use a new test file for this?
Not have to so I'm moving the tests into t/t3500-cherry.sh.

> [...]
>> +test_expect_success 'setup' '
>> + echo hello >world &&
>> + git add world &&
> (*)
>> + git commit -m initial &&
>> + git branch other &&
>> + echo "hello again" >>world &&
>> + git add world &&
> (*)
>> + git commit -m second
>> +'
> 
> Our style is to indent the test snippets with a hard tab, not a single
> (or eight, for that matter) space.
> 
> [...]
>> +test_expect_success 'cherry-pick the commit in the previous branch' '
>> + prev=$(git rev-parse HEAD) &&
>> + git checkout other &&
> (*)
>> + git cherry-pick - &&
>> + test "z$(git rev-parse HEAD)" = "z$prev"
>> +'
> 
> If you insert 'test_tick' in the places marked with (*), the test fails.
> 
> The tests run under a fake clock to ensure that everything, including
> the SHA1s produced, are deterministic.  You never advance the clock, so
> all commits generated in this script share the same timestamp.
> 
> This means that the cherry-pick of 'second' has the same SHA1 as the
> original: its tree, parents, author, timestamp etc. all agree.  If you
> advance the clock at the last (*), this fails.  You should find some
> other way of checking what was picked, e.g., by looking at the file
> contents.
> 
> That said, please use test_commit in the 'setup' snippet instead of
> manually rolling the commits.  It will lead to shorter code, and it
> handles test_tick for you.  It is documented in t/README and in a
> comment in t/test-lib-functions.sh.  (You still need test_tick
> immediately before the cherry-pick!)

I overlooked t/README, thank you for kindly guiding testing!

--
Hiroshige UMINO @yaotti
