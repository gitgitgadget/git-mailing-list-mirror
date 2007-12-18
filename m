From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Tue, 18 Dec 2007 10:30:55 +0100
Message-ID: <4767934F.7070706@op5.se>
References: <20071217192306.5da48540@pc09.procura.nl> <7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YnM-0000NW-H6
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXLRJbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbXLRJa7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:30:59 -0500
Received: from mail.op5.se ([193.201.96.20]:56108 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbXLRJa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:30:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A5ACE1F0803F;
	Tue, 18 Dec 2007 10:30:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zG346PHignKO; Tue, 18 Dec 2007 10:30:56 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5EA3C1F08025;
	Tue, 18 Dec 2007 10:30:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68718>

Junio C Hamano wrote:
> 
> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test macros
> are for the application to define, and for the implementation (iow, the
> header files) to find out what set of names the application wants to
> see.  You are making the application examine the symbol to see what
> implementation it is on, which feels backwards to me.


  #if defined(hpux) || defined(_hpux) || defined(__hpux)

should work ok, although as you say, trying

  #if _POSIX_VERSION < 200112
  # include <non-POSIX.1-2001 headers>
  #else
  # include <sys/select.h>
  #endif

would probably be more suitable.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
