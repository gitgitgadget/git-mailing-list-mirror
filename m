From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] checkout: allow ignoring unmerged paths when
 checking out of the index
Date: Fri, 29 Aug 2008 14:53:12 -0700
Message-ID: <7vzlmv32uv.fsf@gitster.siamese.dyndns.org>
References: <7vbpzb4i1h.fsf@gitster.siamese.dyndns.org>
 <7v7i9z4hx2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 23:54:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZBvC-0001HS-8I
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 23:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbYH2VxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 17:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbYH2VxR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 17:53:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYH2VxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 17:53:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 24A986D076;
	Fri, 29 Aug 2008 17:53:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 957C56D071; Fri, 29 Aug 2008 17:53:14 -0400 (EDT)
In-Reply-To: <7v7i9z4hx2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Aug 2008 14:42:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2700CFA-7614-11DD-B592-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94333>

There is an obvious sequel to this story.  We can enhance the behaviour of
checkout out of the index during a conflicted merge by doing the
following, which is the reason why I stumbled upon this bug that was fixed
by these two patches:

 * Teach "git checkout --ours", "git checkout ---theirs" so that stages 2
   and stages 3 for unmerged paths are checked out (and possibly resolve
   the conflict).

 * Teach "git checkout --merge" to redo the file level merge between
   stages 1/2/3, and update the work tree with the result.
