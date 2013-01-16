From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] Allow custom "comment char"
Date: Wed, 16 Jan 2013 09:17:40 +0100
Message-ID: <CAN0XMOJPgGXUeOBC=ubO0d7NweEihJvQbf2O6wxazh4juLi02g@mail.gmail.com>
References: <7vk3rk25iw.fsf_-_@alter.siamese.dyndns.org>
	<1358275827-5244-1-git-send-email-ralf.thielow@gmail.com>
	<7v622y45wy.fsf@alter.siamese.dyndns.org>
	<7vmww9zlwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 09:18:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvOCA-0002yP-J6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 09:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708Ab3APIRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 03:17:42 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:53187 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab3APIRl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 03:17:41 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so662766wgb.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 00:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=k5qMWJsnddAfdU4qDVLGgdpeBlVC9wblEaYJL8xOMaA=;
        b=rr+kt9mHRBpVpRZvYSCrWtdik7Tr2tg9KTx+/FRaliBEIh/HyUluyk8qEQvteuVDL/
         3gxfN5NyR2ZIV9HwcInlFWJaYx988ti4JrWG98KXFRxzqFBpScDf4ajTeHc3OEngfa8H
         gACO/zYi4rhbMqIrckNlbuiBTdN4BYpRhBW6302Fz6SAcjNXmaWReeImPX3SX1hT7aZ4
         Lh7e0z4Gg4tCkdOhqkToWCClWCCGqh0f65Ln5sk4tVRhxQRUxkpWB7QDG5IddnKgkkyA
         XyncJahCyH9gjRdkgO9caa7Wxsa0xi9ZAjMZkHgI7i8IhSPLJFv6em29O6K3h1I7wvSb
         KpVg==
X-Received: by 10.180.87.73 with SMTP id v9mr416651wiz.26.1358324260500; Wed,
 16 Jan 2013 00:17:40 -0800 (PST)
Received: by 10.194.139.207 with HTTP; Wed, 16 Jan 2013 00:17:40 -0800 (PST)
In-Reply-To: <7vmww9zlwj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213737>

2013/1/16 Junio C Hamano <gitster@pobox.com>:
>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>> index 22ec5b6..1b8d95f 100755
>>> --- a/git-submodule.sh
>>> +++ b/git-submodule.sh
>>> @@ -975,13 +975,19 @@ cmd_summary() {
>>>              echo
>>>      done |
>>>      if test -n "$for_status"; then
>>> +            comment_char=`git config core.commentchar`
>>> +            if [ ! -n "$comment_char" ]; then
>>> +                    comment_char='#'
>>> +            elif [ ${#comment_char} -gt 1 ]; then
>>
>> Not portable, I think.
>>
>>> +            echo "$comment_char"
>>> +            sed -e "s|^|$comment_char |" -e "s|^$comment_char $|$comment_char|"
>>
>> Can $comment_char be a '|'?
>
> I think it may be the easiest to teach one of the pure-helper
> commands, e.g. "git stripspace", to do this kind of thing for you
> with a new option.
>
> To summarize, along the lines of the attached patch (on top of
> jc/custom-comment-char topic).

Very good idea. I'll integrate.
Thanks
