From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 09:23:33 -0500
Message-ID: <CAMP44s3GpZNdpF3j-GSthwx0vY37+yfeVFtnHfPaQgZasJZt7w@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	<87wqqdoqvp.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:23:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimiZ-0006W9-66
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab3FAOXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:23:36 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:55084 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab3FAOXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:23:35 -0400
Received: by mail-wg0-f45.google.com with SMTP id n12so2012244wgh.12
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/tEA3l3QMMOL1eqFFC5Fe7hfmVTclgVWiFRL97nrYdQ=;
        b=EK2wY9zPbKcNuxDNEZIss3Ac9DE5/nMvEJTJXnjFvGl7VKk2LgihyMQz8zz9spL5nJ
         ZQ1+wIhex95Cr6bvaH3hk1mRFgi+5V1xhzpRSwdFf8C0VJW2FiubeNUxMXvWKtnyrBBJ
         eG1KUK20ooV5fj3TZpGxUxRI2ySCzHWuljUog78OYf0frRLvJvgChKz2KO9uJukPPZZ7
         oEIRXGaVRiKP4+RpnYYctD9nQOhuqXAMrbE051+ghWrFObYKzCy5mwwHNQAiI1Yy0bZq
         yqsEsU+PsXnI8rIOXxtfWXUXu40Yjq9q36PlOvAq0ryPS6mz6I38iwIVeULwJYrGm/wD
         1Omw==
X-Received: by 10.194.77.66 with SMTP id q2mr13176996wjw.34.1370096613815;
 Sat, 01 Jun 2013 07:23:33 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Sat, 1 Jun 2013 07:23:33 -0700 (PDT)
In-Reply-To: <87wqqdoqvp.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226134>

On Sat, Jun 1, 2013 at 9:19 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Nobody is checking for specific error codes; it's the errno that's
>> important.
> [...]
>> -             /*
>> -              * This return value is chosen so that code & 0xff
>> -              * mimics the exit code that a POSIX shell would report for
>> -              * a program that died from this signal.
>> -              */
>> -             code += 128;
>
> Have you checked the callers?  There are lots of callers of
> finish_command(), which returns the value from wait_or_whine()
> unmodified.

Yes I did. Most of them simply check that the number is not zero.

However, that was at the time I wrote the patch, and it seems there's
now one instance where the code is checked.

-- 
Felipe Contreras
