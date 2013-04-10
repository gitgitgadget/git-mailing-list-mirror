From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 03:12:20 +0530
Message-ID: <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
References: <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200548.GC24177@sigill.intra.peff.net> <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com> <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:43:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2nN-0006Od-0r
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935483Ab3DJVnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:43:03 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34937 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764955Ab3DJVnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:43:02 -0400
Received: by mail-ie0-f173.google.com with SMTP id 10so1118304ied.18
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Nh7UiJLiHpy6QIWPdrZJpgflmMEvySyZqys5kXRo5xY=;
        b=st9YAasdxjnqwDdDnTm5VLhoClviFXvzxMBiKmkq+U42pr5NgEo+9ec4iTxo6kzrgl
         DD60zJjtKV5JW2ebDfwzGHn+VqJri5zrYzPZzkNlRqBSONjcHxVUdiGS6V679jy067Tv
         7TV9Lsu/rLLHwPRj9Bl/YxOuxMh5+efWpS/uQFuonTVQqpxuYCYCfkPciBp7oIpSvIQu
         hTd8sAVSyEYdVDiRRD4Z36lZZG5pFXyq3THou/wryLdOUnf7HZGASmMLkBsm1YUTWjAb
         gxNdoSnESYnw0p8Wa4Re6nwwHJUPhKXHDLfUtTtW49AY4e3qKHMrL8YisNHg4jspkHbU
         d+xw==
X-Received: by 10.50.119.102 with SMTP id kt6mr2797008igb.12.1365630181161;
 Wed, 10 Apr 2013 14:43:01 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 14:42:20 -0700 (PDT)
In-Reply-To: <20130410212911.GE27070@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220779>

Jonathan Nieder wrote:
> My first hunch is not to like this, since it means
>
>         git push -- master next
>
> might push to two different remotes and because it's not obvious
> to me when it would be useful.

Yes, it will push to two different remotes.  And why is it not useful?
 If we also had something corresponding to branch.<name>.merge for
push*, I would argue that this and branch.<name>.pushremote together
define how a branch should be pushed, independent of everything else.
Like I said earlier, I don't think of a git repository as a whole, but
rather a collection of upstream and forked branches.  Every branch is
always fetched  from its upstream (might or might not be the same as
fork) using branch.<name>.remote, and pushed to its fork using
branch.<name>.pushremote.  A git push; can use the context of the
current branch to select branches (along with their configurations) to
push, nothing more.  It should not apply the configuration of the
current branch to the other branches that it's pushing; that's just
wrong.

* Can we write this branch.<name>.pushmap, effectively overriding
branch.<name>.merge when in push.default = upstream and simple?
