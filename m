From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 19:58:40 -0700
Message-ID: <20130416025840.GH3262@elie.Belkin>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 04:58:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URw6c-0000EC-CS
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 04:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935467Ab3DPC6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 22:58:46 -0400
Received: from mail-da0-f54.google.com ([209.85.210.54]:37675 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935212Ab3DPC6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 22:58:45 -0400
Received: by mail-da0-f54.google.com with SMTP id p1so21490dad.41
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 19:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qvnxuhypdBOCFLmyeidX8u4jjQLcwEVtyJs9YRAfYW0=;
        b=G9GVhv74NWniJprGsSf9LPA5bhd6r9JtabNKb/JXIugGHxHGbURr5IAzOafwrR1dIJ
         nPf2bM0cgtULHxszBRr9+y6GuNgwk1UTaLQuSOmsGcBRBmDn2X5IlMWwDWwGe5X1anZS
         9aNdR7VQo13T407fEUjET8TEGMV6ZrPzlIRwVTHDUBYoSxGgjGhUbHi/Laoehf3e7ST8
         P9GpiNx0HS1YMXQqiuaPs31K1BpAbDlytWz+Uz6iSl+eRVGDqJ1DkygqhsYmf0O7F/dB
         45g0C2MgKkYOpqqm8YJLxzmli8C3n8xuIjsTFEXSU5uQ5RYRN6Mh3Lym+aj5Tc/qdUUs
         y4/A==
X-Received: by 10.66.152.173 with SMTP id uz13mr1086870pab.73.1366081125039;
        Mon, 15 Apr 2013 19:58:45 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ef4sm54679pbd.38.2013.04.15.19.58.42
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 19:58:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221350>

Ramkumar Ramachandra wrote:

>                                                        When set,
> instead of cloning the given repository as-is, it relocates the gitdir
> of the repository to the path specified by this variable.

Interesting.  As the discussion downthread from this illustrated, I am
not convinced this is better than a subcommand of "git submodule" for
that particular purpose, yet.

Is the goal to be able to, under some certain configuration, make
"git clone" + "git add" behave like "git submodule add"?

[...]
>                                            I don't like the
>  .git/modules nonsense).

As Jeff mentioned, a given repository can be a subproject of multiple
different containing projects, that use different versions of it.
It doesn't make sense for different directories on the filesystem to
share an index anyway.

Do you want the subprojects to be symlinks to the One True Version
of each project?  (I can see that working ok in some workflows.)  Or
do you want subprojects to be lightweight workdirs like
git-new-workdir creates, with .git/objects pointing to the project's
One True Object Store?

That is the part of this design that seems least well fleshed out to
me at the moment.

I quite like .git/modules/<subproject name> (for some reasons that
I've mentioned in other threads) and don't consider it nonsense, which
makes me assume I don't understand the goal of this patch, either.
Please don't take that personally.

Hope that helps,
Jonathan
