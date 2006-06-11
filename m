From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: gitweb.cgi history not shown
Date: Sun, 11 Jun 2006 08:32:43 +0200
Message-ID: <e5bfff550606102332v6afb7d51m43ad5d74ba226cf0@mail.gmail.com>
References: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com>
	 <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 08:32:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpJVB-0000rP-17
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 08:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWFKGco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 02:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWFKGco
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 02:32:44 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:6357 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932571AbWFKGco (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 02:32:44 -0400
Received: by py-out-1112.google.com with SMTP id x31so1369282pye
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 23:32:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dguWRRnmncZe649fnnr28z+WBA0lc9GcpsP27YetNH2fuoRnRIPNKlHJ+O0PvSsjMn42Wtu6poq2LqbtkmvWCyDgv0yx8qseRj7PH6WOmknL9jsjJpozxK29h9Oa02hSiFPeRWQSODEG/0GWrLnm7srt//gKsIAOW384d1Ebxpg=
Received: by 10.35.60.16 with SMTP id n16mr5332227pyk;
        Sat, 10 Jun 2006 23:32:43 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 10 Jun 2006 23:32:43 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21634>

>
> Now, look what happens if you instead of starting the history search from
> all the _current_ heads, you start it from a location that actually _had_
> that file:
>
>         git log 1130ef362fc8d9c3422c23f5d5 -- gitweb.cgi
>
> and suddenly there the history is - in all its glory.
>

Why I still get empty results if I run git-rev-list from gitweb merge point?

$ git-rev-list 0a8f4f0020cb35095005852c0797f0b90e9ebb74 -- gitweb.cgi
$
$ git-rev-list 0a8f4f0020cb35095005852c0797f0b90e9ebb74 -- gitweb/gitweb.cgi
0a8f4f0020cb35095005852c0797f0b90e9ebb74

Is this because path changed: gitweb.cgi -> gitweb/gitweb.cgi

I would like to think the problem is the path change because in case
of gitk, merge of a parallel branch but with _no_ path change,
everything worked as expected.

So the question is the path change was "fixed up" by hand or done as
part of gitweb branch merge process, in the latter case probably
git-rev-list should already take in account this without special flags
_and_ without removing history traversal optimizations that are good
and useful in the remaining 99% of cases (for a GUI tool is difficult
to know when to use a flag like --no-simplify-merge or not on a per
request basis).

        Marco
