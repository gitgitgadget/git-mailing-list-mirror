From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 16:13:45 -0800
Message-ID: <7vzl6annwm.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0911260032410.4985@pacific.mpi-cbg.de>
 <7vvdgyp3zn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0911260059040.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRzq-00078U-0b
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759970AbZKZANw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759968AbZKZANw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:13:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759967AbZKZANv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:13:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE53825CC;
	Wed, 25 Nov 2009 19:13:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wya1AK8zDH5qgLaNlQMgIcOcNsE=; b=ZZ/7l5
	O6Vkhg41XC3NsTDRiq6OJdTK/16ckrGCrBVjWtvx4I5Oq1CZ8KCC5jVzI6zOFCkI
	kYlB06mEYJAqk3wRywnUkwxnUcWr0iX6dUdtmZvZc0Vexb1U7O5goYqrqCS9ndbl
	ClPCKWwxE1lo7HfgzFQ/WeNrhWMVb3ssPMjhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkte7kOQTKp/WfwA7PlPSdrGUN6lbZoa
	p7z6lWjNQ6QvtZuN/rXx0Zjc3NViKVTAO5e+8hkgCmm4iUlBSdCLRPdtkb/xH8ZJ
	ZhpSBb7kaLIE+NBkREcugMt1uwXG6AAfH/rNR2swqruPYpaCYDnPALQbZjcywlBZ
	F5pEqjrmef0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F0A825C9;
	Wed, 25 Nov 2009 19:13:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93BBE825C6; Wed, 25 Nov
 2009 19:13:46 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0911260059040.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu\, 26 Nov 2009 01\:04\:04 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 938C983A-DA20-11DE-ADFB-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133712>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you want to specify an argument on MSys that starts with a slash, you 
> have to provide double slashes, otherwise it gets expanded to the Windows 
> path (prefixing with the absolute path of the MSys root).

How well does the command line hack handle things like

    $ git archive --output=/var/tmp/foo.tar

I have to wonder.

> Hopefully you see the real reason why it breaks down?

Yes, Windows' braindamage.  It doesn't invalidate anything I said so far,
but only proves that emulation can go only so far.  I hope msys port can
grok real "path from root" notation on Windows, e.g.

    $ git diff --no-index "C:\My Documents/hello.txt" "D:\goodbye.txt"

(or perhaps "//c/my documents/...", but I do not care about the details).
