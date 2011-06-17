From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 10:08:18 -0500
Message-ID: <Svak9atXpisIKwqaYKGMzry3LEHEDPnWLLqFpfgP7IOuAVUdRy8brA@cipher.nrlssc.navy.mil>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>	<20110617141450.GA12114@sigill.intra.peff.net> <BANLkTin1DAv0pZmZCcrtDyjrUD-ukO6MNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Mc Donnell <michael@mcdonnell.dk>
X-From: git-owner@vger.kernel.org Fri Jun 17 17:08:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXaev-0004y2-Lg
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 17:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185Ab1FQPIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 11:08:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60298 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab1FQPIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 11:08:24 -0400
Received: by mail.nrlssc.navy.mil id p5HF8Ix2004066; Fri, 17 Jun 2011 10:08:18 -0500
In-Reply-To: <BANLkTin1DAv0pZmZCcrtDyjrUD-ukO6MNQ@mail.gmail.com>
X-OriginalArrivalTime: 17 Jun 2011 15:08:19.0012 (UTC) FILETIME=[64224840:01CC2D00]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175952>

On 06/17/2011 09:45 AM, Michael Mc Donnell wrote:
> On Fri, Jun 17, 2011 at 4:14 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, Jun 17, 2011 at 03:35:04PM +0200, Michael Mc Donnell wrote:

>> How do you download and apply the patch exactly? If you are speaking
>> imap to gmail, generally the client would strip out the CR's from the
>> mail.
> 
> I'm just downloading it with Chrome.
> 
> Steps to reproduce:
> 1. Upload patch via:
> $ git format-patch --stdout --keep-subject --attach origin | git imap-send
> 2. Open Gmail in Chrome.
> 3. Open email in drafts folder.
> 4. Click attachment download link
> 5. Apply patch on a fresh branch with git apply.
                                        ^^^^^^^^^

Ok, I suspected that.  The thing that you download from your gmail
drafts folder is an email, not a patch.  It may contain many inline
patches though.  You need to use 'git am' which will extract the
patches from the email and apply them.


A word of caution about using imap and gmail:

Unless something has changed recently, and I don't think it has, if you
_send_ the email using gmail's web interface, it will add newlines at
the 72nd character, and corrupt your patch.  So, even though you
uploaded the patch using 'git imap-send', you still have to select it
from your drafts folder and click "send" from gmail's web interface.
So, gmail's imap interface is pretty useless for sending patches.  You
should be able to use 'git send-email' and configure gmail as your smtp
server though. 

-Brandon
