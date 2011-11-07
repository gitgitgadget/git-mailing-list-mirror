From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/5] gitignore.5 clarifications
Date: Mon, 7 Nov 2011 02:04:55 -0600
Message-ID: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, Johannes Sixt <j6t@kdbg.org>,
	"Y.G." <yamomo1@hotmail.com>, Eli Barzilay <eli@barzilay.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 09:05:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNKCe-0000hX-Ri
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 09:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925Ab1KGIFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 03:05:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62508 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1KGIFE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 03:05:04 -0500
Received: by iage36 with SMTP id e36so5579651iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 00:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=ac+5IQLkQravGiVwZ+1T36gaJyZ2288gXRL3ELyw9bA=;
        b=rSiGXDvyMWGzOIk/pMKvjo2gQcBKxxw/Nj5zqrbFV4FVDHDTUG3GQ1VhFfu1JU7g1J
         B7acOMXP2Fe+bC7VmZGXg63+MBAfxqgbm7JNkFkZcPk6UBdxpsdnJs+LFo0cKpwv88DK
         DxUqtp5k7z3Pr8jKLXQDXHcf8Gj7FkpiiEJ+4=
Received: by 10.231.26.201 with SMTP id f9mr4386976ibc.40.1320653104239;
        Mon, 07 Nov 2011 00:05:04 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l28sm37117799ibc.3.2011.11.07.00.05.00
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 00:05:02 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184957>

Hi,

Y.G. noticed that the explanation of '/' handling in the gitignore
docs are hard to follow.  Worse, it's completely wrong in a number
of ways.

Here's a series to fix a few of those.  Impact:

 - remove some complete nonsense (how did I mislead myself into
   thinking patterns without a '/' were anchored?)

 - address the frequently asked question "how do I un-ignore part of a
   directory I have ignored?"

 - relive what seems to be a bug (even when the "foo/" directory is
   ignored, a "git add foo/bar" should add new changes to the index
   when that file is already tracked)

 - some minor clarity improvements

At this point, I can hardly trust myself, so careful review for
correctness and clarity would be very welcome.

Incorporates material from
http://thread.gmane.org/gmane.comp.version-control.git/170907/focus=170916

Johannes Sixt (1):
  Documentation/gitignore: explain how to un-ignore part of a directory

Jonathan Nieder (3):
  Documentation/gitignore: "foo/" patterns match directories, not files
    under them
  Documentation: clarify effect of '/' in gitignore(5) patterns
  Documentation: unanchored gitignore patterns match basename

 Documentation/gitignore.txt |   48 ++++++++++++++++++++++++++++++------------
 1 files changed, 34 insertions(+), 14 deletions(-)
