From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Lightweight tag ?
Date: Mon, 12 Jan 2009 10:17:33 +0100
Message-ID: <m2bpucnas2.fsf@gmail.com>
References: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>
	<7v63klsgf5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIwt-0001ji-L9
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbZALJRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZALJRm
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:17:42 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:54052 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbZALJRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:17:41 -0500
Received: by bwz14 with SMTP id 14so31773602bwz.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=aEoiqWUXVGRiTKxCbjs0YPOj+rl/AZqGfvMfQqCWYmc=;
        b=PU3XMV4uSUF3lwWs0N4fBQypim+46ulAj6u6ZatS8vqC0w6y+fmPU+tZkpCzt/PH+w
         /+5H6VtPwnfJea8I+FDZS3i2YaMfz9wdjCccagfykweJDCKIz7Py1zoOwCmJCvECDEFI
         YtvkrKS/X/NMlCfFZK2de33y6EWvpxhqqbvm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:references:from:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=HPYsgVguB1tf2Az3rlWINb8dBkBIgdNH4Gl1GSKlf0Nk4RlppJy2wDTSLItRc2odg8
         VKaHcdCZvmdCutR2C4gUaV3r0OUD2WgkpRlp9wvYbhdKFTezBMs1jvzTuRqS60rxEDrT
         VVE3cK6h8U5cCHT6Z1cEOXQJiwVql3HOloGR8=
Received: by 10.223.114.79 with SMTP id d15mr20805564faq.88.1231751858896;
        Mon, 12 Jan 2009 01:17:38 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id f31sm50178021fkf.26.2009.01.12.01.17.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 01:17:38 -0800 (PST)
In-Reply-To: <7v63klsgf5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 11 Jan 2009 13\:04\:30 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105310>

Hello,

Junio C Hamano <gitster@pobox.com> writes:

> Don't use explicit --tags blindly.  It says "no matter what kind of tag,
> transfer everything under refs/tags".  Otherwise you won't see a
> difference.

Well:

	$ git --version
	git version 1.6.0.4
	$ mkdir test-tag
	$ cd test-tag/
	$ date > A
	$ git init
	Initialized empty Git repository in
	/home/fmoreau/tmp/git/test-tag/.git/
	$ git add .
	$ git commit -a -s -m "Init"
	Created initial commit be8750e: Init
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 A
	$ cd ..
	$ git clone --bare test-tag test-tag.git
	Initialized empty Git repository in /home/fmoreau/tmp/git/test-tag.git/
	$ cd test-tag
	$ git tag light
	
	$ git tag -a -m "Annoted tag" annoted
	$ git push ../test-tag.git
	Everything up-to-date
	$ git push --tags ../test-tag.git
	Counting objects: 1, done.
	Writing objects: 100% (1/1), 166 bytes, done.
	Total 1 (delta 0), reused 0 (delta 0)
	Unpacking objects: 100% (1/1), done.
	To ../test-tag.git
	 * [new tag]         annoted -> annoted
	 * [new tag]         light -> light

It looks like they're no difference for git-push...

That said the documentation about this is rather cryptic IMHO:

,----[ man git-push ]
| 	--tags
| 	    All refs under $GIT_DIR/refs/tags are pushed, in
| 	    addition to refspecs explicitly listed on the command
| 	    line.
`----

>From a user point of view, the word lightweight is missing here. Why
not simply saying:

,----
| All kind of tags are pushed with this option _otherwise_ only annoted
| tags are pushed
`----

thanks
-- 
Francis
