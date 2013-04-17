From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Wed, 17 Apr 2013 16:23:20 +0530
Message-ID: <CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 12:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USQ0K-0005j9-C4
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 12:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936315Ab3DQKyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 06:54:06 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:59029 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936303Ab3DQKyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 06:54:01 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so1270101iad.7
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wjK4tly/eHbEgWFq04FCT5V6Q7gv/IvxUOmVxPbWhko=;
        b=nRTz58zo+/mLOzHtTXUbg/sgKeKDZWCqoybZvnD9SmBxzyaJVyYgqoRlHvK1i62KR/
         7otbf25zatzbkSe5qqyp26jEBs83oEY2D5bXnd6fD3NF+7OWLzlKcZgmhyLhy84M7RlD
         t14wz4h73izchz+dwe9Wq3hkwqyZVuu96lm/lsezfKOV2ix1KFVxL41f7hxHxCxYz6LF
         PtJUSv77cAuAHW8Nuias69HrDJyS2B4HbvaT+en4H3nbvK6GHCp1fjpmERen8sLLsK3W
         JwUzd9YgfC8gUE8/KfT2M37As5GkbSYcKHKODbD0dsArcnuvrxx0U/WuRmomOYxiLolh
         UvvA==
X-Received: by 10.42.50.202 with SMTP id b10mr3333305icg.7.1366196040589; Wed,
 17 Apr 2013 03:54:00 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 17 Apr 2013 03:53:20 -0700 (PDT)
In-Reply-To: <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221532>

Duy Nguyen wrote:
> What if I clone a repo then realize it was a mistake and remove it?
> With current clone, a "rm -rf" would do. With this, I'll need to
> figure out which subdir in the top .git contains the repo I want to
> remove. I'm not sure how "git submodule" handles this case though
> (i.e. total submodule ignorant speaking..)

Currently, submodules relocate the GITDIR of submodules to
.git/modules.  So, my proposed patch doesn't make the situation any
worse.  In fact, it improves the situation because you're guaranteed
that all your GITDIRs will be in ~/bare (or whatever your
core.submoduleGitDir is), as opposed to a complex path in .git/modules
of your containing superproject.
