From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Mon, 28 Jan 2008 01:22:07 -0800
Message-ID: <7vlk6auwxs.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJQCz-000505-TM
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 10:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbYA1JWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 04:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbYA1JWW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 04:22:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbYA1JWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 04:22:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BFC96CA6;
	Mon, 28 Jan 2008 04:22:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D52756CA5;
	Mon, 28 Jan 2008 04:22:13 -0500 (EST)
In-Reply-To: <479D9ADE.6010003@viscovery.net> (Johannes Sixt's message of
	"Mon, 28 Jan 2008 10:05:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71867>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
> ...
>> Yeah, /*bin is not inside the repository so it should not even
>> be reported as "others".  Shouldn't the commands detect this and
>> reject feeding such paths outside the work tree to the core,
>> which always expect you to talk about paths inside?
>
> That's what I had expected. But look:
> ...
> Some mechanism for this is already there; it's just not complete enough.

Exactly. That was what I've been getting at from the beginning
of this thread --- fix for that incompleteness is what's needed.
