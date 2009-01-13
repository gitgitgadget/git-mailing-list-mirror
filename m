From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: recognize six digit abbreviated SHA1
Date: Tue, 13 Jan 2009 00:26:37 -0800
Message-ID: <7vd4erd32a.fsf@gitster.siamese.dyndns.org>
References: <87mydw2hrb.fsf@cup.kalibalik.dk>
 <87mydw2hkb.fsf@cup.kalibalik.dk> <496BF5D7.2090003@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	jnareb@gmail.com
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 09:28:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMedB-0008Qu-0a
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 09:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbZAMI0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 03:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbZAMI0r
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 03:26:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbZAMI0r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 03:26:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DED578FE5E;
	Tue, 13 Jan 2009 03:26:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C5ECF8FE5D; Tue,
 13 Jan 2009 03:26:38 -0500 (EST)
In-Reply-To: <496BF5D7.2090003@vilain.net> (Sam Vilain's message of "Tue, 13
 Jan 2009 15:00:55 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E99A26EE-E14B-11DD-BF90-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105473>

Sam Vilain <sam@vilain.net> writes:

> I think if you're going to go so short as 6 digits, it's probably worth
> making sure that the really short SHA1s check commits only. eg, if
> you've got a commit 'fa023473' and a tree 'fa023421', then 'fa0234'
> should match the commit and not the tree. But I don't think there's a
> plumbing way to do a query like that at the moment.

When people give an abbreviated object name, 99% of the time they mean
commits (and "index deadbeef..acebead" in a patch is a good place to pick
blob object names from, which would be what the 99% of the remaining 1%
would name), so making sure it is a commit or a blob would be a very
sensible thing to do.

Unfortunately, you fundamentally cannot do this without taking a
performance hit of actually opening the object.
