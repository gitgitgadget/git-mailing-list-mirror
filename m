From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Mon, 04 Oct 2010 00:55:55 -0700
Message-ID: <7vtyl28k8k.fsf@alter.siamese.dyndns.org>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org> <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino> <20101002084100.GH29638@burratino>
 <7vlj6edcic.fsf@alter.siamese.dyndns.org> <20101004041834.GD24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:56:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fu9-00025x-1e
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab0JDH4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:56:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0JDH4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:56:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB494DBE30;
	Mon,  4 Oct 2010 03:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u8ofj1ovuOF5DGVCoLM42Sv9KO0=; b=s7r7po
	xzSa9gl4Uq7lZn0XerA0UfWb5Ez7mb/0PFRDaqPDuLNmvq9tp1A3iURX49owCyk9
	LXiEqYPPV8GcWa0NcPiv2nV4u29hR7NyWuVYy/e+qooBIp98u6YIX/+Z+GCSeE+L
	GVqdL3UQsx7KJJMM8wRnUBX/KUX/RuXwRNliM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oih5zdKbN6FTrpAsppLbyeh3O8iSgZGh
	d3q8w9tjAGatCZrdac6gUKf1zJ2C2nQ4Wvc0k/h8MW+CCpKLgpsG3zW+ZXI9d5Ns
	yn4kOlghI3ohlX085W6k0Zcg9ezS0UyO5qbPqyc2GqWU5JoEvLnJ4R9p6TcN+/Ot
	2T1+/3UkeZM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6F1DDBE2C;
	Mon,  4 Oct 2010 03:56:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB454DBE23; Mon,  4 Oct
 2010 03:55:56 -0400 (EDT)
In-Reply-To: <20101004041834.GD24884@burratino> (Jonathan Nieder's message of
 "Sun\, 3 Oct 2010 23\:18\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4C6BF9E-CF8C-11DF-A825-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158005>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Even better would be to exit() instead of returning from cmd_
> functions.  Valgrind will not consider any memory that still has a
> pointer to it at exit time as a leak.

Hmm, is there a way to tell valgrind that in these functions pretend as if
they left the scope by calling exit() when they return?
