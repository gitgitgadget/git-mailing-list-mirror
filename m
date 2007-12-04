From: bdowning@lavos.net (Brian Downing)
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 4 Dec 2007 10:18:51 -0600
Message-ID: <20071204161850.GW6212@lavos.net>
References: <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 17:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzaUo-000648-U8
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 17:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbXLDQS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 11:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbXLDQS6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 11:18:58 -0500
Received: from mxsf07.insightbb.com ([74.128.0.77]:44475 "EHLO
	mxsf07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277AbXLDQSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 11:18:55 -0500
X-IronPort-AV: E=Sophos;i="4.23,249,1194238800"; 
   d="scan'208";a="155155861"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf07.insightbb.com with ESMTP; 04 Dec 2007 11:18:53 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAO4LVUdKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.23,249,1194238800"; 
   d="scan'208";a="137907811"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 04 Dec 2007 11:18:53 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id C3708309F21; Tue,  4 Dec 2007 10:18:52 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67062>

On Fri, Nov 30, 2007 at 06:37:52PM -0800, Junio C Hamano wrote:
> * jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit
>  - Start preparing the API documents.
> 
> The primary reason of this series is because I think we made the system
> a lot less approachable by losing hackability.  Although we still have
> sample scripts in contrib/example for use of plumbing in scripts, they
> will not help aspiring git-hacker-wannabees when our primary attention
> has already shifted to moving things to C.
> 
> This currently consists of mostly stubs, although I wrote about a few
> topics as examples.

One comment on this:

+sometype *ary;
+int nr;
+int alloc
+
+for (i = 0; i < nr; i++)
+	if (you like ary[i])
+		return;
+/* you did not like any existing one, so add one */
+ALLOC_GROW(ary, nr+1, alloc);
+ary[nr++] = value you like;

Shouldn't we be encouraging the use of size_t here?  I don't know of a
64-bit platform off hand that has an 'int' that's actually 64 bits, so
encouraging this just seems like asking for 64-bit platform limitations
when arrays get over 2GB.

(Looking through the code it looks like there's a fair bit of using
'int' for array indices already, but I think it's probably best not to
perpetuate that.)

-bcd
