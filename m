From: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
Subject: Re: Prompt for merge message?
Date: Thu, 6 Oct 2011 18:15:11 -0700 (PDT)
Message-ID: <403e37d1-bdd3-46fc-9a9a-e8aab3a2d3ba@f6g2000vbm.googlegroups.com>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
 <7vsjn5ye0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 04:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBzlT-00065l-MQ
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 04:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759449Ab1JGCCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 22:02:15 -0400
Received: from mail-vw0-f56.google.com ([209.85.212.56]:55794 "EHLO
	mail-vw0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1JGCCO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 22:02:14 -0400
X-Greylist: delayed 2822 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2011 22:02:14 EDT
Received: by vws8 with SMTP id 8so2129756vws.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 19:02:14 -0700 (PDT)
Received: by 10.220.150.4 with SMTP id w4mr345650vcv.10.1317950111303; Thu, 06
 Oct 2011 18:15:11 -0700 (PDT)
Received: by f6g2000vbm.googlegroups.com with HTTP; Thu, 6 Oct 2011 18:15:11
 -0700 (PDT)
In-Reply-To: <7vsjn5ye0x.fsf@alter.siamese.dyndns.org>
User-Agent: G2/1.0
X-Google-Web-Client: true
X-Google-Header-Order: HUALESNKRC
X-HTTP-UserAgent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20100101 Firefox/7.0.1,gzip(gfe)
X-Google-IP: 96.244.66.187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183055>

On Oct 6, 6:02=A0pm, Junio C Hamano <gits...@pobox.com> wrote:
> Others commented on the current practices and gave their own useful t=
ips
> already, but an additional hint is to name your branch more sensibly,=
 so
> that you do not feel it is useless to record it in the history.

While I can see your point of view, I don't think that it fits every
work-flow. In particular, if you want to maintain a linear history on
the master branch but record the completion of a feature as a commit
object separate from the last patch in a series, you have two choices
at the moment:

1. A fast-forward merge, followed by an empty commit with --allow-
empty. However, the empty commit seems to get discarded on merges, or
finds other ways to disappear outside of the feature branch on which
it was created. It probably isn't a bug, but it can be very surprising
to create an empty commit object on a feature branch, and then have it
disappear when you merge to master.

2. A merge commit with an explicit merge message, which is what we've
been talking about in this thread.

The point of the exercise is (mostly) to integrate with issue trackers
like Pivotal or GitHub, where a commit with certain keywords can
integrate with ticket history. But, IMHO, it doesn't necessarily make
sense that any given patch closes a ticket; sometimes they do, but
sometimes I really prefer a standalone commit to essentially say "and
now the ticket is really, really done."

The fact that there have been so many useful suggestions about how to
work around this issue seems to imply that it isn't a low bus-factor
issue. My personal vote is for your suggestion of an [-e|--edit] flag
for the merge; that would make it (mostly) consistent with commit's
behavior. I can certainly see that in the common case the default
merge message is the right thing to do, but I really do feel that
there ought to be *some* flag to allow a visual editor to edit the
merge message without having to amend the merge commit or merge
without a commit just so that the next commit will invoke the editor.

Ultimately, I guess what I'm really agitating for is just an editor
option for merge commits. If you take work-flow out of the equation,
isn't there still a case for easily-editable merge messages?
