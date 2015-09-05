From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] disallow test_when_finished in subshells
Date: Sat, 5 Sep 2015 13:17:35 -0700
Message-ID: <CAPc5daX5w5yoRyp=Squdhi8nj87bb4zfqea-=wLyze6GhLPV+w@mail.gmail.com>
References: <20150905085429.GB25039@sigill.intra.peff.net> <cover.1441458341.git.john@keeping.me.uk>
 <CAPc5daUsd8KD77EfF-SBwwOKn0hNPvYXo8UmY-sHBg9S4vUQXg@mail.gmail.com> <20150905175756.GE27660@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Sep 05 22:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYJuR-0007vO-K9
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 22:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbbIEUR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 16:17:56 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35687 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbbIEURz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 16:17:55 -0400
Received: by igbkq10 with SMTP id kq10so32840981igb.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RdRBCWGv160/CKFxb0StEMzI/soWJhI2etHT6DfpSKk=;
        b=wSAyn08uVbqwPTHajsNgX9n1RRbOhT3clRky0Y4D5nH6frVtBQCkiwcjV8ftF2zMUU
         5zgohcEvXtJWu5otnBym3Yto7EuxoEkG54ln7DOPG3P2P8iX6gA+B28VSp7gRZjnOfMm
         qGFdFfwkYqI5IZWjZL5rBUInUs7LuO6ngVGDf+lvWg2RMKqQkAlQg4SWQTyZaX2MCSUi
         UQhFui9UzSYTeHdFI/orNkQB/aeVnBzd4glcCp1JItZZRpu19gzaE/Gxlmnu4yRHSWHv
         DtmWvFWyarpq2HwcPyYWqWwWB+eqAiBVvsqmB2QUZ9pq3qdbjYcIVDcvRZrH5rmnjntr
         oejg==
X-Received: by 10.50.87.98 with SMTP id w2mr19246809igz.60.1441484274858; Sat,
 05 Sep 2015 13:17:54 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Sat, 5 Sep 2015 13:17:35 -0700 (PDT)
In-Reply-To: <20150905175756.GE27660@serenity.lan>
X-Google-Sender-Auth: d7hjg33ISBweinwphr54P0wVaIo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277410>

>> Isn't it just the matter of resetting the variable regardless of $BASH
>> (and ignoring
>> a possible refusal to do so under bash) at the beginning of the test, or do you
>> really have to rely on the value of $BASH and do things differently?
>
> Bash doesn't refuse to set it, it lets you update the value; I did think
> that it wouldn't update it if the user had overridden the value, but it
> looks like that was only because I had unset it first.  It seems that
> the variable is magic (autoincrementing in subshells and can only be set
> to integer values) but if you unset it then it becomes a normal
> variable.

Yes, resetting to =0 at the very beginning is what I have in mind.
