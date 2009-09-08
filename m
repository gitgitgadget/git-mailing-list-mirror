From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: Re: [PATCH] git-rebase-interactive: avoid breaking when
	GREP_OPTIONS="-H"
Date: Tue, 8 Sep 2009 06:47:56 +0000
Message-ID: <20090908064756.GA14155@sajinet.com.pe>
References: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe> <7v7hwar1fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkuUm-0007VY-DK
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZIHGry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 02:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbZIHGrx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:47:53 -0400
Received: from sajino.sajinet.com.pe ([76.74.239.193]:42740 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbZIHGrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:47:53 -0400
Received: by sajino.sajinet.com.pe (Postfix, from userid 1000)
	id 73DD2A5820C; Tue,  8 Sep 2009 06:47:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v7hwar1fp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127975>

On Mon, Sep 07, 2009 at 12:37:30PM -0700, Junio C Hamano wrote:
> 
> How does your patch help when the user has GREP_OPTIONS=-C3 in the
> environment?

It wouldn't help but at least wouldn't break aborting with an script
error since you will always get a number.

> I think a saner workaround for this user environment bug (or GNU grep
> misfeature) is to unset GREP_OPTIONS at the beginning of the script, or
> even in git-sh-setup.

agree, and since grep is used almost everywhere filtering in git-sh-setup
like CDPATH is makes sense, with the only user of grep that wouldn't
benefit from that being git-mergetool--lib.sh AFAIK.

will test and submit a fix for that later, but still think the original
patch at least improves the status quo (will protect also when using
custom grep wrappers as reported earlier) and doesn't do any harm as wc
is already a dependency as well and was part of the original code as well.

Carlo
