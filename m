From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] Introduce commit_list_append() in commit.c
Date: Fri, 06 Jun 2008 17:14:35 -0700
Message-ID: <7viqwmqexg.fsf@gitster.siamese.dyndns.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org> <7v8wxjzd41.fsf@gitster.siamese.dyndns.org> <20080606235239.GY29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4m5q-0004g1-OW
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYFGAOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbYFGAOq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:14:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbYFGAOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:14:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B18214AF;
	Fri,  6 Jun 2008 20:14:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BEDC114AE; Fri,  6 Jun 2008 20:14:38 -0400 (EDT)
In-Reply-To: <20080606235239.GY29404@genesis.frugalware.org> (Miklos Vajna's
 message of "Sat, 7 Jun 2008 01:52:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B95CECB4-3426-11DD-BE62-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84152>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Jun 05, 2008 at 04:16:46PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Do you have a caller of this function that keeps a pointer to commit_list
>> that needs to be appended at the tail or inserted at the beginning
>> depending on the phase of the moon, or does the caller always append to
>> that list?
>
> The later. I use it for appending a new parent for the merge commit and
> after parsing a new remote head. In both cases I always append a list.

If that is the case, you might want to check how parse_commit_buffer() in
commit.c builds "parents" list.  It is a standard pattern to append to the
list using commit_list_insert() and that is the reason why it returns a
pointer.
