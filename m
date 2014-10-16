From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: git describe oddity with GIT_DIR
Date: Thu, 16 Oct 2014 15:34:29 +0200
Message-ID: <543FC965.7040600@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 15:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XelCT-0000CM-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 15:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbaJPNei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 09:34:38 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:53553 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752412AbaJPNeh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 09:34:37 -0400
Received: from p5ddc190d.dip0.t-ipconnect.de ([93.220.25.13] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XelCN-0005Nh-12; Thu, 16 Oct 2014 15:34:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1413466477;fb71641f;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've encountered an oddity with git describe.
Consider the following snippet:
-----
mkdir test
cd test
git init
echo 1 > file
git add file
git commit -m "changes"
$ git describe --always --dirty
8ad486e
$ cd ..
$ git --git-dir=test/.git describe --always --dirty
8ad486e-dirty
$ GIT_DIR=test/.git git describe --always --dirty
8ad486e-dirty
-----

The "-dirty" suffix appears if invoking git not from the worktree
itself, but should actually never appear.

According to my research this behaviour is there since 9f67d2e8 (Teach
"git describe" --dirty option, 2009-10-27).

Is that to expected?

Thanks
Thomas
