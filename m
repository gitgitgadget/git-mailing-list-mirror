From: Michael Blume <blume.mike@gmail.com>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Fri, 5 Dec 2014 22:27:40 -0800
Message-ID: <CAO2U3QjkJRPrFvapK=LDU_GG5Ne6_zVD+S61JP+iV_Xi-gk5JQ@mail.gmail.com>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
 <20141206053434.GF31301@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 06 07:29:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx8s5-0007GF-ON
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 07:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbaLFG2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 01:28:03 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:53167 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbaLFG2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 01:28:02 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so1436433oig.11
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 22:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K4EyS/D7HQDIoXfPIL9RdMdXNob+ctOmemJ/xgqk4fU=;
        b=R+GDIUQxE6qx6S4J9sAcmSC3Jxwj+ZLexM0+bN05CCzvZOF4eWii8GC08BPfoNQqaI
         41q6yt6gzzAZkX2gyGgLaNnRc5GMbpGqRWlcUIBohu/EAfWTFvL/LomcXSd77AOatWGF
         cZ1JCuFGAqNNvX2EDwrt/qyqHOyPlLCELsJ3JytmdDqBORtkLA+7lCSOkH3AKS10/EJT
         MkI4luoejiZ75iKL2xZG40Ta7efQp0Sq3I8oK78iHh42cIrXRHciUOVsospC2yYQS9Bk
         /EO5qrT1v2PFOPbKethUt8WWAoSqMfAdvc0x1zMXD65ehOCNxip3YvzdHfp0DIXf8FVE
         ipzw==
X-Received: by 10.202.202.9 with SMTP id a9mr623315oig.131.1417847281550; Fri,
 05 Dec 2014 22:28:01 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Fri, 5 Dec 2014 22:27:40 -0800 (PST)
In-Reply-To: <20141206053434.GF31301@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260941>

On Fri, Dec 5, 2014 at 9:34 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 05, 2014 at 06:05:24PM -0800, Michael Blume wrote:
>
>> Failures start from
>>
>> commit d2384abff7a6181fd7b9a51af7e780aa21e5cb8d (refs/bisect/bad)
>> Author: Luis Henriques <henrix@camandro.org>
>> Date:   Thu Dec 4 19:11:30 2014 +0000
>>
>>     test/send-email: --[no-]xmailer tests
>>
>>     Add tests for the --[no-]xmailer option.
>>
>>     Signed-off-by: Luis Henriques <henrix@camandro.org>
>>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> but continue with Junio's SQUASH??? commit at b728d078
>
> The commit contains:
>
>   +       test "z$(grep ^X-Mailer: out | wc -l)" = "z$expected"
>
> We have had trouble in the past with "wc -l" output not being strictly
> portable. I do not recall offhand which systems, but it is a good bet
> that this is the culprit. Doing:
>
>   grep ^X-Mailer: out >mailer &&
>   test_line_count = $expected mailer
>
> should fix it. It might be even nicer to actually compare the x-mailer
> line we find to an expected output, but that may introduce complications
> if the value changes with the version or something (you'd have to
> sanitize the output, and then I do not know that the test is really
> buying much over just seeing whether it exists).
>
> -Peff

Actually need to drop the '&&', but yes, that works perfectly, thanks =)
