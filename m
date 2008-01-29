From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Tue, 29 Jan 2008 00:31:43 -0800
Message-ID: <7vprvlowwg.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
	<alpine.LSU.1.00.0801281210440.23907@racer.site>
	<7vwspts9vj.fsf@gitster.siamese.dyndns.org>
	<479ED3AE.5000403@viscovery.net>
	<7v3ashqedx.fsf@gitster.siamese.dyndns.org>
	<479ED92E.4020709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:32:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJltI-000444-MP
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 09:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbYA2Ibw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 03:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbYA2Ibw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 03:31:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbYA2Ibv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 03:31:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9189F3852;
	Tue, 29 Jan 2008 03:31:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E9E4F3851;
	Tue, 29 Jan 2008 03:31:44 -0500 (EST)
In-Reply-To: <479ED92E.4020709@viscovery.net> (Johannes Sixt's message of
	"Tue, 29 Jan 2008 08:43:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71965>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The #ifdef I'm addressing above is one that we had to introduce because in
> the old implementation of prefix_path() on Windows we had to rewrite the
> path more often than on *nix due to '\\' => '/' conversion. In your new
> implementation this rewriting now always takes place, but on *nix it more
> often turns out to be an identity operation.

I am not sure what you mean by "\\" => '/', but you are right.
We should be able to optimize the common case of prefix=none and
no special path components found in path, which should be an
identity function.

>> Especially I have no idea how would that drive lettter stuff
>> would/should work.  When you are in C:\Documents\Panda\, how
>> would you express D:\Movie\Porn\My Favorite.mpg as a relative
>> path?
>
> You can't. But when would this be necessary?

I don't know.  That's why I asked.
