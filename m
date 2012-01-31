From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 15:55:01 -0600
Message-ID: <20120131215501.GF13252@burratino>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 31 22:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsLff-00073v-CW
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 22:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab2AaVzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 16:55:18 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50621 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab2AaVzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 16:55:18 -0500
Received: by wgbdt10 with SMTP id dt10so493432wgb.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 13:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gtb+28C3kT0c6XZcgHyqTNo0DX0X56Pgr94xCNu7hIo=;
        b=EZ6VfiPYK4RqU2Aklkrt82QFILNq/01VWukI8R7GLmnmlyi20kmPNmcZXhqMPmFGsH
         yOZ8EOX3rIniK8ll5enbwR626uR2GTvSbTR7/6na9f/o1dl8DkQxR5AWOseSlvWUP+AX
         ordo7BMKkkG1SGHqBQrHPktIw3hoknOBk8u9k=
Received: by 10.180.95.105 with SMTP id dj9mr37187778wib.18.1328046916986;
        Tue, 31 Jan 2012 13:55:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l8sm66995804wiy.5.2012.01.31.13.55.14
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 13:55:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120131214740.GA2465@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189475>

Jeff King wrote:

> Right. But would you expect:
>
>   git ls-remote foo
>
> to behave the same as:
>
>   cd foo
>   git ls-remote .
>
> and would you furthermore expect that to behave the same as:
>
>   cd foo
>   git rev-parse --git-dir
>
> ?

Nah.  I never run "git ls-remote .". ;-)

[...]
>>  2) As a naive user, I would expect (A) to give a different result
>>     from (B).
>
> Why?

Normally git commands expect me to be in (possibly a deeply nested
subdirectory) of the worktree.  The typical case is a non-bare
repository.  I have been taught that it walks to the toplevel and
finds a ".git" directory.

By contrast, the path passed to git transport commands like "git fetch
otherhost:/foo/bar/baz.git" is a path to the git repository metadata.
I am not allowed to pass a path to a subdirectory, for example.

As a user, when would the distinction ever come up?  One is a fuzzy
"which repository am I working in", and the other is a precise "point
me to the metadata directory, but I allow you to abbreviate a little
by leaving out the trailing .git".
