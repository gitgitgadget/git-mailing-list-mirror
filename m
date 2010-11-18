From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] A loose object is not corrupt if it cannot be read
 due to EMFILE
Date: Thu, 18 Nov 2010 11:29:20 -0600
Message-ID: <20101118172920.GC16610@burratino>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com>
 <1288299210-27092-2-git-send-email-gitster@pobox.com>
 <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
 <4CE55794.7050201@viscovery.net>
 <AANLkTikns0Rm5znC7FOa72qZXKpQzazKiYsPe-oDNMAk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:30:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8JM-0008U2-3o
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641Ab0KRRaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:30:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54019 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515Ab0KRRaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:30:06 -0500
Received: by fxm10 with SMTP id 10so140963fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aJuhWw+kXDXFeNywJrkWEL4n7ZI5cIJiakcuEZZGPno=;
        b=n4XxWkluZBPCGPrpbXIdt0YXB5PJLzpw0WsEZYOxnLnh9GNLj7TIooLcmSuPZOyp/w
         8Lok6bC17vaI6NJvKfYbKnq7z07SH57TcGz/2iKLR3ueUm7MZRhiZGDvwe0uBx3rx5oc
         7XqvAHUC4nGtjkHpI/WIgpY0rCRyoUyR6I9kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LJMxBImFgq10Y/DLgbV1a9VIftL5o5Zek8Yb2TrAcpDzr0S+7VmDRGOGq7V2Jo3DjW
         IXzTsqk5CeRrgMKebmJ68z0/LLtvh7udfuIV2vjFw0dNNEgenpyVVdudfxzH5jz/Qbp5
         QDcbXmKalZ4qlwj6oEPNy4PvsDiq/DrWBpc74=
Received: by 10.223.126.68 with SMTP id b4mr844255fas.55.1290101405658;
        Thu, 18 Nov 2010 09:30:05 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id f5sm221592fai.46.2010.11.18.09.30.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 09:30:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikns0Rm5znC7FOa72qZXKpQzazKiYsPe-oDNMAk@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161690>

Erik Faye-Lund wrote:

> I was wondering about the same thing, I don't think this approach is
> very easy to follow. But either way I think we should make sure
> opendir/closedir/readdir doesn't mess with errno.

Other platforms and are allowed to (and do) clobber errno in many
non-error situations, so the main effect would be to work around/hide
some git bugs.

For mingw-runtime, the balance might be different.  Making buggy,
non-portable application code easier to port does not sound like a bad
thing.

Just my two cents,
Jonathan
