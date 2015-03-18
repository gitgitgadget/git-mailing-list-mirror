From: Junio C Hamano <gitster@pobox.com>
Subject: Re:
Date: Wed, 18 Mar 2015 14:33:01 -0700
Message-ID: <CAPc5daXkiwyAF+rXH6ywN-An5F7rHCa0-QVY72LkeeTpAsRisQ@mail.gmail.com>
References: <CANSxx61FaNp5SBXJ8Y+pWn0eDcunmibKR5g8rttnWGdGwEMHCA@mail.gmail.com>
 <CAPc5daWNTm5qtd1HJdgQ+-yqUpeMaMmK_UuUiyhxCF6gD3K9dQ@mail.gmail.com>
 <CAGZ79kZwmvZyye-3pHCbDgXhuQTQ8OsgtomK7BtR86qqU1koxQ@mail.gmail.com>
 <20150318211716.GC3376@peff.net> <20150318212852.GA28860@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Alessandro Zanardi <pensierinmusica@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLbr-0004Z1-Fz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932AbbCRVef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:34:35 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35589 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829AbbCRVee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:34:34 -0400
Received: by oiag65 with SMTP id g65so49469585oia.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jfwN88li5hrIR/SLMNWqp90PODvE87oZkwgNphZeAGU=;
        b=W4mG8LK8IuqPQg7msBt6zw3nZcbCfvO4gTqUtwmSHLyADfzXHrrbcM0Y8f1bYTp7Xo
         PyIbHyJcBaU0VHSFvtN8VHTqehTTTj+RI00lKRKA6GnYiQOx8lkXFlgoD3wAbPU9AC4h
         T9krlC/6YF/KMHsG7E6s+mvt/Zi2ozAw/w9TT20k91b9RbFlouJa7uJigzifI7YVzYRZ
         JwvZL4Xdd/9RSeH6cOgryQMsDM3R0XQyZmNMTCwg5+MAYZwLHC0TPo5SDyutOhGHPFqB
         2YavtfFy7WsWClYkY2EhbFEK5XHZfefQsudjn/cH+DXoLpxhdvKCZ/d/Ex4hFNaEmQ/0
         hpXA==
X-Received: by 10.182.28.135 with SMTP id b7mr41249738obh.61.1426714474067;
 Wed, 18 Mar 2015 14:34:34 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Wed, 18 Mar 2015 14:33:01 -0700 (PDT)
In-Reply-To: <20150318212852.GA28860@peff.net>
X-Google-Sender-Auth: -hsO_tIdOEhPcdS41i9bU-edVv4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265766>

On Wed, Mar 18, 2015 at 2:28 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 18, 2015 at 05:17:16PM -0400, Jeff King wrote:
>
>> [1] The double-CR fix works because we strip a single CR from the end of
>>     the line (as a convenience for CRLF systems), and then the remaining
>>     CR is syntactically significant. But I am surprised that quoting
>>     like:
>>
>>       printf '"Icon\r"' >.gitignore
>>
>>     does not seem to work.
>
> Answering myself: we don't do quoting like this in .gitignore. We allow
> backslashing to escape particular characters, like trailing whitespace.
> So in theory:
>
>   Icon\\r
>
> (where "\r" is a literal CR) would work. But it doesn't, because the
> CRLF chomping happens separately, and CR is therefore a special case. I
> suspect you could not .gitignore a file with a literal LF in it at all
> (and I equally suspect that nobody cares in practice).

What does the Icon^M try to catch, exactly? Is it a file? Is it a directory?
Is it "anything that begins with Icon^M"?

I am wondering if we need an opposite of '/' prefix in the .gitignore file
to say "the pattern does not match a directory, only a file".
