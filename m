From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 14:12:09 +0200
Message-ID: <861wf5nc6e.fsf@lola.quinscape.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707181121520.14781@racer.site> <86tzs2m1h7.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0707181218090.14781@racer.site> <vpqejj6c52u.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 14:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB8OK-0008Fm-Fm
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 14:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733AbXGRMMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 08:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756370AbXGRMMY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 08:12:24 -0400
Received: from main.gmane.org ([80.91.229.2]:58814 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbXGRMMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 08:12:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IB8OC-0007Ad-FZ
	for git@vger.kernel.org; Wed, 18 Jul 2007 14:12:20 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 14:12:20 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 14:12:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:q8gA+GAkaJ5vIh1NiWpm0wVCHP0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52856>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> > We do not track permissions of directories at all.
>>> 
>>> Ok, this seems like something that should be done as well, even if we
>>> can stipulate at first that a directory should have rwx for the user
>>> in question if you hope to track it.
>>
>> No, no, no.  It should not be tracked.  It is the responsibility of the 
>> _user_ to set it to something sane, be that by a umask or by sticky 
>> groups, or by setting the permissions of the parent directory.
>>
>> It is _nothing_ we want to put into the repository.  That is the _wrong_ 
>> place to put it.
>
> I'm not sure it's wrong to be able to track permissions, but it's
> definitely wrong to track them by default.

I am not sure about "definitely", but there certainly are applications
where it is appropriate.

> * Execute bit. This one is relevant. Indeed, it's more a kind of
>   metadata than really a permission (you can still execute the file
>   with /lib/ld-linux.so.2 /path/to/file or such kind of things).

Please spare us the sophistry.  Probably the most flexible approach
would be to be able to specify a checkout umask, defaulting to 700
(the other bits are then filled in from the normal user umask).  For
archival purposes, one would then set it to 777 instead.

There is the question how to deal with checkins.  While there is no
harm in checking in the full permissions in case one would need them,
it would likely be a nuisance to track the individual contributor's
settings.

-- 
David Kastrup
