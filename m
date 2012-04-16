From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCHv2] Add details about svn-fe's dumpfile parsing
Date: Mon, 16 Apr 2012 23:15:47 +0100
Message-ID: <4F8C9A13.80906@pileofstuff.org>
References: <4F8AF306.8070804@pileofstuff.org> <7vipgztpaf.fsf@alter.siamese.dyndns.org> <4F8C909B.7010507@pileofstuff.org> <20120416213910.GP12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:15:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuDE-00030C-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab2DPWPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:15:52 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:36589 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752828Ab2DPWPv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 18:15:51 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120416221550.PLTM21612.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Mon, 16 Apr 2012 23:15:50 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120416221549.HLJC23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 16 Apr 2012 23:15:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120416213910.GP12613@burratino>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=YmvJA8EKKy4A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=o2eD-HNaAAAA:8 a=mV9VRH-2AAAA:8 a=DGilNdeZpSeoeoiuqRgA:9 a=qMq2BZwFluCOk8nIdxwA:7 a=wPNLvfGTeEIA:10 a=geaEz6FnhbMA:10 a=gHNH_UPw9HoA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195713>

On 16/04/12 22:39, Jonathan Nieder wrote:
> Andrew Sayers wrote:
> 
>> The dumpfile documentation says that "... property key/value pairs may
>> be interpreted as binary data in any encoding by client tools"[1], but
>> SVN itself interprets the data as UTF-8
> 
> Yes, I suspect most of the changes you proposed for the INPUT FORMAT
> section would actually be better as changes for the
> dump-load-format.txt document.  I imagine that folks on the dev@ list
> might be able to clarify a few details (e.g., what one is expected to
> do with historical repositories with non-UTF-8 property data), too.
> What do you think?

Hmm, I'd personally be more interested in going to the SVN folks with a
more general question.  The SVN Book[1] says "pathnames can contain only
legal XML (1.0) characters, and properties are further limited to ASCII
characters. Subversion also prohibits TAB, CR, and LF characters in path
names".  Code documentation[2] gives a lot of complex rules that don't
bear much resemblance to the behaviour I've seen so far (albeit only
lightly tested in SVN 1.6).  The dumpfile docs[3] pretty much declare a
free-for-all, and I've yet to see historical documentation properly
written up anywhere.

I guess my question would be something like "what should a client
reading or writing SVN dumps do to stay as compatible as possible?", but
I feel like I've got a collection of bits that haven't quite coalesced
well enough yet to really drive the conversation.

As a web developer, the SBL work I've been doing is starting to remind
me of the jump from HTML4 ("here's what clients should do.  Of course
it's not what they actually do...") to HTML5 ("here's what clients
actually do.  No we're not allowed to just shoot those people").  Like
HTML5, I figure I've got to take the argument to the official body some
day, but I'd rather have something vaguely mature first.

My instinct is to put this on the TODO list for after I've finished
writing tests, but I'm open to suggestions.

	- Andrew

[1]http://svnbook.red-bean.com/en/1.7/svn.tour.importing.html#svn.tour.importing.naming
[2]http://subversion.apache.org/docs/api/latest/group__svn__fs__directories.html#details
[3]http://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
