From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [1.8.0] Support quoting in .gitattributes, .gitignore
Date: Thu, 3 Feb 2011 18:51:18 +0700
Message-ID: <AANLkTikHNKmcapVWBAcufq8ONVWOWHbnL-H8Nf2WmKM5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 12:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkxjA-0008Tw-0S
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 12:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab1BCLvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 06:51:51 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54483 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab1BCLvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 06:51:50 -0500
Received: by wyb28 with SMTP id 28so1052116wyb.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 03:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=NiikQox+/DDWU0utGj99GsAi3MznAmVC4XF1Lpwc6l0=;
        b=GuuETknXZEL70PNMW3YiFt95H+tIqP9ioRrwFfTZNqyqpgtVZuWkvnjvFlMFQT+mu4
         sa5v9EYnTYsuyekjwqtAz7rfX8xdX1zhtPwM+0GKs5PFpfZl78Cq8LXLDM8qlsNg6jnX
         F+irGGFgdOoHnkAPKMSWFjlbG7+zpilnjuF7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=S4wzVQDAHDLHKYCCl2wAcF0r16EON6PcjAvahGMOlY2rSfK1RnBaZWxwmkH8sytjNE
         JUD4LzES8XTV8eSLJyFjaWdhjjnvQrewmHEk7VIZdw9BDqWGFgUdokbXMQCA9UzO9tyy
         /p8Mf6weFsULRudcQ61yZzOW9UAyN3bFu2Pho=
Received: by 10.216.186.144 with SMTP id w16mr9760745wem.13.1296733909176;
 Thu, 03 Feb 2011 03:51:49 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 3 Feb 2011 03:51:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165970>

Proposal:

There's already a patch for .gitattributes [1].

To summarize: .gitattributes separates pattern and attributes by
spaces, therefore spaces could not be present in patterns. There are
tricks to overcome (e.g. substitute spaces with dots) but it's well..
tricky. The patch adds support for quoting full patterns.

While .gitignore does not have the same problem, it'd be nice to
support quoting too for a few reasons:

 - Keep differences between gitattr and gitignore to minimum. A
hero(ine) might come and unify them some day. Don't make his/her work
harder.
 - Is ability to put \n in patterns counted as a good point?

Risks:

Current patterns with leading double quote mark will be
misinterpreted. Though chances are really small.

Migration plan:

I think a release note mentioning this is enough. No migration needed.

But to be safe, we can make post-1.7.5 warn users about patterns with
leading double quote. By 1.8.0, the new behavior will be used.

[1] http://article.gmane.org/gmane.comp.version-control.git/160867
-- 
Duy
