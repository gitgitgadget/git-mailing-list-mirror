From: "Chris Packham" <judge.packham@gmail.com>
Subject: Removing a commit from a local branch
Date: Mon, 12 Jan 2009 11:42:24 +1300
Message-ID: <a038bef50901111442y16695664y4fed7cdd9d8af27@mail.gmail.com>
References: <a038bef50901111441w21959397tc41922656a25027c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 23:44:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM92L-0002V6-VM
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbZAKWm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754320AbZAKWm0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:42:26 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:19714 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZAKWmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:42:25 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9953913rvb.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qRR8jXJnO3q7HwRbKARV/avcessRF5argEAbFQCln/4=;
        b=CBObg6sIRMZSjzXLdOoOOCGqPpVC8TqHP8L4HuotdRx/PCxidD9RawVSYD/+7dUQZL
         +PNEf9Lr1kOrXsyWULSAE0JjZGu1N6TfW8llSizYjQ/Ijn0e6wL2OgSCJtC4qVuT/s9c
         OyzQt36sc+DBrRIisV0XgQ/fo3JUfeabFaKoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CeOn6QrJISkdlQ+5713fqI0Ws+9Kc9ErGNka5TDYO1UPdDWUpmMQEwYe5MbqAMj6iw
         r+D7XmFJFilniPTYX1QdebC9sG4aThwEA/3BXiFutR2UFRFTJEPw0zkPCkeEVJDix27B
         8PNlr9mzv8AJDdVmx/lCtqWCS1YDSVDitG/gs=
Received: by 10.115.108.1 with SMTP id k1mr18660730wam.0.1231713744473;
        Sun, 11 Jan 2009 14:42:24 -0800 (PST)
Received: by 10.114.109.7 with HTTP; Sun, 11 Jan 2009 14:42:24 -0800 (PST)
In-Reply-To: <a038bef50901111441w21959397tc41922656a25027c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105244>

Hi List,

I'm part of a development team using git. We use a maintainer model
where developers send patches/pull requests to a maintainer who
applies the patches to a local branch, decides if they're good or not
and pushes the good patches to the public repository.

What I want to do is script the removal of a bad patch so that the
maintainer identifies a patch in his local branch, sends an email to
the author telling them why their patch is being rejected then removes
the commit for that patch. Using git log a script can extract the
author email address, hash and headline of each commit. Based on that
information scripting the email is easy enough. Now I come to using
git rebase to remove the bad commit based on its hash which leads me
to my question - How do I refer to a commit based on the hash of its
parent?

Consider the following example. The maintainer has the following branch locally

  todeliver: A-B-C-D

He is happy with commits A, C and D but wants to reject B. Ideally I
want to be able to say
  git rebase --onto <parent of B> <child of B> todelvier

and get
  todeliver: A-C'-D'

I know that <parent of B> can be referred to as B~1 but what about
<child of B>? I've read through the man page for git-rev-parse and
nothing stands out as child of commit X.

Is there a better what do achieve what I'm after?

Thanks,
Chris
