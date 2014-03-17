From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] subtree: initialize "prefix" variable
Date: Mon, 17 Mar 2014 16:08:50 -0400
Message-ID: <CAPig+cSbi7X1z+u8EzXhdMb6_ENbLcTiHyXG0erfpCR=a5BEYQ@mail.gmail.com>
References: <5326F158.4050402@free.fr>
	<20140317195946.GA29839@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gilles Filippini <gilles.filippini@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:09:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdqH-0006Qg-0A
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 21:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbaCQUIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 16:08:54 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:58690 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaCQUIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 16:08:50 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so16328078ykq.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jPGJlN6qPKsRl9eY4cs3xUDiqPK/9qTuGN5Cby/9l2U=;
        b=qt9drhRJCCJtX+CP3penVEHHjHS+Ss38xlbINQEOomAqg6DAT+W/rhGkddx0EuqMmX
         R8xlTIkYSC5AEx1jtO4JSsHaUk50638K1JtxXk186fsq+Rtxay2qLo1mFaPz4QKVxmQA
         SIqS5L9y5ZnCWovtRUkFt9Vwr4In4CctQ7nvs4ay89H9t/TpzTf+yAMMB0vm83B3TTyb
         5SSKbAOfsmajy5W3rpN9OPsvuAbLFMQOkUK09Ha/FlrPL3TKTCayhnzQ0qvvHafDAQVv
         PCT/ws+mdD8oOfWx5sIe2CnnhVbXe2OUIUmjgu32h1N6fxwTSt1nx4hXZk8A1pVCDiKv
         fBTQ==
X-Received: by 10.236.126.81 with SMTP id a57mr11919039yhi.95.1395086930164;
 Mon, 17 Mar 2014 13:08:50 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 13:08:50 -0700 (PDT)
In-Reply-To: <20140317195946.GA29839@sigill.intra.peff.net>
X-Google-Sender-Auth: kq9QQM8-bVd4x0RJOKpHdwdtS9U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244278>

On Mon, Mar 17, 2014 at 3:59 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 17, 2014 at 01:58:00PM +0100, Gilles Filippini wrote:
>
>> Test 21 from contrib/subtree/t/t7900-subtree.sh fails when an
>> environment variable 'prefix' is set. For instance here is what happens
>> when prefix=/usr:
>
> I think it just needs the patch below.

Gilles submitted this same patch [1] a couple weeks ago but it appears
to have been lost in the noise. Your commit message is a bit nicer.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243103/

> -- >8 --
> We parse the "--prefix" command-line option into the
> "$prefix" shell variable. However, if we do not see such an
> option, the variable is left with whatever value it had in
> the environment. We should initialize it to a known value,
> like we do for other variables.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I checked, and this looks like the only variable in this situation.
>
>  contrib/subtree/git-subtree.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index dc59a91..db925ca 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -46,6 +46,7 @@ ignore_joins=
>  annotate=
>  squash=
>  message=
> +prefix=
>
>  debug()
>  {
> --
> 1.9.0.532.gc4c322d
