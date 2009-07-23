From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 12:48:20 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0907231244020.10001@vinegar-pot.mit.edu>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>  <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>  <20090723012207.GA9368@Pilar.aei.mpg.de>  <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:51:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU1W5-0007VT-Oq
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 18:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbZGWQse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 12:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbZGWQse
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 12:48:34 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:55177 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752213AbZGWQsd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 12:48:33 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6NGmLU4013930;
	Thu, 23 Jul 2009 12:48:21 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6NGmKPF017852;
	Thu, 23 Jul 2009 12:48:20 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123881>

On Wed, 22 Jul 2009, Linus Torvalds wrote:
> It uses the "raw" version of 'for_each_ref()' (which doesn't verify t=
hat=20
> the ref is valid), and then does the "type verification" before it st=
arts=20
> doing any gentle commit lookup.

I submitted essentially the same patch in May:
  http://article.gmane.org/gmane.comp.version-control.git/120097
with the additional optimization that we don=E2=80=99t need to lookup c=
ommits at=20
all unless we=E2=80=99re using -v, --merged, --no-merged, or --contains=
=2E  In my=20
tests, it makes `git branch` 5 times faster on an uncached linux-2.6=20
repository.

Anders
