From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Is there a quick way to identify commits that reference missing
 trees or blobs?
Date: Tue, 26 Jul 2011 00:34:50 +0200
Message-ID: <20110725223449.GA25560@toss.lan>
References: <CAH3AnroyfeGOo_23nHKhLjxEnP_qEMi7as1UjXEFjjuVOckBjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 00:34:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlTjm-0001mb-FS
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 00:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab1GYWey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 18:34:54 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:33953 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751532Ab1GYWex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 18:34:53 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 9757AA7EB2;
	Tue, 26 Jul 2011 00:34:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAH3AnroyfeGOo_23nHKhLjxEnP_qEMi7as1UjXEFjjuVOckBjw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177830>

On Sun, Jul 24, 2011 at 02:48:20AM +1000, Jon Seymour wrote:
>
> I was wondering if there is a quick way to identify commits that
> reference missing trees or blobs as identified by git fsck?

The following command has served me well for this purpose. I apply
it to each ref in git-for-each-ref:

$ git rev-list --objects $ref | git cat-file --batch-check

It may not be the fastest way to do it, but it did the trick for
me. I then simply deleted any broken refs using git update-ref -d
$ref, even if the tip of the branch was still intact. I could have
tried to salvage some history from those refs, but I had a backup
and at that point I just wanted to continue working.

hth,
Clemens
