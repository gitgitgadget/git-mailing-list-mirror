From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 13:06:00 +0600
Message-ID: <CANCZXo5qu=+u4BXWeOgX2r6T8jn-ysp9XfLhDc7Ca=UcvrzR4w@mail.gmail.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net>
	<20150618202205.GA16517@peff.net>
	<xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
	<20150619041437.GA26001@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 09:06:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5qNO-0003K6-1K
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 09:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbbFSHGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 03:06:05 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36689 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbFSHGC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 03:06:02 -0400
Received: by lbbqq2 with SMTP id qq2so66411452lbb.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Hdw0FtMPzQrLLsxtoVIwL9iA+N9u0GifAzLVK9rseL4=;
        b=ZEAhV9N5LuiycdtycM1sV4vfdRgOfWuJtlHneO4sJmtxvlF+AyH5sbBR6bydieeQTI
         cJDsm7Nrfzk1wbTqcFxSi9VYtp7p2fEOnh8pQ0I6CpN5u1HnY/aZwYHQasf/oUUjnGNG
         qDwuAeWmn9TD7W1gEOJT01Yzby1vZedPqNUkIFElwlCBSord5Hwiu4pInRo+rI2o6bam
         30MPKyPp4n9XVnMXzDTFjF+hTEUho9WIH9Bbc7UM9h2fWK7teCTsTlNReerFFAhno1n+
         UppXmZOBHfv+O4aGP9IQcn9o5bLtJsLcU9O/N6XC7zigGf896la40ySg1vQ8UW3mDzLk
         o7mg==
X-Received: by 10.112.217.2 with SMTP id ou2mr16463691lbc.15.1434697560769;
 Fri, 19 Jun 2015 00:06:00 -0700 (PDT)
Received: by 10.25.62.150 with HTTP; Fri, 19 Jun 2015 00:06:00 -0700 (PDT)
In-Reply-To: <20150619041437.GA26001@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272104>

Hello Jeff and Junio,

Thank you for feedback and help. I think also I need to add yet another test
which tests case when configuration option is set and -o passed.

I'll make changes and resend the patch.

Thank you.


2015-06-19 10:14 GMT+06:00 Jeff King <peff@peff.net>:
> On Thu, Jun 18, 2015 at 02:46:36PM -0700, Junio C Hamano wrote:
>
>> > If I were designing from scratch, I would consider making "-o -" output
>> > to stdout, and letting it override a previous "-o" (or vice versa). We
>> > could still do that (and make "--stdout" an alias for that), but I don't
>> > know if it is worth the trouble (it does change the behavior for anybody
>> > who wanted a directory called "-", but IMHO it is more likely to save
>> > somebody a headache than create one).
>>
>> I agree with "later -o should override an earlier one", but I do not
>> necessarily agree with "'-o -' should be --stdout", for a simple
>> reason that "-o foo" is not "--stdout >foo".
>
> Good point. At any rate, that was all in my "designing from scratch"
> hypothetical, so it is doubly not worth considering.
>
>> Perhaps something like this to replace builtin/ part of Alexander's
>> patch?
>> [...]
>> @@ -1337,6 +1342,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>               die (_("--subject-prefix and -k are mutually exclusive."));
>>       rev.preserve_subject = keep_subject;
>>
>> +     if (!output_directory && !use_stdout)
>> +             output_directory = config_output_directory;
>> +
>
> Yeah, I think that is the sanest way to do it given the constraints.
>
> -Peff
>
