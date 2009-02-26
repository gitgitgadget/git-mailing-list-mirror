From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 17:51:21 -0600
Message-ID: <wRrDhWKagbvPUgIXKKh8JIhASl974j2rrgyuh-WEzRJFcXywywNupg@cipher.nrlssc.navy.mil>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com> <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org> <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com> <7vmyc8rhry.fsf@gitster.siamese.dyndns.org> <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com> <7veixkrfif.fsf@gitster.siamese.dyndns.org> <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com> <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:53:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcq2a-0000QN-5r
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZBZXva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZBZXva
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:51:30 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43831 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZBZXv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:51:29 -0500
Received: by mail.nrlssc.navy.mil id n1QNpMhW019217; Thu, 26 Feb 2009 17:51:22 -0600
In-Reply-To: <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 26 Feb 2009 23:51:22.0255 (UTC) FILETIME=[209961F0:01C9986D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111616>

Junio C Hamano wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
> 
>> On Thu, Feb 26, 2009 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I don't mind Perl as we already depend on it; the looseness of the regexp
>>> stil bothers me somewhat, though...
>> I think you're letting the perfect be the enemy of the good. The point
>> of the test is merely to check for the SHA-1 has suffix in PUT/MOVE
>> operations. Any of my suggestions so far are better than what is there
>> now. Why so much fuss?
>>
>> I'll send one more iteration, and if that's not good enough, I give up.
>>
>> j.
> 
> Heh, at least with /a-z/a-f/, I think it is usable.

Two minor style issues can also be fixed.

I think the file name can be specified as an argument to sed rather than using
the shell's redirection mechanism.

   sed -e 'script' input-file

rather than

   sed -e 'script' < input-file

I think /that/, and moving the pipe character to the end of the sed line so that
you don't need to escape the newline will conform to git scripting style so it
becomes:

   sed -e "s/PUT/OP/" -e "s/MOVE/OP/" "$HTTPD_ROOT_PATH"/access.log |
     grep "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9]"

-brandon
