From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Fri, 14 Aug 2015 10:10:20 -0700
Message-ID: <xmqqpp2piyo3.fsf@gitster.dls.corp.google.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	<1439416645-19173-3-git-send-email-dturner@twopensource.com>
	<CAPig+cRM-J-5SHJ9JVsHPR+B2Y05nwFrRQWsd0M56pm9jS-mTQ@mail.gmail.com>
	<1439487708.8855.2.camel@twopensource.com>
	<55CCFB32.30608@alum.mit.edu>
	<1439497946.8855.22.camel@twopensource.com>
	<55CDA445.9090503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 14 19:10:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQIUv-00074W-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 19:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbbHNRKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 13:10:23 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36439 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbbHNRKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 13:10:21 -0400
Received: by pacrr5 with SMTP id rr5so64125808pac.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=C960RBnC3PdW1JJ8CN6hmd517kxy982UpG1w2E119eI=;
        b=PmXZjbU0nEglGoWLlEgB3+T5XSkj3DX6OM7tAbZQeU1ywwj2os7kYUG7fXjb6LwoAM
         LIX96qkqDO9jSAQ/PQ++P/nLsfoXtoPH1el/CNHje2VF9mpYs8R3l/9ud8XCPdL49L/z
         9+qUs2/ACfWDQO3QzdRlvHDumE4lSaLD+2HflWyi/9NRCIfaD2bDLYHSThCEAEHD7el9
         jzV9SjjsPAcXWOjHsnaMZny8GXXNadqpavl95957nmLxtLVRCud6vpvWQ9eAYeoZKwfA
         EIKITc2BmDb6m9MKRwmY1wtBjhM3K8v3+qYSaTzcgh/8Z7qaZYby/zAPSGBte2P7GWNs
         7/2g==
X-Received: by 10.68.143.70 with SMTP id sc6mr8986913pbb.87.1439572221218;
        Fri, 14 Aug 2015 10:10:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id qn7sm6647671pab.14.2015.08.14.10.10.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 10:10:20 -0700 (PDT)
In-Reply-To: <55CDA445.9090503@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 14 Aug 2015 10:18:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275912>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I don't see how that can help. The result of a pipeline is taken from
> the last command. The exit codes of earlier commands in the pipeline are
> lost in the sands of time:
>
>     $ false | true
>     $ echo $?
>     0
>     $ false | ( ! false )
>     $ echo $?
>     0
>
> Working around this POSIX shell limitation is surprisingly awkward in a
> general-purpose script. But in this case you could use a temporary file:
>
>     git for-each-ref >refs-actual &&
>     ! grep refs/worktree <refs-actual && [...]

It is not just "you could", but that is what you "should" do, if you
cared the exit status from for-each-ref.

Thanks.
