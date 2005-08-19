From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Cannot use cg-clone over http after packing a public repo
Date: Fri, 19 Aug 2005 15:55:41 +1200
Message-ID: <46a038f905081820552df81905@mail.gmail.com>
References: <46a038f905081820353988dfdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 19 05:56:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5xyr-0001iP-FD
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 05:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVHSDzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 23:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVHSDzn
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 23:55:43 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:44123 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964791AbVHSDzm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 23:55:42 -0400
Received: by rproxy.gmail.com with SMTP id i8so435487rne
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 20:55:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p6g+tYiuVtZbwvE3qGfLHYDQZPTZTWcOWEWlQWMh8otc14ofNOoMdrf4i+mQIUGrKq2MFgXee8EA3WSTcAy4xiGDGgKPKjEFBFCT9bwjnpxpZ01it+8VZlPL26QGIQIXL3nNoWCaw8ZDuCit/JIyaMHKPY9DS/SR0slPIfLOs0M=
Received: by 10.38.75.43 with SMTP id x43mr864716rna;
        Thu, 18 Aug 2005 20:55:41 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 18 Aug 2005 20:55:41 -0700 (PDT)
To: GIT <git@vger.kernel.org>
In-Reply-To: <46a038f905081820353988dfdd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Resolved. I was missing a call to git-update-server-info. It fails to
make the objects/info directory, so that had to be done manually.

  GIT_DIR=~/public_html/repos/moodle.git git-update-server-info 
  error: cannot open
/home/martin/public_html/repos/moodle.git/objects/info/packs+

  mkdir ~/public_html/repos/moodle.git/objects/info
  GIT_DIR=~/public_html/repos/moodle.git git-update-server-info 

And all is well. I'll update the documentation to note that dumb
protocols will need this. Looking at server-info.c, there _is_ a call
to safe_create_leading_directories(), not sure why it'd fail. I'm not
much of a C jockey, really.

This is with git as of a couple of ours ago:
66e06b6a17f1074401ad23f4b2a8a146b2900333

cheers,


martin
