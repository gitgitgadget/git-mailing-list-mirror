From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/6] t7030-verify-tag: Adds validation for multiple tags
Date: Sun, 17 Apr 2016 14:19:00 -0400
Message-ID: <CAPig+cQYAAG7hVe6Li3-TZb99etkE22QzcWbKBCzr8L0SP5LXg@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-3-git-send-email-santiago@nyu.edu>
	<CAPig+cSOLnCoX77O7khEX1cTh0Hu29d6MRdcpfN8ytTkUSVU=A@mail.gmail.com>
	<20160417173155.GA1014@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:19:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arrHo-0002Lt-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 20:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbcDQSTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 14:19:03 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35362 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcDQSTC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 14:19:02 -0400
Received: by mail-ig0-f193.google.com with SMTP id fn8so8524485igb.2
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/R90RVI6CYoYaQmFOApmxnTTiud6PsngblZy0o/kJ68=;
        b=wT7o8cV5Bi6nuCQ43RNDnwnjzlm4VnFK4x8NJ+fK9ybL1dA/E7B7M2POdsSogra71T
         ehT+ztViW5Z0eKEBE6/14XW78XH0SDp+DMk8xUR1YrqsTo09L/9/FBNZvMS6GavPyToh
         gmWjQkW0JJ4Md/qJWb9UHLeEw6EcQn2HTgBMiudxGmiAP8IobYDqxUtPwxjKC2I7yshB
         uCZ7HvvhzDmlNpUyNHnUipHvH2lmVWyNoOnQmOnaSUgJdKWrLbVJ0s7LYm972JlgQSW5
         lbzaSEJ5vhsR0TS0+JyvErV9ggPTr2+1A/EQJqAzR17CO8LD4E49QHsrnSbRJU8BOPst
         yQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/R90RVI6CYoYaQmFOApmxnTTiud6PsngblZy0o/kJ68=;
        b=kGoRS2pj9E7HBKXAUOrDMQ5yV5jqm7bzPwcokMq1HjTUMdJrxbOeD+1lfjhlDlh/eO
         2kZSSdhdcD/BV6OE37cTdvyOfPZYQGEFtVzwBaVHpe+l0R5eFzOLUYwYtrkfbSdBr+Sc
         0yerAtNitEImHqpX7upEwZ14Zcn32iLFHUMQwanHzlxMSALCsUSXiD5IrQc1NR7OvH81
         mDV/6KZ7mS+yZK4G8yJpTKRhO1GriPbo5d4MR6j7z5WDpkkJmbf18YtfEHOYaLq72zHu
         MsxjnJg9bc9ScYPvZM6yrjQfgVfjc2I9AU6YeIRJVhjEKQVFS6S33ycERm1citeZLRJX
         Dj2w==
X-Gm-Message-State: AOPr4FU3ayWXCD9QCJdhZ008YLzuFqNpnd8a9vVgch5W10b6wToDA2fOyocvtoSFciR6+Zr35+FvOe4L3mbDVw==
X-Received: by 10.50.131.164 with SMTP id on4mr13843654igb.97.1460917140828;
 Sun, 17 Apr 2016 11:19:00 -0700 (PDT)
Received: by 10.79.16.67 with HTTP; Sun, 17 Apr 2016 11:19:00 -0700 (PDT)
In-Reply-To: <20160417173155.GA1014@LykOS>
X-Google-Sender-Auth: 1mgk6PCq4KFKDTgGPhjsWt7hGdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291769>

On Sun, Apr 17, 2016 at 1:31 PM, Santiago Torres <santiago@nyu.edu> wrote:
>> +       grep "^.GNUPG" <expect.stderr.1 >expect.stderr &&
>>
>> Hmm, is there a reason you didn't stick with the more strict regex
>> Peff suggested?
>>
>>     ^.GNUPG:.
>>
>> (Genuine question: I'm not saying your choice is wrong, I'm just
>> interested in the reasoning behind the decision.)
>
> I actually had missed the ":". I read the email and tried to internalize
> what the new test was actually doing, then I rewrote the test.
>
> I think I could add it for completeness though.

Junio already made this correction and others in the three patches he
queued on his 'pu' branch. It's possible that he also made other
tweaks not mentioned in the reviews, so it's a good idea to compare
what he queued against what you plan to send for the re-roll to ensure
that nothing is missed. Thanks.
