From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [RFC v2] blame: new option --prefer-first to better handle
 merged cherry-picks
Date: Mon, 13 Jan 2014 23:52:29 +0100
Message-ID: <20140113225229.GA3418@client.brlink.eu>
References: <20140113063008.GA3072@client.brlink.eu>
 <xmqqfvor5xil.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 23:54:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2qP0-0005tc-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 23:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbaAMWyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 17:54:35 -0500
Received: from server.brlink.eu ([78.46.187.186]:55251 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbaAMWyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 17:54:33 -0500
Received: from workstation.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash VPEZql)
	id 1W2qOu-0006Eq-Bm; Mon, 13 Jan 2014 23:54:32 +0100
Received: with local; Mon, 13 Jan 2014 23:52:29 +0100
Content-Disposition: inline
In-Reply-To: <xmqqfvor5xil.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240377>

* Junio C Hamano <gitster@pobox.com> [140113 23:31]:
> I read the updated documentation three times but it still does not
> answer any of my questions I had in $gmane/239888, the most
> important part of which was:
>
>     Yeah, the cherry-picked one will introduce the same change as
>     the one that was cherry-picked, so if you look at the end result
>     and ask "where did _this_ line come from?", there are two
>     equally plausible candidates, as "blame" output can give only
>     one answer to each line.  I still do not see why the one that is
>     picked with the new option is better.

Because:
  - it will blame the modifications of merged cherry-picked commit
    to only one commit. Without the option parts of the modification
    will be reported as coming from the one, parts will be reported
    to be from the other. With the option only one of those two commits
    is reported as the origin at the same time and not both.
  - it is more predictable which commit is blamed, so if one is
    interested in where some commit was introduced first into a
    "mainline", one gets this information, and not somtimes a different
    one due to unrelated reasons.

> To put it another way, why/when would an end user choose to use this
> option?  If the result of using this option is always better than
> without, why/when would an end user choose not to use this option?

While the result is more consistent and more predictable in the case
of merged cherry picks, it is also slower in every case. Usually speed
will be more important than this exactness, especially as the result
will not differ for the common case (if there are no cherry-picked
commits merged or when those commits do not touch any files that are
otherwise only modified in the merged branch).

	Bernhard R. Link
-- 
F8AC 04D5 0B9B 064B 3383  C3DA AFFC 96D1 151D FFDC
