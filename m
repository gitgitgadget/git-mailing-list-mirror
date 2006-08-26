From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem with pack
Date: Sat, 26 Aug 2006 11:20:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608261115570.11811@g5.osdl.org>
References: <44EEED9C.1010000@arces.unibo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 20:20:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH2lh-00055d-4P
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 20:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWHZSU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 14:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422993AbWHZSU0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 14:20:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422992AbWHZSUZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 14:20:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7QIKJnW004695
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 11:20:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7QIKICo028469;
	Sat, 26 Aug 2006 11:20:19 -0700
To: Sergio Callegari <scallegari@arces.unibo.it>
In-Reply-To: <44EEED9C.1010000@arces.unibo.it>
X-Spam-Status: No, hits=-0.424 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26060>



On Fri, 25 Aug 2006, Sergio Callegari wrote:
>
> If I try to verify the pack I get:
> 
> git verify-pack -v pack-ebcdfbbda07e5a3e4136aa1f499990b35685bab4.idx
> fatal: failed to read delta-pack base object 2849bd2bd8a76bbca37df2a4c8e8b990811d01a7
> 
> the package length seems reasonable, however... (no evident sign of
> truncation, but I haven't looked inside the index to check the exact positions
> of objects)...

Can you make the corrupt pack-file and index available publically (or 
perhaps at least to a few git people?)

The fact that verify-pack is happy with the SHA1 checksum is interesting, 
because it means that the pack-file at least didn't get corrupted on-disk 
(or through the sync operation). Iow, it must have gotten corrupted at 
write-out itself somehow, and it would be interesting to see what the 
pack-file looks like.

> and git unpack-object dies with error code -3 in inflate...

That's Z_DATA_ERROR, which is what you get if the input to inflate is bad.

		Linus
