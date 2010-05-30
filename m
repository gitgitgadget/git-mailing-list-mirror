From: Tim Visher <tim.visher@gmail.com>
Subject: Re: rebase --continue confusion
Date: Sun, 30 May 2010 08:44:29 -0400
Message-ID: <AANLkTika8osPqvlcZKqVTMN5IwLxBZioBCD1NgLHj0EQ@mail.gmail.com>
References: <4C01B855.7080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dale Rowley <ddrowley@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 14:45:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIhsz-0006H2-Pq
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 14:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab0E3Mo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 08:44:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56254 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab0E3Moz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 08:44:55 -0400
Received: by gyg13 with SMTP id 13so2083993gyg.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=LdCCJgqnUkt0SCGExgmQ46JiaXGQOROGpRBVEl8kHn8=;
        b=PN9UMALDGlHpwl3XPBzl1K112O8IeEcxP/D0Tt/TVFx/yJ8gHKeutZa4hrWYLBylB5
         H3hOKVgYsoMTFriyjXHFt09tXWf1HnoNTjzqW446RboupAJAvLFGU3SfXOIC/2XX58Uu
         m0KE2qgAuYWgWiUPwbYVDLIaqQvV3+K9W82VY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=g1zj/AgUtP6ZCfDDnh5nYcUKsynshmn0WCwxamfIdvUixIlVQKmHk67S2xxYB/nFJ9
         kwanwWetv0Bhy0WdDc7tuAWo3vuubTTYXU6f55axTugukgQodDEb3oe955DguowMpnKc
         3+YC1SAW0fGcD8hOUdhYinTWyKq1kqtIeglj8=
Received: by 10.101.160.30 with SMTP id m30mr3204409ano.192.1275223489261; 
	Sun, 30 May 2010 05:44:49 -0700 (PDT)
Received: by 10.100.164.19 with HTTP; Sun, 30 May 2010 05:44:29 -0700 (PDT)
In-Reply-To: <4C01B855.7080409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148002>

On Sat, May 29, 2010 at 8:59 PM, Dale Rowley <ddrowley@gmail.com> wrote:
> I ran into a conflict while running 'git rebase branch1 branch2'. So I edited
> the file and resolved the conflicts, and then ran 'git add <file>; git rebase
> --continue'. This printed out a message 'No changes - did you forget to use git
> add?'. I thought 'No, I'm pretty sure I ran git add' and I assumed I had run
> into a bug in git because I didn't see how this conflict was different than any
> others I had successfully resolved. The next time this problem came up, the
> light finally came on and I realized that I should just run 'git rebase --skip'
> because when I resolved the conflicts, I had basically undone all changes that
> the patch would introduce.
>
> OK, so there isn't a bug in git, but since then I've seen co-workers stumped by
> this same problem. So maybe it would help to clarify the message? Maybe
> something like "The index is in the same state as it was before the patch was
> applied - refusing to make an empty commit. Did you forget to use 'git add'? Or
> maybe you should use 'git rebase --skip'?"

2 things.

1. I agree that the message could be more informative, especially
given the context.  If the the patch looks exactly like the last patch
applied now that you've edited it during a rebase, it would _almost_
be safe to assume that you meant to skip and just didn't know you were
going to before hand.

2. `git status` should show you that you had nothing to commit, which
would completely explain why `git rebase --continue` threw out the
message it did.  I'm in the habit of running `git st` continually and
it often helps me catch this sort of thing where I thought I'd added
something to the index or forgot that I'd changed some file between
the last time I'd updated the index or something along those lines.
This is just sort of a recommendation on a way to modify your work
flow that may help you and your coworkers in the future.  YMMV.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
