From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 18 Jun 2008 11:58:29 -0700
Message-ID: <7v4p7qzi22.fsf@gitster.siamese.dyndns.org>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
 <20080611213648.GA13362@glandium.org>
 <alpine.DEB.1.00.0806112242370.1783@racer>
 <20080611230344.GD19474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
 <loom.20080612T042942-698@post.gmane.org>
 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
 <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
 <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>
 <7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
 <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com>
 <alpine.DEB.1.00.0806130551200.6439@racer>
 <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
 <alpine.DEB.1.00.0806132239490.6439@racer>
 <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
 <200806142359.m5ENxsBI028758 @mi0.bluebottle.com>
 <7vabhne15k.fsf@gitster.siamese.dyndns.org>
 <7vy755c0b2.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806171000400.6439@racer>
 <7vej6v683q.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181624120.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:00:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K92sx-0001D2-5b
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 20:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYFRS6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 14:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbYFRS6u
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 14:58:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYFRS6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 14:58:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C2B30166AB;
	Wed, 18 Jun 2008 14:58:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A585C166A9; Wed, 18 Jun 2008 14:58:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806181624120.6439@racer> (Johannes
 Schindelin's message of "Wed, 18 Jun 2008 16:25:19 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9347FDAC-3D68-11DD-9CE6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85399>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 17 Jun 2008, Junio C Hamano wrote:
>
>> Of course,
>> 
>> 	$ git stash apply stashed-longer
>> 
>> would work but that is by accident, as at that point what you are feeding
>> "git stash" command is not really a name of a ref that is a stash.
>
> It would not be by accident.  It would work because we designed git-stash 
> to use refs to store working-directory vs index changes, and this command 
> line you wrote was _exactly_ what I intended.

Well, it is.  For normal stash oriented operations such as

    $ git stash list stashed-longer
    $ git stash apply stashed-longer@{22}

won't work on them.  Only the quoted form works and that _is_ by accident.
