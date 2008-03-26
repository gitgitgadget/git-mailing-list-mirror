From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] filter-branch.sh: support nearly proper tag name
 filtering
Date: Wed, 26 Mar 2008 00:57:08 -0700
Message-ID: <7vmyolgbor.fsf@gitster.siamese.dyndns.org>
References: <7v63vbr4eq.fsf@gitster.siamese.dyndns.org>
 <47E91DF0.5070302@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 26 08:58:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeQWK-000514-NE
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 08:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYCZH5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 03:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYCZH5X
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 03:57:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYCZH5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 03:57:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B143A23AB;
	Wed, 26 Mar 2008 03:57:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 20F7123A9; Wed, 26 Mar 2008 03:57:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78270>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> If you think the strict ordering that mktag requires could be relaxed in the
> future, then the line number addresses in sed could be changed to ranges
> like:
>
> 	-e "1,4s/^object ..*/object $newobject/"
>
> Of course, if we use ranges, we may have to worry about matching against
> the tag body if the header gets any longer.

I do not think you have to worry if you did this:

        1,/^$/{
                s/object .*/object $newobject/
                s/type .*/type $newtype/
                ...
        }
