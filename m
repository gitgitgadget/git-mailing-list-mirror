From: Anders Kaseorg <andersk@mit.edu>
Subject: Re: [BUG/PATCH] t9350-fast-export: Add failing test for
 symlink-to-directory
Date: Fri, 21 Aug 2015 12:47:30 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1508211238570.31851@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1508191532330.31851@buzzword-bingo.mit.edu> <20150821145827.GA565@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 18:52:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSpYZ-0005Lc-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 18:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbbHUQwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 12:52:39 -0400
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:56492 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699AbbHUQwj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 12:52:39 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2015 12:52:39 EDT
X-AuditID: 12074425-f799a6d000007db3-45-55d756244d4a
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 16.61.32179.42657D55; Fri, 21 Aug 2015 12:47:33 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id t7LGlWOw017059;
	Fri, 21 Aug 2015 12:47:32 -0400
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id t7LGlUPg026331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Aug 2015 12:47:31 -0400
In-Reply-To: <20150821145827.GA565@sigill.intra.peff.net>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixG6noqsadj3U4HS4RdeVbiaLht4rzBY/
	WnqYHZg9nvXuYfS4eEnZ4/MmuQDmKC6blNSczLLUIn27BK6MX4/ushR8Z6t4c2ouYwNjL2sX
	IyeHhICJxN3Xs9ghbDGJC/fWs3UxcnEICSxmkvi+di07hLORUeLDym4oZzeTxMGZG8BaWAS0
	JaY/vM4CYrMJqEl8OPoVbKyIgKzE98MbGUFsZgEtiT8f3jGD2MIC4RLHl95nA7E5BSwlnh78
	ygRi8wp4SCy/vwxoJgfQglKJ5rUeIGFRAV2JQ//+sEGUCEqcnPmEBWbk8unbWCYwCsxCkpqF
	JLWAkWkVo2xKbpVubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGcHi6qO5gnHBI6RCjAAej
	Eg/vjMhroUKsiWXFlbmHGCU5mJREeZ/4XA8V4kvKT6nMSCzOiC8qzUktPsQowcGsJML72RIo
	x5uSWFmVWpQPk5LmYFES5930gy9ESCA9sSQ1OzW1ILUIJivDwaEkwXs1BKhRsCg1PbUiLTOn
	BCHNxMEJMpwHaPgHkBre4oLE3OLMdIj8KUZdjgU/bq9lEmLJy89LlRLn3QdSJABSlFGaBzcH
	llZeMYoDvSXMaxcKVMUDTElwk14BLWECWhJZfhVkSUkiQkqqgbHw5Nn9N45Y93/pE14h0nz/
	2OzCewkzOTTb8la+7gngeb73W+Szvs2eqVfKayfNVJQ4MZOJTSrszffzGVV3l13d78qo+/Hb
	7RdtW5KZz0VM/+RcIWL8PjrA8s/GmSYTZe+8FXG7ePnwwdnlv5fNOfrFuGDH340i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276312>

On Fri, 21 Aug 2015, Jeff King wrote:
>   - we may still have the opposite problem with renames. That is, a
>     rename is _also_ a deletion, but will go to the end. So I would
>     expect renaming the symlink "foo" to "bar" and then adding
>     "foo/world" would end up with:
> 
>        M 100644 :3 foo/world
>        R foo bar
> 
>     (because we push renames to the end in our sort). And indeed,
>     importing that does seem to get it wrong (we end up with "bar/world"
>     and no symlink).
> 
> We can't fix the ordering in the second case without breaking the first
> case. So I'm not sure it's fixable on the fast-export end.

Hmm, renames have a more fundamental ordering problem: swapping two 
(normal) files and using fast-export -C -B results in

  R foo bar
  R bar foo

which cannot be reimported correctly without fast-import fixes.

Anders
