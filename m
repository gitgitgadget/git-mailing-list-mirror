From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCHv5 00/14] git notes
Date: Thu, 10 Sep 2009 10:00:18 -0400
Message-ID: <8445CEA3-AC5D-4A38-9C73-B4E14BD4864C@adacore.com>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 16:09:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlkKw-0003Mg-A4
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 16:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZIJOJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 10:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZIJOJL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 10:09:11 -0400
Received: from rock.gnat.com ([205.232.38.15]:45140 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbZIJOJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 10:09:10 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2009 10:09:10 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id B32422BABEF;
	Thu, 10 Sep 2009 10:00:19 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Z2flg-aqmVUw; Thu, 10 Sep 2009 10:00:19 -0400 (EDT)
Received: from [172.16.1.5] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 197A22BABE4;
	Thu, 10 Sep 2009 10:00:19 -0400 (EDT)
In-Reply-To: <1252376822-6138-1-git-send-email-johan@herland.net>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128111>

On Sep 7, 2009, at 22:26, Johan Herland wrote:
> Yet another iteration of the 'git notes' feature. Rebased on top of  
> 'next':
> - Patches 1-9 are unchanged from (patches 1-7, 11-12 of) the last  
> iteration.
> - Patch 10 teaches the notes code to free its data structures on  
> request.
> - Patch 11 introduces the 16-tree notes lookup code that handles  
> SHA1-based
>  fanout schemes. This is pretty much unchanged from patch 8 in the  
> previous
>  iteration.
> - Patch 12 adds selftests that verify correct parsing of notes trees  
> with
>  various SHA1-based fanouts.
> - Patch 13 introduces a flexible parser for a variety of date-based  
> and
>  SHA1-based fanout schemes. This is the interesting part, as far as  
> this
>  iteration is concerned.
> - Patch 14 adds selftests that verify correct parsing of notes trees  
> with
>  various date-based fanouts.
>
> Note that the series does not yet include code for _writing_ notes  
> into a
> suitably structured notes tree. That will be done in a later  
> iteration.
>
> I have some performance numbers that I will send in a separate email.

Hi Johan,

I've been following this series with some interest, and am curious
why notes need to be stored in a separate data structure from regular
objects. Note that I'm not questioning the design (and certainly would
not want to, this late in the process), rather I'd like to learn
about the reasons.

I've wondered about this as well in the context of refs, reflog and
git config. In a completely unified model, every change to the
repository (except  for the index, pack indices and working directory)
would be a  commit of the .git/ directory (again excluding indices).
One of the advantages (besides allowing configuration management
of the repository itself in addition to its contents) would be that
no locking is ever required.

This would be just an implementation detail without necessarily
affecting the user interface other than direct inspection/modification
of the .git directory, which is a similar to the move to packed refs.
Again, I'm not proposing to change anything, just wondering about
design rationale.

   -Geert
