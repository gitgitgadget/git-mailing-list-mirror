From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH 1/2] Make pack creation always fsync() the result
Date: Sat, 31 May 2008 10:19:27 -0400
Message-ID: <20080531141927.GC32168@redhat.com>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <20080530152527.GF4032@redhat.com> <alpine.LFD.1.10.0805300844310.3141@woody.linux-foundation.org> <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 31 16:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Rxn-0007uF-Gg
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 16:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbYEaOUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 10:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbYEaOUp
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 10:20:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbYEaOUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 10:20:44 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4VEKcDX016399;
	Sat, 31 May 2008 10:20:38 -0400
Received: from pobox-3.corp.redhat.com (pobox-3.corp.redhat.com [10.11.255.67])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4VEKbv6017306;
	Sat, 31 May 2008 10:20:37 -0400
Received: from touchme.toronto.redhat.com (IDENT:postfix@touchme.yyz.redhat.com [10.15.16.9])
	by pobox-3.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4VEK5qG012853;
	Sat, 31 May 2008 10:20:37 -0400
Received: from ton.toronto.redhat.com (ton.yyz.redhat.com [10.15.16.15])
	by touchme.toronto.redhat.com (Postfix) with ESMTP
	id 9B9D38001FF; Sat, 31 May 2008 10:19:48 -0400 (EDT)
Received: from ton.toronto.redhat.com (localhost.localdomain [127.0.0.1])
	by ton.toronto.redhat.com (8.13.1/8.13.1) with ESMTP id m4VEJWUK009829;
	Sat, 31 May 2008 10:19:32 -0400
Received: (from fche@localhost)
	by ton.toronto.redhat.com (8.13.1/8.13.1/Submit) id m4VEJRda009828;
	Sat, 31 May 2008 10:19:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83387>

Hi -

On Fri, May 30, 2008 at 09:08:11AM -0700, Linus Torvalds wrote:

> [fsync on pack creation]
> This means that we can depend on packs always being stable on disk,
> simplifying a lot of the object serialization worries.  And unlike loose
> objects, serializing pack creation IO isn't going to be a performance
> killer. [...]

If you stabilize the outputs of the pack procedure rather than its
inputs, this makes me wonder if ordinary unpacked git objects would
also need some sort of fsync treatment.

- FChE
