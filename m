From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 16:16:20 -0700
Message-ID: <CA+55aFwpVoqK7TaG0R3JJO07eOyWQ9pR1sHUGBQt0kmM0vk2bw@mail.gmail.com>
References: <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net> <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
 <CA+55aFzE-okH9gaEyuSFdorK-7v3odpsk65ZTqCMHFz80n65ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 16 01:16:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhrco-0005Bj-GW
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 01:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835Ab1GOXQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 19:16:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55770 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267Ab1GOXQo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 19:16:44 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FNGebK003275
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:16:41 -0700
Received: by wyg8 with SMTP id 8so1098203wyg.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:16:40 -0700 (PDT)
Received: by 10.216.237.131 with SMTP id y3mr971985weq.87.1310771800124; Fri,
 15 Jul 2011 16:16:40 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 16:16:20 -0700 (PDT)
In-Reply-To: <CA+55aFzE-okH9gaEyuSFdorK-7v3odpsk65ZTqCMHFz80n65ug@mail.gmail.com>
X-Spam-Status: No, hits=-102.886 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177242>

On Fri, Jul 15, 2011 at 4:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe there is something seriously wrong with this trivial patch, but
> it gave the right results for the test-cases I threw at it, and passes
> the tests.
>
> Before:

I have fewer branches than tags, but I get something similar for "git
branch --contains":

  [torvalds@i5 linux]$ time git branch --contains v2.6.12 | sha1sum
  9d4224eec98ec7b0bcd5331dfa5badb9ef1fd510  -

  real	0m4.205s
  user	0m4.112s
  sys	0m0.084s
  [torvalds@i5 linux]$ time ~/git/git branch --contains v2.6.12 | sha1sum
  9d4224eec98ec7b0bcd5331dfa5badb9ef1fd510  -

  real	0m0.112s
  user	0m0.100s
  sys	0m0.008s

ie identical results, except one took 4.2s and with the patch it took 0.1s.

This is all hot-cache, of course, and on a fast machine.

                    Linus
