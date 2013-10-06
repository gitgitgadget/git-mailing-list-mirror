From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Sun, 6 Oct 2013 13:50:13 +0300
Message-ID: <20131006105013.GA24950@LK-Perkele-VII>
References: <20131006004236.GB3460@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Oct 06 13:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSm51-00075E-5d
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 13:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab3JFLAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 07:00:39 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:58429 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3JFLAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 07:00:38 -0400
X-Greylist: delayed 623 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2013 07:00:38 EDT
Received: from LK-Perkele-VII (a88-112-44-140.elisa-laajakaista.fi [88.112.44.140])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id AAC993FD6;
	Sun,  6 Oct 2013 13:50:13 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20131006004236.GB3460@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235738>

On Sun, Oct 06, 2013 at 12:42:36AM +0000, brian m. carlson wrote:
> 
> GSS-Negotiate authentication always requires a rewind with CURL.
> 
> The remote in question only supports Negotiate authentication, so
> prompting for a password in this case isn't going to help.  I'm probably
> going to look into this over the next couple of days, but two things
> need to be done here: 1) do not prompt for a password if only Negotiate
> authentication is requested, since it just won't work, and 2) recreate
> the data as needed if we have to rewind, since otherwise pushing a fresh
> copy of the Linux kernel repo simply isn't going to work as the buffer
> will have to be too large.  An alternative is to send a small amount of
> data, smaller than the postbuffer, in the first chunk and only fail to
> rewind if the second or subsequent chunks need rewinding.

Isn't 'Expect: 100-Continue' meant for stuff like this (not that it is
always supported properly)?

-Ilari
