From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Fix HTTP request result processing after slot reuse
Date: Tue, 31 Jan 2006 17:50:47 -0800
Message-ID: <20060201015047.GF3873@reactrix.com>
References: <20060131190655.GE3873@reactrix.com> <7v64o0ulfu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 02:51:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F479E-0001Ms-4C
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 02:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWBABu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 20:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWBABu4
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 20:50:56 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:38546 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964824AbWBABuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 20:50:55 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k111olLc009701;
	Tue, 31 Jan 2006 17:50:47 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k111olkv009699;
	Tue, 31 Jan 2006 17:50:47 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64o0ulfu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15373>

On Tue, Jan 31, 2006 at 01:39:01PM -0800, Junio C Hamano wrote:

> These static variables are probably correct, provided if
> fetch_index, fetch_indices and friends do not recurse into
> themselves, but it just gives me this funny feeling...

It's true that in the current implementation we either don't recurse
into these functions or we explicitly handle cases where we do such as
fetch_alternates.  However, I've got no argument as to why the
structures should be static and can imagine it just causing problems
down the road if we were to eg. start downloading multiple packs
concurrently.

I'll follow up with a patch.

--
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
