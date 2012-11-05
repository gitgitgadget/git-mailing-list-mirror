From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/5] New remote-bzr remote helper
Date: Mon,  5 Nov 2012 16:56:15 +0100
Message-ID: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 16:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVP2q-0007CB-VW
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 16:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab2KEP4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 10:56:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38101 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2KEP4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 10:56:32 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063229bkc.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rRUxdPSRVQR3yoBhIGG2fJ4Yz4wD2HwK/Hqe9WYdeb8=;
        b=Cdhvnbu/XHiGixI2qYfFg9O3/zl/uy7CRyYPNx6kSZd7OoculwcPXinmnlPUQlVIGh
         BfH3FaIgzTbV6nBw1wMy+ElTOxdz3yGEeVN4vgINQlW849SIzW4vz1HskhueQlvLGlWc
         VxH/oQzBMS8DooH/8CtIB70byN5lgoGhjsO6q1fFKwU8guDoZX+3mcRY1BNOnLg3dtWU
         yql2zha4K3p05XMnDcbN6acGersRhEbHiOhgF+KlM7BksViD72JwXduhUeSmRy8kCVMv
         edEi9SGIN/xiEmmfBe4qIcu7lGC/CMinWvl9vm048LwHeHBQkFMzPiuPNEkkmX/bNm1A
         U9oQ==
Received: by 10.204.128.155 with SMTP id k27mr2375662bks.26.1352130990890;
        Mon, 05 Nov 2012 07:56:30 -0800 (PST)
Received: from localhost (ip-109-43-0-76.web.vodafone.de. [109.43.0.76])
        by mx.google.com with ESMTPS id gy18sm10138228bkc.4.2012.11.05.07.56.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 07:56:30 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209067>

Hi,

I decided to get rid of bzr-fastimport; too much complexity for not really that much of a gain.

The only feature I know is missing is support for executable modes and links.

I haven't verified that the resulting output is exactly the same as with other
tools, so be careful while using this.

Also, for the moment I'm not making a distinction betwen local and remote
repositories; they all get a local clone.

Pushing is significantly slower than with bzr-fastimport, but they are using
too many hacks on top of bzrlib, one that has left it broken it for years for
many people, and nobody has bothered to fix it, I had to find it the hard way
and disable the hack. I think the hit in perfromance is completely OK given
that we are using a more conventional bzrlib API, and going to be less likely
to be broken in the future.

Cheers.

Changes sinve v1:

 * Rewritten to avoid bzr-fastimport

Felipe Contreras (5):
  Add new remote-bzr transport helper
  remote-bzr: add simple tests
  remote-bzr: add support for pushing
  remote-bzr: add support for remote repositories
  remote-bzr: update working tree

 contrib/remote-helpers/git-remote-bzr | 672 ++++++++++++++++++++++++++++++++++
 contrib/remote-helpers/test-bzr.sh    | 111 ++++++
 2 files changed, 783 insertions(+)
 create mode 100755 contrib/remote-helpers/git-remote-bzr
 create mode 100755 contrib/remote-helpers/test-bzr.sh

-- 
1.8.0
