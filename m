From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Wed, 3 Jan 2007 10:21:21 +0100
Message-ID: <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 03 10:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H22JL-00051u-38
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 10:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbXACJVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 04:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbXACJVW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 04:21:22 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:24474 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbXACJVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 04:21:22 -0500
Received: by py-out-1112.google.com with SMTP id a29so3343136pyi
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 01:21:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c4dQkaN3i3LS3ieh8e+6QisjXR1dfWu5sZbrSr+H8MxEoMLCWcY8sGRausmZPh1W2WcLpAHtJ4xOq3UrHyklYxv9Pk0jyiL4n2JkYM0CJYuh7JZGsUHeBewE3dToABHrNNLvDEjjn7uSoAhcrDZJ4JQfShBU9ixXXcsOIeEKgJQ=
Received: by 10.35.93.1 with SMTP id v1mr39390183pyl.1167816081340;
        Wed, 03 Jan 2007 01:21:21 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Wed, 3 Jan 2007 01:21:21 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35852>

On 1/1/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > On 12/31/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> Further, if you rely on parsing being super-fast, why not just parse
> >> _only_ the header information that you actually need? The header still
> >> consists of
> >>
> >>         - exactly one "tree",
> >>         - an arbitrary amount of "parent" lines,
> >>         - exactly one "author", and
> >>         - exactly one "committer" line
> >>
> >> After that may come optional headers,
>
> They are more like 'other' headers.  Nobody said the set of
> headers are cast in stone forever.  The only things parsers
> safely can assume are that the original four kinds come at the
> beginning in the above order, and there is a blank line that
> separates headers and the body.
>

I'm cooking the qgit parser fix, please confirm the following
assumption is correct:

	When git-rev-list is called with --header option, after the first
	line with the commit sha, the following information is produced
	
	- one line with "tree"
	- an arbitrary amount of "parent" lines
	- one line with "author"
	- one line with "committer"
	- zero or more *non blank* lines with other info, as the encoding
	- one blank line
	- zero or one line with log title
	- zero or more lines with log message
	- a terminating '\0'


Thanks
Marco
