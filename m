From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help
 listing for vim
Date: Fri, 25 Jan 2013 02:40:24 -0800
Message-ID: <CAJDDKr5ZsqO+PFoUabsZObgvG8jUBfTKL1HmVsn77ZhzsRZk-Q@mail.gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
	<1359107034-14606-7-git-send-email-davvid@gmail.com>
	<20130125103845.GX7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TygiF-0007nI-C4
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab3AYKk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:40:26 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:44948 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab3AYKkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:40:25 -0500
Received: by mail-ee0-f51.google.com with SMTP id d17so111305eek.10
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 02:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lK5151IM0+QS8X1fmgIFdFy0K+jYb9JEqRPtr0zok+U=;
        b=uGhPkfdAFqQr+No3yAxThpM/KuQErF+0qHo3OEuqhJ9Q/IofoTufyINmGBjtrFIpjC
         q8BgWLtVYSrr8Esh6U4no5v/K21whpwcVha7zInCpjNtOr0CsluejZptQTkAlVtU0en2
         w4Ln6itDu8xpnK+ndUhB8H6233K3GzEHXGc5+RfjcVh0UFgJ9bIFZCC7bf8G37ZDaLvd
         xAxIrUqv7yxkEfmSpvH/h3GBmrwhMQwpKw5YCziBCO6yDc5Ph9hbcDYL0ahm523aHHc0
         HNcbWcgPiMRPFiY4E5YyqcV6tweF7u2mPye6nSrVU/vFN6qz8/RRs/cwPQb24WHP752Z
         ElSQ==
X-Received: by 10.14.205.198 with SMTP id j46mr16889708eeo.27.1359110424055;
 Fri, 25 Jan 2013 02:40:24 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Fri, 25 Jan 2013 02:40:23 -0800 (PST)
In-Reply-To: <20130125103845.GX7498@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214542>

On Fri, Jan 25, 2013 at 2:38 AM, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Jan 25, 2013 at 01:43:53AM -0800, David Aguilar wrote:
>> "git difftool --tool-help" and "git mergetool --tool-help" incorreclty
>> list "vim" as being an unavailable tool.  This is because they attempt
>> to find a tool named according to the mergetool scriptlet instead of the Git-
>> recognized tool name.
>
> Actually, after my patches both git-difftool and git-mergetool get this
> right since list_merge_tool_candidates lists vimdiff and gvimdiff.
>
>> vimdiff, vimdiff2, gvimdiff, and gvimdiff2 are all provided by the "vim"
>> scriptlet.  This required git-mergetool--lib to special-case it when
>> setting up the tool.
>>
>> Remove the exception for "vim" and allow the scriptlets to be found
>> naturally by using symlinks to a single "vimdiff" scriptlet.
>
> I wonder if it would be better to make these single-line scripts instead
> of symlinks:
>
>     . "$MERGE_TOOLS_DIR"/vimdiff
>
> where we make git-mergetool--lib.sh export:
>
>     MERGE_TOOLS_DIR=$(git --exec-path)/mergetools

That sounds like the way to go.
-- 
David
