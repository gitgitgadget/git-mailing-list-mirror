From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to be more useful
Date: Fri, 3 Dec 2010 02:14:45 -0800
Message-ID: <85DF30E1-E823-41D9-BAD7-4A11BD0D03C7@sb.org>
References: <20101110015327.GB1503@burratino> <1290629960-60917-1-git-send-email-kevin@sb.org> <20101203080603.GC18202@burratino> <4CF8BE8E.4090100@viscovery.net> <20101203100059.GA12043@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 11:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POSfJ-00075O-Od
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 11:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab0LCKOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 05:14:52 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34724 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0LCKOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 05:14:51 -0500
Received: by yxt3 with SMTP id 3so4163385yxt.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 02:14:50 -0800 (PST)
Received: by 10.150.212.3 with SMTP id k3mr3594117ybg.2.1291371289429;
        Fri, 03 Dec 2010 02:14:49 -0800 (PST)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id q18sm402302ybk.15.2010.12.03.02.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 02:14:48 -0800 (PST)
In-Reply-To: <20101203100059.GA12043@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162785>

On Dec 3, 2010, at 2:00 AM, Jonathan Nieder wrote:

>> But most importantly, since $rest is echoed on the terminal, it MUST be
>> derived from the recipe ($line). Rationale: I replace the commit subject
>> in the recipe by a reminder what I intend to do when the "edit" command
>> stops---I don't care so much what the commit subject is.
> 
> Kevin, this sounds like a vote for the "replace commit message" output
> format.

The v3 patch will emit both a description of the commit it stopped on, as well
as the comment. The rationale for extracting the first line of HEAD is for when
the user doesn't provide any comment - e.g. they just add "edit". It may be
worth doing this only in that case, and if the user did provide a comment,
emit it in place of the first line of HEAD.

Given the recipe

	pick bc17bb7 git-rebase--interactive.sh: extend "edit" command to be more useful
	edit - foo

the edit command would print

	Stopped at bc17bb7... git-rebase--interactive.sh: extend "edit" command to be more useful
	
		foo
	
	You can amend the commit now...

The alternative is to make that same recipe emit

	Stopped at bc17bb7... foo
	
	You can amend the commit now...

I'm leaning towards making that change right now, but I'm not certain.
Do either of you have a preference?

-Kevin Ballard