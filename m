From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 18:50:50 -0600
Message-ID: <CAMP44s3QtOssBDW_XRJR_K0N-rpwQ4mFx-8e2c6pUc-UkoGb1A@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
	<7vvcc6z801.fsf@alter.siamese.dyndns.org>
	<CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
	<7vmwxhycii.fsf@alter.siamese.dyndns.org>
	<CAMP44s0qK6yNiPe0ERDJWK-wfm3DdXZYwRzisoCPJ7PjsdkObQ@mail.gmail.com>
	<7vsj79wmck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 01:51:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjJUa-0000iJ-QB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 01:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab2LNAuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 19:50:51 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43845 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab2LNAuv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 19:50:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2750001obb.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 16:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B7+5QhMgW3yrEEMaTJLyrmpl/xEWVHrjl66+m0b8l7Q=;
        b=npiQ9XsdEcPh06aZsRX7vxWsTHETEXrtiNqW9a8e5TS7UWPYmrUB7VdeqwKept94MY
         2YE5OF/gcRJhKAkeD3wMMyLhAQk0YaDW4Q9JMERXi6WNANClPBLBx8MVNPBhd5V3No8n
         LR32AKmy/DhJeQMJE0/YZeyA2D+8NiDpCdL//fwAEoLuRBBIG/1XSORF02fOgL17LqCp
         nW4qmP+hyl6CpNDPGzRP29IHGn4KGovDISTlc6pwEdLc6lC6FMGz1mnzHUlYPFvt07EU
         PnodiqOI/aJmA/B4yEaPGFqbjZXInEmUCKeSNrKz9PIl1yfa7YhrB3CFW6iNaqCw7ghQ
         xQxw==
Received: by 10.60.170.242 with SMTP id ap18mr3172017oec.97.1355446250638;
 Thu, 13 Dec 2012 16:50:50 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Thu, 13 Dec 2012 16:50:50 -0800 (PST)
In-Reply-To: <7vsj79wmck.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211482>

On Thu, Dec 13, 2012 at 5:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Dec 13, 2012 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> One of the review points were about this piece in the test:
>>>
>>>     > +cmd=<<EOF
>>>     > +import bzrlib
>>>     > +bzrlib.initialize()
>>>     > +import bzrlib.plugin
>>>     > +bzrlib.plugin.load_plugins()
>>>     > +import bzrlib.plugins.fastimport
>>>     > +EOF
>>>     > +if ! "$PYTHON_PATH" -c "$cmd"; then
>>>
>>>     I cannot see how this could have ever worked.
>>>
>>> And I still don't see how your "would work just fine" can be true.
>>
>> As I have explained, all this code is the equivalent of python -c '',
>> or rather, it's a no-op. It works in the sense that it doesn't break
>> anything.
>
> Aren't you ashamed of yourself after having said this?

It is a fact.

>> The purpose of the code is to check for the fastimport plug-in, but
>> that plug-in is not used any more, it's vestigial code, it doesn't
>> matter if the check works or not, as long as it doesn't fail.
>
> If so, the final version that is suitable for merging would have
> that unused code stripped away, no?

To the users there's absolutely no difference.

>>> But it is totally a different matter to merge a crap with known
>>> breakage that is one easy fix away from the get-go.  Allowing that
>>> means that all the times we spend on reviewing patches here go
>>> wasted, discouraging reviewers.
>>
>> There is no breakage.
>
> Unused code that burdens others to read through to make sure nothing
> is broken is already broken from maintenance point of view.

Remove the whole test then. I'm already doing way more than most of
the code in contrib by providing tests.

> Why are you wasting my time and everybody's bandwidth on this, when
> you are very well capable of rerolling the series with removal and
> style fixes in far shorter time?

I will do that, when I do that.

We have no time constraints, have we? This code is not getting in
1.8.1 either way.

Anyway, if you merge this code as it is, nothing bad will happen.
Nobody would get hurt, and in fact, very few, if anybody, would
notice.

Cheers.

-- 
Felipe Contreras
