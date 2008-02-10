From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sun, 10 Feb 2008 12:31:15 +0100
Message-ID: <200802101231.16847.jnareb@gmail.com>
References: <20080209162234.GA25533@fieldses.org> <m363wxhey1.fsf@localhost.localdomain> <7v8x1t5uk1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 12:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOAPl-0003z4-C8
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 12:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646AbYBJLbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 06:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620AbYBJLbb
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 06:31:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:54658 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbYBJLba (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 06:31:30 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3455419fga.17
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 03:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=58tBAUv/zULuJv0rYPR3Zn9W+U3D2HHCLLhItSonID0=;
        b=Bo/3M5wZsE36p1XE3Es5eUKs2xkiMyMF+LDVPKq8ltYeEwaY+OizNRb7sf27izxpcACTzNJuRzl45hVd4qzJDVjAFr2eGhkwU9Cr8C2vE9tdbpASRpBgBtfYbsiqYfKR4WaR+h7QgLqZDmdiq79yn2BnjY18ptYuCJbcqc2AAME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aJwLPFlFAlDbs//6+qLufPnWRBEK5mH32koklSbREvr+xqdx//P5Qh8pFng4Fws2SB5pjL/DCZnallimbJtJaKnJO9r309wJCsAMytQkVSeVTlefzB3brpE68nr8tjk/abnpSgLKLajEuI3cKt5DuyIpoJmblIMtE+exQzQH2B4=
Received: by 10.82.187.2 with SMTP id k2mr27099476buf.16.1202643087929;
        Sun, 10 Feb 2008 03:31:27 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.105])
        by mx.google.com with ESMTPS id z33sm16642213ikz.0.2008.02.10.03.31.25
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 03:31:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8x1t5uk1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73339>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> *.py whitespace=!indent,trail,space
>>> *.el whitespace=!indent,trail,space

Emacs Lisp is (like Perl, and contrary to Python) whitespace agnostic,
so here you just agree on historical usage. In this case the same
should IMHO be done for gitweb/gitweb.perl in main .gitattributes.

:<: checks contrib/emacs/git.el :>:

Hmmm... it looks like git.el uses only spaces, both for indent
and for align, with some spurious TABS happening.

If you allow this, couldn't you allow also for the gitweb.perl?

>>> fast-import/git-p4 whitespace=!indent,trail,space
>>
>> I would also exclude gitweb/gitweb.perl
> 
> Why?
> 
> As far as I can tell, Perl does not use Python/Elisp "indents
> are all whitespace" rule and neither does the script.

Elisp is also whitespace agnostic, but like in Perl it can contain
here-docs, and heredoc-like docstring; I'm not sure about whitespace
rules for that.

> It also happens that I do not personally believe in "alignment
> with spaces" argument.  If you accept W and a SP occupy the same
> horizontal space (which "alignment with spaces" assume), I do
> not think it is unreasonable to accept HT goes to the next
> column that is multiple of 8 places.
 
My argument is that when you change tab-width (and basic-offset), with
"tabs for indent, spaces for align" you don't have source get out of 
align. And not everybody uses large screens, and large resolution.

Besides there is also purely theoretical argument of consistency.
When using tabs also for align, it is in prectice align with tabs
_and spaces_, e.g.:

------>|if (expression ||
------>|____expression) {

or

------>|print "something" .
------>|______"something";

or

------>|$date{'mday-time'} = sprintf "%d %s %02d:%02d",
------>|------>|------>|_____$mday, $months[$mon], $hour ,$min;

where leading tab is marked as "------>|", and leading space as "_".


The argument for using tabs for align is that it is easy to check 
programatically for those kind of whitespace errors, and that editors 
do that. But lacking tools or misconfigured tools shouldn't IMHO be 
cause of selecting a coding style / choosing a policy.

-- 
Jakub Narebski
Poland
