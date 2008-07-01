From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple remote.<...>.fetch and .push patterns
Date: Tue, 01 Jul 2008 02:27:58 -0700
Message-ID: <7vprpynech.fsf@gitster.siamese.dyndns.org>
References: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>
 <48693434.4090402@freescale.com>
 <308083c30806301252l25f072anafbc457f48c6b19e@mail.gmail.com>
 <g4croa$3eu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Jul 01 11:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcAh-0005hB-FX
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbYGAJ2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbYGAJ2O
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:28:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbYGAJ2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:28:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D0AC1DCC3;
	Tue,  1 Jul 2008 05:28:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8F2611DCC2; Tue,  1 Jul 2008 05:28:05 -0400 (EDT)
In-Reply-To: <g4croa$3eu$1@ger.gmane.org> (Michael J. Gruber's message of
 "Tue, 01 Jul 2008 11:00:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06943C4E-4750-11DD-A593-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87014>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:

> The files under remotes are the old way of configuring remotes (see
> git help push). The new are config lines in the remotes section, as
> written by "git remote". I don't think "git remote" can write the
> lines you want, so I'd suggest:
>
> git config remote.ko.url kernel.org:/pub/scm/git/git.git
> git config remote.ko.fetch refs/heads/master:refs/tags/ko-master
> git config --add remote.ko.fetch refs/heads/next:refs/tags/ko-next
> git config --add remote.ko.fetch refs/heads/maint:refs/tags/ko-maint

I'd actually suggest:

	$ edit .git/config

and create this section:

        [remote "ko"]
                url = master.kernel.org:/pub/scm/git/git.git/
                fetch = +refs/heads/*:refs/remotes/ko/*
                push = heads/master
                push = heads/next
                push = +heads/pu
                push = heads/maint

(I used to say ko-master but these days I say ko/master).
