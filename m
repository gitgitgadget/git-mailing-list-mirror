From: David Kastrup <dak@gnu.org>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 09:30:15 +0100
Message-ID: <87a9dv8lew.fsf@fencepost.gnu.org>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
	<CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
	<87y51g88sc.fsf@fencepost.gnu.org>
	<CAHOQ7J_pg6Nqc5TdU9OA81=d+ZG_JpLFQ5-eFLY3uW8CuAQrUQ@mail.gmail.com>
	<87ppms87n7.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 09:30:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDrgu-000053-2d
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 09:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbaBMIa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 03:30:29 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:41691 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbaBMIa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 03:30:28 -0500
Received: from localhost ([127.0.0.1]:40729 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDrgh-0008MK-T9; Thu, 13 Feb 2014 03:30:28 -0500
Received: by lola (Postfix, from userid 1000)
	id 24CBFE0885; Thu, 13 Feb 2014 09:30:15 +0100 (CET)
In-Reply-To: <87ppms87n7.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 12 Feb 2014 20:15:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242046>

David Kastrup <dak@gnu.org> writes:

> Again, that's with an SSD and ext4 filesystem on GNU/Linux, and there
> are no improvements in system time (I/O) except for patch 4 of the
> series which helps perhaps 20% or so.
>
> So the benefits of the patch will come into play mostly for big, bad
> files on Windows: other than that, the I/O time is likely to be the
> dominant player anyway.
>
> If you have benchmarked the stuff, for annoying cases expect I/O time
> to go down maybe 10-20%, and user time to drop by a factor of 4.
> Under GNU/Linux, that makes for a significant overall improvement.  On
> Windows, the payback is likely quite less because of the worse I/O
> performance.  Pity.

But of course, you can significantly reduce the relevant file
open/close/search times by running

    git gc --aggressive

While this does not actually help with performance in GNU/Linux (though
with file space), dealing with few but compressed files under Windows is
likely a reasonably big win since the uncompression happens in user
space and cannot be bungled by Microsoft (apart from bad memory
management strategies).

-- 
David Kastrup
