From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Mon, 24 Mar 2014 14:47:24 -0700
Message-ID: <xmqq1txrp8ur.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
	<CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
	<CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
	<20140228170012.GA5247@tugrik.mns.mnsspb.ru>
	<CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
	<20140305093151.GA3994@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCiT-00058Z-Lz
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbaCXVr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:47:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbaCXVr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:47:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 654CF757A9;
	Mon, 24 Mar 2014 17:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pEnfMslMJSuiKJxnZk0C6PFb5o8=; b=QHWEoa
	wlOUeEo9EwUNQdqfRPnVEOY7JkpSCYPBixd3/nsjZNybW793RgYmaRzeIqgFiQH+
	aQe5Lm9JNM4+c12LW+ZLMHH/zSTUgNoW0fkICNpr9bdaCzAaX2lBs5dIZZCoD3hl
	nIo/3UxSTuwzSYer1erTxnmv8qzMDyX5A7HnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NFZIMD/5ZJesovYQExZadz1EAXVwGBtp
	9ApjzDh/CkEbXtOdqeJLkMWp3KGuQJngAkmaRbnX7Qt5CMoHkzrBjZCneHrI3+EY
	ndSp27F09iSjHUw3JvAyHOrdHc+PgmrA723TITBB4CSqOM6TYX1njo50uzNZbuQS
	vSEEzYGnkFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4838B757A7;
	Mon, 24 Mar 2014 17:47:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 742CB757A4;
	Mon, 24 Mar 2014 17:47:26 -0400 (EDT)
In-Reply-To: <20140305093151.GA3994@tugrik.mns.mnsspb.ru> (Kirill Smelkov's
	message of "Wed, 5 Mar 2014 13:31:51 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3DF8B3E-B39D-11E3-BCBF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244883>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> On Fri, Feb 28, 2014 at 06:19:58PM +0100, Erik Faye-Lund wrote:
>> On Fri, Feb 28, 2014 at 6:00 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
>> ...
>> > In fact that would be maybe preferred, for maintainers to enable alloca
>> > with knowledge and testing, as one person can't have them all at hand.
>> 
>> Yeah, you're probably right.
>
> Erik, the patch has been merged into pu today. Would you please
> follow-up with tested MINGW change?

Sooo.... I lost track but this discussion seems to have petered out
around here.  I think the copy we have had for a while on 'pu' is
basically sound, and can easily built on by platform folks by adding
or removing the -DHAVE_ALLOCA_H from the Makefile.
