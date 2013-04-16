From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Tue, 16 Apr 2013 16:39:26 +0200
Message-ID: <CABPQNSZwc8Ae_fGwvyEq84NuBNntB7-KXnJtqt9ZLowCJof9Gw@mail.gmail.com>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
 <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
 <7v4nf7qzkd.fsf@alter.siamese.dyndns.org> <CABPQNSaA7Qdt5eCZR3rs87gL730Y_xMrg6S-++YuaXdC2k45jg@mail.gmail.com>
 <7vsj2rpj0j.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 16:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US73P-0002sw-ME
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 16:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935797Ab3DPOkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 10:40:09 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:42181 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935469Ab3DPOkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 10:40:08 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so479137iad.7
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+z9JgJu5f0NVLYm3RkBnnMri/grnT8yS4IkF2pypm+4=;
        b=RRKoT3Ux9FWGkLmijLNqIh6ujm1BYEBDS2kh2olQrD3ODyCHNeKqgQA2vIFz332oOr
         jJMDeKRzR/ZB3fJEd8jQvLLsFzytM1LEme3BnPtndOj26BO/Rc2v7zJH8xzvzILMBY7O
         rrSPM2H6gHas6QBp1D1wgM52JuWa00UqoxJnCPYzREmj18SAJTxKwPAtQs/hBTt0MAku
         iPYbw2ihyxakuGdcJMMq5RWbdZ5Vl0nTq0dD+v28/zJtYzjAWYQd0QBAQVYbfoGgbzwh
         J+gwYSWglxqCTeVgmXhhvYaDYOaxcb9Zi5AYgjuHFjRuCiKjGIZHivMn1LNLEje491Ie
         jLHQ==
X-Received: by 10.50.93.71 with SMTP id cs7mr1452383igb.53.1366123207546; Tue,
 16 Apr 2013 07:40:07 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Tue, 16 Apr 2013 07:39:26 -0700 (PDT)
In-Reply-To: <7vsj2rpj0j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221421>

On Mon, Apr 15, 2013 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> This is absolutely the right thing to do. However, stuff have changed
>> a bit since the patch was written; this change now needs to go in
>> config.mak.uname instead of config.mak.
>
> Thanks for a quick response.
>
> What's your preference?  I could just ignore a patch I won't be able
> to test myself and have you guys carry it in your tree forever, but
> I do not think that is necessary for something small like this.

I should probably clarify; conceptually, this is the right thing to
do. Git for Windows is a Windows application, and should have CRLF as
the native newline. I hadn't tested this patch myself, though. Our
tree is currently way behind yours, and I tried to do a rebase, but it
turned out much trickier than I was hoping for.

I've given it a go on top of your tree + some essential patches I'll
need to get things to run, and it seems to do what it claims to do.
However, I haven't been able to run the test-suite, because I need a
bunch more patches from the msysGit-tree for that.

> I think this is low impact enough that it can directly go to
> 'master' or even 'maint' if I were to apply to my tree.
>

I agree. I don't think we need it in maint; we don't track that branch
for msysGit.

> Thanks.
>
> -- >8 --
> From: Jonathan Nieder <jrnieder@gmail.com>
> Date: Sat, 4 Sep 2010 03:25:09 -0500
> Subject: [PATCH] convert: The native line-ending is \r\n on MinGW
>
> If you try this:
>
>  1. Install Git for Windows (from the msysgit project)
>
>  2. Put
>
>         [core]
>                 autocrlf = false
>                 eol = native
>
>     in your .gitconfig.
>
>  3. Clone a project with
>
>         *.txt text
>
>     in its .gitattributes.
>
> Then with current git, any text files checked out have LF line
> endings, instead of the expected CRLF.
>
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> Cc: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 9080054..d78fd3d 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -507,6 +507,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>                 compat/win32/dirent.o
>         EXTLIBS += -lws2_32
>         PTHREAD_LIBS =
> +       NATIVE_CRLF = YesPlease
>         X = .exe
>         SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
>  ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
> --
> 1.8.2.1-542-g3613165
>

Looks fine to me.
