From: bdowning@lavos.net (Brian Downing)
Subject: [BUG] fast-import quoting broken for renames
Date: Mon, 12 Nov 2007 05:13:25 -0600
Message-ID: <20071112111324.GR6212@lavos.net>
References: <20071112110354.GP6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrXEc-00088a-KE
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068AbXKLLN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 06:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757399AbXKLLN1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:13:27 -0500
Received: from mxsf00.insightbb.com ([74.128.0.70]:42829 "EHLO
	mxsf00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014AbXKLLN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 06:13:26 -0500
X-IronPort-AV: E=Sophos;i="4.21,404,1188792000"; 
   d="scan'208";a="108080992"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf00.insightbb.com with ESMTP; 12 Nov 2007 06:13:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAJPDN0dKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,404,1188792000"; 
   d="scan'208";a="158297917"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 12 Nov 2007 06:13:26 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id C522C309F21; Mon, 12 Nov 2007 05:13:25 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20071112110354.GP6212@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64601>

While I'm at it...

$ GIT_DIR=foo.git git init
$ GIT_DIR=foo.git git fast-import <<EOC
commit refs/import
committer foo <foo> 0 +0000
data <<EOF
test
EOF
M 644 inline "foo"
data <<EOF
foo
EOF
R foo "bar"
EOC

fatal: Garbage after dest in: R foo "bar"

$ GIT_DIR=foo.git git fast-import <<EOC
commit refs/import
committer foo <foo> 0 +0000
data <<EOF
test
EOF
M 644 inline "foo"
data <<EOF
foo
EOF
R "foo" bar
EOC

fatal: Missing space after source: R "foo" bar

-bcd
