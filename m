From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Please help provide clarity on git rebase internals
Date: Mon, 08 Sep 2014 20:07:32 +0200
Message-ID: <540DF064.5010907@kdbg.org>
References: <CAE2xRkHgnXK84u5zeLyVZqAnvu3u+0gSgaB+smFXu6Y7pkY1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Colin Yates <colin.yates@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 20:07:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR3Lo-0004ko-9c
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 20:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbaIHSHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 14:07:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:49885 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbaIHSHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 14:07:36 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3hsHX12Pswz5tlJ;
	Mon,  8 Sep 2014 20:07:29 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D2ECE19F363;
	Mon,  8 Sep 2014 20:07:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <CAE2xRkHgnXK84u5zeLyVZqAnvu3u+0gSgaB+smFXu6Y7pkY1kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256664>

Am 08.09.2014 13:25, schrieb Colin Yates:
> For example, let's imagine that #f1 removed fileA, some time later #d1

Assumption: #d1 is in the branch you call "develop HEAD".

> added a line to that file. If I was doing a merge then of course this
> should be a conflict, however applying #f1 to develop HEAD should work
> even if fileA has changed (i.e. #f1 removes the updated fileA).

No. You should get the very same conflict, because the content that #f1
removed is not identical to the content on develop HEAD anymore.

With rebase you generally get the same conflicts as if you did a merge.
But since rebase applies changes only piece-wise, you get the conflicts
also only piece-wise. (Sometimes you can be lucky that you get no
conflicts due to the nature of changes, sometimes you can also have bad
luck and see more conflicts.)

-- Hannes
