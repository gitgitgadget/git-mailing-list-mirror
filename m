From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Sun, 9 Jun 2013 03:33:38 -0400
Message-ID: <CAPig+cTGwhEEaY3th3++-CU9oeONTLohvY8E_zo25ypViUM=0Q@mail.gmail.com>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 09:33:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ula8G-00020h-Eg
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 09:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3FIHdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 03:33:40 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36485 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab3FIHdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 03:33:39 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so4883690lab.30
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=btgRjKbejuyAMFIDOt6piCUImYYAfnsm83Eog9b3tqQ=;
        b=u6gQu5P72MNofT/AaVvYRQikU8lkRO/vG7WWmQP7KzyWNk1J9QYTs5ypVtJSEyEPV6
         trRZU/uDWcEn8RAOa+mzxuCviLmdSwc/2wP84yBCziJUOkAsIZVvY1SbO/IQP1pxtLGD
         djEiC6i+ldR9Xhg25F85CZOCWWncTfOluv/Shw47AVQe7Jp4BdMclULU6ZPjVV3BgaGq
         xkOm2wPT3pLtyTsCCQaxfhPfnw3XV1o8i4LGXwsCWmsgMgynjkf4h/lnDVC1srhEdmGy
         DLdqYTO/xExXYk2uJyilVJZA+uFfYjTtxMmUumu9e5pv1dGlqHYBgYIyN2rzcfZEWiSh
         4Fig==
X-Received: by 10.112.181.71 with SMTP id du7mr4195012lbc.24.1370763218247;
 Sun, 09 Jun 2013 00:33:38 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 00:33:38 -0700 (PDT)
In-Reply-To: <1370724291-30088-1-git-send-email-apelisse@gmail.com>
X-Google-Sender-Auth: YDMN5ZOLBGZUnAGhGY4Trr6-dfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226941>

On Sat, Jun 8, 2013 at 4:44 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> The goal of the patch is to introduce the GNU diff
> -B/--ignore-blank-lines as closely as possible. The short option is not
> available because it's already used for "break-rewrites".
>
> When this option is used, git-diff will not create hunks that simply
> adds or removes empty lines, but will still show empty lines

s/hunks/a hunk/
...or...
s/adds or removes/add or remove/

> addition/suppression if they are close enough to "valuable" changes.
>
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index d11dbf9..04b4bb1 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -56,16 +56,49 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
>  /*
>   * Starting at the passed change atom, find the latest change atom to be included
>   * inside the differential hunk according to the specified configuration.
> + * Also advance xscr if the first changes must be discareded.
>   */

s/discareded/discarded/
