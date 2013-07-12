From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] builtin: add git-check-mailmap command
Date: Fri, 12 Jul 2013 02:39:37 -0400
Message-ID: <CAPig+cQz8jAHw3p4Fi30-KGZoVcb1vkgS9yA23abJVJLpDrvUA@mail.gmail.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-2-git-send-email-sunshine@sunshineco.com>
	<7vli5crk8l.fsf@alter.siamese.dyndns.org>
	<CAPig+cQvnKSxZ5M6zW_r6Y9xwZ0Ch99JDq4SccYXCRof9svsOg@mail.gmail.com>
	<7vbo68pbwm.fsf@alter.siamese.dyndns.org>
	<CAPig+cTwXe7rSKUgJPVHbAvrxYbmL77xNXtLyUeRnd8Taxtrdw@mail.gmail.com>
	<7vmwpsnv5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 08:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxX15-0005jy-6C
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab3GLGjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:39:39 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36805 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab3GLGji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:39:38 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so7400189lbi.39
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 23:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=L77LMGLYIadS2/5H6T33gMyd7OYHGT7oIAdCMEHzMfw=;
        b=TeYRic6Kc4/Z7O7nhVS93hz+6zbx1MR7Y52GwZNRoWhEOAmmrWTOR/pOnbmH4WIFMX
         yJAMdHm8PqfWgb5kJeuBI2Po2aCmL0CxxLSS3CWJfNTnOInSQJeLbtnH6OqtpZkvQN39
         SoS6y3zhbIAx8g5WSzmUT4wvv7sBQtFXKF0XLEFw3XIdrOxYAYp2blyqR3KqEzu4H81P
         3KbeQg4FtskJ4YdElTHx4doPCZ2g/98J0IPPPoSxVHnV0uhr8GtZMcrCXvNIcF8PGfB+
         wKYoj7P0n186SNz584c23ozSm8j9nIXOMpDt2kJgFJpdDZc1EPYxFL1w6JpykMqYPUXD
         Sijg==
X-Received: by 10.152.87.172 with SMTP id az12mr19090034lab.24.1373611177214;
 Thu, 11 Jul 2013 23:39:37 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 23:39:37 -0700 (PDT)
In-Reply-To: <7vmwpsnv5l.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: LQSVryKPA4inDOUnNX0vwuJEdyE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230181>

On Fri, Jul 12, 2013 at 2:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> ... Is it desirable to do so
>> or should the user have more fine-grained control? ("xargs -0" comes
>> to mind when thinking of a null-termination input switch.)
>
> For the purposes of check-attr and check-ignore, a single "-z"
> governing both is sufficient.  I think you already got that from my
> 4-patch series, but the core reason for that is :

I'm reading it right now.

>  - when "-z" is used, the user knows the input paths may need
>    protection against LF.
>
>  - our output contains these same paths.
>
>  - which means our output cannot be expressed unambiguously using LF
>    as record separator.
>
> For the purpose of check-mailmap, I actually do not see much point
> in supporting "-z" format.  We do not even handle names or addresses
> with LF in it.  The mailmap format would not let you express such
> records in the first place, no?

You're right. I had this exact argument in mind for why
null-termination was not needed on the input side of check-mailmap,
but for some reason I had a blind spot concerning the output side.
I'll drop this option in the next re-roll.
