From: Karl Wiberg <kha@treskal.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Mon, 21 Dec 2009 08:08:46 +0100
Message-ID: <b8197bcb0912202308p296207av416cd5590a11251b@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
	 <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
	 <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>
	 <b0943d9e0912201521k73bdcb5fl333e845028954050@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Gustav_H=C3=A5llberg?= <gustav@virtutech.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 08:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMcO0-0000Dm-35
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 08:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbZLUHIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 02:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbZLUHIu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 02:08:50 -0500
Received: from mail1.space2u.com ([62.20.1.135]:59980 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbZLUHIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 02:08:50 -0500
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com [209.85.220.215])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nBL78edU030728
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 08:08:41 +0100
Received: by fxm7 with SMTP id 7so4543998fxm.29
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 23:08:46 -0800 (PST)
Received: by 10.103.84.13 with SMTP id m13mr3216190mul.10.1261379326648; Sun, 
	20 Dec 2009 23:08:46 -0800 (PST)
In-Reply-To: <b0943d9e0912201521k73bdcb5fl333e845028954050@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135541>

On Mon, Dec 21, 2009 at 12:21 AM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:
> 2009/12/19 Karl Wiberg <kha@treskal.com>:
>
>> Better. But couldn't you remove the update function completely and
>> just inline the code in it, since it's called immediately?
>
> Of course, I tried, but couldn't get it to work. I get HEAD and top
> not equal unless I call update() between _TransPatchMap and
> self.__halt(). For the non-conflicting case we need to call update
> before or after this "if merge_conflict".
>
> One solution is to split the "if merge_conflict" in two but maybe
> you have a better idea.

Yes, duplicating the conditional was what I had in mind. But if you
don't find it to improve the readability of the code (as compared to
having a function), I certainly won't insist.

Thanks for working on this.

By the way, you do realize there's another command that requires two
steps to undo completely: refresh? And that one is harder to get out
of---undoing it all in one step would mean throwing away the updates
to the patch.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
