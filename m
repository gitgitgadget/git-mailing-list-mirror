From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default remote branch
Date: Mon, 21 Sep 2015 10:16:49 -0700
Message-ID: <xmqqd1xbbsla.fsf@gitster.mtv.corp.google.com>
References: <CAByu6UUxsWu5RVar=8uKJw3kZpxjawqbwABgNREjJ3g3mGDwVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Thibault Kruse <tibokruse@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:16:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4i0-0005dc-3v
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbbIURQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:16:52 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35389 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbIURQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:16:51 -0400
Received: by pacfv12 with SMTP id fv12so124335720pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nV3eDyJKJB7BSo/ljKT4TyiCQI7mvIFqgtemqhiG96Y=;
        b=gyFgYB64C3FhPnq5js/UJcuIa7lce8XUGtTkuI+9vKlRmO7b4NfdK6PFUu2BdH/Gv3
         b1t1WXf0bnsoHRV+mgmVYP7lUYWn2XbzFA+F9bQNHpSoLAMRrEPOxcgyMGyq8SsaKyoA
         hN3Sk6NabpJizzeHqjPhdLw+SvJIb3cuo/nkTsD+rUR1lsrNN21ChUZewvz8yVDnYAS+
         iPKx9Of89pPJrukD0dfmKp+xItahWBqvaXAqYkwaCFPKaxRIWvi70WjA7RS6xvcjeBQf
         vkaroLF6u7SNa+bEvZoMdj6+29V+gRyQ9BvrVDwFrzneHSwUd4373wCVsVe/VGIkdtij
         uRXQ==
X-Received: by 10.66.186.141 with SMTP id fk13mr25609339pac.7.1442855810869;
        Mon, 21 Sep 2015 10:16:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id yq2sm25539286pbb.39.2015.09.21.10.16.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 10:16:50 -0700 (PDT)
In-Reply-To: <CAByu6UUxsWu5RVar=8uKJw3kZpxjawqbwABgNREjJ3g3mGDwVA@mail.gmail.com>
	(Thibault Kruse's message of "Fri, 18 Sep 2015 11:50:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278314>

Thibault Kruse <tibokruse@googlemail.com> writes:

> Also, I tried finding out whether I can use the
> .git/refs/remotes/<remote>/HEAD to check the default branch without
> accessing the remote. However, I find this file is not updated with a
> git fetch, nor created when missing.

That is more or less deliberate.  Which one of the branches to
consider the primary one becomes a local decision after you clone.
If that was a good choice may be debatable, but that is how existing
users expect things to work.

> So is there a sane way to get the last know default branch without
> accessing the remote?

"The last known" is not updated, due to "where remotes/origin/HEAD
points at is a local matter" design; there is nothing that locally
stores the information you are asking for, so there is no offline
way to answer that question.

An early part of the protocol exchange "git clone" does carry that
information, but I do not think there is a command to ask that to
the remote.  A logical place to add it would be a new option to "git
ls-remote", I would think.
