From: Jay Soffian <jaysoffian@gmail.com>
Subject: [1.8.0] Change branch --set-uptream to take an argument
Date: Tue, 1 Feb 2011 01:57:03 -0500
Message-ID: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 07:57:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkABK-0005eM-EJ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 07:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248Ab1BAG5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 01:57:35 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53259 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1BAG5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 01:57:34 -0500
Received: by iwn9 with SMTP id 9so6192250iwn.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 22:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=VDY2zztF6gEc31GE3cSjLzK4Smh3PXyarsEiqf5WJ4A=;
        b=iMrfEgCao2VJkohoQAujz7bPeEwHhbs+wPXp8u1NjC2gKNyYrBEohUpryLnRa9cznx
         15YMbAnRSUUaYe77990Y0Y/YIomHQtn3ypwCNNzIEiPFtH5SQZrGYz7DNf2jkYEfioXQ
         8WC2gmGh6XQ8JXTX+8V67C7XUIKrbwLGgwnZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=HH9h6dvDlYO6H3qJvS6cn2CF9k6i3zOb/Edz++U4P5ecQhvM6lkMSH9iZdCkJCCFMr
         aLFyOS4fOii0I4u2a/JAeLXOXVXN7cGlEoRTPERrCQ7UfgUud54wAgJ2uWfjgTwZYFho
         8tCmzwv8kWDsYGn+/K43x9vEbCMI/4Dfe5+9c=
Received: by 10.231.207.71 with SMTP id fx7mr7749276ibb.127.1296543453806;
 Mon, 31 Jan 2011 22:57:33 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Mon, 31 Jan 2011 22:57:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165794>

Proposal:

Currently it is very easy to misinvoke --set-upstream if you assume it
takes an argument:

e.g.

  (master)$ git branch --set-upstream origin/master
  Branch origin/master set up to track local branch master.

In order to make its usage unambiguous, and to allow it to be used w/o
specifying the current branch, require it to take an argument like so:

  (master)$ git branch --set-upstream=origin/master

(I've misinvoked it so often, I've had to train myself to always
invoke it this way: git branch master --set-upstream origin/master)

Risks:

Hands which have become trained to use it as it currently is, scripts, etc.

Migration plan:

Introduce the new syntax to the man page and git branch for 1.7.x and
emit a warning whenever the current syntax is used. In 1.8, break the
current syntax.

(Though I'm not sure whether the options parser allows for both
--set-upstream and --set-upstream=<arg>)

j.
