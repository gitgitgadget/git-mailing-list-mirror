From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Wed, 3 Jan 2007 12:14:10 +0100
Message-ID: <8c5c35580701030314t69b6a7dbhf9cb99de4567b93e@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
	 <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com>
	 <e5bfff550701030235g6f26044h8dd73e8abe1ec9e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 03 12:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H244a-0002u3-10
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 12:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbXACLON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 06:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750695AbXACLON
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 06:14:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:6758 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXACLOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 06:14:12 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7662299nfa
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 03:14:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZlNLvEDk4dnVY6LTTq9sYwhwBze4F0PUvitQ1NoIjJoNOlEd0spmEfbDBPFegkRF1zwci7QfcYIiIG8bYihjQjpyWlIIHMGkxNljGMTCoZqOoM6I3W7KscB7lKAKNNC3hKnChOkCzlx7YUnbv07PJRc5yI7YwfQmxz4nS9xaQqo=
Received: by 10.82.184.2 with SMTP id h2mr1703775buf.1167822850841;
        Wed, 03 Jan 2007 03:14:10 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Wed, 3 Jan 2007 03:14:10 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550701030235g6f26044h8dd73e8abe1ec9e3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35859>

On 1/3/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 1/3/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > On 1/3/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > >         - one blank line
> > >         - zero or one line with log title
> > >         - zero or more lines with log message
> > >         - a terminating '\0'
> >
> > I think the should be:
> >   -zero or more blank lines
>
> Isn't it zero or _one_ blank line? Why more then one? would be it
> useful? surely is slower to parse.

My point is just that the log message is unformatted. There is nothing
stopping you from
adding blank lines at the start of the message.

But then I tested it, and it seems as 'git-commit' strips off any
leading blank lines (but git-commit-tree does not). So expecting one
blank _might_ be good enough.

>
> >   -zero or more non-blank lines with log title
>
> multi lines titles are allowed? never saw one of them.

It is allowed (I tested this)

>
> >   -zero or more blank lines
>
> Why? this is necessary only to disambiguate muti (non blank) lines
> titles, but as Junio pointed out distinction between log title and log
> message is only in the Porcelain, not encoded in git. So the Porcalain
> is going to show _one_line title if any an the remaining stuff in the
> log message.

Well, if the porcelain chooses to do so, it probably is ok. But I
think the parsing/presentation of the log title/message would be more
correct/better formatted if the parser is more "adaptive" to the
content.

-- 
larsh
