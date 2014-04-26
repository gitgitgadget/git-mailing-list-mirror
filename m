From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 19:22:38 +0200
Message-ID: <878uqs80pt.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
	<87wqec8rb5.fsf@fencepost.gnu.org>
	<CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
	<87ha5g8286.fsf@fencepost.gnu.org>
	<CAJo=hJsrFb+FdBDoHiYOPeB0nEQhD+9dBXTK84bDSj1MgBBdQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6JI-0004JK-Mm
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbaDZRWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:22:40 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:45794 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbaDZRWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:22:39 -0400
Received: from localhost ([127.0.0.1]:44837 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1We6JC-0002l5-Hn; Sat, 26 Apr 2014 13:22:38 -0400
Received: by lola (Postfix, from userid 1000)
	id 1D9A8E05FE; Sat, 26 Apr 2014 19:22:38 +0200 (CEST)
In-Reply-To: <CAJo=hJsrFb+FdBDoHiYOPeB0nEQhD+9dBXTK84bDSj1MgBBdQA@mail.gmail.com>
	(Shawn Pearce's message of "Sat, 26 Apr 2014 10:09:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247162>

Shawn Pearce <spearce@spearce.org> writes:

> Right, and JGit blame still is missing the -M and -C options, as I
> have not implemented those yet. I got basic blame and reverse blame
> working a few years ago and then stopped working on the code for a
> while. Now we have interest in improving the latency for $DAY_JOB, so
> I've been poking at the code again for the last week or so.
>
> But that -M and -C thing is still not implemented, and I know its
> going to be tricky to get right with the way the scapegoating is
> passed along.

Actually, for -M/-C it would be saner to rip open the whole xdiff
blackbox which internally goes to quite some effort in order to produce
the linear ordering of a diff, and then -M has to simulate dropping that
linear ordering requirement by doing a host of parallel diffs for each
chunk.

-- 
David Kastrup
