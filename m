From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Tue, 03 May 2011 15:51:00 -0700
Message-ID: <7vsjsvgzzf.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC0608F.9040208@dailyvoid.com>
 <20110503204442.GI1019@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org,
	vmiklos@frugalware.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHOR6-0003tc-2O
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 00:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab1ECWvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 18:51:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab1ECWvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 18:51:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D71C5C71;
	Tue,  3 May 2011 18:53:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iTSciePulp95cvI6FgoN6GnYqks=; b=Fogpmw
	QCANwnDwC4p48c3LAjS2zzPJ8BSggVEP2Wqd7tmOfR+U4wsp+/Rczt9VxKHFUM9H
	4eIeaiJjtqAwb8ZDfS7YSBrvB6SoRDIlTxlbnmOnS1Quk1bjy3aysrFgaIRY4XYK
	54GYXrVPx6Eama3HBZnq2koLwConI6YbQVLqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TGRYVNE8nx+2Q+9w+6kNQ6M6tH/ogUiZ
	fF1fsUzP4V8s7PiV2FXB9oTJ1MfabXhAuAXMTRdgpxLMWqjd8TuBRXIbUaNj30JJ
	VLKPPMNrNkaAP3UdVougm4tYdFJDVwmp+ndKK6Gj4UGPyDUgSg6jHTPgQBDUu4cH
	DoWmcw0U+zQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D5155C63;
	Tue,  3 May 2011 18:53:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BAEDA5C5A; Tue,  3 May 2011
 18:53:06 -0400 (EDT)
In-Reply-To: <20110503204442.GI1019@elie> (Jonathan Nieder's message of "Tue,
 3 May 2011 15:44:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F68A174-75D8-11E0-AECE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172699>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In what sense are they overridden?  For example, if I write
>
> 	[branch "*"]
> 		mergeoptions = --no-ff
>
> 	[branch "master"]
> 		mergeoptions = --log=5
>
> and merge another branch into master, will the effect be as though I
> wrote --no-ff --log=5 or just --log=5?

I think the latter is overriding, and the former is cumulative.

> I'm starting to suspect it might be simpler to add a new "[merge] no-ff"
> configuration item, like the existing "[merge] log".

Surely

	[merge]
        	log = false
                ff = false

would be a lot simpler and probably far easier to explain.

Does

	[merge]
		log = false
	[branch "master"]
        	mergeoptions = --log=5

do the right thing with the current codebase?
