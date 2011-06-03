From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative paths.
Date: Fri, 03 Jun 2011 21:51:05 +0200
Message-ID: <4DE93B29.4030401@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 21:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSaOq-0005GK-LI
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 21:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab1FCTvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 15:51:11 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:54267 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab1FCTvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 15:51:10 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7526B1908BAE5;
	Fri,  3 Jun 2011 21:51:08 +0200 (CEST)
Received: from [93.240.117.60] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QSaOi-0003JT-00; Fri, 03 Jun 2011 21:51:08 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7v39jsdulf.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19necbcbC2H4sTmm0juGSTLecl9AjebO4GLbnoH
	pbHkGnfcSMawz3w+5jW7uG15YrqfuZ7xv9DqC7lGBowMS1jghJ
	qGmvRxfPUVzNK0NQ5N1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175023>

Am 02.06.2011 19:14, schrieb Junio C Hamano:
> I suspect that it would be a relatively easy fix if your toplevel
> superproject is its own authoritative upstream.  Something along the line
> of this patch, perhaps?  It is obviously untested, and we may want to
> issue an "echo >&2 'info:...'" to tell the user what we are assuming in
> this codepath.

Maybe it is better to not automagically switch from "path is relative to
url configured in superproject" to "path is relative to $(pwd)" depending
on the presence or absence of a default remote in the superproject. When
a user wants to set up his submodules relative to the superproject and
simply did forget to configure the url of the superproject first he won't
notice that anymore after this patch. But instead he will get a local
submodule url only to find out later that this was not what I wanted (and
an 'info' can easily be missed).

Now I understand this issue better I'd vote for leaving the relative url
like it is, comment it better in the man page and give a better error
message when that happens. After all this issue only surprised a few
people, mostly due to the lack of information in the error message and
man page, so I'd rather prefer to not change the behavior but the wording.
