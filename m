From: Steven Penny <svnpenn@gmail.com>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Date: Fri, 18 May 2012 19:43:54 -0500
Message-ID: <CAAXzdLU2t64x0jk_QHjwBDP2OPEeVqipT6uaivikn=6F6aieAA@mail.gmail.com>
References: <4FB09FF2.70309@viscovery.net>
	<1337191208-21110-1-git-send-email-gitster@pobox.com>
	<1337191208-21110-3-git-send-email-gitster@pobox.com>
	<CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com>
	<7vd364c5kt.fsf@alter.siamese.dyndns.org>
	<4FB58678.1050009@ramsay1.demon.co.uk>
	<7vehqib4kk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:44:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVXm4-0006kc-9m
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081Ab2ESAn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 20:43:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46358 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758797Ab2ESAnz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:43:55 -0400
Received: by obbtb18 with SMTP id tb18so4648810obb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 17:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rBwHjx5UtEgirF0JTyy70A6o0n44wZDwAFswz2NMyN4=;
        b=V7zfSpkX+pPn5OmrkkBCwtHzGN5sr2dvy6xWPq1wDVBH6MLhNlpZvQp70rEv4dD9ud
         azNiGUN0J7MZDGE4L7l35pcRA6V4Y43S/hhHG4wBLYsGfC6PUzoX3UQsigyFSERIfe2/
         kaVbI1bgZCtQey5O/82ts+9/dn6PXlnlbzY6Eqmo0VZgFyJzX0hlNH/EDBlkC0kozq9K
         NybRJwmvNXqi8zPw/GB9kZqR4cmxQHq/tm6p27jjdTWnJ86KK7G7YxVM333EvrEaPA6c
         iN9/YpRTikuejJhzqmMbhr9ygJ4e4GhtZGqfHHw46c5yEAPRj96zF46NMxFy2AhBQsuY
         h2aw==
Received: by 10.50.195.131 with SMTP id ie3mr2121361igc.73.1337388234623; Fri,
 18 May 2012 17:43:54 -0700 (PDT)
Received: by 10.231.69.140 with HTTP; Fri, 18 May 2012 17:43:54 -0700 (PDT)
In-Reply-To: <7vehqib4kk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198001>

On Thu, May 17, 2012 at 9:34 PM, Junio C Hamano wrote:
> And from Cygwin Git, your programs (like $EDITOR and hooks) will get POSIX
> paths.  It is your programs' responsibility to turn them into Windows
> paths if/as necessary.

I think this is correct. These program should be accepting Cygwin paths and are
not for obvious reason, they exist outside the the Cygwin world.

For now I will do something like this

	editor(){
		cygpath -m "$1" | xargs notepad
	}

	export -f editor
	
	git config core.editor editor
