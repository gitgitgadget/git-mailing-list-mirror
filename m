From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use path limiting (using a glob)?
Date: Wed, 11 Feb 2009 11:48:52 -0800
Message-ID: <7v1vu4eouz.fsf@gitster.siamese.dyndns.org>
References: <20090211191432.GC27232@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXL6I-0007sw-MV
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbZBKTs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbZBKTs6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:48:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZBKTs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:48:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CA3F42AECF;
	Wed, 11 Feb 2009 14:48:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1CBBC2AEC0; Wed,
 11 Feb 2009 14:48:53 -0500 (EST)
In-Reply-To: <20090211191432.GC27232@m62s10.vlinux.de> (Peter Baumann's
 message of "Wed, 11 Feb 2009 20:14:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04E75D82-F875-11DD-9C45-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109518>

Peter Baumann <waste.manager@gmx.de> writes:

> after reading Junio's nice blog today where he explained how to use git grep
> efficiently, I saw him using a glob to match for the interesting files:
>
> 	 $ git grep -e ';;' -- '*.c'
>
> Is it possible to have the same feature in git diff and the revision
> machinery? Because I tried
>
> 	$ cd $path_to_your_git_src_dir
> 	$ git log master -p -- '*.h'
> 	.... No commit shown 
>
> 	$ git diff --name-only v1.5.0  v1.6.0 -- '*.c'
>
> and both don't return anything.

There was a recent discussion on this.  The index family uses glob, the
tree family uses leading-path only.  The one implemented for grep can do
both, and attempts to unify both by providing possibly reusable interface
so that the other two families can be ported to, but we haven't managed to
trick anybody to take up the task ;-).
