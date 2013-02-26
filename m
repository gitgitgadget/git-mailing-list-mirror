From: Gunnlaugur Thor Briem <gunnlaugur@gmail.com>
Subject: Re: Better handling of erroneous git stash save "somemessage" --keep-index
Date: Tue, 26 Feb 2013 16:46:49 +0000
Message-ID: <CAPs+M8+5yXz59PiOKwFpkUZkOoR-LA+jt0CWEAPz9Eq9VnaAcQ@mail.gmail.com>
References: <CAPs+M8JvcnTcZiySmpMBuOxek4THRnTx0jkZv7NHaSDNLhcOAQ@mail.gmail.com>
 <7vwqtvm4yr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UANgm-00042Z-A9
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758829Ab3BZQrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:47:10 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57369 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759130Ab3BZQrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:47:10 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so4602002iea.40
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 08:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FWLNgnHrwx+PaLblxkYQ4g9BZmuDq/YKh5w+QondyE4=;
        b=SbyEyu7Essn6L5JSO5cvR4Xk+gP3cdpfVI4nN0sp8O8dBhMl/tNUCGxQO7bNWuui/I
         7SLnWAqBKQmCpBqNMkc2Sgpz+xym2LWBFIXjpjnYBYY5LYUbUi9d96QA8pQe2s7hFRlF
         SUVc8bTaTUZYvCItpKCUMPGbipxuDLjkKHT+HAY92ZmtWcW2KIt9Vu70FEf+xzi5bEyj
         w5gZ4i5/b4+ykAhKyczi6RPwf9IBxkF7QIPrNX6BO8Doobs7hOeZn+f3aDYp2kTCThgx
         ykFvgvHrWrDiflua2BG4xBfKVHEQO60h9rv7OyGY7SKhMOxPXSHx+Gzype2Y92BKBGCb
         gGUA==
X-Received: by 10.42.159.194 with SMTP id m2mr6464105icx.13.1361897229505;
 Tue, 26 Feb 2013 08:47:09 -0800 (PST)
Received: by 10.64.51.130 with HTTP; Tue, 26 Feb 2013 08:46:49 -0800 (PST)
In-Reply-To: <7vwqtvm4yr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217145>

On Tue, Feb 26, 2013 at 4:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Then the user cannot say
>
>         git stash save some message that consists of multiple words
>
> no?  You may have a WIP to enhance the behaviour of one option and
> you might want to say
>
>         git stash save wip: tweak behaviour of --keep-index
>
> to save it away when switching to higher priority task.

In this case (which must be rarer than --keep-index intended as a
parameter) the user gets the error message, the problem is pretty
clear, and the workaround is very easy, quote the message:

        git stash save "wip: tweak behaviour of --keep-index"

... which also is more conventional on the command line.

To minimize the behavior change, it could apply solely for the case of
known parameters to this command (like --keep-index), so that:

        git stash save wip: tweak behaviour of --froob-nob

would still work like before. That's less consistent, but then again,
this is just a matter of catching very likely errors to avoid lost
work.

Expressing a multi-word message without quotes on the command line is
unconventional (in general, though maybe not in the use of git-stash)
so it seems reasonable to let that usage be the one that gets
inconvenienced.

-Gulli

(Sorry about the initial reply to you alone Junio)
