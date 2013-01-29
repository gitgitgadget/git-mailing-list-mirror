From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 1/4] mergetool--lib: Simplify command expressions
Date: Tue, 29 Jan 2013 14:09:21 -0800
Message-ID: <CAJDDKr4CFyQrAec3jCxyDCx0+4BMXmQAciG1YcnMYS=PAeW-Mw@mail.gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
	<1359334346-5879-2-git-send-email-davvid@gmail.com>
	<20130129192204.GC1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0JNB-0000AO-Em
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 23:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab3A2WJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 17:09:23 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40942 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3A2WJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 17:09:22 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn17so2972020wib.12
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=QgenruYJaSsJ8lUehMMbEtj7xO6KSeJNTFF8S1pYZKc=;
        b=G0SBdm5LGdPqK96LDM39Oe94GUq167SWUerAjdoXkXfY5ikmxxPPcb0eCbnhTWI1sJ
         zOcPyrP1asTofNW6Ilm7/+3FNwi+YU2SiAIZE63N8zy5ZLtWDs1byE3XRzemJ9cB4Y3g
         n+8ht0E3+j3EaYOy/O0587Ti6ljT2yCVn7S3RloKNrGGQBKh9u7tPQ/VIP6JsBJ2gcuB
         FBmjBWdT9XgQ/tpNDlT/FZbioKG1DFwtPp/Y7SXWCC74ITizxKbnwgyna/z3IcEhwBsQ
         06W3fVvNvcY8I3C0ns8XKjfua5LtXNsn6dWngcINV8nu5jPYuNVknNOSi751hnRhfejx
         y9yg==
X-Received: by 10.194.58.175 with SMTP id s15mr5108882wjq.31.1359497361178;
 Tue, 29 Jan 2013 14:09:21 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Tue, 29 Jan 2013 14:09:21 -0800 (PST)
In-Reply-To: <20130129192204.GC1342@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214974>

On Tue, Jan 29, 2013 at 11:22 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Jan 27, 2013 at 04:52:23PM -0800, David Aguilar wrote:
>> Update variable assignments to always use $(command "$arg")
>> in their RHS instead of "$(command "$arg")" as the latter
>> is harder to read.  Make get_merge_tool_cmd() simpler by
>> avoiding "echo" and $(command) substitutions completely.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> @@ -300,9 +292,9 @@ get_merge_tool_path () {
>>       fi
>>       if test -z "$merge_tool_path"
>>       then
>> -             merge_tool_path="$(translate_merge_tool_path "$merge_tool")"
>> +             merge_tool_path=$(translate_merge_tool_path "$merge_tool")
>>       fi
>> -     if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
>> +     if test -z $(get_merge_tool_cmd "$merge_tool") &&
>
> This change should be reverted to avoid calling "test -z" without any
> other arguments, as Johannes pointed out in v1.
>
> The rest of this patch looks good to me.

You're right.  My eyes have probably been staring at it too long and I
missed this (even though I thought I had checked).

Junio, how would you like these patches?
Incrementals on top of da/mergetool-docs?

I won't be able to get to them until later tonight (PST) at the
earliest, though.
-- 
David
