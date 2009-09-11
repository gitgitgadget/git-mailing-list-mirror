From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Re: add documentation for mailinfo.scissors and
 '--no-scissors'
Date: Fri, 11 Sep 2009 11:53:05 -0700
Message-ID: <7vws45wbxq.fsf@alter.siamese.dyndns.org>
References: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr> <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr> <7veiqe0x05.fsf@alter.siamese.dyndns.org> <20090911134112.GA18684@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Sep 11 20:56:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmBIl-00011e-Rj
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 20:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbZIKSxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 14:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755925AbZIKSxN
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 14:53:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938AbZIKSxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 14:53:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CE6E4D722;
	Fri, 11 Sep 2009 14:53:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dMSxljYHcq3IYxB1JyxUGmXAObE=; b=x/OZ9T
	t+i2fwLFIQ1YoA+sx2ck2YBeNJJH6QrpwXMjUxEprlawuTXXhmjEDTSxsLJ3Qube
	3KDqF+SY5jCFPrMTaDaFSCsTibEZ5U+BgN+7HoCdlj5tXS8FyLG+fjj9k3OLMM32
	Zaam6iD+BCOhWYIF2XfxLyROoga0qQgE3jeXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XzgkBLpYAJDh8Cgb0K7lbM5A594ki1cw
	rmzjaGvx3+Ig8SDSDaNATsNo7uM99mc6FEigAo4BNfxpkqqkva8DWBJbce/CLVI7
	YccAC1TmLgVgv+ZOp9AMDixkzdHhe59wXlBIEmZMtaUTACSzJ3nPmtFN2cyMekp6
	q5yuNsBtlU0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E5A14D721;
	Fri, 11 Sep 2009 14:53:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B1BB54D720; Fri, 11 Sep 2009
 14:53:06 -0400 (EDT)
In-Reply-To: <20090911134112.GA18684@vidovic> (Nicolas Sebrecht's message of
 "Fri\, 11 Sep 2009 15\:41\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A39598A-9F04-11DE-AA2E-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128211>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> I don't understand your point here. This hunk doesn't allow
> --no-no-scissors but add --no-scissors to usage of 'git am', no?
>
> Do I miss something around $OPTIONS_SPEC?

You missed two thirds of the issue and I missed the other one third ;-)

As scissors is not marked with ! (see PARSEOPT section in the rev-parse
documentation), no-scissors is already available without that hunk, and
that is why your patch is unnecessary.

Your patch did not mark no-scissors with ! either, so it makes the call to
rev-parse --parseopt to process your OPTIONS_SPEC pass --no-no-scissors.

However, you did not add --no-no-scissors arm to the case statement that
processes rev-parse --parseopt output, so the command as the whole still
rejects --no-no-scissors as invalid (this is the last third I missed).
