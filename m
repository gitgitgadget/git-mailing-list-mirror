From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] Add extra logic required to detect endianness on Solaris
Date: Fri, 2 May 2014 08:49:17 +0100
Message-ID: <20140502074917.GA25198@hashpling.org>
References: <1398930197-12851-1-git-send-email-cbailey32@bloomberg.net>
 <xmqqa9b1coml.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 09:49:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg8Dk-0002J5-PP
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 09:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbaEBHtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 03:49:20 -0400
Received: from avasout05.plus.net ([84.93.230.250]:49189 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaEBHtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 03:49:20 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id wvpF1n0062iA9hg01vpG6h; Fri, 02 May 2014 08:49:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=WIHxXxcR c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=VVbyae50lWsA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=t6vHy8rRs7sRERAV4agA:9
 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1Wg8Dd-0006bO-Aa; Fri, 02 May 2014 08:49:17 +0100
Content-Disposition: inline
In-Reply-To: <xmqqa9b1coml.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247928>

On Thu, May 01, 2014 at 11:58:26AM -0700, Junio C Hamano wrote:
> 
> This patch seems to address two unrelated issues in that.
> 
>  (1) The existing support does not help a platform where the
>      convention is to define either _BIG_ENDIAN (with one leading
>      underscore) or _LITTLE_ENDIAN and not both, which is Solaris
>      but there may be others.
> 
>  (2) There may be __LITTLE_ENDIAN and __BIG_ENDIAN macros already
>      defined on the platform.  Or these may not have been defined at
>      all.  You avoid unconditionally redefing these.
> 
> I find the latter iffy.

Yes, you are right. I think I was uncomfortable defining macros with
names reserved for the implementation even if the implementation didn't
seem to be using them. I think I made my patch less correct as a result.
Looking at the rest of the git source code we don't seem to use any of
these macros anywhere else so perhaps we could use macros specific to
GIT?

Let me follow up with an alternative patch.

Charles.
