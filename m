From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using email between 2 developers to keep git repositories in
 sync
Date: Tue, 22 Jan 2008 13:00:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801221255530.5731@racer.site>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: ab_lists@mac.com
X-From: git-owner@vger.kernel.org Tue Jan 22 14:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHIk5-0002iU-5D
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 14:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbYAVNAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 08:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbYAVNAG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 08:00:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:39881 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750781AbYAVNAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 08:00:05 -0500
Received: (qmail invoked by alias); 22 Jan 2008 13:00:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 22 Jan 2008 14:00:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FKQ1DWfyFCSH3TnW5RpIhxYbvwROnramfKqKayr
	eKPcVQ76QZFCaY
X-X-Sender: gene099@racer.site
In-Reply-To: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71448>

Hi,

On Tue, 22 Jan 2008, ab_lists@mac.com wrote:

> However I need to share code with a co-developer. He also has a code 
> base that I need access to. For several reasons, a shared server will 
> not work so I was thinking of using email to send patches back and 
> forth.

My recommendation: Use bundles.  Just make the initial "clone" like this:

	$ git bundle create initial.bundle --all

Send the file "initial.bundle" (which you just created) to your 
co-developer.  He should now initialise his repository:

	$ mkdir my-new-workdir
	$ cd my-new-workdir
	$ git init
	$ git pull /path/to/initial.bundle master

(Someone tried to get "git clone /path/to/bundle" to work, but I don't 
know if that work was ever completed, so I assume it was not.)

Whenever he wants to send you an update, he has to do something like this:

	$ git bundle create update.bundle --all --since=2.weeks.ago

and send you the resulting file named "update.bundle".

Hth,
Dscho
