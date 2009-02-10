From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Wed, 11 Feb 2009 00:58:06 +0100
Message-ID: <a1b6cb1b0902101558s7df025c7hfe078638452413c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Geoffrey Lee <geoffreyj.lee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 00:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2Vt-0007eT-Dy
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbZBJX6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbZBJX6L
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:58:11 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41495 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbZBJX6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:58:10 -0500
Received: by fxm13 with SMTP id 13so402078fxm.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 15:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=zawjeQzPPl1n4q1FOMHdaV4oN4nlxoXnD2wVjioXfoY=;
        b=MnoZdMljQpIOv1MdVLxGUhU512XYpF0znazFASIF1EgaWpe1sC+5kJ6VKoUqSBaPWO
         jRUh185P30OQ0w4tuqi3k6C61mm4xegCRl37Ek9vLUSsYaB/AboKGMGl4V7xNa0kuF4W
         ajSANwWKAccmXj6knEx8Dhs6oRX+WYLWsJFnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=n+xP0trOirXIi6ejLaXMELmGgnguu3ow6zH6lHZtxnAl5bpuBJCX7Q5YXo7xsmpTdR
         tWUXXlTIcHtrbyXFwSUwzeXQBXo0FysnZPnRWxR9Kw70d8CNvCqCxBZjIK0MBbZnzAxN
         45D/fAcOGA4hACprDYAN2HOo/jnLnmxwSGF0w=
Received: by 10.180.250.7 with SMTP id x7mr100685bkh.175.1234310286857; Tue, 
	10 Feb 2009 15:58:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109355>

> On Tue, Feb 10, 2009 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> > How is it different from "git stash create"?
>
> Git stash doesn't touch untracked files, whereas git snapshot would.
> Take another closer look at the table in the original post titled
> "What are the differences between 'git stash' and 'git snapshot'?"
>
> -Geoffrey Lee

I'm understanding this just as I read this, but it seems that implementing a
git snapshot (I'm myself interested), could be done quickly with a new git.
(When was git stash create introduced? I don't know it?)

Something like this:
cp .git/index .git/tmp-index
GIT_INDEX_FILE=.git/tmp-index
git add -N .
git stash create

So we use add -N to put all files into tracked but unstaged by default, but we
keep our old index. Now stash is ready to save off the working directory, and
further logic has to be applied on the returned commit to save it off..


Ulrik Sverdrup
