From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Fri, 13 Apr 2012 13:30:49 -0500
Message-ID: <20120413183048.GB2387@burratino>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
 <1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
 <20120413060845.GA15610@burratino>
 <20120413180436.GA2387@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 20:30:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIlGt-0007V0-7S
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 20:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab2DMSay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 14:30:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58103 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab2DMSax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 14:30:53 -0400
Received: by iagz16 with SMTP id z16so4574048iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/cFelQY6fxQiEIhT318Nvfu9/Xb4gwsdUI52scZNgvc=;
        b=gYdPxt1Js1eYbGham01gHdzT/QFRwhw3VgXuc2YuANkmzrZcgWwZDE6Ll9Ffvnvtiy
         A1ARGvvlLVWATeeqTiYTPHxbIAQECLEFFFdV+rItVk6Qay/qv/MH94rgy/PWUs7SvjAi
         8H2kz45/WegafAPe9T+mXWZxJoZuug/vQ1FZNwdEYCfA3CEOHpoDVa0+UT6Uh8gMJ0yl
         otdaRW4AzSmvB90TQ4Xd2ms/xERA7cgalE7I+pi2/UPVBFI2nDRt8foLnnyOkgT7UQJO
         6i+AeCIDlYlGCvfmRJrJ04ODRfo9uHHGqE7RfgMmFwG04LwidRfOeFyaKYBJu1XQrR+o
         1ctw==
Received: by 10.50.186.161 with SMTP id fl1mr2531402igc.44.1334341853139;
        Fri, 13 Apr 2012 11:30:53 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id wf10sm4079953igb.8.2012.04.13.11.30.51
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 11:30:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120413180436.GA2387@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195429>

Jonathan Nieder wrote:

> In other words, how about something like this?  Tests left as an exercise
> to the interested reader.

... and here's a simpler way to spell it.

-- >8 --
Subject: completion: do not add trailing space when completing --exec-path

--exec-path looks like to the completion script like an unambiguous
successful completion, but it is wrong.  The user could be trying to
do

	git --exec-path; # print name of helper directory

or

	git --exec-path=/path/to/alternative/helper/dir <subcommand>

so the most helpful thing to do is to leave out the trailing space and
leave it to the operator to type an equal sign or carriage return
according to the situation.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714da..d2109897 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2639,6 +2639,7 @@ _git ()
 			--bare
 			--version
 			--exec-path
+			--exec-path=
 			--html-path
 			--work-tree=
 			--namespace=
-- 
1.7.10
