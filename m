From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [BUG?] git remote rm repo nukes local refs for mirror repo
Date: Tue, 14 Oct 2008 12:55:13 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-14-12-55-13+trackit+sam@rfc1149.net>
References: <48F460DB.9030209@drmicha.warpmail.net>
	<alpine.DEB.1.00.0810141131130.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 14 12:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KphbC-00074p-Hp
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 12:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYJNKzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 06:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbYJNKzX
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 06:55:23 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:34064 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbYJNKzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 06:55:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 21AD0E04D9;
	Tue, 14 Oct 2008 12:55:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8E6WwP7K2JqS; Tue, 14 Oct 2008 12:55:14 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id A66C8E04BE;
	Tue, 14 Oct 2008 12:55:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id C13A4C40BC;
	Tue, 14 Oct 2008 12:55:13 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPOhkuR0llgp; Tue, 14 Oct 2008 12:55:13 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 89CA3C40BD; Tue, 14 Oct 2008 12:55:13 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0810141131130.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes Schindelin's message of "Tue\, 14 Oct 2008 11\:32\:13 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98179>

Michael> I just noticed the hard way that "git remote rm repo" nukes
Michael> all local (mirrored) refs if repo had been setup with "git
Michael> remote add --mirror repo url".  Some may argue that this
Michael> behaviour fits the description "deletes all remote tracking
Michael> branches" but I would claim it does not: mirrored branches
Michael> are not remote tracking branches in the proper sense.

Johannes> Count me into the former group.  If you set up a "--mirror"
Johannes> repository, it defeats the purpose to mix that with _true_
Johannes> local branches.

IMO it should exit with an error and force to use "--force" to perform
the operation. The scenario I envision is a mirror becoming the
primary repository because the original source has disappeared. You
would want to remove the now-useless reference to the source, and
silently nuking all branches is wrong.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
