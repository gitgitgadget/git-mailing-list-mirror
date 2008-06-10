From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 16:03:46 -0400
Message-ID: <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <m3abhtp42o.fsf@localhost.localdomain>
	 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:05:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6A5D-00087t-Ir
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 22:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYFJUDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 16:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYFJUDu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 16:03:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44056 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbYFJUDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 16:03:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1898791fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zDbGJf/mTf9+lXW7pW/0UErXHzOxdwdPcJo5zlhdUFA=;
        b=aDpeoHbjpuhdtyl10LTY9UHPne4NxdOlRAtuPbt7nGrQURb7LWwhIjKKenGNHoT9Ce
         zq5wpoQt4Gr623Kv+AceJdrJzWzFJocT0XO5HwNahQfPobA/9e0IW/c5pii02vmI5s4U
         3ZZPSsqCF/F433FwOKRAnGVB8ZDgbfcY2d0/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vJXFW+IPvyDW7X/z5E3VMOemybM2SWme2a4/SJR0UXLbgCtFhBi8Qa84zSUI0HaJU/
         feChkNW5hi7u3uCu7HeBsB0/DDlwolBTx2AmeJYVXRC7Ss3Zg+7xifz13wCcJpP1nIJf
         vN7Ggu4APoNNc8cBrBY5NMhVd9ZqmpCwW2Hds=
Received: by 10.86.87.13 with SMTP id k13mr6227584fgb.1.1213128226133;
        Tue, 10 Jun 2008 13:03:46 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 13:03:46 -0700 (PDT)
In-Reply-To: <200806102159.02875.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84541>

On Tue, Jun 10, 2008 at 15:59, Jakub Narebski <jnareb@gmail.com> wrote:
>> Shouldn't these be unreferenced now that I've run filter-branch?
>
> Try to clone this repository (using file:/// pseudo-protocol to force
> transfer of objects instead of hardlinking them), and chek if the
> problem persists in the clone too.  If not, error/missing might be
> in "garbage".
>
> But I'm not sure...

You're onto something:

[dorothy.local /tmp <Tue Jun 10> <16:02:08>]
tmp[176] > git clone file:///Volumes/work/identity.fb/
Initialized empty Git repository in /tmp/identity.fb/.git/
remote: Counting objects: 401, done.
remote: Compressing objects: 100% (364/364), done.
remote: Total 401 (delta 170), reused 0 (delta 0)
Receiving objects: 100% (401/401), 233.76 KiB, done.
Resolving deltas: 100% (170/170), done.

[dorothy.local /tmp <Tue Jun 10> <16:02:22>]
tmp[177] > cd identity.fb/
/tmp/identity.fb

[dorothy.local /tmp/identity.fb <Tue Jun 10> <16:02:24>]
identity.fb[178] > git fsck --full
broken link from  commit 4737fea59fdc8325e09b5206cc7a6ac593446ce3
              to  commit fe431b4b69453ad9207a5528cf9b9d12ef69c988
dangling commit 28aa69aafc8ae901e588f6d341b3e6d3558c6d26
dangling commit 884a8024fbcb9367726abb25f8bb6ac539712d46
missing commit fe431b4b69453ad9207a5528cf9b9d12ef69c988

But I've just substituted one error for another.  Are these errors
easier to fix?


-- 
                              Denis
