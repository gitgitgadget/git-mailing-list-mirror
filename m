From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Mon, 13 Jul 2009 15:57:31 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907131555200.13838@localhost.localdomain>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>  <20090713133343.GA23946@skywalker>  <b0943d9e0907131007q18dbed72tc017be92ed23a61d@mail.gmail.com>  <20090713172017.GA29333@skywalker> <20090713174743.GB29333@skywalker>
 <b0943d9e0907131506s329bc2c2qe35180ac783a52f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karl Wiberg <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 00:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQUT1-0005ys-4K
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 00:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZGMW5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 18:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbZGMW5l
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 18:57:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59698 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752982AbZGMW5l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2009 18:57:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6DMvWa3028502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Jul 2009 15:57:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6DMvVa9013651;
	Mon, 13 Jul 2009 15:57:31 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <b0943d9e0907131506s329bc2c2qe35180ac783a52f3@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123208>



On Mon, 13 Jul 2009, Catalin Marinas wrote:
> 
>      os.environ.setdefault('PAGER', config.get('stgit.pager'))
> +    if os.environ.get('PAGER').startswith('less'):
> +        os.environ.setdefault('LESS', '-FRSX')
>      # FIXME: handle EDITOR the same way ?

That's not very smart.

First off, PAGER could easily be something like "/usr/local/bin/less".

Secondly, if it isn't less, so what? If it's not less, it won't care about 
the LESS environment variable.

So just do an unconditional

	os.environ.setdefault('LESS', '-FRSX')

and it will (a) work better, (b) be simpler and more efficient.

		Linus
