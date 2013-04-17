From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Wed, 17 Apr 2013 20:32:25 +0530
Message-ID: <CALkWK0kchO-cKuh1vd=aziZa5CA8w81aEecUKqhazp_Y7pOrkw@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
 <CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com>
 <CACsJy8C9mrJzmg4FjqBMAZis7WQUpyhNH7TMTLbebWQE124YMg@mail.gmail.com>
 <CALkWK0nLamX1XKcg2t7VWJTPuFhX+ctEGE=4sjSSd7JqMmGzPA@mail.gmail.com> <CACsJy8DxspNbopJbSsvcCZZwMFees1JVV_iV5r7dXRJTngzmFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:03:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USTtD-0008Mg-AF
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966710Ab3DQPDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 11:03:07 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:55484 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966461Ab3DQPDG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 11:03:06 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so1506078iad.7
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8wE60m4SR42VQydKlIYIX1h/JEc7nliVwTgghkb9n90=;
        b=ZOZ2eeWIaFGQ83pSlTembw8qrGdQqvQFXL0TD3a9hSkPDepH0wXr+1h+cF/+bpmbLy
         KuUSv6IX+h/rcgUcjy02HBABojKza0iAhMjumM04O9MWXWMZvEjjcvNMGnercKB6znrW
         5xF84Z1uLlL9KqlqCZZXhhOz2tRXNAPiMCbPVMa7QXWydexkc2H6S9Brfg25zvBVhjkS
         WbroVG+VyqKIsF0c7+2uBK4KQpyc24FWny0ktTCVqrwShNRdZsFNXwByB3YqE63Dyryv
         Lhu83Zrg2+3jpt8vHZMBxCxxaRAkSw6lHGmxJzHMvv4NBdh2MtFTqCnqCvp80lgtd1CE
         TXSg==
X-Received: by 10.50.119.102 with SMTP id kt6mr4478711igb.12.1366210985356;
 Wed, 17 Apr 2013 08:03:05 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 17 Apr 2013 08:02:25 -0700 (PDT)
In-Reply-To: <CACsJy8DxspNbopJbSsvcCZZwMFees1JVV_iV5r7dXRJTngzmFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221542>

Duy Nguyen wrote:
> Well, it has "submodule" in the command line. My first reaction would
> be looking for "git submodule rm" or something.

No, 'git submodule rm' cannot remove the corresponding GITDIR.  What
if there are other branches that refer to the submodule?  What if you
want to remove it from this branch and add it to another branch?

> No, the point is people make mistakes. What do we do in that case? Or
> will you introduce yet another "gc" command for clean up ~/bare?

So, people don't make mistakes when they use 'git submodule add', but
do make mistakes when using 'git clone'?  How has the problem
_changed_ with my patch?  It's reasonable to point it out as an
existing problem, and ask for it to be fixed independent of this
discussion, but that is not what you are doing.

git cannot read your mind to determine if you made a mistake, if
that's what you're asking.  No, a gc equivalent won't work either (and
there's nothing in the current submodule world), because it is
impossible to determine if a workdir is attached to that GITDIR
somewhere on your filesystem.

You'll have to do _something_ to say that you don't want that GITDIR
anymore.  It's reasonable to request tooling to help with this task,
but your request is entirely different.
