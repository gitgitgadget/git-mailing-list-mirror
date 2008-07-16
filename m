From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 15:41:35 -0700
Message-ID: <7vod4xo3j4.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
 <7vabghr5br.fsf@gitster.siamese.dyndns.org>
 <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com>
 <7vr69tpoze.fsf@gitster.siamese.dyndns.org> <20080716223205.GK2167@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFhr-0003dJ-I6
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857AbYGPWlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758695AbYGPWlo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:41:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758462AbYGPWln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:41:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BDAF2D3A7;
	Wed, 16 Jul 2008 18:41:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8BE062D3A4; Wed, 16 Jul 2008 18:41:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C7794FA-5388-11DD-A2A0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88776>

Theodore Tso <tytso@mit.edu> writes:

> So from a pedagogical perspective, what I would probably do is show
> them how to replicate svn-up, and explain to them how this script
> works:
>
> #!/bin/sh
> # git-up
>
> if git diff --quiet && git diff --quiet --cached ; then
> 	git pull $*
> else
> 	git stash ; git pull $*; git stash pop
> fi

Looks good, except:

	if git diff ....; then
		git pull "$@"
	else
        	git stash && git pull "$@" && git stash pop
	fi

to make sure the conflict notices won't be scrolled off by error messages
from the later commands.
