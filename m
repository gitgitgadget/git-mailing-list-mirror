From: Michael Blume <blume.mike@gmail.com>
Subject: Re: 'make test' fails in pu
Date: Tue, 17 Feb 2015 11:07:09 -0800
Message-ID: <CAO2U3Qju6+vua8hXHi49hOOnzXb-MDJ6yjmPPx-V=zp8hMGJ=A@mail.gmail.com>
References: <1424162357.30155.14.camel@kaarsemaker.net> <20150217085509.GC17174@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNnUe-0002rK-18
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 20:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbbBQTHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 14:07:31 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:37204 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbBQTHa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 14:07:30 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so56803964obc.7
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 11:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kbYs0liWeEwLavc1ailqOVHl9old0k6JZFOxV/h0d2w=;
        b=P9hDtfU8gMPlRLxOtKsUyeOaQmlaCfvy81FNFJ9qd3WSN1LnblLC5Lee8F+myZzmhC
         mmL/NeY+ZCGLfaURim/x5u4rIL30BWZ05Pdo14OmBBv/GXqCVEiIHbvq9jqspd8FfAjm
         sYKmSS9DxbAcK+9qlKyhB9FPNqEBvqAB3wv5xZRzUmDARre1E9+0ByY2blFCJqCsjg/N
         dF5bPH6Ppne1PUrRBzdu/TwjjGH36dbTp+dgmBMslUa0dSRz3YSAM1VhG9tYXCi/NMHZ
         gNq5mIPp/la5rDzORUdenwdTDR5vUAaRdxNF8819xL4yqgcLkd3gE71lfX+Kh1oBp6TA
         rpEw==
X-Received: by 10.182.153.39 with SMTP id vd7mr15588251obb.78.1424200049949;
 Tue, 17 Feb 2015 11:07:29 -0800 (PST)
Received: by 10.202.48.65 with HTTP; Tue, 17 Feb 2015 11:07:09 -0800 (PST)
In-Reply-To: <20150217085509.GC17174@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263976>

For the record, that commit also sporadically breaks test 3910 on my
system (mentioning since it's not on the list)

On Tue, Feb 17, 2015 at 12:55 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 17, 2015 at 09:39:17AM +0100, Dennis Kaarsemaker wrote:
>
>> Make test has been failing for 'pu' yesterday for and today at
>> t4016-diff-quote.sh. Full log:
>> http://ci.kaarsemaker.net/git/refs/heads/pu/1df29c71a731c679de9055ae5e407f3a4e18740a/artefact/test/log
>>
>> I noticed this a few times before and it tends to get fixed again
>> relatively quickly. So I'm wondering:
>>
>> - Should I even mention that it's failing, or is that just useless
>>   noise?
>> - If I should report this, I could also make my testing thing send
>>   mails. Would that be useful?
>
> If you bisect this, it turns up commit 30cd8f94f, which says:
>
>     WIP: diff-b-m
>
>     [...]
>
>     This update is still broken and breaks a handful of tests:
>
>          4016 4023 4047 4130 6022 6031 6032 9300 9200 9300 9350
>
> Sometimes a breakage in pu is surprising (e.g., it breaks only on a
> platform that the maintainer does not run "make test" on) and we would
> want to know about it. But sometimes it is merely that there is a
> work-in-progress. And it probably requires a human to tell the
> difference.
>
> So no, I do not think automatically mailing on test failures in pu is a
> good idea. Manually peeking at them and sending fixes before the series
> is merged to next _is_ very much encouraged, though. :)
>
> Unlike "pu", "next" and "master" should never fail tests (I think that
> Junio will not push them out if the tests have failed on his system). So
> failures there are much more likely to be interesting platform bugs (but
> of course, testing "pu" is still encouraged, as we may catch problems).
>
> But even for "next", I would say blind automated emails are not nearly
> as useful as a human who has looked at the problem (and especially
> bisected).
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
