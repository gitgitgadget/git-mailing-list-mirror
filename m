From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] git-log.txt: fix description of <since>..<until>
Date: Sun, 21 Apr 2013 12:48:25 +0530
Message-ID: <CALkWK0n7e-GQ8eBjgd4pnB5AzLGN0bik-n8_McbK68CvJh6P=A@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-4-git-send-email-artagnon@gmail.com> <20130420222528.GA10043@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:19:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UToYT-0000bP-SC
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab3DUHTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:19:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45148 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab3DUHTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:19:07 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so5952924ied.19
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 00:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aNK0rz8v/W3zld5U3SBJUC5ydhaxtowoAjDsQGP1hcg=;
        b=bdML4XAoXoGQlnbzKV5QaFnnTID+zZk+9t80y/hIQ5qupiBgRXuxjN6VPcyXj8CNKA
         ZElClZ1YdMb20Oz7O+5CtM4vm9JD2tQ+xbOfgrdyQQQtkAuJOzgtdFpukgVxogtxl8/D
         j7S8tSEG5G/SA0BJ1rjqF4O9wGpj8D+RmWpdAIvz6TjPFgSPW3I1S0mOLziOgpCwYcHO
         zeQgBXjrKra47VV+XfqI0eBaRkpY9gcBdeEzkexKgrKSMFDnCSCAVRh/NuG5HGEhdxy5
         AiNNjFbxRf4qFZ4oWwSeL22dYHzksRgi0iHB99R8aP/9NAz6yrrWeiJYD82HPlfVKUtj
         gDgg==
X-Received: by 10.50.119.102 with SMTP id kt6mr12840338igb.12.1366528746038;
 Sun, 21 Apr 2013 00:19:06 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 00:18:25 -0700 (PDT)
In-Reply-To: <20130420222528.GA10043@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221902>

Jonathan Nieder wrote:
> What's the difference between a revision and a commit?  The definition
> in gitglossary(7) only confuses me.

What's so confusing about it?

commit:: As a noun: A single point in the Git history; the entire
history of a project is represented as a set of interrelated commits.
The word "commit" is often used by Git in the same places other
revision control systems use the words "revision" or "version". Also
used as a short hand for commit object.

revision:: A particular state of files and directories which was
stored in the object database. It is referenced by a commit object.

-- 8< --

There a reference to "revision" in the "commit" description which
might be misleading.

Otherwise, these are quite accurate.  master~3:README is a valid revision,
but not a commit, for instance.  Another problem with the word commit
is that it doesn't encapsulate ranges like 'master~3..HEAD'.  It would
probably help to add the terms "commitish" and "treeish" to the
glossary to refer to "rev specs" (those in revisions.txt) that resolve
to commits or trees.  I'll give you two simple examples:

1. In 'git show master:README', master is a treeish and master:README
is a blob.  If we were to say 'git blame master: -- README', it would
error out because master: is not a commitish, but a treeish.

2. In 'git log master~3.. -- README', master~3.. is a commitish.  In
general, log can take only rev specs that resolve to a commits.
Although 'git log master:' doesn't error out, it doesn't make any
sense either.  Perhaps we should tighten it?
