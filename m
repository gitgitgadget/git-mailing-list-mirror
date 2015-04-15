From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 23:26:47 +0300
Message-ID: <20150415202647.GA29170@LK-Perkele-VII>
References: <552E628C.7040809@debian.org>
 <20bd52de595018f49eeeea64128e3a77@www.dscho.org>
 <552E7927.5030803@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 22:34:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiU14-00026k-64
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 22:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbbDOUea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 16:34:30 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:37447 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbbDOUe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 16:34:29 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2015 16:34:28 EDT
Received: from LK-Perkele-VII (a88-112-44-140.elisa-laajakaista.fi [88.112.44.140])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 799201A25D1;
	Wed, 15 Apr 2015 23:26:47 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <552E7927.5030803@debian.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267237>

On Wed, Apr 15, 2015 at 08:13:51PM +0530, Pirate Praveen wrote:
> 
> Q: Are the mosh principles relevant to other network applications?
> 
>     We think so. The design principles that Mosh stands for are
> conservative: warning the user if the state being displayed is out of
> date, serializing and checkpointing all transactions so that if there
> are no warnings, the user knows every prior transaction has succeeded,
> and handling expected events (like roaming from one WiFi network to
> another) gracefully.
> 
> Can the ideas be used to resume a pull, push or clone operation?
> Especially serializing and checkpointing.

Well, it is possible to write a remote helper and serverside program
that internally handles connection unreliability, so Git itself
(upload-archive, upload-pack, receive-pack, archive, fetch-pack
and send-pack) sees a reliable (full-duplex, half-closeable, stream)
channel.

Suitably done, that can "resume" (from Git POV, nothing special
happened) across things like IP address changes.

However, that is quite difficult to do in practice. Not because
interface to Git is complicated, but because the transport problem
itself is complicated (however, it still seems way easier than
making Git internally be able to resume interrupted operations).

Mosh needs to solve at least most of that, it just doesn't provode
the right kind of interface.


-Ilari
