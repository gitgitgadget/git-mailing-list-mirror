From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Tue, 17 Jul 2007 10:58:10 +0200
Message-ID: <86vecj1k65.fsf@lola.quinscape.zz>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <alpine.LFD.0.999.0707161252330.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 10:58:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAitT-00025f-Sa
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 10:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761062AbXGQI6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 04:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761000AbXGQI6n
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 04:58:43 -0400
Received: from main.gmane.org ([80.91.229.2]:58297 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759777AbXGQI6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 04:58:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAit9-0004kN-AS
	for git@vger.kernel.org; Tue, 17 Jul 2007 10:58:36 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 10:58:35 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 10:58:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:VWQUR2EKC/N4lNw0b6Q2a52sPH8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52751>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 16 Jul 2007, Thomas Glanzmann wrote:
>>
>> Calling unlink on a directory on a Solaris UFS filesystem as root makes it
>> inconsistent. Thanks to Johannes Sixt for the obvious fix.
>
> Ack, I think this is the right thing to do.
>
> As pointed out, it doesn't _guarantee_ that git won't call
> "unlink()" on a directory (race conditions etc), but that's
> fundamentally true (there is no "funlink()" like there is
> "fstat()"), and besides, that is in no way git-specific (ie it's
> true of *any* application that gets run as root).

Please note that doing "remove" before "mkdir" without checking for
directoriness still offers a race window where one can slip in a new
non-directory file.

-- 
David Kastrup
