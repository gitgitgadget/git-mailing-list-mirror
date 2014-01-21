From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 21 Jan 2014 00:42:58 -0800
Message-ID: <5B91161D-7B06-4C80-9554-89F379C4E2A6@gmail.com>
References: <20140117041430.GB19551@sigill.intra.peff.net> <20140117042153.GB23443@sigill.intra.peff.net> <398F146D-72F1-44CD-B205-729665FD8765@gmail.com> <20140121053026.GC5878@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 21 09:43:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5WvL-0001ct-2V
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 09:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbaAUInC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 03:43:02 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38052 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbaAUInB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 03:43:01 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so8031735pab.5
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 00:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=HH1YdUzJrBcCPcF6KqIx21Go5H6yHdNAbKJ3OO8nzXU=;
        b=Nnakym/h7vFBH62yav46V+NJsvldqMskiC4MzU4xxtuAMq69keX4V0yF4+O+cvkKEK
         FDv/+ZIwKuIvQgYuyQ11MlJ2+gxCIsO+i+EJBPhcgVil/bzYOiLdgwpK2tqWVKKlxe+D
         2g8l+Bh3GEveaBavWOHJ0IiWKasAsFsbSEkZ2OZCUTi2kMR9A8YtbGxp2d5BoaLYssag
         WJhiDwy6zKcqigF9P0aVoBTCor6zrQo7ZxHiIphziqfzIZuQwlFMpH8HemmC3fBSRCoq
         AokSjaPnwwN+WZXAqSsyEEiscpJsB6FaXkUB4gwQLy2XQbMk4BcWJNMtuRNznrFIqmns
         ookw==
X-Received: by 10.68.134.98 with SMTP id pj2mr23531422pbb.110.1390293780877;
        Tue, 21 Jan 2014 00:43:00 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yz5sm21356348pac.9.2014.01.21.00.42.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 00:43:00 -0800 (PST)
In-Reply-To: <20140121053026.GC5878@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240747>

On Jan 20, 2014, at 21:30, Jeff King wrote:
> Ugh. Having just read the LESS discussion, it makes me wonder if the
>
>  strchr(getenv("LESS"), 'R')
>
> check I add elsewhere in the series is sufficient. I suspect in  
> practice
> it is good enough, but I would not be surprised if there is a way to
> fool it with a sufficiently complex LESS variable. Maybe we should  
> just
> assume it is enough, and people with crazy LESS settings can set
> color.pager as appropriate?


This attempts to show colors but doesn't work properly:

   LESS=-+R git -c color.ui=auto -c color.pager=true log --oneline -- 
graph

but this does

   LESS=-R git -c color.ui=auto -c color.pager=true log --oneline -- 
graph

so yeah, just checking for 'R' in $LESS is only approximate.  :)
Also -r is good enough to show colors too...
