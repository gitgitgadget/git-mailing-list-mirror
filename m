From: Nick Hengeveld <nickh@reactrix.com>
Subject: [RFC] Timeouts on HTTP requests
Date: Tue, 18 Oct 2005 16:51:04 -0700
Message-ID: <20051018235104.GO5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 19 01:51:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES1Ef-0002yq-7d
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 01:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbVJRXvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 19:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVJRXvJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 19:51:09 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:33311 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751510AbVJRXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 19:51:08 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9INp4ko020432
	for <git@vger.kernel.org>; Tue, 18 Oct 2005 16:51:04 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9INp4KV020430
	for git@vger.kernel.org; Tue, 18 Oct 2005 16:51:04 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10241>

Our QA department today checked what would happen if the network connection
went away completely in the middle of an HTTP transfer.  It looks as though
the answer is that git-http-fetch sits there forever waiting for CURL to
return something.

I'm thinking of taking advantage of CURL's capability of aborting a request
if the transfer rate drops below a threshold for a specified length of time
using a new pair of environment variables and/or config file settings:

GIT_HTTP_LOW_SPEED_LIMIT/http.lowspeedlimit
GIT_HTTP_LOW_SPEED_TIME/http.lowspeedtime

Does this make sense, and if so should there be defaults if nothing is
specified?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
