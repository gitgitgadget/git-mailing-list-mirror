From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 21:38:10 -0600
Message-ID: <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	 <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 04:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC6Ig-0004B5-V8
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 04:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXAaDiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 22:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbXAaDiM
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 22:38:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:41466 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbXAaDiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 22:38:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so410550nfa
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 19:38:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TlyFMZRjpEX00LjH5sSV+zryagHQh7BV95V0+7lq9gsLeAvaoejL4n4ouLu5e1E3Yd3NdBLDp3rNVMqkUKdAjm1CA9ZlDry+unYSSLpC7KZ0Kk0dgcTL+MrDo3FPhemtgHKA7kU4pynaO2PHc7oI9Hs0/njwsUwa+/VZI247zdI=
Received: by 10.49.107.8 with SMTP id j8mr1853816nfm.1170214690138;
        Tue, 30 Jan 2007 19:38:10 -0800 (PST)
Received: by 10.48.246.15 with HTTP; Tue, 30 Jan 2007 19:38:10 -0800 (PST)
In-Reply-To: <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38224>

Thanks for all of your replies--this information is very helpful.
Though both hg and git look good, I will probably try git first,
partly because it seems the most interesting.  It feels like fertile
ground for experiments, and I suspect someone will think of some
surprising application for it.  (Also, I had the privilege of working
with Junio in a past life, and I consider his involvement a good
portent.)

This mercurial list post by Ted Tso was also useful:

    http://www.selenic.com/pipermail/mercurial/2007-January/012039.html

Regarding a Python (or other interpreted language) implementation, the
most obvious practical benefit would be an easy win32 port.  Not that
I'd ever choose to develop there, but it removes its lack as an
objection in some organizational settings (such as mine).  Someone
mentioned a Java port--that'd cover that base quite well.

As for performance, my thinking was that since hg is implemented
apparently almost entirely in Python, and has (again apparently)
generally acceptable performance, this suggested that much of the
problem might be I/O-bound enough that language efficiency might not
matter so much.

Aside: The program for which I'm considering trying git does mass spec
protein identification and has (in the general case) exponential
runtime, all of it CPU.  Run times on a 500-node cluster start at two
hours and go up rapidly.  You might think at first that this wouldn't
be a good candidate for Python, but so far this looks to be incorrect.
 The simple reason: asymptotically, all of the run time happens in
about four functions.  Given that, and friendly constants, what was
about 15K (*) lines of C++ has turned into somewhat less than 1K lines
of C++ and 1K lines of Python--it's difficult to gauge because so many
new features have been added.  Somewhat ironically, the worst
performance issue seems to be C++'s obscure (to me) object
construction costs--I may end up just switching the C++ part to C.

There are many axes of design to be considered, of course, but the
moral I took away from that is that better than asking "Does this
program have to be really fast?", one should ask "How many lines of
this program could run 20x slower (than C) without significantly
affecting overall performance?"  If the answer is 80%, it might be
worth thinking about.  Skepticism is always in order, of course.

Mike

(*) via David Wheeler's sloccount
