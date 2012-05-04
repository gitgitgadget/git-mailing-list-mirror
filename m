From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Index format v5
Date: Fri, 4 May 2012 14:25:05 +0100
Organization: OPDS
Message-ID: <2A6D903A618147EEBBFEF99234104EE6@PhilipOakley>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <trast@student.ethz.ch>, <gitster@pobox.com>,
	<mhagger@alum.mit.edu>, <peff@peff.net>, <spearce@spearce.org>,
	<davidbarr@google.com>
To: "Thomas Gummerer" <t.gummerer@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 04 15:25:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQIVY-0004VH-8W
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 15:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120Ab2EDNY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 09:24:59 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:52760 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758000Ab2EDNY5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 09:24:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgcFAE3Yo09cGnSp/2dsb2JhbABFizanKoEIggQBBAEBBQgBAS4eAQEhCwIDBQIBAw4HAQslFAEECBIGBxcGARIIAgECAwGFNweCKAgDD7EvDYlTiguBBYUaYwSIMIVKk0OFA4JpgVQ
X-IronPort-AV: E=Sophos;i="4.75,531,1330905600"; 
   d="scan'208";a="390042369"
Received: from host-92-26-116-169.as13285.net (HELO PhilipOakley) ([92.26.116.169])
  by out1.ip01ir2.opaltelecom.net with SMTP; 04 May 2012 14:24:53 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197021>

From: "Thomas Gummerer" <t.gummerer@gmail.com> Sent: Thursday, May 03, 2012 
6:25 PM
>I have been drafting the Version 5 of the index format over the past
> few days with the help of Thomas Rast, Michael Haggerty, cmn and
> barrbrain on IRC. It will save with prefix compression on the path, and
> using a crc32 over the stat data, instead of the full data, since it is 
> only
> used for checking if the file is changed. (Thanks Michael Haggerty for
> this hint. Unless we are missing something this will save another
> ~4 MB on the Webkit index.
>
>
>
> GIT index format
> ================
>
> = The git index file has the following format
>
xxx
>
> == Directory entry
>
>  Directory entries are sorted in lexicographic order by the name
>  of their path starting with the root.
>
>  Path names (variable length) relative to top level directory (without the
>    leading slash). '/' is used as path separator. '.' indicates the root
>    directory. The special patch components ".." and ".git" (without 
> quotes)
>    are disallowed. Trailing slash is also disallowed.
>

Does the prohibition of ".git" prevent the potential for versioning of the 
.git directory itself (e.g. .gitignore the pack & objects themselves)?

It should be possible for one's current repo status to be tracked and 
summarised by a single sha1, say as an indepenedent branch, as you would the 
code itself.

[my use case is in a managed environment where one has plenty of networked 
project storage, but no real availability of a network server, so anybody 
and his mate could corrupt ones network repo with badly thought through 
tweaks. The lack of a server is the root cause, but that's not something the 
project can fix, so thinks ... 'version the meta data...']

I can see that the lack of the leading "/", and the ".." are a policy 
statement about paths being relative to top level directory, with direct 
path referencing. The typical avoidance of ".git" should be a note about how 
regular git works, rather than an absolute prohibition.

Philip 
