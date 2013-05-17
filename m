From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 5/6] test-lib: allow prefixing a custom string before "ok N" etc.
Date: Fri, 17 May 2013 10:00:39 +0200
Message-ID: <87fvxmc9y0.fsf@linux-k42r.v.cablecom.net>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<f440021d75345b1242e54f47697c3d2ac9593e99.1368736093.git.trast@inf.ethz.ch>
	<CABURp0pZQFB37oBDab1h3r8w7nj6jb+HXwPrbn=9pQhfLkTMMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 10:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdFas-00087X-Mv
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 10:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab3EQIAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 04:00:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6083 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab3EQIAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 04:00:41 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 May
 2013 10:00:38 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 17 May 2013 10:00:39 +0200
In-Reply-To: <CABURp0pZQFB37oBDab1h3r8w7nj6jb+HXwPrbn=9pQhfLkTMMQ@mail.gmail.com>
	(Phil Hord's message of "Thu, 16 May 2013 18:53:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224655>

Phil Hord <phil.hord@gmail.com> writes:

> On Thu, May 16, 2013 at 4:50 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> This is not really meant for external use, but allows the next commit
>> to neatly distinguish between sub-tests and the main run.
>
> Maybe we do not care about standards for this library or for your
> use-case, but placing this prefix before the "{ok,not ok}" breaks the
> TAProtocol.
> http://podwiki.hexten.net/TAP/TAP.html?page=TAP
>
> Maybe you can put the prefix _after_ the "{ok, not ok}" and test number.

Actually that was half on purpose.  You will notice I did not document
that option, as it is intended only to be used to distinguish between
the parallel runs implemented in [6/6].

Those parallel runs look something like

[4] ok 1 - plain
[4] ok 2 - plain nested in bare
[...snip until othes catch up...]
[4] ok 33 - re-init to update git link
[4] ok 34 - re-init to move gitdir
[3] ok 1 - plain
[2] ok 1 - plain
[4] ok 35 - re-init to move gitdir symlink
[4] # still have 2 known breakage(s)
[4] # passed all remaining 33 test(s)
[4] 1..35
[3] ok 2 - plain nested in bare

It's invalid TAP no matter what: there are N plans and the ok/not ok
lines from N runs all intermingled.  So I'd rather not even pretend that
it is valid in any way.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
