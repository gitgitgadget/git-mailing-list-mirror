From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Mon, 12 Nov 2012 17:40:57 +0100
Message-ID: <CAMP44s1zWzaExNC9fOvfSQhxe6UmoDqOs39n_C3EN1JonBT0Dw@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
	<29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de>
	<CAMP44s0o1eP+aeT0AHu4uP1NPLqJq56qUDb-+F_x5NjoJCnf+A@mail.gmail.com>
	<EA56F0CC-7C93-491F-A076-4A1AA9593ED0@quendi.de>
	<20121112154515.GB3546@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:41:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXx4a-0000C8-UA
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 17:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab2KLQlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 11:41:00 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44666 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab2KLQk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 11:40:57 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6410782obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GLtEXbja9TqaLzumIAi9dl1S0To5wC257VVAH11OBMw=;
        b=nUwWcgSXh9YhAG//0+BGWHV2fbjAU9tp4kwG25RGyZVkW6em8KHg4kgSi3EL90p/Kn
         JR/NB/DVGa19iw0HyWWxA1z9JSd6MlMty/2YQFYSeIyCRBdPaxrbWomY4J9ZMnaYLQvt
         DBfCtPvy8Tcj4PYsoRA3L6xRfMPySHYJFmHW6yeWIIJPcauGMJR10Xi2l584rx0I/ZQb
         lTc35/ror9GpSbEyD6wO8zkwh9m54sajOAmgUEzvypfW65dlw3GdQVtZF8I4Cy4chUzN
         RWiMEUzPRzqBhlbuII1ULQyo41dy7Jwq98Nx4n7YXyzux7OvJbe+nTkHCQab9aTTDPJU
         R9qw==
Received: by 10.60.12.225 with SMTP id b1mr15158013oec.96.1352738457213; Mon,
 12 Nov 2012 08:40:57 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 08:40:57 -0800 (PST)
In-Reply-To: <20121112154515.GB3546@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209486>

On Mon, Nov 12, 2012 at 4:45 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Max Horn wrote:
>
>> Aha, now I understand what this patch is about. So I would suggest
>> this alternate commit message:
>>
>>   remote-testgit: make it explicit clear that we use the 'done' feature
>>
>>   Previously we relied on passing '--use-done-feature ' to git
>>   fast-export, which is easy to miss when looking at this script.
>
> I'm not immediately sure I agree this is even a problem.  Is the point
> that other fast-import frontends do not have a --use-done-feature
> switch,

You mean other fast-exports.

And what other fast-exports? Most remote helpers don't use an external
fast-export tool, and the only I know that used one is the one I wrote
(and is now deprecated) that used bzr fast-export, and no, that one
didn't support the done feature.

Most remote helpers would probably be doing the equivalent of
fast-export themselves.

> so a typical remote helper has to do that work itself, and the
> sample "testgit" remote helper would be a more helpful example by
> doing that work itself?

Yes.

> The idea behind --use-done-feature is that if fast-export exits early
> for some reason and its output is going to a pipe then at least the
> stream will be malformed, making it easier to catch errors.  So there
> is something to be weighed here: is it more important to illustrate
> how to make your fast-export tool's output prefix-free,

What fast-export tool?

This is a remote helper.

> or is it more
> important to illustrate how to work around a fast-export tool that
> doesn't support that feature?

Ditto.

If you want to launch a campaign of adding the 'done' feature to
whatever fast-export tools are out there (that I'm not aware of), go
ahead, but this is about remote helpers, most (all?) of which would
not use a fast-export tool to achieve the export, but do it
themselves.

Cheers.

-- 
Felipe Contreras
