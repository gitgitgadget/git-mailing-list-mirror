From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: handle change type T
Date: Mon, 17 Mar 2008 01:01:14 -0700
Message-ID: <7vve3lbwz9.fsf@gitster.siamese.dyndns.org>
References: <E1Jay7s-0000dO-IX@fencepost.gnu.org>
 <7v63vmicvf.fsf@gitster.siamese.dyndns.org> <47DD9890.3060005@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, beuc@gnu.org,
	Martin Langhoff <martin@catalyst.net.nz>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 09:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbAIO-0002Sw-P9
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 09:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbYCQIB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 04:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYCQIB1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 04:01:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749AbYCQIB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 04:01:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EDCA2581;
	Mon, 17 Mar 2008 04:01:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DEB32257E; Mon, 17 Mar 2008 04:01:19 -0400 (EDT)
In-Reply-To: <47DD9890.3060005@gnu.org> (Paolo Bonzini's message of "Sun, 16
 Mar 2008 23:00:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77418>

Paolo Bonzini <bonzini@gnu.org> writes:

> Junio C Hamano wrote:
> ...
>> Do cvs clients even know how to handle symlinks, or will this patch just
>> start sending the readlink(2) result as if it is just a regular file
>> contents?
>
> It was before too.  The problem arises if one found the problem,
> deleted the symlink, added the regular file -- and now cvsserver stops
> working at all. :-(

Yeah, I see why $git_perms fall back to "rw" now around l.2620 -- if file
mode is 120000, none of the r/w/x would have been added in.

Martin, likes, dislikes?
