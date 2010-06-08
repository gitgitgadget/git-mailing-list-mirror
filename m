From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option "--ignore-submodules"
Date: Tue, 08 Jun 2010 22:41:12 +0200
Message-ID: <4C0EAAE8.3060300@web.de>
References: <4C0E7037.8080403@web.de> <7vhbldtow3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:43:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5e6-0005Lt-EN
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab0FHUnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 16:43:33 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40414 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0FHUnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:43:32 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id E12CF15DF6257;
	Tue,  8 Jun 2010 22:41:14 +0200 (CEST)
Received: from [80.128.73.122] (helo=[192.168.178.26])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OM5bm-0005z0-00; Tue, 08 Jun 2010 22:41:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vhbldtow3.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19XbrxdCG9K06OfcSeW9vDnS+TN92PsDffwbzxR
	h/PZ2tlvOKRmSJ+ptk18PUyGXoC2jPGmfFFjGJ2+2ltp15LYol
	2E8YcfhinP3O+15NyM/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148711>

Am 08.06.2010 19:28, schrieb Junio C Hamano:
> The above outline (I haven't looked at the code) sounds sane.  We might
> even want to make untracked (or dirty) the default, if nothing is given
> from the command line nor configuration.

Hm, as far as I interpreted the postings here, "none" should be a
reasonable default for most users because it protects them from errors
that are easy to make and hard to detect.

IIRC there are two main exceptions which want a different setting:

 - Huge submodules which take a substantial portion of time to scan may
   want "dirty" to avoid spending the extra time (at least until we have
   an inotfiy daemon ;-).

 - Submodules where the provider doesn't care or is not able to provide
   a proper .gitignore for other reasons want "untracked" to avoid the
   noise.

(Anything I missed?)

And these seem to fall into the category: If you are unlucky enough to
have one of these included in your superproject, configure these to use
"dirty" or "untracked" as appropriate. And AFAICT they are more the
exception than the rule so I came up with this proposal of a per
submodule configuration, so people won't have to turn off submodule
checking for all submodules because of a single special one.


> I don't see a reason for patch 1/2, though.

Ok, I will drop that from the next round.
