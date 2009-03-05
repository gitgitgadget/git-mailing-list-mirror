From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: just curious: what influences a commit hash?
Date: Thu, 05 Mar 2009 11:38:08 +0100
Message-ID: <vpq7i3445m7.fsf@bauges.imag.fr>
References: <20090305063632.42880@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: stoecher@gmx.at
X-From: git-owner@vger.kernel.org Thu Mar 05 11:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfB4I-0002Sj-FJ
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbZCEKmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbZCEKmu
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:42:50 -0500
Received: from imag.imag.fr ([129.88.30.1]:60954 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145AbZCEKms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:42:48 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n25AcACH016811
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Mar 2009 11:38:10 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LfAxs-0008Qz-Mn; Thu, 05 Mar 2009 11:38:08 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LfAxs-0003hY-KQ; Thu, 05 Mar 2009 11:38:08 +0100
In-Reply-To: <20090305063632.42880@gmx.net> (stoecher@gmx.at's message of "Thu\, 05 Mar 2009 07\:36\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 05 Mar 2009 11:38:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112291>

stoecher@gmx.at writes:

> Hi,
>
> being new to git I did some experiments with commits looking at the hashes. What I observed:
> * The same commit (same file, same committer, same message) into
> different empty repositories (git init) gives different hashes. So I
> assume that also the time of the commit influences the hash. Is this
> intended? For what reason?

You should distinguish "commit objects" from "tree objects". You can
see the "commit" object with, for example:

$ git cat-file -p HEAD
tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
author Matthieu Moy <Matthieu.Moy@imag.fr> 1236249249 +0100
committer Matthieu Moy <Matthieu.Moy@imag.fr> 1236249249 +0100

foo

See: it contains a reference to the tree, possibly references to the
parents, and a timestamp. So, hashing it takes the timestamp into
account. A consequence of this is that you can not change the
timestamp for a commit without changing the "revision identifier"
(i.e. the hash of the commit object).

But the empty tree object is deterministically
4b825dc642cb6eb9a060e54bf8d69288fbee4904.

-- 
Matthieu
