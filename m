From: Shawn Pearce <spearce@spearce.org>
Subject: Re: remote's HEAD not detected correctly
Date: Mon, 28 Feb 2011 13:01:08 -0800
Message-ID: <AANLkTimqTa24QSWACFX9GErt-Tn+wLda1s_AvH7dzEpm@mail.gmail.com>
References: <AANLkTimWieViK4JcJQuTDiRiAdyvHuwkwy8fL+XUV+i-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 22:01:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuADm-0007Vx-Eh
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab1B1VB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 16:01:29 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59423 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1B1VB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 16:01:28 -0500
Received: by iwn34 with SMTP id 34so3468266iwn.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 13:01:28 -0800 (PST)
Received: by 10.231.35.3 with SMTP id n3mr5792189ibd.90.1298926888097; Mon, 28
 Feb 2011 13:01:28 -0800 (PST)
Received: by 10.231.158.134 with HTTP; Mon, 28 Feb 2011 13:01:08 -0800 (PST)
In-Reply-To: <AANLkTimWieViK4JcJQuTDiRiAdyvHuwkwy8fL+XUV+i-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168145>

On Mon, Feb 28, 2011 at 12:52, Jeffrey Middleton <jefromi@gmail.com> wrote:
>
> So somehow, the clone misses the fact that origin's HEAD is pu, not
> master, and git remote is only partially aware of this. It looks like
> this only happens when the two branches in question are pointing to
> the same commit; perhaps git is trying to guess what HEAD is via the
> SHA1? I know that ls-remote prints an SHA1, not a refname, for HEAD -
> is it not actually possible to get that information through a general
> transport protocol?

Right. The transport protocol doesn't expose the name that a symbolic
reference points to, only its current value. Thus clients are forced
to guess by looking for another reference whose current SHA-1 is the
same. If there is more than one, its taking a best guess.

There have been a few attempts to expand the protocol and include the
current symbolic reference target name, but thus far it hasn't gotten
much beyond the idea stage.

-- 
Shawn.
