From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Thu, 17 Dec 2009 10:35:47 +0100
Message-ID: <20091217093547.GA25451@pcpool00.mathematik.uni-freiburg.de>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de> <4B29106C.1040501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 10:35:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLCm4-0007Dm-Bh
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 10:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbZLQJfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 04:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764214AbZLQJfu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 04:35:50 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:46406
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764208AbZLQJfs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 04:35:48 -0500
Received: from pcpool10.mathematik.uni-freiburg.de ([132.230.30.160])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLClv-0006tR-Ek; Thu, 17 Dec 2009 10:35:47 +0100
Received: from brl by pcpool10.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLClv-0006gF-D6; Thu, 17 Dec 2009 10:35:47 +0100
Mail-Followup-To: git@vger.kernel.org, j.sixt@viscovery.net
Content-Disposition: inline
In-Reply-To: <4B29106C.1040501@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135362>

* Johannes Sixt <j.sixt@viscovery.net> [091216 17:53]:
> Bernhard R. Link schrieb:
> > --prune-tree makes rev-list without paths equivalent to
> > "git rev-list $options -- ." (or .. or ../.. and so on,
> > if you are in some subdirectory).
> > This is the new default for format-patch and rebase
>
> Why do you need a new option when you can just add "-- ." to the rev-list
> invocation?

I want the default for format-patch changed.

For this I think it is easiest to add a new rev_info flag, as otherwise
format-patch would need to duplicate parsing the rev_list options
and either duplicate applying revs->prune_data or changing the argv for
setup_revisions with some special casing of bare repository and non-bare
repository cases.

And if there is that rev_info flag I think it is most logical to make
it accessible from the outside.

That also allows to revert to the old format-patch behaviour,
in case someone uses format-patch not to get some appliable patches but
some differently formated log or for something else I cannot imagine.

And when there is that option, I think it is more robust to use that
in merge -m and merge -i, as "-- ." only does the right thing by chance
because both only work with a non-bare repository and have
cd_to_toplevel.

Hochachtungsvoll,
	Bernhard R. Link
-- 
Please do not CC me if git@vger.kernel.org also gets a copy.
