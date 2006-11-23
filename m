X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x proxying
Date: Fri, 24 Nov 2006 12:52:13 +1300
Message-ID: <46a038f90611231552x3e33eec4w7863ce6a1da5781b@mail.gmail.com>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
	 <7v64d5keke.fsf@assigned-by-dhcp.cox.net>
	 <45661C36.9010101@catalyst.net.nz>
	 <7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:52:21 +0000 (UTC)
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Igqzd3CDpAsfyLBOQWTNh1At2syBe8XaTbIKbATA5g50EprSWQCE1H6kIN7g4kpHkgRf+s7JBTd0HJvozzHQKqCq+Mv4OKZjHWDlAW+nTaXX1RNvmOL+W1FX2deTvK2E6z5aaRpq7kMbzcTqMYIiKBd0+VrNLo4c+3bE8iF7HZc=
In-Reply-To: <7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32180>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnOMc-0006X3-I6 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757508AbWKWXwP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757509AbWKWXwP
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:52:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:6475 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1757508AbWKWXwP
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:52:15 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1039455nfa for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 15:52:13 -0800 (PST)
Received: by 10.49.92.18 with SMTP id u18mr4772769nfl.1164325933669; Thu, 23
 Nov 2006 15:52:13 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Thu, 23 Nov 2006 15:52:13 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/24/06, Junio C Hamano <junkio@cox.net> wrote:
> It is more about HTTP proxying and it is my understanding that
> response to CONNECT method request has that empty line after the
> successful (2xx) response line and zero or more response
> headers.  The code is still wrong; it does not have a loop to
> discard the potential response headers that come before the
> empty line the code we are discussing discards.

You are right. It should be something along the lines of

  # discard headers until first blank line
  while (<$s> ne '') {
      # nothing
  }

that is, assuming we can just ignore headers happily.

cheers,



