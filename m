From: John Koleszar <jkoleszar@google.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 4 Apr 2013 18:22:08 -0700
Message-ID: <CAAvHm8NyJ3nRZPygy+grMw5BLhLe8eWfEBNfK1tkC8Y34jRynA@mail.gmail.com>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
	<1365091293-23758-1-git-send-email-jkoleszar@google.com>
	<7v6202jjhx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 03:22:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNvMV-0000NA-TO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 03:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765970Ab3DEBWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 21:22:11 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:59496 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765965Ab3DEBWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 21:22:10 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so3243639wgh.15
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 18:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4kOrBsVp7BfmmFIrdJ2/QxgWStFLXCN5K4xMx0dFsZY=;
        b=ndl73uLNxTDupoUNobs0dg/mHqCAeM3nkOL85sqfUYyY6enQBdtSfgo0fy0qLEQyf8
         +IkdArribbVsRSceoDtDOj/mAmD6W+g6mOFn3hiw9wySv2ogsNAOPQigPrmxf+rcNU2n
         ofiM4a68zdt3GjH/1ZElkUVNneGvAyusVR/L9couOD7rEpKvfgypUHJx6Pym/MHeOFIy
         SGbBI30CDVcettbDRTY57HcjTYybLwdBMEMmc5lWIx9SV6ddqrQJN6DmDKS/7DoEsEvJ
         vYs6j4L07cGpIof6xwiI8bVnq/TrK2ye1DD/XrqeagntjMHuKXbf31eHoK0EFpNDRBzv
         QRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=4kOrBsVp7BfmmFIrdJ2/QxgWStFLXCN5K4xMx0dFsZY=;
        b=kPDCSUaB4jVQeqnYpKVc/JlWQA7D0r2tf8alOyT2Pk9Z5WxDbWswhnA89otalEEFfi
         h1hlI4MF2qVQVgoBScwaHu3EjxMSzPonRDrvFxhXspGL1ETWVBA7kKcCeLb1Z97HbeqN
         RKuqsws5uKyaRzoYBiLtV9VEXA0NupiYMXola3mIZeyycYFDm8UGLpaaYGbUHg20qtSq
         KqcE0JdgAaFwTZRr1iTGc/b1gG7+bavh5AejLwHD8tiC6Hu9YxkJamojQrwyZwMUGoTL
         Yhx9sOzUdHj+pyx1+1E00H51fdGMBvpwPLlXXKSQONEnJ/XkV+29MLHKBlBg/kj8qefH
         TxDg==
X-Received: by 10.180.103.40 with SMTP id ft8mr696186wib.28.1365124928795;
 Thu, 04 Apr 2013 18:22:08 -0700 (PDT)
Received: by 10.194.62.165 with HTTP; Thu, 4 Apr 2013 18:22:08 -0700 (PDT)
In-Reply-To: <7v6202jjhx.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnj3EzpGQOROkBK4/62DrtvI4f/4d/cP8fzF+VQsDUHAI+fVxb3FIxqCBhn5WidoWDFUon3r7klwf7g7gCsTotSlXG9dA3S5V1sg2ubuJcFGgZrc814M1KqUmjjkLPrR5WC15LW3So3LI4w+iGY0O3t5N3RJk3Zi8/7pV8U9mR3594K+bDTgA1v2TxAITYHtqXCSd6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220129>

On Thu, Apr 4, 2013 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> John Koleszar <jkoleszar@google.com> writes:
>
>> @@ -402,7 +404,8 @@ static void get_info_refs(char *arg)
>>
>>       } else {
>>               select_getanyfile();
>> -             for_each_ref(show_text_ref, &buf);
>> +             head_ref_namespaced(show_text_ref, &buf);
>> +             for_each_namespaced_ref(show_text_ref, &buf);
>>               send_strbuf("text/plain", &buf);
>>       }
>
> Whether we are namespaced or not, we used to do for_each_ref() here,
> not advertising the HEAD (outside refs/ hierarchy), but we now do,
> and as the first element in the output.
>
> Am I reading the patch correctly?
>
> Is that an unrelated but useful bugfix even for people who do not
> use server namespaces?
>

Actually, I think this line may be buggy. Hold off submitting if you
haven't already.

Including the HEAD ref in the advertisement from /info/refs ends up
duplicating it, since the dumb client unconditionally fetches the file
/HEAD to use as the that ref. I think the right thing to do is
generate the correct /HEAD using head_ref_namespaced(), rather than
returning the bare file $GIT_DIR/HEAD, but I'm not 100% sure how HEAD
and namespaces interact, since I haven't been able to produce a repo
with a different HEAD in a namespace. Can you verify this approach?

$ GIT_SMART_HTTP=0 ./git ls-remote http://localhost:8080/  | grep HEAD
bd9cd9a1859aa464b3092f2023b3a4040166572d HEAD
bd9cd9a1859aa464b3092f2023b3a4040166572d HEAD

Generates these requests (ignore the errors):
2013/04/04 18:18:49 /info/refs
2013/04/04 18:18:49 http: invalid Content-Length of "3285\r\n" sent
2013/04/04 18:18:49 /HEAD
2013/04/04 18:18:49 http: invalid Content-Length of "41\r\n" sent

I didn't catch this before, since the smart protocol includes HEAD in
its response, and I was trying to make the two match.
