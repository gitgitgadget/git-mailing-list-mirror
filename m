From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sat, 07 Feb 2009 11:43:41 -0800
Message-ID: <7veiyavxqq.fsf@gitster.siamese.dyndns.org>
References: <498DA4F9.20104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 20:45:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVt74-0007UA-GD
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 20:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZBGTnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbZBGTns
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 14:43:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZBGTnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 14:43:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B813A97861;
	Sat,  7 Feb 2009 14:43:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AEC5497860; Sat,
  7 Feb 2009 14:43:43 -0500 (EST)
In-Reply-To: <498DA4F9.20104@gmail.com> (Tay Ray Chuan's message of "Sat, 07
 Feb 2009 23:12:57 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A26DB930-F54F-11DD-BA51-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108877>

Tay Ray Chuan <rctay89@gmail.com> writes:

> In 753bc91 ("Remove the requirement opaquelocktoken uri scheme"), the
> lock token is guaranteed to be prefixed with the string
> 'opaquelocktoken:', which propagated down to file path creation
> operations in the remote repository, namely, in start_put (and
> consequently start_move).
>
> These file operations may not be successful, due to the colon ':'
> character in the file path (specifically, in Windows).
>
> This patch ensures that the lock token sans 'opaquelocktoken:' is used
> instead in start_put.

I am not familiar with DAV so I have to wonder who guarantees in the
codepath that the string that follows the "opaquelocktoken:" (and any
other lock token uri scheme) is without problematic characters, such as a
slash (or colon)?
