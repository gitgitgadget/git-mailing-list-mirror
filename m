From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 12:27:06 -0800
Message-ID: <7vk58pk9k5.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de>
 <200901192017.54163.bss@iguanasuicide.net>
 <200901192145.21115.bss@iguanasuicide.net>
 <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
 <7vskndkip9.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901201819490.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNDL-0005es-Bg
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbZATU1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbZATU1W
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:27:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbZATU1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:27:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D49CE92B51;
	Tue, 20 Jan 2009 15:27:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D949192B4F; Tue,
 20 Jan 2009 15:27:10 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901201819490.5159@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Tue, 20 Jan 2009 18:28:14 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBF16276-E730-11DD-ACF0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106519>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> By the way, wouldn't it make sense to optimize the precontext of that 
>> hunk by doing _something_ like:
>> 
>> 	if (!o->word_regex && strcmp(one->path, two->path))
>>         	o->word_regex = userdiff_word_regex(two);
>> 
>> "Something like" comes from special cases like /dev/null for new/deleted
>> files, etc.
>
> You mean to avoid the cost of initializing the regex in case one and the 
> same file is diffed against itself?

No.

What I meant is much simpler than that.

If one and two are the same filename, and earlier gitattributes lookup for
the path already failed to produce any when you checked one, isn't it very
likely that the gitattributes lookup for two would fail the same way to
produce any result?
