From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: large(25G) repository in git
Date: Thu, 26 Mar 2009 08:43:39 -0700
Message-ID: <49CBA2AB.30304@oak.homeunix.org>
References: <49C7FAB3.7080301@brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 16:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmrld-0004yK-Ic
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbZCZPnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbZCZPnp
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:43:45 -0400
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:43664 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752448AbZCZPnp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 11:43:45 -0400
Received: (qmail 36880 invoked from network); 26 Mar 2009 15:43:43 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.240.231.157 with plain)
  by smtp116.sbc.mail.sp1.yahoo.com with SMTP; 26 Mar 2009 15:43:42 -0000
X-YMail-OSG: 2.YHoBkVM1n4M5otVxnbQAkPxtJlSPkjFdJsIhe1AJMT1HT7faO4zSoYeczHjiCUM6XXnWnr_qomOOqSSoKTDKDGaO_eB1kaCjkRUNRkRCRZREUpzYXLdqGQQeAogzuCvPIhd54ZTQerium7uUwJ87.t
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1Lmrk5-0002AB-9h; Thu, 26 Mar 2009 08:43:41 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <49C7FAB3.7080301@brainfood.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114794>

Adam Heath wrote:
> We maintain a website in git.  This website has a bunch of backend
> server code, and a bunch of data files.  Alot of these files are full
> videos.
>
> We use git, so that the distributed nature of website development can
> be supported.  Quite often, you'll have a production server, with
> online changes occurring(we support in-browser editting of content), a
> preview server, where large-scale code changes can be previewed, then
> a development server, one per programmer(or more).

My company manages code in a similar way, except we avoid this kind of
issue (with 100 gigabytes of user-uploaded images and other data) by not
checking in the data.  We even went so far is as to halve the size of
our repository by removing 2GB of non-user-supplied images -- rounded
corners, background gradients, logos, etc, etc.  This made Git
noticeably faster.

While I'd love to be able to handle your kind of use case and data size
with Git in that way, it's a little beyond the intended usage to handle
hundreds of gigabytes of binary data, I think.

I imagine as your web site grows, which I'm assuming is your goal, your
problems with scaling Git will continue to be a challenge.

Maybe you can find a way to:

* Get along with less data in your non-production environments; we're
hoping to be able to do this eventually

* Find other ways to copy it; we use rsync even though it does take
forever to crawl over the file system

* Put your data files in a separate Git repository, at least, assuming
your checkin, update, and release code more often than your video files.
 That way you'll experience pain less often, and maybe even be able to
tune your repository differently.

Marcel
