From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 09:47:17 -0500
Message-ID: <QMrPJrj9ztlKRRk907LM0hozdFOSLjShMt2uDhbAk6DGxE1OSBFMkg@cipher.nrlssc.navy.mil>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com> <20110617141450.GA12114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Mc Donnell <michael@mcdonnell.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 17 16:47:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXaKh-0000X4-1g
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 16:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328Ab1FQOrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 10:47:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54738 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab1FQOrc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 10:47:32 -0400
Received: by mail.nrlssc.navy.mil id p5HElGFW002384; Fri, 17 Jun 2011 09:47:16 -0500
In-Reply-To: <20110617141450.GA12114@sigill.intra.peff.net>
X-OriginalArrivalTime: 17 Jun 2011 14:47:17.0292 (UTC) FILETIME=[741716C0:01CC2CFD]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175950>

On 06/17/2011 09:14 AM, Jeff King wrote:
> On Fri, Jun 17, 2011 at 03:35:04PM +0200, Michael Mc Donnell wrote:
> 
>> I'm using git imap-send to send patches to wine-patches, and it seems
>> like it converts all my patches to have CRLF line endings?
> 
> The canonical line ending for mail is CRLF. So yes, it will convert your
> patch to CRLF for storage. But anything pulling it out of the IMAP
> folder should convert it back to native line endings.

Not always.  Modern thunderbird (3.1.10, is that modern? I haven't
checked), saves mail using CRLF.  I don't have access to gmail at the
moment, but I'm pretty sure gmail does the same thing, i.e. when you
select "view original", and then use your browser to "save as...".

mailsplit was modified to strip CRLF when splitting mail here:

  c2ca1d7 Allow mailsplit (and hence git-am) to handle mails with CRLF line-endings

which should have first appeared in git v1.6.5.

>> I can see it when I download the patch from the Gmail drafts folder.
>> Git complains about white space when I apply the downloaded patch. It
>> works fine if I just use git to create the patch and then apply it on
>> a new branch. Is it git imap-send or just Gmail that's the problem?
> 
> How do you download and apply the patch exactly? If you are speaking
> imap to gmail, generally the client would strip out the CR's from the
> mail.

Michael, how are you applying the "email"?  Are you using 'git am'? or
possibly are you trying to use 'git apply'?  You need to use 'git am'.

Also, as I mentioned above, you should be using git more recent than
v1.6.5 so that you have a mailsplit that will strip out the CRLF line
endings.

-Brandon
