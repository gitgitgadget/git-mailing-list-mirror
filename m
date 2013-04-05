From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATH 3/4] remote-hg: add version checks to the marks
Date: Fri, 5 Apr 2013 16:29:26 -0600
Message-ID: <CAMP44s3o2ewvJiyvOBqEM5ztByEzdRCLHXpVYHe3=okjfr6L8A@mail.gmail.com>
References: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
	<1365161779-32170-4-git-send-email-felipe.contreras@gmail.com>
	<8738v5qh5v.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQp-0001b9-Fl
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162901Ab3DEW33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:29:29 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59619 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162737Ab3DEW32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:29:28 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so4150142lbi.6
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=G/HscRBMPmc9ZioEvCevCxc3Z3xg+yyRu1jvurap4ts=;
        b=q0CftI6i1XKHod0xi03lDc6492CbVmo+I8gXwapc0SPToFeqqeixFkPfoDHflny3mn
         wb6arFaYpErFRkKJQ67MtMt6kpCU5ZhAFrc8kUul3sTKnzDsV0kbrDNZqb0ycfjKNrWe
         8H5JeY+3UByg7VMm8O7WPnCfHgUzrZYwk6BlMwEFnCoOS319GDlB5e4EoeiuPN7ySV4W
         ioK4xPy+KEuzNpcgLEBF1/DRv2JH+RIMsN2E3hdLcMy54IzvIRDzIaS82IOOTDdkJYkx
         179Sv14i0uRGq2JEe7H3Nr/HL8YdwZFLV80qW4QHg+jJhRZFawN8BTpOTZGwkh4x/ksx
         9++g==
X-Received: by 10.112.130.201 with SMTP id og9mr7104260lbb.65.1365200966098;
 Fri, 05 Apr 2013 15:29:26 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Fri, 5 Apr 2013 15:29:26 -0700 (PDT)
In-Reply-To: <8738v5qh5v.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220242>

On Fri, Apr 5, 2013 at 6:46 AM, Jed Brown <jed@59a2.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> @@ -76,12 +78,19 @@ class Marks:
>>
>>      def __init__(self, path):
>>          self.path = path
>> +        self.clear()
>> +        self.load()
>> +
>> +        if self.version < VERSION:
>> +            self.clear()
>
> It's friendlier to just upgrade the marks in-place. This takes less than
> one second to run on repositories where full re-import would take half
> an hour:

Yeah, but that's riskier, and only works for this particular version.
Besides, it only happens one time per repository at best. Also, it
would mess up the current organization of the code. I'm not sure it's
worth worrying about it at this point, and we could always add a patch
on top.

-- 
Felipe Contreras
