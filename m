From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Errors from http-fetch
Date: Wed, 19 Oct 2005 14:26:44 -0700
Message-ID: <20051019212644.GB6160@reactrix.com>
References: <Pine.LNX.4.64.0510191536350.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 23:29:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESLT3-0000B2-1O
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 23:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVJSV0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVJSV0w
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 17:26:52 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:36843 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750889AbVJSV0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 17:26:51 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9JLQieF014416;
	Wed, 19 Oct 2005 14:26:44 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9JLQiEu014414;
	Wed, 19 Oct 2005 14:26:44 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510191536350.25300@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10312>

On Wed, Oct 19, 2005 at 03:46:10PM -0400, Daniel Barkalow wrote:

> I've now started getting errors from http-fetch; my guess for the output 
> is that it has problems if an object is not available loose, and is only 
> available in a pack file which is already being downloaded for a different 
> object, possibly only if the first request to be made for the loose 
> object is not the first one to fail.

Are you getting a curl return code of 52/CURLE_GOT_NOTHING?  Any chance
you have access to the associated server logs?

In the situation you describe, fetch() won't be called for the second
object until fetch() for the first object is finished - at which point
the pack will have been fully downloaded for the first object (or
failed, causing fetch() for the first object to fail as well.)

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
