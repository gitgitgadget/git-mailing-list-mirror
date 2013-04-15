From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 13:29:45 +0530
Message-ID: <CALkWK0=9OgRtrwnCpVOpmjHb0j38M=VQrzfFh4H=sV=dVvcV8w@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 10:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UReL2-0003tt-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 10:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab3DOIA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 04:00:28 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63315 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab3DOIA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 04:00:27 -0400
Received: by mail-ia0-f174.google.com with SMTP id o25so1265527iad.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yWI3ScdO0b7kLUSPYJnZXSQP1xw4pn30lYFWa3Ipy54=;
        b=UMnKj4hFo9Qc9cFV4Uve/SflcELVde7+pe7EgPPy5K1W+y68skwjT1PbALIg37qWdI
         p3+rVUtCczQ1fvo2Ed1oeMnE1iDY/gAONm2rNGRnqP3UlancJcPZddmOc2fUSbUhPFGy
         +GB8ThscbDIIlZdoSL74gF1M7D0KqrN8ffJxUS+rHYhjmFFPvGAAfIK4hQlrE+q4hHlU
         BsLF1iNXhZ02qfLZ8CMGNkK9hwltADN9H0Ro5X6eTI+oYUi6xNmgkHXnbRmMhMCJqOxX
         nvSw/hbVP72aFI+G6T5TKBLgguTI3EVppCIe5m/An7pb7UIy7GJZDQ8BDS3VQUyP18b7
         kxvg==
X-Received: by 10.50.17.166 with SMTP id p6mr4597230igd.12.1366012826120; Mon,
 15 Apr 2013 01:00:26 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 00:59:45 -0700 (PDT)
In-Reply-To: <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221199>

Junio C Hamano wrote:
> Relocate to where in the superproject's gitdir?  Presumably you can
> do this more than once in a given superproject, so there needs to be
> a key per such a clone, no?  I am guessing that you would follow the
> usual "when adding a submodule without name, use its path as the
> initial name" convention, but then I would suggest it to be spelled
> out (and if you are doing it differently, that choice needs to be
> spelled out and defended).

I probably wasn't clear enough in the commit message, but this is what
happens when I set clone.submoduleGitDir to ~/bare: a git clone
gh:artagnon/clayoven inside the superproject's worktree will make
~/bare/clayoven.git and ./clayoven corresponding to the GITDIR and the
worktree of the newly cloned repository.  If there are conflicts, it
will complain as usual saying that the destination path %s already
exists, in which case the user has to choose a name for the GITDIR
(not yet implemented) and/or the worktree path (as the final
command-line argument to git clone).
