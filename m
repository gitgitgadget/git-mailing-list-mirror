From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: rerere affects handling of git-stash-pop merge conflicts
Date: Fri, 15 Jul 2011 22:19:27 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1107152208530.12060@debian>
References: <4E1F22DF.7060209@cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 04:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhuTj-0000I8-E9
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 04:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab1GPCTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 22:19:33 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35683 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab1GPCTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 22:19:32 -0400
Received: by vxh35 with SMTP id 35so720483vxh.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 19:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=J8n2FBUeMmK7NNh1XcNMxcok23R7JQJZUl3gv2uo0sA=;
        b=B2CJFedddG1z80P+kTNDIeeKA+bOyDbtI0q4/3bYCJPs/VT2p9Eah1g1ZXj+lKUIJa
         qgx6QH773rkhMO0x5qwwEJpxVy07HO3J+e1WPlP2kPubRdXVMroHCgirDBFpLhgyRC1a
         9XRTwfsFFqJfO5FkYPfZDvGTLJcngsHQpy/ag=
Received: by 10.52.73.137 with SMTP id l9mr4234548vdv.516.1310782771811;
        Fri, 15 Jul 2011 19:19:31 -0700 (PDT)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id db1sm848114vdc.20.2011.07.15.19.19.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jul 2011 19:19:31 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <4E1F22DF.7060209@cisco.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177248>

On Thu, 14 Jul 2011, Phil Hord wrote:

> Summary:
> After a 'git stash pop' with conflicts, 'git mergetool' fails to notice
> the conflicted files if 'rerere.enabled=true'.  git mergetool
> erroneously reports 'no files need merging'.

It seems to be because git-stash uses git merge-recursive directly
instead of calling git merge. I don't know why git merge-recursive is
used directly. It has been like that ever since git-stash was
introduced in f2c66ed (Add git-stash script, 2007-06-30).
