From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v3 3/3] Don't expand CRLFs when normalizing text during
	merge
Date: Fri, 25 Jun 2010 10:00:43 +0200
Message-ID: <20100625080043.GB4734@pvv.org>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com> <90f38b5f5c49f9b9f5427a026e51f867a1121982.1277408598.git.eyvind.bernhardsen@gmail.com> <4C244278.10407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 25 10:01:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS3qM-0007Pr-1p
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 10:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab0FYIAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 04:00:52 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:58421 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0FYIAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 04:00:52 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OS3q8-0005oH-0R; Fri, 25 Jun 2010 10:00:44 +0200
Content-Disposition: inline
In-Reply-To: <4C244278.10407@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149670>

On Fri, Jun 25, 2010 at 07:45:28AM +0200, Johannes Sixt wrote:
> Am 6/24/2010 22:44, schrieb Eyvind Bernhardsen:
> > There's no need to expand CRLFs when convert_to_working_tree() is called
> > to normalize text for a merge since the text will be converted back
> > immediately.  Improves performance of merges with conflicting line
> > endings when core.eol=crlf or core.autocrlf=true.
> 
> Pardon me, first you make a big deal about normalization for merges, only
> that you finally omit it? What am I missing?

He calls convert_to_working_tree and then immediately calls
convert_to_git again.  convert_to_git will still convert CRLF to LF
where appropriate, so the end result will be the same. There is no
reason to go through an "expensive" conversion of LF->CRLF in
convert_to_working_tree first.

- Finn Arne
