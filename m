From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Sat, 15 Nov 2008 19:30:23 +1300
Message-ID: <1226730623.26334.2.camel@maia.lan>
References: <1226647174-15844-1-git-send-email-sam@vilain.net>
	 <1226655681.17731.4.camel@maia.lan>
	 <7vfxlu9lhs.fsf@gitster.siamese.dyndns.org>
	 <200811142009.51803.fg@one2team.com>
	 <7vr65d7dct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Francis Galiegue <fg@one2team.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 07:31:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1EhD-00015b-M4
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 07:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbYKOGad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 01:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbYKOGad
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 01:30:33 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:39851 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbYKOGac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 01:30:32 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 34F0021C413; Sat, 15 Nov 2008 19:30:31 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8812121C413;
	Sat, 15 Nov 2008 19:30:22 +1300 (NZDT)
In-Reply-To: <7vr65d7dct.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101051>

On Fri, 2008-11-14 at 21:44 -0800, Junio C Hamano wrote:
> Actually, POSIX does not even talk about EPERM for mkdir(2), but that was
> not my point.  The code does something different from what the proposed
> commit log message talks about.  That was what bothered me.

My wording was a little terse and confusing.  Here's a new one;

Subject: sha1_file.c: resolve confusion EACCESS vs EPERM

EPERM or 'Operation not permitted' is an unlikely error from
mkstemp(); test for EACCESS 'Access Denied' instead.  Make the
special branch which prints the error to the user nicely also
understand EACCESS.
