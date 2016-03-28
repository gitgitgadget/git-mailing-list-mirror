From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Mon, 28 Mar 2016 21:37:55 +0800
Message-ID: <CAKqreuyrENgmB+a7eAHNx9fA4RsQu2PwjLV1wc2z7=kzNTseUw@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	<xmqqpoui4huo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 15:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akXMn-0000ON-EG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 15:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcC1Nh6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 09:37:58 -0400
Received: from mail-ob0-f195.google.com ([209.85.214.195]:33165 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbcC1Nh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 09:37:56 -0400
Received: by mail-ob0-f195.google.com with SMTP id do7so9611607obb.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=M+dA8QfmhmWe0cjPZ8OwD9LOFlX7fGv7rbuvrEoLjkc=;
        b=vYaLRHkkTzrBUApShOe4bsG5XGTHXLxphkGT/8UKaBkBFpYrzVirKXmsGdUFn0Tw2n
         7IbmjDx1+THv+dEAZidxkswgmYf0KdRIVPCk0JNWY5uf0kkYwaNnyFelHCYq2lQtcTlJ
         fCc5Os8F3lu9bvbnhh66Hxzpntpy2JbTO22qGRDhG09UDxTxho9iTnBXiZENA8oHrhzY
         Lcm1taZiZIaITNnUz8O8qQ2wuDouio6yrdIvpiSm75yq/dHevmO9HQ581EIi2gllwC6M
         tKY3VTET4kdV/N/jpLoXbCx3Z5H5yRkibpcCBkbw23A+V8NYfvC3j33mT020h4aMVQ9u
         qjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=M+dA8QfmhmWe0cjPZ8OwD9LOFlX7fGv7rbuvrEoLjkc=;
        b=SWuXPZJqutH3hPCsFwek0qMxMwUZB2jfDIZivq1+n+aD5eB6wk9oECGrwMFp9UJdBx
         ArS+KdGmuw33FvkNmijq/5Ylu+Aa4XJzXzYclufFsUjpIGZgDAcJ8KpbEA4Nh2V6D9Ez
         aWrMrbqA4iJMfRvspctEg9pz9nuKVYCjHn7znTUgRhphXYwIufsUqdBKF7+9tU/exHvK
         2pQp8XhfnSdd35gujlgj8wXBx+9Vnre+qvfZQ/YIA52870V0ErzRd8/uiDm90uJnAO8n
         CHlJNPRrHDWY3AFCGt8ZDpaQTEINi5TVKLLks+kL1RfMuhWId4EOGgPzUWC3aErecz98
         nauA==
X-Gm-Message-State: AD7BkJJ8Ll9D2rcdhg/IO/53LfC2OslrFpcVL+7ZBtV+MEgu2WoutE9YE5o4qoDvilRcchQ+lTBmY5Cwi7glDg==
X-Received: by 10.60.141.227 with SMTP id rr3mr11672889oeb.57.1459172276037;
 Mon, 28 Mar 2016 06:37:56 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 06:37:55 -0700 (PDT)
In-Reply-To: <xmqqpoui4huo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290033>

2016-03-26 0:55 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>
>>> There's a lot of "what" here that the caller doesn't really care ab=
out,
>>> and which may go stale with respect to the implementation over time=
=2E Can
>>> we make something more succinct like:
>>>
>>>   /*
>>>    * Return a path suitable for writing run-time files related to g=
it,
>>>    * or NULL if no such path can be established. The resulting stri=
ng
>>>    * should be freed by the caller.
>>>    */
>>>
>>> ?
>>
>> That's clearer, but if I were the caller, I would worry about the
>> security of the path.
>> How about adding:
>>
>> The security of the path is ensured by file permission.
>
> Is "by file permission" descriptive enough?
>
> To protect /a/b/c/socket, what filesystem entities have the right
> permission bits set?  If the parent directory is writable by an
> attacker, the permission bits on 'socket' itself may not matter as
> the attacker can rename it away and create new one herself, for
> example.
>
>> I will deal with it.
>>
>> I find there are some similar leakage in this file. I'll fix them in
>> another patch.
>>
>> Do you think we need some additional comments for the release of str=
buf?
>
> As Documentation/technical/api-strbuf.txt has this, I think we are
> already OK.
>
> `strbuf_release`::
>
>         Release a string buffer and the memory it used. You should no=
t use the
>         string buffer after using this function, unless you initializ=
e it again.
>

Excuse me, but I could not find `Documentation/technical/api-strbuf.txt=
` in
master branch. Do you refer to the header of `strbuf.h`? In which, I le=
arnt how
to initialize the strbuf and how to take use of it when I began to use
it. If there
is also a note about whether I should release it and how do it, such as=
:

=46or every strbuf that has been initialized and buffer of it has not
been detached
with strbuf_detach, you should release the resource by strbuf_release.

It will save me (maybe others) much time to explore the entire method l=
ist.
