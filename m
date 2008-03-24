From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Sun, 23 Mar 2008 22:49:45 -0700
Message-ID: <7vr6e01xja.fsf@gitster.siamese.dyndns.org>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil>
 <47E298A5.6050508@nrlssc.navy.mil>
 <alpine.LSU.1.00.0803201812560.4124@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 06:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdfa1-0005GB-28
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 06:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbYCXFuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 01:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbYCXFuD
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 01:50:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbYCXFuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 01:50:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FFF31471;
	Mon, 24 Mar 2008 01:50:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 771ED1470; Mon, 24 Mar 2008 01:49:54 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803201812560.4124@racer.site> (Johannes
 Schindelin's message of "Thu, 20 Mar 2008 18:14:45 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78005>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 20 Mar 2008, Brandon Casey wrote:
>
>> Add support for creating a new tag object and retaining the tag message, 
>> author, and date when rewriting tags. The gpg signature, if one exists, 
>> will be stripped.
>> 
>> This adds nearly proper tag name filtering to filter-branch. Proper tag 
>> name filtering would include the ability to change the tagger, tag date, 
>> tag message, and _not_ strip a gpg signature if the tag did not change.
>
> I think such a change in semantics merits a new option.

It is a different story if the fix is a good one, or has room for
improvement.  For example, the sed script that knows what is on the first
and second line and relies on that knowledge to use 1c...2c... looked very
fragile to me.

However, at least to me, this looked like an attempt for a pure "fix".

If you tell filter-branch to filter a branch A and a tag T, as the command
is advertised to rewrite positive refs that were given from the command
line, isn't it natural to expect that the command would attempt its best
effort to rewrite such a tag object?
