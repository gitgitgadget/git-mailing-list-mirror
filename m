From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Why /usr/bin/env in scripts
Date: Mon, 25 Apr 2005 13:45:19 -0400
Message-ID: <426D2CAF.7080101@dwheeler.com>
References: <426C9E63.4050907@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 25 19:42:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7aO-0001br-NC
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVDYRqC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVDYRqC
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:46:02 -0400
Received: from aibo.runbox.com ([193.71.199.94]:19608 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262701AbVDYRp2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 13:45:28 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DQ7e5-0005vb-PR; Mon, 25 Apr 2005 19:45:21 +0200
Received: from [129.246.254.27] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DQ7e2-0000ZK-19; Mon, 25 Apr 2005 19:45:18 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Philip Pokorny <ppokorny@mindspring.com>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <426C9E63.4050907@mindspring.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Philip Pokorny wrote:

> I notice that the first line of the pasky shell scripts is
>
> #!/usr/bin/env bash
>
> rather than what I'm more familiar with:
>
> #!/bin/bash

...

> So what am I missing?  Is this a portability aid?


Correct.  Bash gets installed in different places on different systems,
e.g., on OpenBSD bash is NOT in /bin or /usr/bin, but in /usr/local/bin.
Invoking "/bin/sh" on OpenBSD will _NOT_ get you bash, but a pdksh
variant that doesn't implement the bash capabilities some scripts require.
Using env this way an old trick; I don't know who originally came up 
with it.

Technically, even this isn't 100% portable.  Leading "#!" (shebang)
isn't implemented by a very few old systems (it's not in the Single User 
Spec,
though it was introduced between v7 and v8 of Unix). Also,
you can find one or two really obscure systems where env isn't in /usr/bin
(OpenServer 5 and a few really old Linux distributions).
But env is ONLY in /usr/bin for the *BSDs.
This version runs on 99.999% of the Linux/Unix systems, and takes
essentially zero effort to implement; "more portable" solutions are so much
more work that few people bother if they're writing shell scripts.

--- David A. Wheeler

