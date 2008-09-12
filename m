From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui: more issues with diff parsing
Date: Fri, 12 Sep 2008 10:06:18 -0700
Message-ID: <7vy71xpa45.fsf@gitster.siamese.dyndns.org>
References: <200809091030.04507.barra_cuda@katamail.com>
 <20080912152345.GE22960@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeC7J-00069E-5n
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 19:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbYILRGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYILRGZ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 13:06:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbYILRGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 13:06:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C55A060A9A;
	Fri, 12 Sep 2008 13:06:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 263D860A96; Fri, 12 Sep 2008 13:06:19 -0400 (EDT)
In-Reply-To: <20080912152345.GE22960@spearce.org> (Shawn O. Pearce's message
 of "Fri, 12 Sep 2008 08:23:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 20DD37DC-80ED-11DD-A204-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95752>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Notice how we get two diffs for the same file?  That's why git-gui
> is choking on this particular change.  It expected only one diff
> for the path it gave to Git.  It got two back.  In cases like this
> we may not be able to support line or hunk application as the patch
> is really two different patches against that path.  :-|
>
>> The following patch seems to fix this particular issue, but I don't think
>> it's the right fix...
>
> I don't think that is the right fix, but the one that I just tried to
> write to do clear_diff when we see the second diff --git line didn't
> work either.  Plus we probably need to disable the hunk apply code.

You will have the same issue not for submodules, too.  A typechange has
always been expressed as delete followed by create.

Probably you already have learned the nature of change (i.e. create?
modify? delete? typechange?) when you populate the list of files with
changes that could be staged, which means by the time the user picks from
the liast you already know if it is a typechange.
