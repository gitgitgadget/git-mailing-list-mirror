From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 5 Dec 2014 21:55:09 -0000
Organization: OPDS
Message-ID: <C082ED21306F4D82BCF6B03D9163836B@PhilipOakley>
References: <1417732931.20814.16.camel@segulix><1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org><CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com><1417798622.23238.6.camel@segulix><xmqq1toeq79b.fsf@gitster.dls.corp.google.com><12536C063959480083CC2D4CBA0BA38E@PhilipOakley> <xmqqfvctq030.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?Q?S=E9rgio_Basto?= <sergio@serjux.com>,
	"Duy Nguyen" <pclouds@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 22:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx0pj-0007U5-VC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 22:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbaLEVyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 16:54:36 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:39731 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852AbaLEVyf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 16:54:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AugOAEUpglROl3BEPGdsb2JhbABZgwaBKoYzbMErAUeDSgQCgRgXAQEBAQEBBQEBAQE4IBuDfQYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiC7GS5AjjH2DUoMogRUFigCFRlyHGINHDotCijw/MIJDAQEB
X-IPAS-Result: AugOAEUpglROl3BEPGdsb2JhbABZgwaBKoYzbMErAUeDSgQCgRgXAQEBAQEBBQEBAQE4IBuDfQYBAQQIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiC7GS5AjjH2DUoMogRUFigCFRlyHGINHDotCijw/MIJDAQEB
X-IronPort-AV: E=Sophos;i="5.07,525,1413241200"; 
   d="scan'208";a="654208517"
Received: from host-78-151-112-68.as13285.net (HELO PhilipOakley) ([78.151.112.68])
  by out1.ip06ir2.opaltelecom.net with SMTP; 05 Dec 2014 21:54:08 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260898>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> The problem here is that there is no guidance on what those actions 
>> are
>> that may make git 'notice'....
>
> I think the guidance the users need is the one j6t has given already
> in the upthread: "If you are promising Git you are not going to
> touch a path, do not touch it.  Bad things may happen."
>
> There is no need to say "if you touched this way or that way, then
> you might get lucky." because the "lucky" part is not designed.  As
> we find more codepaths that can rely on the promise by the user, we
> may decide to take advantage of that promise even further and the
> "lucky/unlucky" equation _will_ change when that happens.
>
However the man page's statement 'When the "assume unchanged" bit is on, 
Git stops checking the working tree files for possible modifications, so 
you need to manually unset the bit to tell Git when you change the 
working tree file.' can easily be understood the way Sergio has 
described. Git stops checking so it won't notice any changes, which is a 
contract it doesn't keep.

Perhaps the man page itself needs rewording to be more firm that the 
user should NOT change the file. The contract is with the user not to 
change, rather than a contract by Git not to look.

Even with that man page change, it would not solve many of the user X-Y 
problems where what they want is an "--ignore-this" flag for a file 
which does give that alternate contract that 'git won't look until the 
flag has been cleared.

--
Philip 
