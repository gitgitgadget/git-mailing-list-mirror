From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Tue, 03 Dec 2013 20:00:03 +0100
Message-ID: <529E2A33.7000804@gmail.com>
References: <1385922611.3240.6.camel@localhost>	<20131201190447.GA31367@kaarsemaker.net> <529DF64A.70801@gmail.com> <xmqqtxepokej.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org,
	ingy@ingy.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:00:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvCc-0001u5-IF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab3LCTAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:00:06 -0500
Received: from mail-ea0-f176.google.com ([209.85.215.176]:40911 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab3LCTAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:00:05 -0500
Received: by mail-ea0-f176.google.com with SMTP id h14so10229675eaj.35
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2SKOgQurlrOA2xv+PvYKLrsyjFGZ7b2w0s0lNQG2pxQ=;
        b=VRzIrm2Qk0pWR7iz9fP32aW0t+ji5Zn0NQFgvvmuwo6YFVtCpLQjvOlbYElhqUNTrI
         CAKrKUnz5bLTxvOdsszlzujgFR5syIVzEBEmwcbImAvzGookfG2DOsuO3U33XMdY8Gix
         3oJmCqncV6zOhHrBkX+52CakHqTTbQw2zq4LmmNqhNeAdvifzTZK0kjPDNqTocETT1R9
         AolPAYG7KWv3HQ23iKowvHIbXN8mFtZGOXo1wgoU8BSif5l+1JhLM5ekGWFpfnsqN4uO
         Zq2Oa9SlVeRNszNC5BA05m1+l57nngnfBoDApU1t+0K0w0buPHPJoc9IfqRHdumAqkHY
         VI8w==
X-Received: by 10.14.104.201 with SMTP id i49mr4125146eeg.78.1386097203845;
        Tue, 03 Dec 2013 11:00:03 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o47sm85919574eem.21.2013.12.03.11.00.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 11:00:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqtxepokej.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238715>

Am 03.12.2013 19:32, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> So I figure that GIT_DIR is not meant to _rename_ the ".git" dir,
>> but to point somewhere _outside_ the worktree (or somewhere within
>> the .git dir).
> 
> Correct.
> 
>> If we don't want to support this, though, I think it would be more
>> approrpiate to issue a warning if GIT_DIR points to a worktree
>> location.
> 
> But how do tell what is and isn't a "worktree location"?  Having the
> path in the index would be one, but you may find it out only after
> issuing "git checkout $antient_commit".
> 

In setup_work_tree(), the result of remove_leading_path(git_dir, work_tree) must be absolute or start with ".." or ".git", otherwise warn?
