From: Simon Braunschmidt <sb@emlix.com>
Subject: tracking branch on a tag
Date: Thu, 23 Apr 2009 11:52:52 +0200
Organization: emlix gmbh, Goettingen, Germany
Message-ID: <49F03A74.5080805@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 12:00:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvdW-00068s-4z
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbZDWJw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbZDWJw4
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:52:56 -0400
Received: from mx1.emlix.com ([193.175.82.87]:46531 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbZDWJwz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:52:55 -0400
Received: from gate.emlix.com ([193.175.27.217]:44908 helo=mailer.emlix.com)
	by mx1.emlix.com with esmtp (Exim 4.63)
	(envelope-from <sb@emlix.com>)
	id 1Lwvbx-0002kL-VR
	for git@vger.kernel.org; Thu, 23 Apr 2009 11:52:54 +0200
Received: by mailer.emlix.com
	id 1Lwvby-0003Eg-S8; Thu, 23 Apr 2009 11:52:54 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117326>

Hi

So i set up a tracking branch on an annotated signed tag like:


$git branch --track foobranch v2.6.26
 >Branch foobranch set up to track local ref refs/tags/v2.6.26.

Check it out, get an error

$git checkout foobranch
 >Switched to branch 'foobranch'
 >error: Object 14650d6ec137e70b6c1918cdef235027c5156020 is a commit, 
not a tag
 >fatal: Invalid symmetric difference expression 
bce7f793daec3e65ec5c5705d2457b81fe7b5725...14650d6ec137e70b6c1918cdef235027c5156020

Inspect the relevant object

$git-cat-file -p bce7f793daec3e65ec5c5705d2457b81fe7b5725
 >tree 05bc81f9b27a1ab60ea4e506357f0c7f2ece4eda
 >parent ec229e830060091b9be63c8f873c1b2407a82821
 >author Linus Torvalds <torvalds@linux-foundation.org> 1215985889 -0700
 >committer Linus Torvalds <torvalds@linux-foundation.org> 1215985889 -0700

 >Linux 2.6.26

$git-cat-file -p 14650d6ec137e70b6c1918cdef235027c5156020
 >object bce7f793daec3e65ec5c5705d2457b81fe7b5725
 >type commit
 >tag v2.6.26
 >tagger Linus Torvalds <torvalds@linux-foundation.org> Sun Jul 13 
 >14:51:38 2008 -0700
 >
 >Linux 2.6.26
 >-----BEGIN PGP SIGNATURE-----
 >Version: GnuPG v1.4.9 (GNU/Linux)
 >
 >iEYEABECAAYFAkh6ePIACgkQF3YsRnbiHLuJcACgpHzd21qAY25V2VQWBCYPW8bB
 >Z8MAoJ9qfiwuRt27cdrmAU2aJq+YFrYs
 >=aHK8
 >-----END PGP SIGNATURE-----

I get this errors only on annotated/signed tags, not on lightweight 
tags. Admittedly it doesnt make much sense to track a tag, yet this 
error message makes even less sense:

error: Object 14650d6ec137e70b6c1918cdef235027c5156020 is a commit, not 
a tag

with 14650d being a tag.

Is this error message serious, as fatal sound quite harsh? Can it be 
avoided, by guiding the user on  branch creation or by simply not 
showing it in this situation?

Gruessle
Simon
