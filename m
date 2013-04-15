From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 09/12] pretty: add %C(auto) for auto-coloring on the
 next placeholder
Date: Mon, 15 Apr 2013 19:54:44 +1000
Message-ID: <CACsJy8A6vMxZLn8RXaxxMAg2yx-Pmfriip_u_DSSYeyjwY2aHg@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1364636112-15065-10-git-send-email-pclouds@gmail.com>
 <7vzjxihztj.fsf@alter.siamese.dyndns.org> <CACsJy8C0wb92QOhh=e27Cqd=e5yJYnQWYkYi4uPd+vPXGqVbdQ@mail.gmail.com>
 <7v8v4wdhpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URg8B-0007E6-No
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab3DOJzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:55:19 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38773 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3DOJzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:55:18 -0400
Received: by mail-ob0-f171.google.com with SMTP id wc20so909236obb.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oeiynnXvOkQge9SwO322vZQINKp2SNSct+D69/fGyDc=;
        b=wRmIOjVe8w/HaM5zhKA6LWV7JRLPeXd9GD3YUZt6oqT8+WIdTrkgPzIqa6tQKSaPmC
         amDJsMwcA8eZy+O/ASuNXwb6fMxD1FN29T7Cj8+DTEMSY6mfipHrxhF8rjJ0piQERFK+
         GSKSIaTsXq3W9AAf4oXnMzMQfFnzUljkNVIYv0yXxb/M+krtQWVDl3WRi6dHeaiNTTTv
         N9caza7z2/c33X3jCiPU2jFKaVoGyU67wlbM2eXelO43sclRHGHeYT877ytzaV4ie3jJ
         48Z1LKhytKvFbjjWE68flUcZlMBsAnTUrEUBpq6FTU7RId+xeqPiNvD9LEfO8kidTcgd
         a/8w==
X-Received: by 10.60.99.68 with SMTP id eo4mr7189062oeb.126.1366019714694;
 Mon, 15 Apr 2013 02:55:14 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Mon, 15 Apr 2013 02:54:44 -0700 (PDT)
In-Reply-To: <7v8v4wdhpd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221218>

On Sat, Apr 6, 2013 at 4:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If %C(auto) applies to some %<placeholder> but not to some others,
> the user needs to learn which %<placeholder> will eat the "auto" (so
> it no longer applies to the next one) and which one will not even
> look at "auto" (so the next %<placeholder> is affected by the auto,
> i.e. making the effect of auto skip a %<placeholder>).  If the rule
> were "%C(auto) applies to -next- placeholder", then the user does
> not have to worry about which ones are what you call textual and
> which ones are not (and there is no textual placeholder defined in
> the glossary).
>
> That would make it harder to learn. It would be much easier to
> explain if you said "%C(auto) affects the next %-placeholder and
> then resets".

So far (after this series, that is), we have two modifiers: %C(auto)
and %< (and friends). Both can be used to modify the "next"
placeholder, so either of them must learn to ignore the next
non-textual placeholder...

> I wonder if "Everything after %C(auto) will not be coloured if the
> output is not going to the terminal.", i.e. not resetting once
> colouring decision is made, makes more sense, though...

.. or we do this, which makes %< and friends the only placeholders
that care about the next one. Thanks for the idea.
--
Duy
