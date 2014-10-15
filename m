From: Nicholas Chmielewski <nicholas.chmielewski@ennova.com.au>
Subject: Re: Expected bug with reset --hard
Date: Wed, 15 Oct 2014 15:47:51 +1000
Message-ID: <CAEemfuUNEEkgaX+ek0N1_801Zu=g6AizABmzAakpkosx93A_eQ@mail.gmail.com>
References: <CAEemfuW5k+2r7TpetUK8dh5vLZBR4-Kc1JgYJhG-RPpoQTRQ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 07:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeHRF-0007Ka-5e
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 07:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbaJOFrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 01:47:53 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:62828 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaJOFrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 01:47:52 -0400
Received: by mail-qg0-f53.google.com with SMTP id q107so391009qgd.26
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 22:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=4ES0T3n+OGTrEoKCe5pX/Vuj+kSalmd11m+qiybA5KM=;
        b=CufpWH2kgUoUkKDkicyK3UY88tewxsKX0P/TpSNH3B1S+YlkKpl9XWGyjbr0R9TBF4
         nv8Y39zB382ptqchXTFex/OKEY24B5RdT3Xn41BxsOtziNPi9xjO4KSnOUV76YSWAKlt
         pSDbBgdM3d4w7LqyUfuoPi1TWYjYMUqLe23gQ9jEIr1ijGshcdXaglZZR8I/ozwaTvbo
         UG/YWCscSA2m13NE8vhnr3QIoWcX4M31ksGlcMYaT5m0NNej1nvBvLqLNUQwpVUkqiRc
         etYNQ6W3t9VaorawXzYv2h6cKU6y2jTH7Ve1m4Wj5fD+syb056lBAPp2V+NB/0n+Dy+Q
         oSWw==
X-Gm-Message-State: ALoCoQmFjyuJP+RNkS06zB9V67SDsOxdBKWNVDphZigBWcpkJotY/OyWZFedsekAoj/kGGV2CamA
X-Received: by 10.224.131.8 with SMTP id v8mr16991905qas.6.1413352072036; Tue,
 14 Oct 2014 22:47:52 -0700 (PDT)
Received: by 10.140.94.172 with HTTP; Tue, 14 Oct 2014 22:47:51 -0700 (PDT)
X-Originating-IP: [150.101.176.147]
In-Reply-To: <CAEemfuW5k+2r7TpetUK8dh5vLZBR4-Kc1JgYJhG-RPpoQTRQ3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to rescind my bug report.


A bit more further investigation revealed that git was detecting the
file with changes as jquery.datatables.js but the file in my directory
was reported as being named jquery.dataTables.js .

I'm currently working on OS X 10.9, and this issue is probably related
more to the case-preservation of the file system rather than git
itself.

On 15 October 2014 14:34, Nicholas Chmielewski
<nicholas.chmielewski@ennova.com.au> wrote:
> git version 1.9.1 & version 2.1.2
>
> I had some changes in a tracked file that I wanted to discard.
> Instead of using checkout, I instead used `git reset --hard HEAD` to reset.
>
> Git returned the message `HEAD is now at <sha> <commit-message>`
> I then went `git status` and it showed me that I still have changes to commit
>
> I expected there to be no changes in my working directory as a result of
> doing a `git reset --hard`
>
> I did a little more fiddling around and still yielded the same results.
>
> - `$ touch file.md`
> - `$ git add file.md`
> - `$ git commit -m 'empty file'`
> - `$ echo 'text' > file.md`
>
> At this point git reported that I had uncommited changes for both file.md and
> the troublesome file in question (jquery.datatables.js)
>
> `$ git reset --hard HEAD`
>
> Git now no longer reports and untracked changes for file.md but still
> for jquery.datatables.js
>
> `$ git reset --hard HEAD~1`
>
> Git still reports untracked changes for jquery.datatables.js
>
> I have included a copy of the diff of the jquery.datatables.js
