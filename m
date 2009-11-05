From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 5 Nov 2009 13:53:09 +0100
Message-ID: <16cee31f0911050453w67ef7186l72e22f32a8d8092d@mail.gmail.com>
References: <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
	 <1257416325-5605-1-git-send-email-ahaczewski@gmail.com>
	 <4AF2C4B9.10402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	kusmabite@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 14:01:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N61xM-0001Bh-Fb
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 14:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbZKENAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbZKENAk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 08:00:40 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:62148 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544AbZKENAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 08:00:40 -0500
Received: by ewy3 with SMTP id 3so4195014ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 05:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=7n8uRWciU3W8ow1zXzDwqMU6f9hGrnvF2m0PKD15ZoY=;
        b=Ar4XfSg3hkvYbS0pCksntfeKqpNhCAay/1cSPV4UJ0b3uF9eLlkIwdQO5gkXp6RFKN
         wqn0i2c3jla+XD3F5fTdChVw0zMnjFvg+B/I/UDeGzMB996LWK9R+dAGKm6v9/sDUB/Y
         T0OaVTbybt0NrRFh2Nn+lPr4i3lmrF4gC0IQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=io/9jFjK2TMVMhUM/nEzJ04aHYZ7fATto1NvpQgxTW7bj3Af6p3FxtsAgs/XvNXJsD
         Oxvo2nAtKQb2qcTNcrOeGK/x7gJt3+/o9MXyTA4i/DYoP4y3ikVXzYlWqKKn+2eBYohH
         Q3PxqliXipgpurQhpH2aKUY1Kb0/3+YHQxGEI=
Received: by 10.239.161.69 with SMTP id g5mr280632hbd.161.1257425589290; Thu, 
	05 Nov 2009 04:53:09 -0800 (PST)
In-Reply-To: <4AF2C4B9.10402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132226>

2009/11/5 Johannes Sixt <j.sixt@viscovery.net>:
> Elsewhere we use _beginthreadex(). What's the difference?

Oh my, I've just run through MSDN documentation and I'm wrongly using
CreateThread. I should have used _beginthread from the start, because
besides calling CreateThread it initializes local thread storage for
global C-runtime variables (errno etc.), which CreateThread does not
do. That could lead to very unpleasant consequences. I'll redo thread
creation to use _beginthreadex(). Thanks for that question!

> The pthread_cond_* functions are quite voluminous, but not performance
> critical. Could you please move them to pthread.c as well?

Ok, will do.

--
Andrzej
