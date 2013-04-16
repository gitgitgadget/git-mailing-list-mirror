From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Tue, 16 Apr 2013 12:52:20 -0700
Message-ID: <CA+sFfMc1Brgf3mewjizv-F9Fir+wJ56fV18s--CE1h0gsuvcrw@mail.gmail.com>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
	<CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
	<7veheal28i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:52:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBvX-0007mi-3C
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936013Ab3DPTwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:52:22 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60552 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935589Ab3DPTwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:52:21 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so850026wiv.15
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EwqHbP9O5avKM2fCK7kRLzXrfz6iag/RToW2u/wgujw=;
        b=j5AUxgViTkoE2LiGhQ/QjzHg/qpdvn4dPoDWp7Xw0TVH9lTQx64pGlQUSZ66FsNl+/
         tib21ahDyFOcSoF/9YRu+O+WwR8jybuAX5gXGRPiHD7ELysQ8N9T1mt0rO4AunsDZSoH
         PmDSu0NRSrhbt3hLih6otxQMXTsZpN7xr8UYGUAK599tURIMT6TIOwCN/GPe93MCK00+
         sDIN4W4aL9B0QQMdUiz0Lx6NkcdiZofuNvP2pThhiPBSyEUjYan8ZJa3VS2gGisn3SBI
         y1ZczIwNil+1Gd8iIc1u3FffwTTyoozpEfPofjhUMlVqdb9d1Es+5zFkdNQNQ219tvdy
         G9VA==
X-Received: by 10.194.5.196 with SMTP id u4mr6427683wju.54.1366141940440; Tue,
 16 Apr 2013 12:52:20 -0700 (PDT)
Received: by 10.194.249.69 with HTTP; Tue, 16 Apr 2013 12:52:20 -0700 (PDT)
In-Reply-To: <7veheal28i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221461>

On Tue, Apr 16, 2013 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> The stash is implemented using the reflog.  The ^{/<text>} notation
>> searches the commit history, not the reflog.  So I think it will be
>> able to match the first entry in your stash stack, but not any of the
>> other ones.
>
> Good point, together with...
>
>> An extension to the reflog dwimery that implements @{/<text>} could be
>> interesting though.
>
> "log -g --grep=<text>" gives you a way to eyeball, but with
> @{/<text>} you _might_ have a good way to name the revision.
>
> I am not however so sure if it is useful outside the context of the
> stash, because the ones you would want to recover from a normal
> reflog is most likely the older version of what you already amended,
> so the latest hit will likely be the post-amend version, not the one
> closer to the original.  You would end up eyeballing the output of
> "log --oneline -g -grep=<text>" and cutting from it.

Yeah, I think that's true.  I can't think of a reason, at the moment,
where it would be useful outside of with 'git stash'.  I mainly wanted
to spell out "@{/<text>}" so that the mental link could be made back
to the code in git-stash that removes the "@*" suffix.

-Brandon
