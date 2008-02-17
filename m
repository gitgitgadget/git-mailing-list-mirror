From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Teach git mergetool to use custom commands defined
 at config time
Date: Sun, 17 Feb 2008 03:08:39 -0800
Message-ID: <7vmypz262w.fsf@gitster.siamese.dyndns.org>
References: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 12:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQhPQ-0007zJ-JE
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 12:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584AbYBQLJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 06:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbYBQLJi
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 06:09:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbYBQLJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 06:09:37 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 30BE85D3B;
	Sun, 17 Feb 2008 06:09:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 9AC4D5D3A; Sun, 17 Feb 2008 06:09:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74119>

Charles Bailey <charles@hashpling.org> writes:

> This series of patches are a cleaned and improved version of the
> earlier RFC patch that I sent.

About the organization of the series, I think (note that what I
think does not count as much as what Ted thinks around this
area) it would make much more sense to do 4 first (unless there
is a reason why it behaves differently for existing backends),
then 2 (remove $path everywhere and use $MERGED consistently,
not just where you call out to the custom tool), and then
finally 1.  The general idea is to clean-up first and then add
features on solidified base.

I do not personally see much need for 3, as the custom script
should be able to check the situation and adjust its behaviour
accordingly, and that way you do not have to maintain two
scripts.  I.e. if $BASE does not exist, there is no base, no?
