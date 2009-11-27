From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/2] Lazily generate header dependencies
Date: Fri, 27 Nov 2009 11:45:58 -0600
Message-ID: <20091127174558.GA3461@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 18:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE4hj-0006wB-Jz
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 18:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZK0Rds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 12:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZK0Rds
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 12:33:48 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:64387 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZK0Rdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 12:33:47 -0500
Received: by ywh12 with SMTP id 12so1845987ywh.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WJkHlc8FeNl4ieStWR4/+mOCtcOhNn/hOAmhXbG2Hd8=;
        b=GAeWm9Y6dLr2VdYZs+HrGyLpb+MXSb8qQhYAncVUHl2TbaVATTBCPFeHyJVaAkg1a/
         V6BthwSrT0ZkIWAi7/iQKs7aQdlz45B0Yj544q6ltIsSgIL7XlyDQb29bT1SIQVCAXgd
         wC5lkNAIK0EUcC1dzSEYN1yFSmbL+nsAxnjx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=g4DI4B10G8qAu5T6v9dUrpXn62ax0lMbRs7Ikdl+CE3iG1ZpiLOoMXwX/GnMcIUqow
         Ka7mQt6/EaXtCPfR6+3ikr7KWOGfA61zRRiB/YPIr5vX2lTizVhyu4W7l+Y+3rRp4nKB
         YyG2L5u6K5cReKGDeyP++YaKtU26UV6XopAFM=
Received: by 10.101.129.1 with SMTP id g1mr594763ann.124.1259343233596;
        Fri, 27 Nov 2009 09:33:53 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 5sm898738yxg.46.2009.11.27.09.33.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 09:33:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133911>

Johannes Schindelin wrote:

> Funny; I thought that not all header files are library header files, i.e. 
> not all header changes should trigger a full new build of libgit.a.

Maybe something like this could help?

Jonathan Nieder (2):
  Makefile: use target-specific variable to pass flags to cc
  Makefile: automatically track header dependencies

 .gitignore |    1 +
 Makefile   |   46 +++++++++++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 17 deletions(-)
