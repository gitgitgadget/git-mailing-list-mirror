From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Migrating away from SHA-1?
Date: Thu, 14 Apr 2016 18:40:51 -0400
Message-ID: <20160414224051.GD16656@thunk.org>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
 <1460502934.5540.71.camel@twopensource.com>
 <20160414015324.GA16656@thunk.org>
 <1460654583.5540.87.camel@twopensource.com>
 <71A5D062-FCCD-42E5-80A8-AA9D8DE20604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:41:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqpwc-0005jt-ER
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbcDNWk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:40:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:56582 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbcDNWk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 18:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Aqp1DpP0cV9DPoM3gaD1mFXvL5Pgue/84Gwx5hbcCC0=;
	b=DWC2FV9RhZfjz8fLUDVLZtiZtoYwymcSpnih33Q7pZumYJ36TfMfxo+U9aiorWf36kCnc6KYOh9yzPlDgUbYsMG8ZmdVRiFLePjl865l+8ewa0w0sAf+deT5PYDkPlwMCziZPfm242Oniobt3Ao1dqHIGkb+4Q+2WP8U1mA9N8I=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1aqpwT-0003J8-0h; Thu, 14 Apr 2016 22:40:53 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id BAE3782F142; Thu, 14 Apr 2016 18:40:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <71A5D062-FCCD-42E5-80A8-AA9D8DE20604@zytor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291574>

On Thu, Apr 14, 2016 at 10:28:50AM -0700, H. Peter Anvin wrote:
> 
> Either way, I agree with Ted, that we have enough time to do it
> right, but that is a good reason to do it sooner rather than later
> (see also my note about freezing the cryptographic properties.)

Sure, I think we should do it as well.  But the fact that the attacker
will likely need to get a commit into the tree in order to be able to
carry out a collision attack means that it's easier (and probably less
detectable) to get some underhanded C code into the tree.  For one
thing, you just need to introduce it via a patch ("Hi, I'm super eager
newbie Nick, here's a cleanup patch!"), as opposed to getting a
sublieutenant to accept a git pull request.

Also, remember that while we can write programs that look for
suspicious git objects that have stuff hidden after the null
terminator (in fact, maybe that would be a good thing to add to git,
hmmm?), the state of the art in detecting underhanded C code which is
deliberately designed to not be noticed by static code checkers (or
humans doing a superficial code review, for that matter) is not
particularly encouraging to me.

						- Ted
