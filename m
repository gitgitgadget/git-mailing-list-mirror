From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 23:06:59 -0700
Message-ID: <20051017060659.GH5509@reactrix.com>
References: <434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org> <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org> <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org> <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net> <20051016213341.GF5509@reactrix.com> <7vwtkd6rik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 08:07:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERO9S-0006vi-Ls
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 08:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVJQGHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 02:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVJQGHJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 02:07:09 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:38432 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751340AbVJQGHH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 02:07:07 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9H66xn8024814;
	Sun, 16 Oct 2005 23:06:59 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9H66xRS024812;
	Sun, 16 Oct 2005 23:06:59 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtkd6rik.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10179>

On Sun, Oct 16, 2005 at 03:12:03PM -0700, Junio C Hamano wrote:

>  - Among the set of packs that contain the object we are
>    currently interested in, try to find the "best" pack.  The
>    definition of "best" would be a balancing act of finding the
>    one that contains the least number of objects we already
>    have, and the one that contains the most number of objects we
>    do not have yet.

To get a complete list of objects we do not have yet, fetch will need
to walk all the trees first and then make another pass to process
all the missing objects.  Is it worth considering a case where the
missing objects are packed along with objects that don't need to be
transferred?  From the use cases you described, it's not clear that
situation would ever really happen.

If the blobs have been packed, it seems likely that the tree objects will
also be packed, so fetching them during the first pass will either involve
fetching a pack without being able to determine which is best or fetching
the appropriate ranges from packs to get the tree objects.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
