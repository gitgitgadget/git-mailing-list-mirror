From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Support customized reordering in version sort
Date: Fri, 20 Feb 2015 19:25:59 -0800
Message-ID: <CAPc5daXtmvfgkFA_YeQxunjSWYGUQB0uWCQVgfxMP_M9fB9qEw@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
 <20150220071342.GB8763@peff.net> <CAPc5daVJ_nYk=tWqpUYPpsX6Z50H429jOh8QfMwUdNDdTDMq9w@mail.gmail.com>
 <20150221030209.GA567@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 04:26:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP0i2-0008QX-Or
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 04:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbbBUD0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 22:26:21 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:54462 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbbBUD0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 22:26:20 -0500
Received: by mail-oi0-f45.google.com with SMTP id i138so5807783oig.4
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 19:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lZVNKsq+JhsLpMkMVGBUj1xFfwn9PfwR6mbPCAqKr+A=;
        b=c7/vzJeXoV7L7K1FqUJKxXkgwQasyiPXqIhCozjMc9vRBJm67xZ25enKnvPm9/R1aF
         Va3KU1a/G9IA4BLSiUnpCwr7QebkyJxrefTKZkb2pOBZMA+SQzLi+k8OJjxKTRVZlQNB
         nnxelC3y2Wb9taqsE86a6zVdSHZ+7ltQUPiIMXCgTz7x9jTlyZ9suluV7ouo8cNtNIy2
         JfGJr4exSUR51EOqw9nS17kx8RtUyyl0tN70i50gfVNknOG7hq3/hO1is1iVXrXcKxzR
         kGm9JGnCRrWyHXYpfD0VZmoB7tteCKmKA6nGwydJSLqxsAq2MEl5Zi3rdFNbQQI8mFbV
         r8jA==
X-Received: by 10.60.39.165 with SMTP id q5mr563986oek.72.1424489180019; Fri,
 20 Feb 2015 19:26:20 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Fri, 20 Feb 2015 19:25:59 -0800 (PST)
In-Reply-To: <20150221030209.GA567@lanh>
X-Google-Sender-Auth: pTdh_ezMmCpAsmow9qOP5IH50og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264200>

On Fri, Feb 20, 2015 at 7:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> My idea is to make it easy for the user to change the sort algorithm.
> And it's probably intuitive to just substitute a string with
> something. So if "1-rc1" is put incorrectly before "1.1" and you
> realize that "1.999" ought to be the last one before "2". You could
> tell git to internally replace "1-rc1" with "1.999".
>
> This patch does that. The user feeds substitution rules via
> versionsort.substitute config keys, e.g.
>
>     git config versionsort.substitute "-rc .999"

I would say 1-rc1 comes and then 1-rc2 and then 1-rc3 ... 1-rc10 and then
1-rc11 and then finally 1. It will probably be followed by 1.1-rc1, 1.1-rc2, ...
and then 1.1 (aka 1.1-final).

If 1-rc1 is equated with 1.9991 because -rc is replaced with .999, how does
it make 1 come after 1.99911, and 1.1.9992 come before 1.1?

I didn't read the patch text and perhaps the explanation above is the only
thing faulty about your message, or perhaps my reading is faulty and the
above describes a sound idea, but I do not see how the above makes sense.
