From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/4] notes: document cat_sort_uniq rewriteMode
Date: Fri, 14 Aug 2015 15:11:01 -0700
Message-ID: <xmqq4mk1h66i.fsf@gitster.dls.corp.google.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:11:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNBt-0001bC-7B
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbbHNWLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:11:04 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34358 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbbHNWLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:11:03 -0400
Received: by paccq16 with SMTP id cq16so24205554pac.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DmhGDqWXPtORz+HL5vQHHiiZcnJl8IW0U49rRTMmpUM=;
        b=uOXKvBHtydJZHyMtkdQE/nQm3UJF3HsteVjkfnnjXE6W4tK2WgVpkQCiLuT/9ijI7o
         Mq+YjeCPLTHATaVW28cP6+PSZQUDedF2kU5IRh5v9UxfkAT19nEW/1lT1nwoj3hcDJis
         VZfg0QTNSbqdDE6wpS7j+Uu96TbEAXgfbVvomtbqJFJIjIacqSqOp+GgqPUy+nm5pBjY
         fyiuNZJcEhlRU6hgI6vo63EomBAfFoc8d9TFY3s8teV+9qwlR9cMd/7IDFIIxDK7y8q1
         N8HOWAEWllo/hKEuaHj/ozCRDd0giDOsti4QJ0DSCIH0eKM+JDG8u5CDFShGrwzmNVWw
         anGg==
X-Received: by 10.69.2.69 with SMTP id bm5mr91124020pbd.41.1439590262540;
        Fri, 14 Aug 2015 15:11:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id pi9sm7085750pbb.96.2015.08.14.15.11.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 15:11:01 -0700 (PDT)
In-Reply-To: <1439586835-15712-2-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Fri, 14 Aug 2015 14:13:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275967>

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 75ec02e8e90a..de67ad1fdedf 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1947,8 +1947,8 @@ notes.rewriteMode::
>  	When copying notes during a rewrite (see the
>  	"notes.rewrite.<command>" option), determines what to do if
>  	the target commit already has a note.  Must be one of
> -	`overwrite`, `concatenate`, or `ignore`.  Defaults to
> -	`concatenate`.
> +	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
> +	Defaults to `concatenate`.
>  +
>  This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
>  environment variable.
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 851518d531b5..674682b34b83 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -331,7 +331,8 @@ environment variable.
>  notes.rewriteMode::
>  	When copying notes during a rewrite, what to do if the target
>  	commit already has a note.  Must be one of `overwrite`,
> -	`concatenate`, and `ignore`.  Defaults to `concatenate`.
> +	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
> +	`concatenate`.
>  +
>  This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
>  environment variable.

This obviously is not a problem introduced by this patch, but I
wonder why we have two similar but different set of modes for
rewrtie and merge.  Isn't 'overwrite' like 'ours', 'ignore' like
'theirs', and 'concat' like 'union', and if these are similar
enough, perhaps it would be helpful to the end user if we unified
the terms (or accepted both as synonyms for backward compatibility)?

Also I notice that you cannot manually reconcile while rewriting;
don't we want to have 'manual' there, too, I wonder?

[jc: Cc'ed Thomas who invented rewrite back when merge was not even
there, and Johan who added merge]
