From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Tue, 27 May 2014 12:05:21 -0700
Message-ID: <CAL=YDW=tJaUwRW0gaP-HCEySet8LV0jAu90xy7VXCQK48xz5Nw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<20140522230802.GZ12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 21:05:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMgk-00032E-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbaE0TFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:05:23 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:63499 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaE0TFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:05:22 -0400
Received: by mail-ve0-f173.google.com with SMTP id pa12so11336802veb.32
        for <git@vger.kernel.org>; Tue, 27 May 2014 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0Me5A8bNu6Zs+rfBtgiA9a+dmnc2kmfSK4GYMLTJZ9U=;
        b=VjE5iKSvEah9+bKBjbspw+b4nzHd+IPBL8psoVDgEuGti9c0VpLcts8BIbiIgZLQP1
         PYy6iYOT4mgHZ2lJOdxMWEeBj1QoH0kUIsO/66yJM5nBAcigh0OKeCJ/HvMyyiat5Cjk
         gY1mqd3piM/Llf/ThmKmbyiEYTZ/6K+0pgn/lpw8oy/jYOMJNM7TUeVqsrYN5QT10OA8
         zTYj4QcOnb2n52INhzbalCRT/K34FS9DTEpujMgqwof4is4XUf9k0i8GOcw8E8BdEq4h
         y95wUC8G3FrX+eZ/G0yaB+mVZsMWdRVQnZu3fhfmd6FCKv4wCcng4zrZtcu+H2gzxTlr
         iE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0Me5A8bNu6Zs+rfBtgiA9a+dmnc2kmfSK4GYMLTJZ9U=;
        b=i3Dy3QhOWK2sqDgBqwTTbfCTMtsuLHyzzz7PVCjo+rWRLjd7HWRiJHsNPIjtG8jHdW
         ERVh7r0xFYsmEPdY2RjAHYWGpFUQnqBkjLWWFbJHzFdojwwaV7dCcjjqoNVC/3EWShR6
         Ednx6BusUvN2zS0FR6RCZzxqDF31LnJjqc/BOroerylZQKmB2Mbcc087eMNP8ZVh7JUB
         bmzDM9h1jZLUrvhI/MzrPGryTZyA2TO49ertUzEiW+2yL18JBlq4JS0kSh3eotnaO39G
         Ue0W0yQRfHrZHaUTNNLB5vbiPhJukNiu61snq6CqMo60XfxT1MGmCc9nHuxldzOXeK5f
         /gqA==
X-Gm-Message-State: ALoCoQmLcTxy0SuZh6ya+QRRflvtpJ2Ud75Oi5i6uYLw3L++iaNwZSbn25azqNaqSgqgEVP6NANC
X-Received: by 10.58.112.8 with SMTP id im8mr4295604veb.35.1401217521264; Tue,
 27 May 2014 12:05:21 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 27 May 2014 12:05:21 -0700 (PDT)
In-Reply-To: <20140522230802.GZ12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250188>

On Thu, May 22, 2014 at 4:08 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> This patch series can also be found at
>> https://github.com/rsahlberg/git/tree/ref-transactions
>
> Continuing with the review of 65a1cb7b (2014-05-22 12:08):
>
>  11/40 change ref_transaction_update() to do error checking and return status
>  The "there will be in the future" sounds ominous.  Do you have an
>  example in mind?  E.g., I suppose it would be nice if _update could
>  notice D/F conflicts or connection to a database server closing early,
>  but it's not clear to me whether the kind of errors you're talking
>  about are that or something else.
>

Updated the message.
Next series moves both locking as well as checking for name conflicts
to _update.

>  With or without such a clarification,
>  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  12/40 change ref_transaction_create to do error checking and return status
>  What does "On failure the err buffer will be updated" mean?  Will
>  it clear err and replace it with a message, append to err, or
>  something else?  Does the message explain the context or is the
>  caller responsible for adding to it?  Does the message end with a
>  newline or is the caller responsible for adding one when printing it
>  out?

I have updated the documentation.
Message is appended to the string buffer. Caller is required to
strbuf_reset before calling the transaction if caller wants only most
recent error instead of all errors appended one by one.


>
>  For cases like this where lots of functions have a similar API,
>  API comments start to become potentially repetitive.  It might be
>  better to explain conventions at the top of the file or in
>  Documentation/technical/api-refs.txt and say "See the top of the
>  file for error handling conventions" or "Returns non-zero and
>  appends a message to err on error.  See
>  Documentation/technical/api-refs.txt for more details on error
>  handling".

Done.

>
>  13/40 ref_transaction_delete to check for error and return status
>  Each successive commit dropped something from its subject. :)
>  (First the (), then the verb.)

Done.

>
>  Same comments as before about an example being useful for the
>  log message and the API documentation on error handling being a
>  bit vague.
>
>  14/40 make ref_transaction_begin take an err argument
>  I found the "failed to connect to mysql" example instructive while
>  doing reviews.  Perhaps it would be worth mentioning in the commit
>  message.
>
>  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  15/40 add transaction.status and track OPEN/CLOSED/ERROR
>  It says an ERRORed transaction cannot be committed and can be rolled
>  back by calling _free.  Can a CLOSED transaction be committed or
>  _freed?
>
>  What does "faild" mean in the documentation comments?  (Maybe
>  "non-OPEN"?)
>
>  In the previous version of this patch passing a non-OPEN transaction
>  would die("BUG: "...) to diagnose the caller's mistake.  Now I'm
>  confused about the API: it seems you're allowed to pass a non-OPEN
>  transaction but it doesn't append a message to 'err' in that case.
>  Is this meant as a way to save the caller some typing, like
>  fwrite/fclose do?  (I've found people often make mistakes with the
>  fwrite API fwiw but can understand the appeal of it.)
>
>  Maybe with more context I'd like this.  As is, it feels like a step
>  in the wrong direction.
>
>  16/40 tag: use ref transactions when doing updates
>  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  17/40 replace: use ref transactions when doing updates
>  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  18/40 commit: use ref transactions for updates
>  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  19/40 sequencer: use ref transactions for all ref updates
>  This would be a lot simpler if the "ref_transaction_commit should not
>  free the transaction" patch came before it (yes, sorry, killing the
>  fun).  I can push the result of a rebase doing that somewhere if you
>  like.

Beeing done.

>
>  20/40 fast-import: change update_branch to use ref transactions
>  Likewise.
