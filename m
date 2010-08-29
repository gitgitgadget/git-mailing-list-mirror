From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 14:59:41 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1008291443030.14365@iabervon.org>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com> <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpnDu-00008h-NA
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818Ab0H2THP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 15:07:15 -0400
Received: from iabervon.org ([66.92.72.58]:56201 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785Ab0H2THO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 15:07:14 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Aug 2010 15:07:12 EDT
Received: (qmail 1234 invoked by uid 1000); 29 Aug 2010 18:59:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Aug 2010 18:59:41 -0000
In-Reply-To: <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154701>

On Sat, 28 Aug 2010, Sverre Rabbelier wrote:

> Currently the only way to end an import stream is to close it, which
> is not desirable when the stream that's being used is shared. For
> example, the remote helper infrastructure uses a pipe between it and
> the helper process, part of the protocol is to send a fast-import
> stream accross. Without a way to end the stream the remote helper
> infrastructure is forced to limit itself to have a command that uses
> a fast-import stream as it's last command.
> 
> Add a trivial 'done' command that causes fast-import to stop reading
> from the stream and exit.

Yeah, this is definitely worthwhile.

> ---
> 
>   Very straightforward. It is handled in parse_feature() instead of
>   in parse_one_feature() because I didn't want to allow '--done' as a
>   commandline argument. Allowing it would be silly, it surves no
>   other purpose than to indicate up front that the stream will
>   contain a 'done' command at the end.
> 
>   I'm fine too with dropping the feature and just adding the new
>   command, whichever is preferred.

I think the point of the feature would be to get the error response up 
front, where it might be easier to determine what to do about importers 
not supporting it. As such, I think the command line option actually makes 
at least as much sense, but it's probably not necessary anyway.

I believe there's a gfi mailing list, which ought to hear about this bit. 
Not that there are likely to be conflicts, but, when I was thinking about 
adding this command (for the same reason you're adding it), I'd called it 
"quit", so it's worth letting people know a de facto standard, so gfi 
implementations don't vary.

The code looks obviously good to me.

	-Daniel
*This .sig left intentionally blank*
