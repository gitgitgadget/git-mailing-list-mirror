From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] checkout: Don't crash when switching away from an invalid branch.
Date: Sat, 08 Nov 2008 11:07:25 +0100
Message-ID: <87k5bea5uq.fsf@wine.dyndns.org>
References: <871vxnbhbh.fsf@wine.dyndns.org>
	<alpine.DEB.1.00.0811071903300.30769@pacific.mpi-cbg.de>
	<87od0r9nnj.fsf@wine.dyndns.org>
	<7vbpwrf85x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 11:08:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KykkO-0005U6-B2
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 11:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYKHKHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 05:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbYKHKHi
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 05:07:38 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:52205 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYKHKHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 05:07:37 -0500
Received: from adsl-84-226-9-85.adslplus.ch ([84.226.9.85] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Kykj2-00023d-8j; Sat, 08 Nov 2008 04:07:35 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 91BB81E73B5; Sat,  8 Nov 2008 11:07:25 +0100 (CET)
In-Reply-To: <7vbpwrf85x.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Nov 2008 15:06:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100392>

Junio C Hamano <gitster@pobox.com> writes:

> For that matter, dying without removing the trace of that funny state
> might be even preferrable if you need to do postmortem to figure out why
> you got into such a funny state to begin with, but not everybody uses git
> to debug git.

It turns out to be user error, that was a tree I hadn't used in a long
time and I didn't realize it was using alternates, so HEAD was pointing
to a commit that had been rebased and garbage-collected in the source
repository.

Most other commands die with a "bad object HEAD" in that situation, and
checkout could certainly do that too, but I think it's nicer to provide
an easy way of getting out of that broken state.  I'll resend an updated
patch.

-- 
Alexandre Julliard
julliard@winehq.org
