From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git doesn't finds the parent of a commit
Date: Sun, 27 Apr 2008 13:18:18 -0700
Message-ID: <7vtzhnf3w5.fsf@gitster.siamese.dyndns.org>
References: <slrng019fg.nd8.joerg@alea.gnuu.de>
 <20080413094131.GA9437@xp.machine.xx> <slrng0v8h8.ujv.joerg@alea.gnuu.de>
 <200804240801.13674.chriscool@tuxfamily.org>
 <20080424060857.GX29771@spearce.org> <20080427104704.GA11784@alea.gnuu.de>
 <20080427173731.GA9523@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:19:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqDL6-00052D-Ix
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 22:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447AbYD0US0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758368AbYD0US0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 16:18:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbYD0USZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 16:18:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FC334BCC;
	Sun, 27 Apr 2008 16:18:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6D7D64BC9; Sun, 27 Apr 2008 16:18:21 -0400 (EDT)
In-Reply-To: <20080427173731.GA9523@cuci.nl> (Stephen R. van den Berg's
 message of "Sun, 27 Apr 2008 19:37:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80481>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> J?rg Sommer wrote:
>>% git rev-parse b63e99500137c913bd801a2f22b6cf88c63b95c5~1
>>b63e99500137c913bd801a2f22b6cf88c63b95c5~1
>>fatal: ambiguous argument 'b63e99500137c913bd801a2f22b6cf88c63b95c5~1': unknown revision or path not in the working tree.
>>Use '--' to separate paths from revisions
>
>>Can someone tell me what I'm doing wrong?
>
> I've had similar symptoms when I had circular references in the
> repository.  They're not reported by any of the existing checks, I've
> submitted a patch (resent it just now) which causes git to check for
> (and report) circular references when using --topo-order on e.g.
> git-rev-list.

Assuming that we never have SHA-1 hash collisions, the graft mechansim is
practically the only way to get yourself into the circular reference
situation.

Perhaps we should check this circularity when we install grafts instead of
special casing the topo-order codepath?  How expensive would that
alternative approach be?
