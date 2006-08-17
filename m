From: linux@horizon.com
Subject: Re: Compression and dictionaries
Date: 17 Aug 2006 18:33:03 -0400
Message-ID: <20060817223303.1712.qmail@science.horizon.com>
References: <Pine.LNX.4.63.0608160832320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: git@vger.kernel.org, jcrigby@gmail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Aug 18 00:33:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDqQM-0003JO-Ne
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 00:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWHQWdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 18:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWHQWdG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 18:33:06 -0400
Received: from science.horizon.com ([192.35.100.1]:22333 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030276AbWHQWdE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 18:33:04 -0400
Received: (qmail 1713 invoked by uid 1000); 17 Aug 2006 18:33:03 -0400
To: Johannes.Schindelin@gmx.de, jonsmirl@gmail.com
In-Reply-To: <Pine.LNX.4.63.0608160832320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25616>

Just a note: there are index structures that support regular expression
searching.  In particular, a PAT tree, usually represented implicitly as
a PAT array, can be walked by a finite automaton to find all the places
it matches.

However, there's a lot of code complexity associated with that.  And a
PAT array assumes efficient random access to the text being indexed,
as it does not keep a copy of the text.


Perhaps most importantly, this would be a big change to "git grep", as
it would search every object in the database, not a particular commit.
And mapping objects back to filenames in trees and commits requires
another index.


Compression dictionaries and indexes have some opposing points.  In a
compression dictionary, you prefer common words that appear in many places.
For an index, you prefer rare words that identify a small set of files.
