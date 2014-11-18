From: Mike Hommey <mh@glandium.org>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 13:17:57 +0900
Message-ID: <20141118041757.GA15972@glandium.org>
References: <20141118003426.GA6528@glandium.org>
 <20141118022137.GA8418@glandium.org>
 <20141118023520.GB14034@glandium.org>
 <20141118032740.GJ4336@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 05:18:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqaF2-0007Qn-FH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 05:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbaKRESH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 23:18:07 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:46627 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaKRESG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 23:18:06 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XqaEn-0004Cx-OP; Tue, 18 Nov 2014 13:17:57 +0900
Content-Disposition: inline
In-Reply-To: <20141118032740.GJ4336@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 07:27:41PM -0800, Jonathan Nieder wrote:
> Mike Hommey wrote:
> 
> > And while I'm here, it's sad that one needs to emit a dummy cat-blob or
> > ls command to wait for a checkpoint to be finished
> 
> That's a good point.  (Though relying on checkpoints to read back
> information is an ugly trick, so if we can get other commands to
> provide the information you need then that would be better.)
> 
> The old-fashioned way is to do "progress checkpoint done".  Alas, that
> writes to the progress fd, which doesn't go to the remote helper's
> stdin.  How about something like this?

How about something more generic, like "sync", which purpose would be to
request synchronisation with fast-import, which would respond "sync" on
the cat-blob fd?

Or "ping"<->"pong".

Although... I wonder if that would really be useful for anything else
than checkpoint...

That said, I, for one, would be fine if this is not "fixed" as long as
marks can be resolved some other way (and, in fact, it may turn out that
I don't need to resolve marks to sha1s at all)

Thanks for you help

Mike
