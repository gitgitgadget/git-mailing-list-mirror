From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 13:38:32 +0530
Message-ID: <CALkWK0m-X7K=WXFiiMkqZBBTBB9KC6myeN+s_xYLXfadGJCdZQ@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <7v61zo4igg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 10:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UReTb-0004WD-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 10:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934192Ab3DOIJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 04:09:17 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:36747 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337Ab3DOIJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 04:09:15 -0400
Received: by mail-ia0-f170.google.com with SMTP id j38so4177453iad.29
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iz1M+F0B/lDScCDrSII3g+6nRCtOTkbnxY2F3So8HV0=;
        b=uJycqdSA3pHYdALkfqlRnRz0B9uqqFz5iEm0F6toyoSZOUPTS0cMDxKVxx7rimY69S
         5GuZi2XZC8P+vYt07EwdOC4eKxoMBucM8f3gNOxFDcdBt2C3eLSeFHr3aHd4uk4YzMvy
         7372smUmB8DvgWR+i+ScHF+O7XgKKHXVofeFNYh7fpL7qKvHlPwhEBpOkXBWbISuPz1k
         4fwJclzxaegcBPeyL+3WhAd6E7WhPamXtTR+LJcLltiOhWH0ZO63WMkZy/+faeLIMqJH
         MzIc3COlWMHqpjjFyA9eSqTOFIVPv1JTi5bb4MMcEYpuE8vok+l4PfhmrK3WCWNgZCfK
         tIrA==
X-Received: by 10.50.119.102 with SMTP id kt6mr4773017igb.12.1366013352397;
 Mon, 15 Apr 2013 01:09:12 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 01:08:32 -0700 (PDT)
In-Reply-To: <7v61zo4igg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221200>

> You could continue "git clone" and then teach "git add" (or "git
> submodule add") to relocate the embedded git directory from the
> submodule working tree, you could "git clone" with separate-git-dir
> from the beginning, or you could extend "git add", perhaps
>
>     git add --url=git://up.stre.am/repository [--name=name] sub/mod/ule
>
> and do that "git clone --separate-git-dir" internally (which will
> mean that the end user will not run "git clone").

I specifically did not go down this route, because I think it is
gross.  Where does moving a GITDIR fit into what git add's normal job
(index manipulation) is?  Tools should do one specific thing, and do
it well: not a mixed bag of unrelated things.  git clone, on the other
hand, was always intended to have a way to point to a location for
GITDIR and the worktree: isn't this feature very close to
--separate-git-dir already?  It is, therefore, git clone's job to
relocate the GITDIR.  My future plan is to deny git add'ing anything
but a worktree-with-a-gitfile.
