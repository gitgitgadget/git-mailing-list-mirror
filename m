From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 16:05:08 -0600
Message-ID: <CAMP44s0qK6yNiPe0ERDJWK-wfm3DdXZYwRzisoCPJ7PjsdkObQ@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
	<7vvcc6z801.fsf@alter.siamese.dyndns.org>
	<CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
	<7vmwxhycii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 23:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjGuI-0007LE-PQ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 23:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab2LMWFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 17:05:13 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38624 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab2LMWFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 17:05:09 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2621711obb.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 14:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5uXmj5ydJLGI/hF9UusWBpDBvAV85l0do3RC45+/3NE=;
        b=0AC8V4jfQIOBbjRCQzq1pWSGuU+rmjLlda9FKkd2Td1bzpxAXarj2ffeIFqpnHLTPy
         BwF6QsWlcggMmSaWcHoJCHArbDZQre2/d7IH5/rwYFMxmDlqiH+K2nJf/6Hhdle28t1m
         QIPxRMDvtKtXhcbvIUDS9G458gXyzXV6EmrDpgfApUhKHYI0WtCnu8alA2EJbxIN0O6h
         CPP3O9Ougvm6i9WRCGsnSkzgzpk0qEArPDFdm+x28LtUu9kF/dGHDWxZnwtw4khyHL/l
         O1zYuWeP3ap5jV6CpFN053JlcGgYJY2wv9kAGcBlLXN9v8hvYh04cnOIbo2AcVcw1FLb
         s/DA==
Received: by 10.60.169.177 with SMTP id af17mr2818265oec.103.1355436309082;
 Thu, 13 Dec 2012 14:05:09 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Thu, 13 Dec 2012 14:05:08 -0800 (PST)
In-Reply-To: <7vmwxhycii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211473>

On Thu, Dec 13, 2012 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Dec 13, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>>>  New remote helper for bzr (v3).  With minor fixes, this may be ready
>>>>>  for 'next'.
>>>>
>>>> What minor fixes?
>>>
>>> Lookng at the above (fixup), $gmane/210744 comes to mind
>>
>> That doesn't matter. The code and the tests would work just fine.
>
> One of us must be very confused.  Perhaps you were looking at a
> wrong message (or I quoted a wrong one?).
>
>   ... goes and double checks ...
>
> One of the review points were about this piece in the test:
>
>     > +cmd=<<EOF
>     > +import bzrlib
>     > +bzrlib.initialize()
>     > +import bzrlib.plugin
>     > +bzrlib.plugin.load_plugins()
>     > +import bzrlib.plugins.fastimport
>     > +EOF
>     > +if ! "$PYTHON_PATH" -c "$cmd"; then
>
>     I cannot see how this could have ever worked.
>
> And I still don't see how your "would work just fine" can be true.

As I have explained, all this code is the equivalent of python -c '',
or rather, it's a no-op. It works in the sense that it doesn't break
anything.

The purpose of the code is to check for the fastimport plug-in, but
that plug-in is not used any more, it's vestigial code, it doesn't
matter if the check works or not, as long as it doesn't fail.

>>> but there may be others.  It is the responsibility of a contributor to keep
>>> track of review comments others give to his or her patches and
>>> reroll them, so I do not recall every minor details, sorry.
>
> There may be others, but $gmane/210745 is also relevant, I think.

I'll comment on the patch, but I don't think it really prevents the merge.

>> There is nothing that prevents remote-bzr from being merged.
>
> What we merge may not be perfect.  Bugs and misdesigns are often
> identified long after a topic is merged and it is perfectly normal
> we fix things up in-tree.  There are even times where we say "OK, it
> is known to break if the user does something that pokes this and
> that obscure corners of this code, but the benefit of merging this
> 99% working code to help users that do not exercise the rare cases
> is greater than having them wait for getting the remaining 1% right,
> so let's merge it with known breakage documentation".
>
> But it is totally a different matter to merge a crap with known
> breakage that is one easy fix away from the get-go.  Allowing that
> means that all the times we spend on reviewing patches here go
> wasted, discouraging reviewers.

There is no breakage.

> If you want others to take your patches with respect, please take
> reviewers' comments with the same respect you expect to be paid by
> others.

I don't need others to take my patches with respect, my patches are
not people, they don't have feelings.

That being said, I don't think I have disrespected any of your
comments. Yes, you are right that the above code is wrong and doesn't
do anything, what part of agreeing is disrespectful? But I don't agree
that it is a merge blocker. Disagreeing is not disrespecting.

This code was ready for 1.8.1, but it's not going to be there, so, I
don't see any hurry. As I said, I think the code is ready, and these
minor details can wait.

Cheers.

-- 
Felipe Contreras
