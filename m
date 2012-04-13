From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: use test_i18ncmp in t2020 (checkout --detach)
Date: Fri, 13 Apr 2012 18:46:07 -0500
Message-ID: <20120413234607.GE13995@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIqC1-0005x1-KV
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319Ab2DMXqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 19:46:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44391 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab2DMXqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 19:46:12 -0400
Received: by iagz16 with SMTP id z16so4907064iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kutQXJANtCVSTa/WCBGpRWFu3R8sVWyABCtczGT0T4A=;
        b=s9rcdQIL4eYuwdH1m+LiTyKh/YC2QpBJOnZu73pWJZiKQQ4cBHbmV6mm5vnTJjRWnV
         Tioanx3S4/YQEIaa99woKPehyD3+9YP39vTE+5gWNDw1XrWh0l/jZTcnk4umuWTTgzY5
         yep/JeD13nKnR+k8iZO1oWQ7ikYdO00kJoIBVr/RMDSmvzz7kr8TSBDvdTBvLvZHu+HJ
         iWjml+R7xWt8BoKkLH9P+Ku0SeR/dnvhyLcW1XwFfp9Y2g/xskxNdpujk+ez4dhKJEGk
         DhoaJNwtDiWVxPGntGEKU18rsWDPjrXuzzo4Igsayb3rc8DPWTcjVS0BwuwRz3fuv2zs
         M13w==
Received: by 10.50.220.129 with SMTP id pw1mr49601igc.29.1334360771844;
        Fri, 13 Apr 2012 16:46:11 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id wf10sm180712igb.8.2012.04.13.16.46.10
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 16:46:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120413233010.GA16663@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195459>

Jeff King wrote:

> I think it is not "forgot" but "predates" in this case. The commit
> introducing the problem is 8a5b749 (i18n: format_tracking_info "Your
> branch is behind" message, 2012-02-02). But obviously your fix is
> correct either way.

Oh, that makes sense.  I wonder why we didn't notice this before.
GETTEXT_POISON support hit "master" in 2011-05-23.

>> Jeff King wrote:

>>> When leaving a detached HEAD, we do a revision walk to make
>>> sure the commit we are leaving isn't being orphaned.
>>> However, this leaves crufty marks in the commit objects
>>> which can confuse later walkers, like the one in
>>> stat_tracking_info.
>>>
>>> Let's clean up after ourselves to prevent this conflict.
>>
>> Very nice thing to do.  Thanks.
>
> A minor complaint, but the format of your email left me confused for
> several minutes, as I didn't remember writing that or working in this
> area recently. It turns out that it is because this commit was from over
> a year ago.

Yeah, I should have paid attention to the date.  A better diagnosis
would be

	When v1.7.9.2~28^2 (2012-02-02) marked the "Your branch is behind
	message for translation, it forgot to adjust tests to stop checking
	for that message when tests are being run with git configured to write
	its output in another language.

	With this patch applied, tests pass with GETTEXT_POISON=YesPlease
	again.

	Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
	Explained-by: Jeff King <peff@peff.net>
