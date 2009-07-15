From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] shortlog: add '--sort-key' and '--sort-key-regexp'
 options
Date: Wed, 15 Jul 2009 08:11:57 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907150807401.13838@localhost.localdomain>
References: <alpine.LFD.2.01.0907141852400.13838@localhost.localdomain> <7v8wiqfj60.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907151316320.4410@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 15 17:12:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR69w-0001g5-Rr
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 17:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbZGOPMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 11:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755228AbZGOPMb
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 11:12:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48201 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755198AbZGOPMb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 11:12:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6FFBvTg014865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Jul 2009 08:11:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6FFBvWM010488;
	Wed, 15 Jul 2009 08:11:57 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0907151316320.4410@intel-tinevez-2-302>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.967 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123320>



On Wed, 15 Jul 2009, Johannes Schindelin wrote:
> 
> Instead of always sorting by author, allow to sort by either
> a whitespace-delimited field or by a regular expression (first group)
> on the oneline.

Ok, I got a SIGSEGV on the regexp, because I didn't react to the "first 
group" part. So I did

	git shortlog --pretty=%cD --sort-key-regex ' [0-9]*:' -ns

and it immediately segfaulted for me.

I realize that I _should_ have done

	git shortlog --pretty=%cD --sort-key-regex ' \([0-9]*\):' -ns

and then I get the expected hourly statistics, but it shouldn't have 
SIGSEGV'd either.

But cool small patch-series. This was exactly what I was looking for.

		Linus
