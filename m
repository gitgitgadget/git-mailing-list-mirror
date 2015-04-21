From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Tue, 21 Apr 2015 15:40:35 -0400
Message-ID: <CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
	<20150419002807.GA11634@hashpling.org>
	<xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
	<20150420074433.GA30422@hashpling.org>
	<8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
	<20150420091920.GA31279@hashpling.org>
	<553520CF.6070304@gmail.com>
	<20150421101641.GA13202@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 21:40:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yke2D-0002K3-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 21:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbbDUTkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 15:40:37 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34941 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584AbbDUTkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 15:40:36 -0400
Received: by igbyr2 with SMTP id yr2so96116367igb.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HSIs66p1G7atuyuDBhw4Z1fjFqmnPks234JOrxNDP1Q=;
        b=A2950V/qGBCoB7mXsZtjvGCxAyAn7ckbA1WgIs3+cCUJFuBbQN7UZ9KJD5GHljoaar
         L1NUUKXR4poLz5VRT9POFEsLLAeKGubSBOFVlKeLuewlGKTpbCnC/nzZ+xIMgfCfTAGK
         5orNmt1WkoFX/l3cebQXCiXlJwD+nJoJG9Kfd6ZYSFASyMHzc32iz6jYf2AT64PyLVa6
         050v7FJzKzokZo6+AIGAIfYz89J9Fxq7ivE+7Tk+C388vaDskYNz2n4cTXvW/6/Chgun
         n4r8fPVe+j5nneYV0RNb1QArCDqoX8jSEzlzLz8N2NKACAS15druWf6T/DhfFG0Jt4xj
         /c9A==
X-Received: by 10.50.66.230 with SMTP id i6mr6581969igt.22.1429645235785; Tue,
 21 Apr 2015 12:40:35 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 21 Apr 2015 12:40:35 -0700 (PDT)
In-Reply-To: <20150421101641.GA13202@hashpling.org>
X-Google-Sender-Auth: bo3hz7ldtWTWKpX7S9IzMl9vWhs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267550>

On Tue, Apr 21, 2015 at 6:16 AM, Charles Bailey <charles@hashpling.org> wrote:
> On Mon, Apr 20, 2015 at 09:22:47PM +0530, karthik nayak wrote:
>> On 04/20/2015 02:49 PM, Charles Bailey wrote:
>> >As far as I could tell - and please correct me if I've misunderstood,
>> >cat-file's literally is about dealing with unrecognized types whereas
>> >hash-object's --literally is about both creating objects with bad types
>> >and invalid objects of "recognized" types. This latter scenario is where
>> >the option name "literally" makes the most sense.
>> Yes. What you're saying is correct, but it also makes sense as we're asking
>> "cat-file" to give us information about the object irrespective of the type of the
>> object, hence asking it to literally print the information. Also it stays as a compliment
>> to "hash-object --literally", which is already existing.
>
> OK, I think you've hit the main point which I was trying to make.
>
> To me, "literally" means "without transformation" or "exactly as
> written/recorded/transmitted" (which -t/-s do anyway) and doesn't really
> encompass the "irrespective of type" meaning that it has been given here.
>
> In any case, I've made my point so I won't labour it any further. I
> think that --no-validation or --allow-any-type might be more accurate
> but if everyone else is happy enough with --literally then I'm happy to
> live with that too.

It's easy to be blinded into thinking that cat-file's new option
should be named --literally since it was inspired by the --literally
option of hash-object, but indeed it may not be the best choice.

In addition to your above suggestions (and --unchecked which you
proposed earlier), if we take inspiration from existing Git options,
perhaps one of the following (or something derived from them) would be
better?

    --force
    --ignore-errors
    --no-check
    --unsafe
    --no-strict
    --aggressive

Or, some pure made-up bike-shedding?

    --try-harder
    --allow-bogus-type
    --ignore-bogus-type
    --loose
    --gently
