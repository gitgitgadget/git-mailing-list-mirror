From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v12 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 1 Jul 2014 15:34:50 +0200
Message-ID: <CAP8UFD3QhOaepNzDwdxdV5hyjV4L7qvqREULZZYXBiiVbZZ9Ow@mail.gmail.com>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
	<20140525053223.5329.28002.chriscool@tuxfamily.org>
	<53B150B4.1030303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 15:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1yD4-00085a-NN
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 15:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475AbaGANex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 09:34:53 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61846 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbaGANeu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jul 2014 09:34:50 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so7572184qac.7
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=m8rmtCilIwSZqeCGVP9kQ+m0tDrGE12VBI9zEL6B7ZA=;
        b=TPN2vXY674+6M03+pwKhInS2UaUtt+5DTBfZP78dNxWrEQ6F/vBApuwG7IyKdU0GHh
         JFFdKLnloko9mteeGKXJmiardoX1GTlfI6eEEbqazNhMTenjsNvqhSBpAbUJ0XKADYw7
         iN5ar8pUE78k9AYPRhmFb8UlQZH1D/Wz1dd5PfofJ+SnuxhPsiDU8R/yJImAIXffZ4x6
         cL4ASu/XuUijoz+tBnUZMlqk0OiuXCzYqOts01J54erDgYof3KlS1InHPN9nm1otSCXt
         RE9zDwOzw6Te1JwmeHGW1IbM5wn6zMm6sWnXT5k/U40vnOBBaTfcYjxGQ6YnWCg7zpSq
         4wUg==
X-Received: by 10.140.80.14 with SMTP id b14mr23441768qgd.113.1404221690282;
 Tue, 01 Jul 2014 06:34:50 -0700 (PDT)
Received: by 10.140.87.233 with HTTP; Tue, 1 Jul 2014 06:34:50 -0700 (PDT)
In-Reply-To: <53B150B4.1030303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252716>

On Mon, Jun 30, 2014 at 1:57 PM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:
> Christian Couder wrote:
>
>> +------------
>> +
>> +* Configure a 'sign' trailer with a command to automatically add a
>> +  'Signed-off-by: ' with the author information only if there is no
>> +  'Signed-off-by: ' already, and show how it works:
>> ++
>> +------------
>> +$ git config trailer.sign.key "Signed-off-by: "
>> +$ git config trailer.sign.ifmissing add
>> +$ git config trailer.sign.ifexists doNothing
>> +$ git config trailer.sign.command 'echo "$(git config user.name) <$=
(git
>> config user.email)>"'
>> +$ git interpret-trailers <<EOF
>> +> EOF
>
>
> How to configure git-interpret-trailers command so that it follow
> current rules for DCO:
> * Signed-off-by: is always at bottom; we can have
>   signoff+signoff+ack+signoff
> * Signed-off-by: can repeat itself with the same author;
>   this denotes steps in coming up with current version of the patch.
> * but we shouldn't repeat the same signoff one after another

Right now something like: signoff+signoff+ack+signoff is not supported.

It could be, if someone implements more options for the
"trailer.<token>.where" config variable. Right now the only options
are "after" and "before", but it could be possible to have "end" and
"start" too. And maybe "end" should be the default instead of "after".

When I first worked on this series I was under the impression that
people wanted to group all the trailers with the same token together.

> So we want to allow this:
>
>   Signed-off-by: A U Thor <author@example.com>
>   Signed-off-by: Joe R. Hacker <joe@hacker.com>
>   Acked-by: D E Veloper <developer@example.com>
>   Signed-off-by: C O Mitter <committer@example.com>
>
> but prevent this
>
>   Signed-off-by: C O Mitter <committer@example.com>
>   Signed-off-by: C O Mitter <committer@example.com>

This can be prevented by using "addIfDifferentNeighbor", for example li=
ke this:

$ git config trailer.sign.ifexists addIfDifferentNeighbor

So I think the full config for what you want would be something like:

$ git config trailer.sign.key "Signed-off-by: "
$ git config trailer.sign.ifmissing add
$ git config trailer.sign.ifexists addIfDifferentNeighbor
$ git config trailer.sign.where end
$ git config trailer.sign.command 'echo "$(git config user.name)
<$(git config user.email)>"'

$ git config trailer.ack.key "Acked-by: "
$ git config trailer.ack.ifmissing add
$ git config trailer.ack.ifexists addIfDifferentNeighbor
$ git config trailer.ack.where end

Best,
Christian.
