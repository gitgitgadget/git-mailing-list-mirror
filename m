From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Mon, 1 Dec 2014 17:43:16 +0700
Message-ID: <CACsJy8C1968-NJAxvxnwXAOZTofedpAe+Rmg4OYJA4E3t9Ao+g@mail.gmail.com>
References: <1417390076-2953-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 11:43:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvOSP-0007E3-4C
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 11:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbaLAKnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 05:43:49 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36380 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbaLAKns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 05:43:48 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so8581231igb.9
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 02:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pq/dzGdDngzgwzHpEZqgifCdjKFFfst1FAkTTjUyEpM=;
        b=pbOP0sWUl+0m3Fzn5RQ3agOLtz4QVuS4qrjJYKjkptUw2sHQwV/V6Jkwhaa3/vb6K/
         6EQOZISD8XuqVHHqr/kO/QqM9cAVjuNCqCmOF3IQAIoFPor24egL5f8LT4ECKA714ji7
         d6PGme3XNQ+8H6A8ru6rXEcBgmSxlP963enJgRmgg2zJQQ/iA4Io1LyVNGPK6fwj1G7R
         oneSom0bZbGjIoadiodTqOahrMU+LdW/72RqQRPR9rZE+jsKfBxnow+2h6caKfcUclSM
         XVedZQMF1vzLjvZPhC9zVB7gvuWHlnf1NGKEuQAKwlm9rBkCnG5GQaHiFMyPnpDaO6Ha
         0y1w==
X-Received: by 10.50.43.202 with SMTP id y10mr44873564igl.41.1417430627977;
 Mon, 01 Dec 2014 02:43:47 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Mon, 1 Dec 2014 02:43:16 -0800 (PST)
In-Reply-To: <1417390076-2953-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260479>

On Mon, Dec 1, 2014 at 6:27 AM, Max Kirillov <max@max630.net> wrote:
> But, while hacking the submodule init I became more convinced that the
> modules directory should be common and submodules in checkout should be
> a checkouts of the submodule. Because this is looks like concept of
> submodules, that they are unique for the lifetime of repository, even if
> they do not exist in all revisions. And if anybody want to use fully
> independent checkout they can be always checked out manually. Actually,
> after a submodule is initialized and have a proper gitlink, it can be
> updated and inquired regardless of where it points to.

Just throw something in for discussion. What about keeping
$GIT_DIR/modules like it is now (i.e. not shared) and add
$GIT_DIR/shared-modules, which is the same for all checkouts? That
would keep current submodule code happy (no name collision or
anything). New submodule code can start using $GIT_DIR/shared-modules
while still keeping an eye on $GIT_DIR/modules for old setups.
-- 
Duy
