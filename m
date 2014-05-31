From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 2/2] connect.c: replace signal() with sigaction()
Date: Sat, 31 May 2014 07:45:16 -0700
Message-ID: <20140531144516.GA22508@hudson.localdomain>
References: <cover.1401482787.git.jmmahler@gmail.com>
 <1d11d5da7ebc3a6e0d4ab64802b601526c19113c.1401482787.git.jmmahler@gmail.com>
 <5389B16B.6070004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 16:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqkXH-0006Gt-88
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 16:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbaEaOpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 10:45:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:63823 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbaEaOpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 10:45:22 -0400
Received: by mail-pa0-f53.google.com with SMTP id lj1so1641144pab.40
        for <git@vger.kernel.org>; Sat, 31 May 2014 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wnOFOC6dWZODz1JkRxHWNO84CdiajU2+MW26Sr6zQbU=;
        b=kfRWPvp8Cvl1MkmmdVvXcVpUdwErBU9Tg0sRxwaCX8iJE47LJ5gJQmH8o4zfZM/14/
         N87oMsT1k/eZ/2PLOsMWhOz/+PzuFGo+/KQ2ndr8Ee0ZWpx7wWItyD8KtO5Yr8CEkSNI
         NuTZJHPkVqNo5H975G04qBZXcNd0CyH607PdYLOqIHhm96t38UpuqYbAaeGO7rm2BiRf
         wLVkCuSNGZ0ShH9w1lzLfrcWLHPETCFKfh4nBPXjUk3oqNndognHwlw4QBtQRkxAnMoG
         x5shnxH9ZuKqVAQkh1ypQSga1kdhkpEDp+KtZCYYCjw36KJCOKRnAJfIGbzn8diH+ogX
         16FQ==
X-Received: by 10.66.66.225 with SMTP id i1mr27400051pat.0.1401547521499;
        Sat, 31 May 2014 07:45:21 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id se3sm11635883pbb.80.2014.05.31.07.45.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 31 May 2014 07:45:20 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 31 May 2014 07:45:17 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5389B16B.6070004@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250509>

Chris,

On Sat, May 31, 2014 at 10:39:39PM +1200, Chris Packham wrote:
> On 31/05/14 08:58, Jeremiah Mahler wrote:
> > From signal(2) man page:
> > 
...
> > -	signal(SIGCHLD, SIG_DFL);
> > +	memset(&sa, 0, sizeof(sa));
> > +	sa.sa_handler = SIG_DFL;
> > +	sigaction(SIGCHLD, &sa, 0);
> 
> I think this got lost in the wash with v1 but
> Documentation/CodingGuidelines says to use NULL here instead of 0.
> 
Got it.  Will be in to the next revision.

  sigaction(SIGCHLD, &sa, NULL);

Thanks,
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
