From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] include/asm-arm/: Spelling fixes
Date: Mon, 17 Dec 2007 12:22:51 -0800
Message-ID: <1197922971.27386.32.camel@localhost>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918889.git.joe@perches.com>
	 <20071217195658.GB13515@fieldses.org> <1197921847.27386.16.camel@localhost>
	 <20071217201219.GC13515@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:23:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MUw-00071c-VU
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166AbXLQUXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757577AbXLQUXC
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:23:02 -0500
Received: from DSL022.labridge.com ([206.117.136.22]:3465 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757072AbXLQUW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:22:59 -0500
Received: from [192.168.1.128] (192-168-1-128.LABridge.com [192.168.1.128] (may be forged))
	by perches.com (8.9.3/8.9.3) with ESMTP id LAA00868;
	Mon, 17 Dec 2007 11:34:37 -0800
In-Reply-To: <20071217201219.GC13515@fieldses.org>
X-Mailer: Evolution 2.12.0-2mdv2008.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68610>

On Mon, 2007-12-17 at 15:12 -0500, J. Bruce Fields wrote:
> Hope you don't mind my cc'ing the git list:

Nope.  Not a bit.

I had patches that were committed in word order that
I wanted to aggregate by subsystem.

I took all the patches, created a branch, committed
all the patches at once, then used these commands:
 
(patch_order is a directory list)

$ let count=0 ; for line in $(cat patch_order) ; do ((count++)); \
	printf -v tmp "%04u-Spelling-%s" $count $line ; \
	tmp=${tmp//\//-} ; tmp=${tmp// /}; \
	git-format-patch -N --thread --start-number $count -s \
	-o patch3 \
	--subject-prefix="[PATCH] Spelling: $line" master $line  ; done
[converted the subjects appropriately]
$ git-send-email --smtp-server <foo> --smtp-user <bar> \
	--from "Joe Perches <joe@perches.com>" \
	--to "linux-kernel@vger.kernel.org" \
	--cc "Andrew Morton <akpm@linux-foundation.org>" \
	--cc-cmd "../get_maintainer.pl --nogit" \
	--no-thread --suppress-from patch3

I probably just reversed the "--thread" on
git-format-patch and send-email.

cheers, Joe
