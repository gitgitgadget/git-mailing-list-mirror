From: "Elijah Newren" <newren@gmail.com>
Subject: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 07:26:43 -0600
Message-ID: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Walter" <stevenrwalter@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 15:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd3G4-0006j2-Rp
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 15:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYIIN0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 09:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbYIIN0p
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 09:26:45 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:59149 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbYIIN0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 09:26:44 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2025962wfd.4
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=5Hgqo6Xgo6tw5Ob5mgrc4+KhxDbxVTV2OQWOxzy1wYs=;
        b=RLKpJIQDZUs+DFDNb5ybeVvrHrkGZf1i68pssLnDK9Coq0adVwpSTZLRLxP1HqD/cQ
         2CEQQW/gbkW7OuUqXRXgCCM2ix/SyrWkdjrTOZpf+tqCh2ZoDGaBKLurygK0/q7jEgIQ
         aNJHxnGF9asOwectfjqKIqxI/P5ALyHpRD0eI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=VE91eA40znYqpLxIi17wQhygKNKDVyMOPr/JOnhHBxf6fCjZzYjzh5K7Da69kg10cK
         uLl3zirYPBSP44FdJUiF8pEX7EmKtFfvOwwPL45IMBanX9HZdI9uXA7yaQvQRZfwLFUk
         4YLEHVEqphjHyFEbi6oXY3GUFEtJvedhkN3yY=
Received: by 10.141.88.3 with SMTP id q3mr9735652rvl.46.1220966803462;
        Tue, 09 Sep 2008 06:26:43 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Tue, 9 Sep 2008 06:26:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95382>

Hi,

On Mon, Sep 8, 2008 at 10:25 PM, Govind Salinas
<govind@sophiasuchtig.com> wrote:
> On Mon, Sep 8, 2008 at 8:05 PM, Steven Walter <stevenrwalter@gmail.com> wrote:

> I had some very different ideas along the lines of reducing the number of
> commands (where the commands do something similar just DWIM rather
> than force me to remember or read docs on different commands), making
> commands look similar to commands from other SCMs (revert should do
> what it does for me in all the other SCMs that I have used, which is to
> checkout the HEAD copy into the working directory)

Your description of revert in various systems isn't quite accurate; it
isn't necessarily HEAD, since most systems (at least bzr and hg) can
also revert files to revisions earlier than HEAD.  In fact, questions
of how to do that have come up several times on this list, so you
wouldn't want to exclude that case.  Also, the revert behavior of git
(minus perhaps the default auto-commit) comes in pretty handy too
sometimes, and I can't easily find it in other systems (I suspect many
just drop back to diff + patch to handle the case that git provides).

I don't see why the revert command can't support all these cases that
users want (though you'd need to add flags like --since and --in to
differentiate between reverting the changes since a given commit or in
a given commit).  Doing so has the added advantage that you can
avoid/deprecate/hide/whatever the second forms of the checkout and
reset commands of git, which have long caused confusion for users in
understanding the differences between them and the revert command.

Elijah

P.S. Yes, EasyGit's revert was designed this way.  Don't look to eg
for implementation guidance, though -- I botched it, and there's a few
bugs in it due to my mistakes.  I'll be fixing it...when I get a
little bit of time.
