From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH] git-cvsimport: allow author-specific timezones
Date: Mon, 15 Oct 2012 21:26:05 -0500
Message-ID: <CAEUsAPY3fJJSzX8WPRVQPNOF0A0KAMCXr1u0ZzjEFvXDF=v6JA@mail.gmail.com>
References: <1350261054-5171-1-git-send-email-crorvick@cogcap.com>
	<7vpq4jws4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 04:26:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNwrM-00083n-C6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 04:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab2JPC0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 22:26:08 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:52000 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2JPC0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 22:26:07 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3821209lag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 19:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=bRnnzlhRrviVxzccAE+aDbVXmRcM/aAqUpUli5X/Tno=;
        b=0xU8QLNKvatMYO6yPGGA0qcya+e/Wo1f9gUKbxsGBZ53mq9gYFKWekGVyGLen2uFpM
         5V+NgaYNj6RyYYw/Qn6IIcpkBWooaeC0Ihszsb3RBS2AQqtukwVhO1AkMtg7HMn3Snxr
         2jlDggVDfn8qGHkeUuqT5QKUxXCjnofKWYQndMwoMxO90c6Px3A0nP9CPbhvaUkhPjrI
         HgNFHwg/SoJ8pa/iVLcDzurUpqfzXc1tAaykhPRL8DTMk7BiKdNA0kNmf1qQ5S5OVtjj
         u/33OZnGAmUEmO/uWLMsRcIEWfmAN9xGy92jOynyaTbWCU0qN/bGVbFhlEt1gnWmKh/X
         OZVQ==
Received: by 10.112.46.7 with SMTP id r7mr4947176lbm.73.1350354365173; Mon, 15
 Oct 2012 19:26:05 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Mon, 15 Oct 2012 19:26:05 -0700 (PDT)
In-Reply-To: <7vpq4jws4d.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: kRgIaGI4lg4vsEPZKzB2NlJc3jk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207796>

On Mon, Oct 15, 2012 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
>> new file mode 100644
>
> Huh?  What happened to the executable bit we saw earlier?

Uh, yeah.  Sorry about that.

>> +test_expect_success 'check timestamps are UTC (TZ=Australia/Sydney)' '
>> +
>> +    TZ=America/Chicago git cvsimport -p"-x" -C module-2 module &&
>
> This look identical to the first one, but even with a trivial change
> to use Australia/Sydney instead of Chicago, I am not sure what the
> test buys us.

This is left over from when I was using the script to test the "use
local timezone" option.  It was useless there, too, but did provide
some symmetry.  :-)  Removed.

It occurred to me that the success of the unit test depends on the
host platform's zoneinfo database.  I think this problem is inherent
with this functionality.  Should the unit test attempt to detect
support for the used timezones and short circuit if this fails?  Not
sure exactly how I'd do this, but wondering if it's worth thinking
about.

I've made all the other recommended changes, I'll resubmit shortly.

Thanks,

Chris
