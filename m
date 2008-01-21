From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 18:00:53 -0500
Message-ID: <20080121230053.GA317@mit.edu>
References: <alpine.LFD.1.00.0801!210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08!01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.!0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0!0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5fi-0001RC-2E
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758867AbYAUXBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 18:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758762AbYAUXBc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:01:32 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:51520 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758535AbYAUXBb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 18:01:31 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0LN0tAI024368;
	Mon, 21 Jan 2008 18:00:55 -0500 (EST)
Received: from closure.thunk.org (c-76-19-244-124.hsd1.ma.comcast.net [76.19.244.124])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0LN0r2a006827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 Jan 2008 18:00:54 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JH5dN-00009J-7G; Mon, 21 Jan 2008 18:00:53 -0500
Content-Disposition: inline
In-Reply-To: <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71368>

On Mon, Jan 21, 2008 at 05:46:27PM -0500, Kevin Ballard wrote:
> I find it amusing that you keep arguing against having git treat filenames 
> as unicode when, if you had actually taken my advice and read my previous 
> email talking about "ideal" vs "practical"...

If by "ideal" you mean a world where 100% of all computers were
designed by Steve Jobs, you might have a point.  But trying to argue
for such a state of idealism seems to be stupid, and certainly a
complete waste of everyone's time on the git mailing list.  It's
simply not reality.  It's like with the infamous resource forks, which
would have worked fine if all the world were MacOS, but which had a
tendency to get stripped off whenver you used a program that wasn't
resource fork aware, like zip, or a protocol that wasn't resource fork
aware, like FTP.  And so people had to put in all sorts of kludges
like BinHex to work around MacOS's "if only the entire world was like
*me*, no one would get hurt" attitude.  In some ways, the MacOS
designers are even worse than Microsoft in terms of having the "the
world revolves around us" attitude.

> In other words, I was trying to illustrate that 
> HFS+ isn't wrong, it's just different, and the difference is causing the 
> problem.

And if you want to interoperate with the rest of the world, where at
least count over 92% of computers are NOT running HFS+, then "Thinking
Different" is indeed causing the problem, yes.  And whose fault is that?

The whole point of interoperability is that when we communicate, we
have to do so in a uniform and predictable way.  If we can't, the next
best thing is to have protocol translators; but in order to do that,
we must avoid lossy transformations, such as HFS+'s
pseudo-normalization.  (Why, by the way, will not result in a "normal"
form for any glyph which can be encoded with and without a combining
character if said glyph was introduced into Unicode after 1988.  So
you can't even call it a "normalization" algorithm, but just a
pseudo-normalization transformation which is lossy and which DESTROYS
filename information in an irrecoverable way.)

	      	     	     	 	  	    - Ted
