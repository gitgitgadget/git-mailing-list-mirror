From: Olivier ROLAND <cyrus-dev@edla.org>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Tue, 28 Apr 2015 13:02:17 +0200
Message-ID: <CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
	<20150428055506.GJ24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Apr 28 13:02:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn3HT-0003dC-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 13:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbbD1LCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 07:02:19 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38081 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933179AbbD1LCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 07:02:18 -0400
Received: by igbhj9 with SMTP id hj9so17334980igb.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 04:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:cc:content-type;
        bh=raoUFKLMlL637miyTKj9Ae4xqfMIt3ppb2OgDppACTM=;
        b=ORub8TwBI3+xrClQn+Z5QNM6ggymS/1wEX+E0OrreJTz0OtTP7NoUpLiJIS67tyQz2
         o61CJivpZaLvioU38Y9LCD2tsODfeF2zOLhS20ymMS9dQBEp3mvbqMndViRC9KIAqDV6
         cj9/s0SMmzcIdgNbdh2Y6aLgKTY3ZkEb8FBTAqpcePlUhMv90kSqQ8PundIWESivRmvu
         eXZl4Z+kOE2sD9I744HolBSpJsML0+zimpe6sFOFIJM8rPsnTuztJnFhhQl/S3Ffy7U6
         JTNqcGwqJsfn5csEX//ucPSlQZiJ8BljzSxoRA7tyfQAPiB6Cw9PKSAtCvUqYLQCU27t
         Ar3g==
X-Gm-Message-State: ALoCoQmnoTmyGFg668f5JYK56xc9Ihf9FFOnCKh7MP6w0pnTe74z9t76FRRwJ6aKKCthnMwWZF+j
X-Received: by 10.107.6.84 with SMTP id 81mr20308019iog.52.1430218937471; Tue,
 28 Apr 2015 04:02:17 -0700 (PDT)
Received: by 10.36.6.8 with HTTP; Tue, 28 Apr 2015 04:02:17 -0700 (PDT)
X-Originating-IP: [90.58.122.223]
In-Reply-To: <20150428055506.GJ24580@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267920>

2015-04-28 7:55 GMT+02:00 Jeff King <peff@peff.net>:
> On Sun, Apr 26, 2015 at 11:25:52AM +0200, Olivier ROLAND wrote:
>
>> OSX 10.10.3 git 2.3.6 HFS+ case-sensitive
>>
>> How to reproduce :
>> Step 1 : git clone https://github.com/begeric/FastParsers.git
>> Step 2 : cd FastParsers/
>> Step 3 : git filter-branch --env-filter 'if [ 0 = 1 ]; then echo 0; fi' -- --all
>>
>> Result on OSX :
>> Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
>> Ref 'refs/heads/experiment' was rewritten
>> Ref 'refs/remotes/origin/experiment' was rewritten
>> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
>> Ref 'refs/remotes/origin/master' was rewritten
>>
>> Result on Debian :
>> Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
>> WARNING: Ref 'refs/heads/experiment' is unchanged
>> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
>> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
>> WARNING: Ref 'refs/remotes/origin/master' is unchanged
>>
>> Do you have any thoughts on this ?
>
> Weird. Did you build both versions of git from source (that is, there's
> no question that the OS X one is a hacked-up Apple git or something)?
>
> Presumably it's some incompatibility in the shells used. What does:
>
>   head -1 "$(git --exec-path)/git-filter-branch"
>
> say about the shell in use on each system? Does running that shell with
> "--version" report anything useful?
>
> -Peff

Hi,

Both versions are builded from source.
head -1 "$(git --exec-path)/git-filter-branch"
#!/bin/sh

sh --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin14)
Copyright (C) 2007 Free Software Foundation, Inc.

/bin/bash --version
GNU bash, version 4.1.5(1)-release (x86_64-pc-linux-gnu)

The bug seem really git related.

Thanks.
