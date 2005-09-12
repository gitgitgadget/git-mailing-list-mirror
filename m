From: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 10:55:43 -0400
Message-ID: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjj-0000SG-V1
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVILO4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVILOzz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:55:55 -0400
Received: from citi.umich.edu ([141.211.133.111]:51975 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751263AbVILOzn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:43 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 4B7591BAF3;
	Mon, 12 Sep 2005 10:55:43 -0400 (EDT)
To: git@vger.kernel.org
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8393>


[ This series is posted for review and comments. ]

The following patch series introduces an abstraction called a "cache
cursor" that will eventually allow us to replace the current
active_cache array with something else.

A cache cursor represents a position inside the cache.  This position
has a cache_entry associated with it, of course, but since the cache
is ordered, a cache cursor also has the concept of next, previous,
and end-of-cache.

With a cache cursor we can build a simple iterator mechanism that
calls a particular function for every entry in the cache, in order.
This allows us to hide further the specifics of the active cache
implementation -- the function gets to see the cache cursor and
an element, but does not have direct access to the cache and cannot
assume it has a particular structure.

Currently the cache cursor type is just a structure with an integer
in it, so it largely mimics the existing implementation.

This patch series is against the "proposed updates" branch, as of
a couple of days ago.  It has been tested via "make test" and I'm
currently using it for my own work without issue.

Signed-off-by: Chuck Lever <cel@netapp.com>
--
