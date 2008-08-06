From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] perl/Makefile: handle paths with spaces in the NO_PERL_MAKEMAKER
 section
Date: Wed, 06 Aug 2008 09:25:18 -0500
Message-ID: <klGWkbWGpsUHZpuNwl9WvZs5UGGfYVAngWbiM3eippaejrXLNyLpRA@cipher.nrlssc.navy.mil>
References: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil> <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil> <7v8wvbuit7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 16:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQjzK-0005dV-Jj
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 16:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbYHFO0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 10:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757455AbYHFO0F
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 10:26:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43778 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbYHFO0E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 10:26:04 -0400
Received: by mail.nrlssc.navy.mil id m76EPIOW012108; Wed, 6 Aug 2008 09:25:18 -0500
In-Reply-To: <7v8wvbuit7.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Aug 2008 14:25:18.0872 (UTC) FILETIME=[40936980:01C8F7D0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91515>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Use double quotes to protect against paths which may contain spaces.
>> ...
>> +	echo '	mkdir -p "$(instdir_SQ)"' >> $@
> 
> Is this sufficient?  We seem to apply double-sq when writing shell
> scriptlet in GIT-BUILD-OPTIONS from the main Makefile, and I suspect you
> would need to do something similar.

It seems to be sufficient. The double quotes survived into my perl.mak file
and the two perl modules were installed correctly when I supplied a prefix
with spaces. Is there something else to be concerned about?

perl.mak:
all: private-Error.pm Git.pm
        mkdir -p blib/lib
        rm -f blib/lib/Git.pm; cp Git.pm blib/lib/
        rm -f blib/lib/Error.pm
        cp private-Error.pm blib/lib/Error.pm
install:
        mkdir -p "/home/casey/opt/SunOS spaces/sun4u/lib"
        rm -f "/home/casey/opt/SunOS spaces/sun4u/lib/Git.pm"; cp Git.pm "/home/casey/opt/SunOS spaces/sun4u/lib"
        rm -f "/home/casey/opt/SunOS spaces/sun4u/lib/Error.pm"
        cp private-Error.pm "/home/casey/opt/SunOS spaces/sun4u/lib/Error.pm"
instlibdir:
        echo /home/casey/opt/SunOS spaces/sun4u/lib

-brandon
