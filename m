X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: Fix req_update to handle packed refs
Date: Fri, 5 Oct 2007 09:43:55 +1300
Message-ID: <46a038f90710041343g5b6a5a30gcd0c9f18d265fa28@mail.gmail.com>
References: <1191525680-10481-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 4 Oct 2007 20:44:27 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Frank Lichtenheld" <frank@lichtenheld.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Tcr9c94AT+0hYcQyDQ9yan36O5I1CC6+JIjvLouPwAk=;
        b=Tv6Lae4WaLN6QJBn1+DbwrvDMRf2yxFaSZ2K8YdPbOr0aCnzs5FYqmwfIIWXXcXugaCjkmyX8yKcs0SKrnoq6ofzk5j2QDI/ecFqX4Xk8p0hI3M3oZlQaNujxVKg1PWxGJS4k7duxdTKnv7ORrbyhZAETVZF8xCbaNHf4K5n//0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mn67kAU65Hm1BUktZ0wF9qp874F3CzS7WYpQEpILsLWUcYb7JRofMYWr0pad87BSy0xhxfGfCUb2gv9uuUb6YL7btbj68ncfgn2YrkVJ4imAuCuu+7CvJ/aPiL7MSoTBY5Q4HKT1lacdLva7CUtT/TlXpoUJeVL73K/VtIoX0ps=
In-Reply-To: <1191525680-10481-1-git-send-email-frank@lichtenheld.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1IdXYF-0007s6-Kz for gcvg-git-2@gmane.org; Thu, 04 Oct 2007
 22:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757579AbXJDUn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007
 16:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757571AbXJDUn6
 (ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 16:43:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:17157 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1757557AbXJDUn5 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 Oct
 2007 16:43:57 -0400
Received: by ug-out-1314.google.com with SMTP id z38so410489ugc for
 <git@vger.kernel.org>; Thu, 04 Oct 2007 13:43:55 -0700 (PDT)
Received: by 10.67.19.17 with SMTP id w17mr2466534ugi.1191530635381; Thu, 04
 Oct 2007 13:43:55 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Thu, 4 Oct 2007 13:43:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org

On 10/5/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> cvsserver returns a list of existing modules on command
> 'update' without a module specified (apparently this is
> used by some clients to get a list of available modules,
> the CVS cli client doesn't support it).
>
> Fix this code to work correctly in presence of packed refs.
> (Use git-branch instead of reading refs/heads/)

ACK - good stuff - thanks!

There is one minor issue around this I suspect - refs with slashes in
them. Without this patch, only refs that literally sit in refs/heads
will be returned. With git branches, you could see oldbranches/foo
being returned to the client.

IIRC - the behaviour cvsserver supports here is completely
unspecified, and clients will probably error out in weird and wacky
ways. I'd perhaps filter out any headref with a slash.

cheers,


martin



