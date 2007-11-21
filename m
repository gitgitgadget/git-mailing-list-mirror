From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Wed, 21 Nov 2007 19:55:22 +0800
Message-ID: <46dff0320711210355icdbf634l258cf39c1582e8d4@mail.gmail.com>
References: <1195503174-29387-1-git-send-email-pkufranky@gmail.com>
	 <474308A5.8070301@viscovery.net>
	 <46dff0320711201838g5affba6bo21a8c837b0bef681@mail.gmail.com>
	 <7vmyt8gdzv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 12:55:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuoBD-0006gf-W8
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 12:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbXKULzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 06:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbXKULzZ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 06:55:25 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:24624 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbXKULzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 06:55:24 -0500
Received: by py-out-1112.google.com with SMTP id u77so7138260pyb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 03:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U5scp3TRj/JCCakVFnYw3UETuJmciAtsrhC+ErxNK3g=;
        b=XbzTPZwqRsMYiyqa8/sV52z1TyEsXLBsv5aZeNviSJ+adeoApSDT6yBI8XRs4JEP4LjOApyOhX/pIjb8KJKTI/JDTawa1pPsE2RiXrGfiUCNO3e56D3zbb9bHdR+zqkB3TcN2MXZfe6jWPoHpbhAkS94Fk5LuW86KvKYdZViXnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nI91mstcN3Ailg0XigiCHupvq+PYJ0sUo83zoFoXwoSPkuU/MFvMWB/OfgkXHJM+JwNpGJXsX9vAtRzmncM5f2SVLAZO0lR2YQjH5+iYlwrPWxD/TnlNoIVnqoXfWAA3WqMPwo89LCYZRnz/2Mo+s0V8c5Mi4r6dReBtYnHy8v8=
Received: by 10.35.110.13 with SMTP id n13mr8911360pym.1195646122991;
        Wed, 21 Nov 2007 03:55:22 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Wed, 21 Nov 2007 03:55:22 -0800 (PST)
In-Reply-To: <7vmyt8gdzv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65633>

On Nov 21, 2007 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:

> But I think an API definition that says "These fds are closed
> after the call, so if you are going to use them, you can dup()
> them beforehand" is equally valid, and I suspect that forgetting
> to dup() is easier to detect than forgetting to close() --- you
> will notice the former mistake immediately because your read and
> write say "oops, nobody on the other end" but the latter mistake
> will result in a hung process.  And for that reason, I think it
> can be called more "graceful".  So ...
>
I don't konw the original API definition and havn't found any API
deinition that clarifies the fds will be closed after start_command.
However, when i see child_process.close_in/close_out, i thought
start_command will not close the fds.

I never said that start_command must not close fd. At least this
behaviour of start_command makes child_process.close_in/close_out no
sense.
>
>



-- 
Ping Yin
