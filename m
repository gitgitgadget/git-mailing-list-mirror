From: David Kastrup <dak@gnu.org>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 10:30:03 +0200
Message-ID: <85zlzn812s.fsf@lola.goethe.zz>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	<7vwsur590q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 10:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWpWH-0006uX-UU
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 10:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbXIPIaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 04:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbXIPIaO
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 04:30:14 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:47807 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625AbXIPIaM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 04:30:12 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id E24304CD67;
	Sun, 16 Sep 2007 10:30:10 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id D11A95BF30;
	Sun, 16 Sep 2007 10:30:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-028-166.pools.arcor-ip.net [84.61.28.166])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id AA0502D2A55;
	Sun, 16 Sep 2007 10:30:06 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BC5A01CDAC0C; Sun, 16 Sep 2007 10:30:03 +0200 (CEST)
In-Reply-To: <7vwsur590q.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 16 Sep 2007 01\:06\:45 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4289/Sun Sep 16 07:49:23 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58306>

Junio C Hamano <gitster@pobox.com> writes:

> Yes, I am very well aware that somebody already mentioned "there
> is a window between the true checkout and permission tweaking".
> If you need to touch the core level in order to close that
> window, I am not interested.

Doing this atomically involves creating the file in question by
specifying the permissions on the creat system call already, and
possibly wrap seteuid calls and similar around it for getting the
right file/ownership.

However, it is not really necessary to do this atomically: instead one
can rather create the file using safe permissions (600) at first, then
do fchown and fchmod (or chown/chmod) at some point in time afterwards
as required.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
