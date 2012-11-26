From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Mon, 26 Nov 2012 12:37:07 +0100
Message-ID: <CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
	<7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 12:37:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcx0D-000885-2m
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 12:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296Ab2KZLhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 06:37:09 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48745 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab2KZLhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 06:37:08 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10582057oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 03:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2xb0OzrpWN/YkE+7f1q8z4k5/WOYLXOfXkIL3HodNsY=;
        b=xg+Tc7cnlggO2NYxEpAnVx9zZ8sTC5ycA79JKPpeTIu9mlDKHEwnS4UbfR33/lCovn
         PIgVpM1qWHOGf1LwNLc+eFdk5I8Toi2DCK5U8vUT1AbL7t8NgKsljPuE3J5QavGxlKxk
         wlPnQ8LJ/rQC7d0naCL9ovJqyxSX6rrxtzrZBSI077dboJ3XAIhxSb6Z+Ul37cdeClbK
         xlB+Q5obAsd8QqQNjoAhtHdBN48IONRPzq13WlMwNWPZVBl99acVoefbsDaYIXeFM06A
         bPaIykJWIwfjzDC8+4Hhc3D61IaC7aVBsI7Vji9c3E43Fmv44kNV1IcQsyICh3r20IQ9
         ns8Q==
Received: by 10.60.30.70 with SMTP id q6mr8728159oeh.103.1353929827610; Mon,
 26 Nov 2012 03:37:07 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 03:37:07 -0800 (PST)
In-Reply-To: <7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210433>

On Mon, Nov 26, 2012 at 5:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> fast-export can fail because of some pruned-reference when importing a
>> mark file.
>>
>> The problem happens in the following scenario:
>>
>>     $ git fast-export --export-marks=MARKS master
>>     (rewrite master)
>>     $ git prune
>>     $ git fast-export --import-marks=MARKS master
>>
>> This might fail if some references have been removed by prune
>> because some marks will refer to non-existing commits.
>>
>> Let's warn when we have a mark for a commit we don't know.
>> Also, increment the last_idnum before, so we don't override
>> the mark.
>
> Is this a safe and sane thing to do, and if so why?  Could you
> describe that in the log message here?

Why would fast-export try to export something that was pruned? Doesn't
that mean it wasn't reachable?

Essentially, if 'git rev-list $foo' can't possibly export this pruned
object, why would 'git fast-export $foo' would?

Cheers.

-- 
Felipe Contreras
