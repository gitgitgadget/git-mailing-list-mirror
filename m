From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Wed, 22 Jul 2015 13:32:14 -0700
Message-ID: <xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 22:32:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI0gf-0003hW-JR
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 22:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbGVUcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 16:32:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35099 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbGVUcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 16:32:17 -0400
Received: by pabkd10 with SMTP id kd10so72053376pab.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aVF2tZUBJ+7RZ4ktSrvlhV/rGJaR3mDbsyiI+8MZmwo=;
        b=ZQ8s0H6e8nyAOwGfOaoMqUif7Olu60HSR0WAfbwe1cKQLF3oWL+BEieq6zwLZ4ZdPq
         tM5X6y3JPmG3MjEKo9DBqw0oGyWcw9kVXaxMDdmwYpf/k9v1rdGjn3VjIeL64UDzA4QU
         sB8y4w9AsjPg/SmwI1wWRYZpGmx/37QLdr3Exl1kJhhz/ca7xtn7Evemipow4pEFd26z
         w68IIO6MERRM8G8SyJ/GoNnNoPv+KOWDNKK0kAT//N466BqILToKaNBKVbPVZSnvlia9
         KVu/bp+NfZeIsLaXWQ50k+Hg/BS9eayJ1DykmwTSmypgenLj7hssVc5EiHYrTUA/cdrm
         PLfQ==
X-Received: by 10.66.245.142 with SMTP id xo14mr9478869pac.151.1437597136552;
        Wed, 22 Jul 2015 13:32:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id tm3sm4905659pac.44.2015.07.22.13.32.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 13:32:15 -0700 (PDT)
In-Reply-To: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	(Sebastian Schuberth's message of "Wed, 22 Jul 2015 09:29:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274466>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> "--quite" is documented to "Disable all output of the program". Yet
> calling diff-tree with a single commit like
>
> $ git diff-tree --quiet c925fe2
>
> was logging
>
> c925fe23684455735c3bb1903803643a24a58d8f

At this point, unfortunately I think we need to call that a
documentation bug.  The "output" it refers to is output from the
"diff" portion, not the "poor-man's log" portion, of the program,
where diff-tree was the workhorse behind scripted "git log" that
gave the commit object name as the preamble for each commit it
shows information about.
