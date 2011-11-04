From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: [PATCH] http-push: don't always prompt for password
Date: Fri, 4 Nov 2011 19:34:58 +0100
Message-ID: <CAJzBP5TdwZ4AhY6cosLOhcmxLfBA8hX7G9nBhiaLKYmMgPcyfQ@mail.gmail.com>
References: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
	<1320390188-24334-1-git-send-email-stefan.naewe@gmail.com>
	<7vlirvdeb2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 19:35:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMObb-0007p7-HT
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 19:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab1KDSfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 14:35:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57773 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab1KDSe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 14:34:59 -0400
Received: by gyc15 with SMTP id 15so1701765gyc.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=593t9hFpOUL0evZpczBpgOp3zLOPV4P+4IF9RHwFFW0=;
        b=tBGe7ttY7SkMcfASDziI35TSWolbs5QY/AIjQe5/vQyH+BRkA/0e7Ko/Pj+eP5Wc8i
         2ro5jBdSpmMbo6j3YQx5569YY7GTtJuNDKa4qfrSj8JnjAR94nzBRydWJdvkbEKzTFU+
         QDejQRtl+8HEoJ88VjHY5EY+I6Ig6H/GDfOjk=
Received: by 10.101.185.16 with SMTP id m16mr3970157anp.157.1320431698907;
 Fri, 04 Nov 2011 11:34:58 -0700 (PDT)
Received: by 10.100.33.12 with HTTP; Fri, 4 Nov 2011 11:34:58 -0700 (PDT)
In-Reply-To: <7vlirvdeb2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184795>

On Fri, Nov 4, 2011 at 5:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Naewe <stefan.naewe@gmail.com> writes:
>
>> http-push prompts for a password when the URL is set as
>> 'https://user@host/repo' even though there is one set
>> in ~/.netrc. Pressing ENTER at the password prompt succeeds
>> then, but is a annoying and makes it almost useless
>> in a shell script, e.g.
>>
>> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
>> ---
>
> Thanks.
>
> With this the only callsite of init_curl_http_auth() becomes the one after
> we get the 401 response, and this caller makes sure that user_name is not
> NULL.
>
> Do we still want "if (user_name)" inside init_curl_http_auth()?

Dunno...
I think what Peff says makes sense.

> I tried to rewrite the proposed commit log message to describe the real
> issue, and here is what I came up with:
>
> [...]

Looks good to me.

> What is somewhat troubling is that after analyzing the root cause of the
> issue, I am wondering if a more correct fix is to remove the user@ part
> from the URL (in other words, document that a URL with an embedded
> username will ask for password upfront, and tell the users that if they
> have netrc entries or if they are accessing a resource that does not
> require authentication, they should omit the username from the URL).

Don't get me wrong, but I really don't care.
I just wanted to have that issue fixed, to get my scripted 'multi
repository pull' working
again.

Regards,
  Stefan
-- 
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode('hex')"
