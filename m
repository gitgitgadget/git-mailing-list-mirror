From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-log --format: Add %B tag with %B(x) option
Date: Fri, 18 Sep 2009 12:12:39 -0700
Message-ID: <7vtyz083tk.fsf@alter.siamese.dyndns.org>
References: <7vk4zxgnim.fsf@alter.siamese.dyndns.org>
 <1253296845-17219-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoitC-0004v4-7B
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 21:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbZIRTMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 15:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbZIRTMo
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 15:12:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbZIRTMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 15:12:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F076E37C26;
	Fri, 18 Sep 2009 15:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JX/rhzDfKtwOchInNz5JGDoO15Y=; b=R5LPLwZzhEs3CQuUQpSN2cu
	cQ6mDvIkB73Vrl9NWGrs64nVIoDdREmuRwDlgToxoa2jw2/taLMJG9kRojfE2DlV
	tD/nIvA16DmP1fn+yaQ7yZcZujGFGbbupdmLFRi6nkUstUGwVy1O8Dd8MT3pzs+M
	fKg4x4TH05pepogz0HhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DcCmrEzaOcMhBkdKE4tbKLO/aSIpmdZCL6x7+elk9CdgrLSlh
	04sTBhkaxVSZWrJKZvGntUUgIDGcXCbwD47v7YweewwaDZXrRUbkjbNeFAmIg5NJ
	Ups6N09Q2hnY4ahRr6VAtdU2GYhjaouHzwKNgSpLH/N3jxmq1ADuDNBuOw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BFB2B37C24;
	Fri, 18 Sep 2009 15:12:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0767337C21; Fri, 18 Sep
 2009 15:12:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3EB8C118-A487-11DE-8348-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128807>

Johannes Gilger <heipei@hackvalue.de> writes:

> %B(c5) is simply no ident, while %B(5c) is 5 spaces indent. Don't know if this 
> is unwanted behaviour, but that's what strtol gives us.

Not really.

"strto[u]l(arg, &endp, 10)" parses arg as a decimal and moves "char *endp"
to point at where the number ended, so you can tell things like:

 - return value of 0 with (arg == endp) being "an empty input, the user
   did not necessarily meant zero"; or

 - (*endp != '\0') being "some garbage after the number".
