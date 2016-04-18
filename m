From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git merge branch --no-commit does commit fast forward merges
Date: Mon, 18 Apr 2016 17:09:18 +1000
Message-ID: <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
References: <874mb0kkkk.fsf@gmail.com> <alpine.DEB.2.20.1604180825170.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Paulik <cpaulik@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 18 09:10:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1as3K7-0000oX-89
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 09:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbcDRHKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 03:10:11 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34233 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbcDRHKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 03:10:09 -0400
Received: by mail-io0-f172.google.com with SMTP id 2so186905883ioy.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wght2fQm7UrI7dEpcWPMlsbBwOV5AwFQrSoYXqoqI2k=;
        b=zJ+6C7GNcCXERAnCa8AKQPk1f0NumG5chqU47uOlXT7xoOJqeq6DTgU/lTD6gwxI5m
         Zw7pbj1YrYZlWIdgsA3FbpZYKTBbIiyRvbOnlMPnXhsz34xZnfdID8dyXOW/XUf20p5v
         WiAR8xgSTOAvqvd3DE3xRO22Cuq9N1O9IBtng7MfFnexLCmvc02vyTkGbA5q1Wa+E2HM
         tL8OEvCNfbQi2NTIqChuPUWSCCAKhdv9l5kBdGOoA7O/cOM9AEsmgKYlMNdeoDiCsfz4
         Ty6tdF2JF/Ql8oFsvViBv/wMKFEn6AlHakQ9JAdd5TyRFrQw8z/GVq7M8J5fk1SR+o4i
         l9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wght2fQm7UrI7dEpcWPMlsbBwOV5AwFQrSoYXqoqI2k=;
        b=KeY9r9p2Wny5NKlvv3O+zmtnAx0muIV6QK4NS7RcEzLWLlWELhty8X5n2uUhFYyyn3
         uTYCICkOjWh16fIVU2dub7PCxCBlIuGZ/RMkFkeAa5lbDBr/NKCYrJ7l9n2Xx1kSLMmY
         fDIgKhi0JWGSRAduvv0tn8v9a5hPQXXdi4aWsTqpqQtswZsHY1gZUKiRJX6fsw75Kd5u
         FELyI5HyAAKy0E7qsgpjq/cxMheCLczm5yQct8cCV7uNGJkAYA5pwo1Q2C/tdWUi42lW
         lng77hHufdWrXUuDm9FYhj6pg82Yn7mb1F2H0JZqiKnxAqr77vkb9P4trQjbuiI6FKP5
         YeUg==
X-Gm-Message-State: AOPr4FWL6kMeU+N9fWfzcTuHLMRtOeAzskGVXEOsBzrMJ+9Mr6nJMo9XCwXVyUmdvzBijSDD5hADEePFdpDGVg==
X-Received: by 10.107.13.133 with SMTP id 127mr40299609ion.129.1460963398503;
 Mon, 18 Apr 2016 00:09:58 -0700 (PDT)
Received: by 10.36.45.69 with HTTP; Mon, 18 Apr 2016 00:09:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604180825170.2967@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291798>

On 18 April 2016 at 16:26, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> > The command only works as expected when also adding the --no-ff flag.
>
> Then you need to fix your expectations ;-)

I *think* the core of this problem is that the intent of the end-user
does not align with the command options available.

In this use case (as far as I can tell), the user wants to see what
the result of a merge from somewhere else will look like, without
changing their HEAD.

While you are correct in saying a fast-forward does not create any new
commits, for the user it certainly looks like a whole slew of new
commits have been added. Moreover, the nature of the option means that
the user has to investigate if the merge is a fast-forward in order to
know what the outcome of the command will be.

If the merge is a fast-forward, --no-commit has no effect on the
outcome. If the merge is not a fast-forward, --no-commit has a huge
effect on the outcome.

If I see a --no-commit option, as an inexperienced user, I would be
quite surprised to find my HEAD changed after using it. It would be
far more intuitive, for that user, for --no-commit to imply --no-ff
however I suspect that such a change may well cause more problems then
it fixes.

What I wonder is, in what situation is the current behaviour is desirable?

While I agree that the option works as designed, I think its behaviour
is more surprising to the end user then it should be.

Regards,

Andrew Ardill
