From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Fri, 07 Nov 2008 13:11:40 -0800
Message-ID: <7vskq3fdgz.fsf@gitster.siamese.dyndns.org>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
 <20081101220319.1116.50509.stgit@gandelf.nowhere.earth>
 <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org>
 <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net>
 <7v3ai3gugt.fsf@gitster.siamese.dyndns.org>
 <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 22:13:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyYdk-0005hT-Mw
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 22:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYKGVL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 16:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbYKGVL6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 16:11:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYKGVL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 16:11:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B5EA0947CB;
	Fri,  7 Nov 2008 16:11:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 85CF7947C9; Fri, 
 7 Nov 2008 16:11:42 -0500 (EST)
In-Reply-To: <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net>
 (Yann Dirson's message of "Fri, 7 Nov 2008 21:39:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3210BF6-AD10-11DD-85BD-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100333>

Yann Dirson <ydirson@altern.org> writes:

> On Fri, Nov 07, 2008 at 12:19:14PM -0800, Junio C Hamano wrote:
>> I am afraid that this is totally unacceptable, as you yourself mentioned,
>> the end result is unapplicable with any existing tool and would confuse
>> viewers like gitk and gitweb.
>
> Well, other tools will still have to be taught about a new syntax, if
> they're going to use the new flag - just like it was for --rename.

You are mistaken.  For a patch, you are dealing with two different
parties: producer and consumer.  If you are adding new feature to the
producer, the output format should be desigend to allow the consumer tell
that it is something it does not know how to handle.

Marking a non patch with "diff --git" to trigger the logic to signal the
beginning of a patch to git-apply (and perhaps other tools) is a non
starter.

And for this "we are giving a patch that your git-apply can apply and gitk
can show, but by the way we also think the whole directory foo moved to
new location bar" is merely an additional information.  You should still
be able to apply the patch with tools that are unaware of this new
directory move detection feature.
