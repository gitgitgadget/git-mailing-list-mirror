From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Thu, 25 Apr 2013 15:08:09 -0400
Message-ID: <CABURp0pSMRZLLDz8hgXxMtTtx-vpn8SSAi-16tyw2+J+ttUQTg@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRX1-0007gT-AE
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759099Ab3DYTIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:08:31 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:40086 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759040Ab3DYTIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:08:30 -0400
Received: by mail-vc0-f169.google.com with SMTP id gd11so3232588vcb.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DHwbJ6tuTf/BAJgtZ9bpgiNjuMVQqi1Kba7fazClwj0=;
        b=JFFFyhH/U0MUJVDXv6mu2nNbCfsN4iM87vpx6wd2fUUE3cFs0s3DmIy4Rx8RhzvvnV
         kALQ+11LuXexWKlEFhD/ys76suQj7dSbo9thbx0h4Z5acsuwqAvtKmoF754lUWsqnz3N
         f3Q2ETM/3005GGQRsDX0ZbBxTe3cEmLQBBvKklNkfoNBWaT9ZE3IFKW+iXI2Zh0El4TA
         RH8zxdVHMlnq7PB7sVNCsrw7ml0MMG8ePDBwUlsFC7T9WFG2i2ZcpQgZFpDkqRxdeN8C
         MVqhb+3Y+HgZvE2QkbRfM9qzins9/6VlFvKA3hoFqZuJCdizhkK7NfbA+cKzkkCgnLA8
         vpZw==
X-Received: by 10.58.96.72 with SMTP id dq8mr27247298veb.49.1366916909590;
 Thu, 25 Apr 2013 12:08:29 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Thu, 25 Apr 2013 12:08:09 -0700 (PDT)
In-Reply-To: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222415>

On Thu, Apr 25, 2013 at 1:07 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> 2. git rebase -i master fails unless I've rebased my branch on top of
> master.  I always wished I could do the equivalent of 'git rebase -i
> master..', but I can't.

In what way does it fail?   It seems to work ok for me.  Do you mean
that it chooses extra commits you did not want?

Maybe you expect rebase--interactive will only result in changes to
commits you touch in the todo list and it will not actually rebase
anything.   Is that the goal?

I have been thinking of adding a targeted "rebase -i" extension.  I
often use rebase -i to change one commit in recent history or to
squash some fixup into place.  The trip through $EDITOR to do this
seems disruptive to my thinking.   So I would like to be able to do
this:

   git rebase --edit $REF

which should act the same as

  GIT_EDITOR='sed -i "s/^pick $REF/edit $REF/"' \
  git rebase -i $REF^

Except that $REF could be any ref and not just the exact
SHA1-abbreviation given in todo.

The change I imagine allows --fixup, --reword,  --squash, etc.  It
might even allow multiple instances of each.

I haven't thought through how to handle the case where there are
merges in the way, but I do already suppose that the command will
simply fail if a ref is not an ancestor of HEAD.

Maybe this is too simple for your workflow, though. As I said, I did
not understand your itch.

Phil
