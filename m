From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with
 EACCES
Date: Wed, 14 Dec 2011 23:06:22 +0100
Message-ID: <op.v6h2cwuw0aolir@keputer.lokaal>
References: <op.v5e8mgbc0aolir@keputer>
 <1323788917-4141-1-git-send-email-fransklaver@gmail.com>
 <1323788917-4141-2-git-send-email-fransklaver@gmail.com>
 <7vliqguwhq.fsf@alter.siamese.dyndns.org>
 <CAH6sp9Mf=EjkVN9mDN59ZCxCU0sCFLa8E=7YxM1J8LCCMr=xYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	"Frans Klaver" <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 23:06:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RawyT-00018U-4X
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 23:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244Ab1LNWGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 17:06:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64991 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758243Ab1LNWG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 17:06:27 -0500
Received: by eekc4 with SMTP id c4so1346978eek.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=Yg8SCX29ovIotvjtJPsuCSraLg/EQx0KJNLFOwYcCJg=;
        b=xaFkGYCmfNfaJPc4IbrZ528S8uZ6QfgehGdZAlBqvAeiCYfrUayOqpb7jj5OyMlL2L
         PXtHn+a1C7pCY7cLlJgftX0kuHUGLewSrnlv8du2LJf+jGDmSj1YcwMWl6v0HnS505TR
         pywKcdcLi0ckHj6FugsdWPhGF64lR0LSYReQo=
Received: by 10.213.14.66 with SMTP id f2mr1068961eba.125.1323900385786;
        Wed, 14 Dec 2011 14:06:25 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id z54sm15467325eeh.5.2011.12.14.14.06.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 14:06:24 -0800 (PST)
In-Reply-To: <CAH6sp9Mf=EjkVN9mDN59ZCxCU0sCFLa8E=7YxM1J8LCCMr=xYQ@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187172>

On Wed, 14 Dec 2011 15:31:25 +0100, Frans Klaver <fransklaver@gmail.com>  
wrote:

> Since fopen() uses the effective uid/gid, it then makes sense to use
> eaccess(3) instead of access(2) if available. It would be stupid to
> have bugs arise just because of a mismatch between the [ug]ids used by
> the two access checks. I'm aware of the fact that eaccess isn't a
> standard function, so a #define HAVE... fallback to at least access()
> would probably be required.

Just to be clear, I don't really want to restart the discussion of which  
uid to use, but it is something to consider now or in the future. The next  
roll will use access(2) as far as I'm concerned.
