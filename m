From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within transactions
Date: Tue, 12 May 2015 08:45:19 -0700
Message-ID: <CAPc5daVQEMv-QPDpyNVGzcjrjrw20QLzm8dkC0ZYAX=Y4zGaBQ@mail.gmail.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
 <1431357920-25090-2-git-send-email-mhagger@alum.mit.edu> <xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com>
 <5551BA88.3090900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 12 17:45:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsCNN-0004eU-Kq
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 17:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbbELPpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 11:45:41 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35305 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbELPpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 11:45:40 -0400
Received: by obcus9 with SMTP id us9so8741008obc.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JiQ1N6hoaKq+kNPsbDyG7r+2eU9gclDVmZ9HATSYRA0=;
        b=UMM3QHVQoppIy4+KLLo8+gDLolKI30d5ZfO3Ghcf1dBwRJr7xDaOnOTks3/MPSNOtk
         5MWsDSGoon5ULbqtlHNovZ48s6olP8t+wETzUrEYfZUu6ad6C4xlrAb+2ehmGqbOqgpg
         vhFcGaZPhmqvw6dxgqivcm+1IPXuB1KjKwtArScgae1XwME9ioutTort42yeR/Su5ZAz
         hkLo9qnXMivKMuMfVByIIPjcIiSPdTvGxN0fmhO59tQN00hyiXRES/I1YtoTXsC30XD5
         MHcJYujk20FjVlKQUiPaYaiQmEEWkuz1LsKx06cV1xqqP/phFAGmmPvz1KWZB1ZoqnSw
         mCKA==
X-Received: by 10.60.160.65 with SMTP id xi1mr12415694oeb.17.1431445539838;
 Tue, 12 May 2015 08:45:39 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Tue, 12 May 2015 08:45:19 -0700 (PDT)
In-Reply-To: <5551BA88.3090900@alum.mit.edu>
X-Google-Sender-Auth: 3_Rw3P758ZPAS-RgJzJnaUQpo0U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268857>

On Tue, May 12, 2015 at 1:32 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/11/2015 09:37 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> ...
>>> +    test_must_fail git update-ref --stdin <input 2>output.err &&
>>> +    grep -F "$error" output.err &&
>>
>> I am not 100% confident that "grep -F" is the right thing to use
>> here.  I checked all the error message these tests are expecting and
>> none seems to go through _(), but is it fundamental that these
>> errors should not be translated?
>
> Aren't tests run in the "C" locale so that tests don't have to worry
> about i18n?

But there is a i18n markings test, for which test-i18ngrep was invented for.
