From: David Kastrup <dak@gnu.org>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Mon, 27 Aug 2007 07:52:53 +0200
Message-ID: <85ps19a5hm.fsf@lola.goethe.zz>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
	<7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
	<52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
	<7vsl66svv4.fsf@gitster.siamese.dyndns.org>
	<C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com>
	<7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
	<B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
	<46D23C48.6060904@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPXYc-0001vx-04
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 07:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXH0FyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 01:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbXH0FyZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 01:54:25 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:57437 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751716AbXH0FyY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 01:54:24 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 00D232CB373;
	Mon, 27 Aug 2007 07:54:23 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id E6D7328EBD3;
	Mon, 27 Aug 2007 07:54:22 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-115.pools.arcor-ip.net [84.61.38.115])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id A1C7D312761;
	Mon, 27 Aug 2007 07:54:16 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8B49D1C1E23E; Mon, 27 Aug 2007 07:52:53 +0200 (CEST)
In-Reply-To: <46D23C48.6060904@vilain.net> (Sam Vilain's message of "Mon\, 27 Aug 2007 14\:51\:52 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4069/Mon Aug 27 01:21:53 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56765>

Sam Vilain <sam@vilain.net> writes:

> Dmitry Kakurin wrote:
>>> A tree that has .gitattributes (and I am assuming in the longer
>>> term you can use "ignore" and "precious" in .gitattributes
>>> instead of using .gitignore) POINTS TO A BLOB already, so what
>>> you are saying does not add anything to what we already have,
>>> other than that you are renaming .gitattributes to "META ENTRY".
>>
>> Almost true! The difference is: META BLOBS are not created as files in
>> the workspace (not during checkout, not ever).
>> In order to edit it you'd have to use 'git meta' command.
>> So once again, there is only one place to check for metadata - the index.
>
> Can I just chime in here and express my distaste for this idea, on
> several grounds, but the summary is that svn does it this way, so it
> must be wrong.
>
> These files which store metadata would be stored in a way that is
> "in another dimension" to the project files, despite being a part of
> the history.  That means that all tools built to deal with regular
> files and directories will not be able to merge the changes to the
> attributes without special support.  I think this is broken.

That presumes that a good way to merge attributes is to use a text
file merge algorithm, complete with finding diff context lines in a
basically unchanged order.

And I don't see that this is a sensible merge strategy at all.  No
matter where the attributes are stored, whether in a file or somewhere
else, any useful merge strategy would require an algorithm quite
different from the currently used one.

Now this might be a case for pluggable merge strategies: after all,
there might be non-git related files with similar unordered per-line
merge semantics, or files expressing some information about files.

> As far as file properties goes, I still like Linus' idea of making
> these files which are accessed by treating the file as a directory
> (eg filename.txt/ACL, filename.txt/mime-type), and that approach
> could be represented in git well.

Well, at least _some_ interesting Reiser4 idea resurfaces.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
