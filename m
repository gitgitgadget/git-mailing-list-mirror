From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 14:56:14 -0700
Message-ID: <CAGZ79kaUPf=kBCuH__8BahjM3WjSGaijiQr05pMKe+TNdg3W9w@mail.gmail.com>
References: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:56:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDEr-0000bq-LZ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbcCXV4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:56:17 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38421 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbcCXV4P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:56:15 -0400
Received: by mail-ig0-f179.google.com with SMTP id ig19so1972120igb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2RoS9hgg60wp0GUR9WkW/AlgrhPa+5kLAWNAuWAgquU=;
        b=CQf9RsjVqrUpM2J/S2RDSS2rNVYxIEj712NJiKcVJAO+Q9uBXwgRGbAkC5VmkcLTDp
         PP+D3Lxy78i1/JcazsAJjJVzx2cJ6iLSunr9lII0tbtbgneahDkOqLDhzpc+d43oEdd2
         y83JcuEFaJ7ozzMQgEFyyhpe63KR5yVVufM7bgfGesXpqg9ZNbbbON12nNuGD3cMsbRk
         R56ln3f8g1NaYFFljvvv7dQKk6heIqHaICXzQB/rTXMUEQe167Ne/M0z1j/hhXLofeUt
         oqnUIZiGPrnwfe8WtVpYsUgigzAc9vBWbCdC6qyq8dYozsbVCaC///m0JqSKT6t2WacJ
         uSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2RoS9hgg60wp0GUR9WkW/AlgrhPa+5kLAWNAuWAgquU=;
        b=jTWfkxiSaw8MLV3M+3pcqTLgh/v0GJ/4qDm9gPK1Q1NsyF+6ZO4omZK3upGvMfmESj
         1ePO34PQQ+ktgmA0axldUjIc/OUnN1hVwGL7LIye5D32B8FMhgCyyUVpbxjx722jGY6v
         qI6Fmcr3I/uHLPlP9qtfeGaeglGqXymnDDyFE58mbyf89CY3D6Ub1o70h5Zqsls7ET8j
         GSJ31s92AZfDqYbsCp6Cl760nWwjrt+p93aqEVQNBWSgNCKEa6e1rdk2zrfY+7O65DH3
         F7Neo3SXwL+wcGVXoqRa2O7cRxh4RrGC9nd2RtUuw06604nIeFAuEy//ncpa9vk9IjxF
         mh4w==
X-Gm-Message-State: AD7BkJL+vDwh0q22Rm60HgtpcBAO2kd8Rs429IntiCoG8mCVRYgVUpenSU4vj5iL/fxQa7wVdlu314Dczn0qcTYB
X-Received: by 10.50.13.34 with SMTP id e2mr25951111igc.85.1458856574673; Thu,
 24 Mar 2016 14:56:14 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Thu, 24 Mar 2016 14:56:14 -0700 (PDT)
In-Reply-To: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289809>

On Thu, Mar 24, 2016 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Discuss.

> For example, I keep
> a backup version of whats-cooking.txt in the working tree that I use
> to manage the 'todo' branch as whats-cooking.txt+, and this is not
> explicitly "ignored".

Completely side tracking thought: Have you considered ignoring
whats-cooking.txt+ locally?

WC+ is a local thing to your repo, so you'd want to prefer
$GIT_DIR/info/exclude over .gitignore.

You wish to ignore WC+ by git, so make it be ignored,
instead of changing the git add rules. Your proposal
feels like fixing the symptoms instead of the root cause.

I can see (3) being useful as it narrows down the list
by a lot, I would imagine.

As I rarely use git add, but prefer git-gui, I have no experience though
for git-add completion, but if you had one conflict after a bad merge
you can just do git add <TAB> to get that file(?), so I guess people use it.

Stefan


>
> Thanks.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
