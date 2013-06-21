From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 00/16] Cleanup {branches,remotes}-file cruft
Date: Fri, 21 Jun 2013 21:52:15 +0530
Message-ID: <CALkWK0mr4KU_VydBs9MP+4N7dROeGEnL-eM+W1ekqyOBPLeA5w@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com> <7vsj0bo7pr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, akpm@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq473-0007si-1K
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423281Ab3FUQW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:22:56 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:62537 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423074Ab3FUQWz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:22:55 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so20066825ieb.10
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dd9SDrVkFD13ztux/IrnnR39/CmESqEDVeraDFUXwGY=;
        b=qWcDTdJeyjkEDnapJWCweXtjerGEhD67g6Ms6GrUmM0pXmkKk5FSTfjARWBLQppxvt
         mI/o/w0JN+lLxgaGerKhf+vKdIlsMy67q1yXMWjIwtbt8UFUnqiknJVxBVxe3Wl6n4YF
         OxIBxppFLZw+B42xBm/71LZ7QJut75liMc3SR3F8QCIAHECDTqS+VEp4Po3rZOzlMyt5
         iUIKu7YXtofeplEYMVlqH1ef/i4cSsI5PXtnH9NQswqc0fX0b8cQtKdl3AdbtjHijJt7
         m2QUJSn2PBMU3ah5Hwv4z2KOkim9uq5wWSddXxrm6ZffqmP4CXP7RGr2YDdvhF/JIQZe
         vrqw==
X-Received: by 10.50.47.105 with SMTP id c9mr2769111ign.50.1371831775304; Fri,
 21 Jun 2013 09:22:55 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 09:22:15 -0700 (PDT)
In-Reply-To: <7vsj0bo7pr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228627>

Junio C Hamano wrote:
> The last time I hinted removal of .git/branches/, Andrew Morton
> reminded me that there are those who use Git primarily to fetch from
> many dozens of other people's branches, to maintain his own quilt
> patch series on top of, and never push anything back.  To them,
> being able to say
>
>     $ echo the-repository-url#the-branch >.git/branches/the-subsys
>     $ rm .git/branches/the-subsys
>
> has been a much easier and simpler way than "git config".  The only
> thing they do with them is essentially:
>
>     $ git fetch the-subsys
>     ... use FETCH_HEAD to integrate it to a larger whole
>     ... against which his remaining quilt queue is rebuilt

Interesting.  A cheap alias for a URL + branch that can be
added/removed very easily.  I suppose it's worth keeping around.

> I myself thought that replacing the established work process of
> these people to the one that instead uses "git config" should be
> simple enough even back then, and in the longer term, these old
> mechanisms will become disused so that we can remove them, but
> deciding _when_ is the good time is not a no-brainer at all.

Oh, this series is not about removing the feature: it's about removing
dead code, testing the feature properly, and not mentioning it in
obscure places.  It is a prerequisite for removal, if we desire to do
that at some later point.  After your explanation, I think everything
but [16/16] is fine.  [16/16] adds a comment about deprecation; we
should tweak/drop it.
