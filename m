From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Fwd: git cvsimport implications
Date: Wed, 15 May 2013 14:03:13 -0400
Message-ID: <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
	<CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
	<7vfvxpfbli.fsf@alter.siamese.dyndns.org>
	<51932A1A.4050606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 15 20:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucg9m-0006Sg-KJ
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 20:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922Ab3EOSK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 14:10:26 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:46609 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566Ab3EOSK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 14:10:26 -0400
Received: by mail-ia0-f177.google.com with SMTP id z13so2473291iaz.36
        for <git@vger.kernel.org>; Wed, 15 May 2013 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=hVPq5IX1oiu70CLnkf64fU+LsZWnXEBh3N8OB981jng=;
        b=EybzAgn6vTElPlyDK+jQ+ZKTHTO7u+gny5UWNlJ7CAYAjNxZjC+uC9xZfIRhBCDN74
         JponUxXxiVfja5DxLqjoqF6b+slcyBJdk3DLl/gZY/kigKodA+G1Kwb2kl/sASHsH2yV
         HkRhmSnYeXCzHec/9VhZN0zmEKrkwszIx8NjKe2ZefSRB+soKuQeTpWp+93UqolrFauU
         qWEFvj6RJuVK/WXx/fSXja2kimcqKQVvYjna+zvggfcj9ILtV0pJFhPKh8qc2aVAxVHt
         zc90UWrkevHm01e5JEvbunkTOtyk5xafONYgdMm18EneDCCqdJEuVVaqqWNHqNIv/u2W
         svlg==
X-Received: by 10.50.138.166 with SMTP id qr6mr6202093igb.45.1368640993939;
 Wed, 15 May 2013 11:03:13 -0700 (PDT)
Received: by 10.42.150.130 with HTTP; Wed, 15 May 2013 11:03:13 -0700 (PDT)
In-Reply-To: <51932A1A.4050606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224436>

Hi

My primary goal was to understand better what are the real problems
that we might have with the way we use git cvsimport, so I was not
asking about the guarantee of the cvsimport to import things
correctly, but if there is a guarantee the import will result in
completely broken history. IF there is a situation when cvsimport can
do things right and when it definitely going to fail?

Anyway, thanks a lot for the info. I do know that cvs2git is an option.

If the cvsimport is that broken - is there any plan to fix it?

Thanks,
Eugene

On Wed, May 15, 2013 at 2:24 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/15/2013 12:19 AM, Junio C Hamano wrote:
>> Eugene Sajine <euguess@gmail.com> writes:
>>
>>> What if there are a lot of branches in the CVS repo? Is it guaranteed
>>> to be broken after import?
>>
>> Even though CVS repository can record branches in individual ,v
>> files, reconstructing per branch history and where the branch
>> happened in each "changeset" cannot be determined with any
>> certainty.  The best you can get is a heuristic result.
>>
>> I do not think anybody can give such a guarantee.  The best you can
>> do is to convert it and validate if the result matches what you
>> think has happened in the CVS history.
>
> Junio, you are correct that there is no 100% reliable way of inferring
> the changesets that were made in CVS.  CVS doesn't record which file
> revisions were committed at the same time, unambiguous branch points,
> etc.  The best a tool can do is use heuristics.
>
> But it *is* possible for a conversion tool to make some more elementary
> guarantees regarding aspects of the history that are recorded
> unambiguously in CVS, for example:
>
> * That if you check the tip of same branch out of CVS and out of Git,
> you get the same contents.
>
> * That CVS file revisions are committed to Git in the correct order
> relative to each other; e.g., that the changes made in CVS revision
> 1.4.2.2 in a particular file precede those made in revision 1.4.2.3 of
> the same file.
>
> git-cvsimport fails to ensure even this minimal level of correctness.
> Such errors are demonstrated in its own test suite.
>
> cvs2git, on the other hand, gets the basics 100% correct (if you find a
> discrepancy, please file a bug!), in addition to having great heuristics
> for inferring the details of the history.
>
> There is no reason ever to use git-cvsimport for one-time conversions
> from CVS to Git.  The only reason ever to use it is if you absolutely
> require an incremental bridge between CVS and Git, and even then please
> use it with great caution.
>
> Michael
> the cvs2svn/cvs2git maintainer
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
