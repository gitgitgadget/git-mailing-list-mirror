From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Sun, 22 Jul 2012 13:10:55 +0200
Message-ID: <6F148977-4F57-47FF-B43B-0997694F3891@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 22 13:11:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssu4U-0006nI-23
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 13:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164Ab2GVLK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 07:10:59 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56470 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab2GVLK6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2012 07:10:58 -0400
Received: by weyx8 with SMTP id x8so3632521wey.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=J8VQYLKKc5vPICe9xixz2WGqJDnCRyc6iOuGtT9UFw0=;
        b=FMASKyo5I4DQ//SzQFcuuyRnK7Sv0eEG3eXp3BsLxnsZ7lMyMbu9ir4ylIJEV/UfSa
         WctmhSkKcGxKyYLg64jMCAZpltgUOkSMG8BRwp8F1yWQe5m3guIEJZX9n2lsBfysLJ5W
         EQoH/Ta06mvKBlVVuY1At6Jy/ZhQpLw+etGl+iEHaxNdI6hYX1jsrgw1Ly9jageMMnm3
         zpxWLcQT8F0Ap40VA8XYCPTEHyHcbm55Q2CML84/HKIt2GWymBAkYwe5od9gi4DKwBpi
         3JZz3cDd1jbqCu1SYGZiHRXxSvE24OXUGbZtLO7tJblbceETITJI69P2ch+SNt+qWzT2
         5Mnw==
Received: by 10.180.92.194 with SMTP id co2mr1201707wib.12.1342955457340;
        Sun, 22 Jul 2012 04:10:57 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id fu8sm10268427wib.5.2012.07.22.04.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 04:10:56 -0700 (PDT)
In-Reply-To: <20120720154403.GB2862@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201846>

On 20 Jul 2012, at 17:44, Jeff King wrote:

> On Fri, Jul 20, 2012 at 11:49:07AM +0200, Michael Haggerty wrote:
> 
>>> This patch moves reflog entries into a special "graveyard"
>>> namespace, and appends a tilde (~) character, which is
>>> not allowed in a valid ref name. This means that the deleted
>>> reflogs of these refs:
>>> 
>>>   refs/heads/a
>>>   refs/heads/a/b
>>>   refs/heads/a/b/c
>>> 
>>> will be stored in:
>>> 
>>>   logs/graveyard/refs/heads/a~
>>>   logs/graveyard/refs/heads/a/b~
>>>   logs/graveyard/refs/heads/a/b/c~
>>> 
>>> Putting them in the graveyard namespace ensures they will
>>> not conflict with live refs, and the tilde prevents D/F
>>> conflicts within the graveyard namespace.

Sorry if this idea is stupid or if i miss something, but how about putting deleted reflogs for

refs/heads/a
refs/heads/a/b
refs/heads/a/b/c

to

refs/heads/a@yyyy-mm-dd-hhmmss
refs/heads/a/b@yyyy-mm-dd-hhmmss
refs/heads/a/b/c@yyyy-mm-dd-hhmmss

with the time they were deleted?

-Alexey.
