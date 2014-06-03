From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: Reset by checkout?
Date: Tue, 03 Jun 2014 22:48:49 +0300
Message-ID: <538E26A1.5020509@bracey.fi>
References: <20140531144610.754B.B013761@chejz.com> <53898448.8040105@bracey.fi> <20140601132624.821C.B013761@chejz.com> <538AE814.2010407@bracey.fi> <xmqqmwdv2d08.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nakagawa <atnak@chejz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:08:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrv0W-0005dk-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 22:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933706AbaFCUIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 16:08:23 -0400
Received: from mo2.mail-out.ovh.net ([178.32.228.2]:53643 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934283AbaFCUIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 16:08:20 -0400
Received: from mail435.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id BD285FF9899
	for <git@vger.kernel.org>; Tue,  3 Jun 2014 21:48:53 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 3 Jun 2014 21:54:59 +0200
Received: from 81-175-152-164.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@81.175.152.164)
  by ns0.ovh.net with SMTP; 3 Jun 2014 21:54:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <xmqqmwdv2d08.fsf@gitster.dls.corp.google.com>
X-Ovh-Tracer-Id: 2887088838073749720
X-Ovh-Remote: 81.175.152.164 (81-175-152-164.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrjedtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500002/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrjedtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250642>

On 03/06/2014 00:54, Junio C Hamano wrote:
>
> Not that I can think of a better way to update these descriptions,
> and not that I am opposing to update these descriptions to make it
> easier for new people to learn, but I am not sure if these "treat
> ORIG_HEAD and the changes since that commit as separate entities"
> is a good approach to do so.
>
> Somewhat frustrated, not by your patch but by being unable to
> suggest a better way X-<.
>
>

I know. I started off myself knowing what I meant to say, and then got 
bogged down somewhat trying to be detailed enough for a full 
explanation. I think it's just inherently very hard for anyone to 
visualise what these do in the /general/ case.

This is one of those commands where the structure of a man page gets in 
the way. We have to give a summary of what the mode options /do/, but 
that's not what people want to know. They want to know what they're /for/.

(And, to some extent, reset, like checkout, is two separate commands. 
One being the path manipulator, the other being the HEAD manipulator. 
Just bogs us down further).

I think these are the most important HEAD resets, covering 95%+ of uses:

    git reset --soft HEAD~<n>
    git reset HEAD~<n>
    git reset --keep HEAD~<n>
    git reset --keep ORIG_HEAD
    git reset --keep @{<n>}
    git reset --keep <some other arbitary place>

(and possibly

    git reset --merge

although I think this should be fully covered by "git xxx --abort" - 
maybe a couple of those missing like git stash pop/apply --abort?)

Anything more than those, I think, are pretty far-fetched. I can't 100% 
grok "--soft/--mixed" onto a different branch, for example. (But at 
least we do define those cases in the A/B/C/D "discussion" section for 
the real geeks.)

Maybe we just need to tighten up the EXAMPLES section? Give it 
easy-to-locate <path>/--soft/--mixed/--keep subheadings, covering all 
those common use cases (in clean trees...), including a before/after git 
status views. Then normal users could skip the top technical section 
waffling about indexes and go straight there instead.

Kevin
