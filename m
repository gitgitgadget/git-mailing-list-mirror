From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'add -u' without path is relative to cwd
Date: Sat, 05 Sep 2009 14:46:16 -0700
Message-ID: <7vk50dysif.fsf_-_@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905084641.GA24865@darc.dnsalias.org>
 <7veiql1etz.fsf@alter.siamese.dyndns.org> <20090905184508.GA20124@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Sep 05 23:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mk35i-0000zh-ML
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 23:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZIEVqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 17:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbZIEVq3
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 17:46:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZIEVq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 17:46:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7389227EA8;
	Sat,  5 Sep 2009 17:46:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6CTA53LdlssBNTWc/9OrzYPCzGY=; b=jcF4Lo
	uvdBj50Oj7/uDu8hNYgJCJPL2eH4YCOxWrFrc1AC6VSLRscTAJVRzO/NSqdLmc5b
	45HOGMeONJgJ+QfqCXoFl1SjBUrxMU/8JH8sbk296735vuNdKv1zEbNWyKFeuT8x
	d9PWB15XuIL8rXbm2J/qLnHc7QcByxlifX+zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bJx6Owth0plzY9cfS4nKOZEqRKXhOgLx
	sTc12dBL9fn3jF1Ew+2HYkkSjW7wc2kzzUoVNhFLj6tMF5lHxudQOx7WDF8b9HGZ
	JOkEcVv/Szi3WKtInZcHxn6x3rUzXacPCM/1Dbzkso2YCvEbSgUS/2ouDWbIXVSI
	/z2K4G1O7ZY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B06427EA7;
	Sat,  5 Sep 2009 17:46:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8093B27EA6; Sat,  5 Sep
 2009 17:46:20 -0400 (EDT)
In-Reply-To: <20090905184508.GA20124@localhost> (Clemens Buchacher's message
 of "Sat\, 5 Sep 2009 20\:45\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8FC5A8D6-9A65-11DE-A189-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127828>

Clemens Buchacher <drizzd@aon.at> writes:

> I can only guess that you mean the "sane way for script writers to defeat
> the configuration without much pain" part. But I'm not sure how that's a
> problem. If you want the script to continue to work as before you either
> configure "workdir scope", or you add a '.' to the affected commands.

One who writes the script and lends it to you may be using different
`scope` from what the recipient uses, so that is not an escape hatch at
all.

One crudest form of workaround may be for your code to notice an
environment variable to override that `scope` configuration setting, so
that you can advise the script writers to set it in their script.  But
that is so ugly I'd rather not go there if we do not absolutely have to.

That is why in general we should be very careful and avoid any magic that
makes the same command behave completely differently depending on how a
repository is configured.
