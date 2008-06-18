From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Guided merge with override
Date: Wed, 18 Jun 2008 09:31:13 -0700
Message-ID: <7viqw6zovi.fsf@gitster.siamese.dyndns.org>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
 <20080616092554.GB29404@genesis.frugalware.org>
 <48563D6C.8060704@viscovery.net>
 <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
 <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 <7vve076d6t.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181618070.6439@racer>
 <alpine.DEB.1.00.0806181627260.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 18:32:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K90aB-0000DU-Cm
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 18:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYFRQbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 12:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbYFRQbd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 12:31:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYFRQbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 12:31:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8DD4315BB9;
	Wed, 18 Jun 2008 12:31:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 66F1F15BB5; Wed, 18 Jun 2008 12:31:16 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806181627260.6439@racer> (Johannes
 Schindelin's message of "Wed, 18 Jun 2008 16:28:42 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF4B4780-3D53-11DD-A42D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85390>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thinking about this again, there could be a problem: in case of complex 
> merges, it is possible that the sides are switched around for an 
> intermediate merge.  IOW you'd expect it to take "theirs", but it really 
> takes "ours".

Are you thinking about using this in merge-recursive?

I do not think there is any reason to use this during intermediate merges
done inside merge-recursive.  The point of recursive merge is to create a
neutral intermediate merge result, with conflicts and all.  Do this only
during the final round and you are fine (for some definition of "fine" ---
I still have not heard a convincing argument as to why it is even a good
thing to be able to take one side for only parts that did conflict, while
taking the change from the other side in places that did not).
