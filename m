From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the callback 
	data of git-config.
Date: Mon, 16 Mar 2009 12:46:31 +0100
Message-ID: <1b46aba20903160446y34bf106ai100b8231a54699ab@mail.gmail.com>
References: <1237015035.9952.10.camel@luis-desktop>
	 <7vprgjakpz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 12:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjBJh-0005V4-8V
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 12:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbZCPLqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 07:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755837AbZCPLqf
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 07:46:35 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:52113 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbZCPLqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 07:46:34 -0400
Received: by fxm24 with SMTP id 24so3443811fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ertvF+OrPBUN9pkGsMY/3gDx55kLARUjFcGudi2EfJo=;
        b=QVuS/rr/4J4X32nR4M3oAvEBe+B7pxWXIQkzVA0DkvgatXOpU7kmtrpIQHzm12X5d1
         D53UPixOyxU7FoVTtroxOuyqLMx8HkZDyZnj6zJExUmH3+c2YIbZqowh5t3+1cbtKeIk
         bHn3bkK1OQDU6TMYKKej72D41t91Zs1E2aon4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iFYqpnD8/ehSc5JXgPTuGgZpuvcnQJgBg0aJMxS17MdktCFjejKngwUL5RLMrwtuna
         fj54eTMPWcfFrkTtiqFHNhpCorgnom8MNrbWIH/QFQHnkixrDWQF+HbJ96Wk27q/tfot
         uc1QXo37evVm2OQsMc577Bf/+lfEekApIuvbI=
Received: by 10.223.113.200 with SMTP id b8mr3149522faq.84.1237203991641; Mon, 
	16 Mar 2009 04:46:31 -0700 (PDT)
In-Reply-To: <7vprgjakpz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113321>

On Sat, Mar 14, 2009 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Carlos Rica <jasampler@gmail.com> writes:
>
>> Signed-off-by: Carlos Rica <jasampler@gmail.com>
>> ---
>>
>> Here I declare a struct to wrap the new local array along with its size.
>> QUESTION: An alternative to this is strbuf, would it be preferable?
>
> The command already uses strbuf for other purposes, so why not?

strbuf is designed as an unlimited length buffer, and now the user
signing-key id (obtained from the config or as a command's argument)
is limited to the current static array size.

It is right to remove this limit? I haven't found something like
strlcpy for strbuf and I'm not sure if it would be a nice adition:

size_t strbuf_lcpy(struct strbuf *dest,
        const char *src,  size_t max);
