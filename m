From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 11:18:44 -0700
Message-ID: <xmqqtwuwh8fv.fsf@gitster.dls.corp.google.com>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
	<1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqiobcy9yt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 20:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy2OU-0004Xs-Rg
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 20:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbbE1SS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 14:18:58 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35833 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbbE1SSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 14:18:48 -0400
Received: by igbyr2 with SMTP id yr2so119529385igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gOgpeze3b3Erk+XEOjC91K/1oCN8AJbTvfFkIwnD5l4=;
        b=vAgovmFt2bBqimLUooN862QIGFMwRhyWZHa+5eOocI18Ok9jXl9oIFnyu2fH4W9i3j
         jVD17EC6Oc6ZJP58hHjnm7hgiLdrxk5xAXs2JEJfmNaBFlDM/etWhMqdNDuPKyz7Pt3l
         jgcjf8LfX3RE1Hzjr2D8JTZ4x+fZD2CqiZq8/dH0aVkA0uW6OumyivLB3BeQF/jS+CaO
         xmf11mVOSC6eKtG/M/kbs2AHO9C/UrDbpbMID8FLvPOFlB0Tjt2ZrQdKhVSqGNf1SRxS
         wf2meEJCoaE6jCWGO+jS8AVVSKrZCki1ZU0SjWjEX+dJk11hfVB3QutkOR3RvdfOGg5f
         80Tg==
X-Received: by 10.50.43.227 with SMTP id z3mr12947135igl.12.1432837128229;
        Thu, 28 May 2015 11:18:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id ot6sm4845497igb.11.2015.05.28.11.18.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 11:18:47 -0700 (PDT)
In-Reply-To: <vpqiobcy9yt.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	28 May 2015 17:53:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270175>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But I think there are more relevant information to show (e.g. list of
> already applied commits, remaining list of commits, possibly truncated
> if the list is overly long, and information that rebase gave you when
> stopping like the path to the file being applied). Having them all in
> "git status" would make the output really long, for little benefit in
> day-to-day use.

Sorry, I do not quite agree with this reasoning.

Isn't "git status" during a rebase that shows "really long"
information to help the rebase operation a good thing?  In
day-to-day use when you are not in the middle of rebase, the command
would not show what remains to be done, would it?

I may be biased, because I rarely use 'git status' while running
'git rebase' (with or without interactive).  But to me, 'git diff'
would be a more appropriate tool to help me unstuck in managing the
current step of conflict resolution than 'git status' gives me
during either a rebase or a merge as "Unmerged paths" anyway.

If this topic enhances 'git status' with the in-progress rebase
information, I'd view it as turning 'git status' from 'a more or
less useless command during rebase' to 'a useful command'.
