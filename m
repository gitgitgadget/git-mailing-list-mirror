From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: [PATCH] shared repository settings enhancement.
Date: Sun, 11 Jun 2006 13:32:53 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF4105079578F3@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 11 19:33:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpToc-0007jt-Sf
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 19:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWFKRdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 13:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWFKRdK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 13:33:10 -0400
Received: from ahmler3.mail.eds.com ([192.85.154.74]:11910 "EHLO
	ahmler3.mail.eds.com") by vger.kernel.org with ESMTP
	id S1750746AbWFKRdJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 13:33:09 -0400
Received: from ahmlir3.mail.eds.com (ahmlir3-2.mail.eds.com [192.85.154.133])
	by ahmler3.mail.eds.com (8.13.6/8.12.10) with ESMTP id k5BHX213017852;
	Sun, 11 Jun 2006 13:33:03 -0400
Received: from ahmlir3.mail.eds.com (localhost [127.0.0.1])
	by ahmlir3.mail.eds.com (8.13.6/8.12.10) with ESMTP id k5BHWOVN024410;
	Sun, 11 Jun 2006 13:32:24 -0400
Received: from usahm012.amer.corp.eds.com ([130.175.214.153])
	by ahmlir3.mail.eds.com (8.13.6/8.12.10) with ESMTP id k5BHWOSu024405;
	Sun, 11 Jun 2006 13:32:24 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm012.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 11 Jun 2006 13:32:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] shared repository settings enhancement.
Thread-Index: AcaMQ9Nf75vm1yKtSPqAtTsY3gtHnQBOO+IQ
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 11 Jun 2006 17:32:55.0540 (UTC) FILETIME=[12F96340:01C68D7D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21665>

Speaking as a non-developer sysadmin, if I were to make a suggestion, it
would be this:
  [core]
     sharedrepository = {useumask | useronly | userandgroup |
worldreadable}


Mark Post

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Linus Torvalds
Sent: Saturday, June 10, 2006 12:09 AM
To: Junio C Hamano
Cc: git@vger.kernel.org
Subject: Re: [PATCH] shared repository settings enhancement.

On Fri, 9 Jun 2006, Junio C Hamano wrote:
> 
> Having said that, I do not think the distinction is that
> important; I would rather make the core.sharedrepository = true
> to mean an equivalent of "chmod go+rX" (it does "chmod g+rX"
> currently).

How about making it be

	[core]
		sharedrepository = {umask | user | group | everybody}

and allow the old boolean expression syntax to mean "0/false means
umask, 
1/true means group".

So you'd have:

 - umask/0/false means "use 0777 permissions with default umask"
 - user means "use 0500 permissions"
 - group means "use 0550 permissions"
 - everybody means "use 0555 permissions"

(where "5" is r-x, and only for directories, and obviously degenerates
to 
just "4" aka r-- for regular files).

That sounds really pretty self-explanatory and obvious, wouldn't you
say?

			Linus
