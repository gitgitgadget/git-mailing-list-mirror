From: Paul Mackerras <paulus@samba.org>
Subject: Re: Bug in gitk search box
Date: Thu, 26 Jul 2007 10:27:45 +1000
Message-ID: <18087.60033.676105.538784@cargo.ozlabs.ibm.com>
References: <20070725135621.GC21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Thu Jul 26 02:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDrCy-0006eG-Lg
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 02:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbXGZA16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 20:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbXGZA15
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 20:27:57 -0400
Received: from ozlabs.org ([203.10.76.45]:36828 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbXGZA15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 20:27:57 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4D2D3DDE39; Thu, 26 Jul 2007 10:27:53 +1000 (EST)
In-Reply-To: <20070725135621.GC21692@lavos.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53744>

Brian Downing writes:

> * Open gitk in any repository, the Git one seems to work fine.
> * Type a string that it won't find into the search box, like 'asdfasdf'.
> * Click find.
> 
> You'll get:
> 
> can't read "commitdata(e83c5163316f89bfbde7d9ab23ca2e25604af290)": no such element in array

It turns out that this problem crept in when I changed from using git
rev-list --header to git log -z --pretty=raw, and the thing that
causes it is that git rev-list puts a null character after every
commit, while git log only puts a null between commits, i.e., there
isn't a null after the last commit.

Junio, is this behaviour deliberate?

Paul.
