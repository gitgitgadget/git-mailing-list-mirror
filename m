From: Eugene Sajine <euguess@gmail.com>
Subject: Re: global hooks - once again
Date: Fri, 2 Jul 2010 15:47:48 -0400
Message-ID: <AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:47:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUmDM-0001VO-03
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408Ab0GBTrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:47:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63903 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231Ab0GBTru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:47:50 -0400
Received: by gwj21 with SMTP id 21so46405gwj.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=17iZJrH6Z+U+/q+u6P/o0SAOkphSBCNhAcKnRxn2okY=;
        b=QQFWxrGGq8ARCWhEMCtgEELwsGmbfKruReMp43hZ0cC0KFeyM756WPzwltBDYgg9h4
         xsWvIx4SnnZGN4bQqLcm3mGC/qHj9Vv1+1z8UDlOzkq/cfpRAD+1LUKE9NKXlhSSG2QP
         A5vmLHkLD9e+ZVV/Gf354I1EKAoiqvOS/Q6mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Nz3ceuw1VglxHNHCFBfyCevo81gHsH5X90it2sdJ4/bqqogB1/sVFjgFdyqX4Jhr2M
         JpLKhsc8SIamirkynFnM8M+xrK028WqB6paTzxftX9hM0lgDHzU0reOy4ek77mOofWAb
         rngjUHFexO2Y63/95I+j6gshHKIJM/F7c4iBI=
Received: by 10.229.236.76 with SMTP id kj12mr639161qcb.226.1278100069045; 
	Fri, 02 Jul 2010 12:47:49 -0700 (PDT)
Received: by 10.229.212.209 with HTTP; Fri, 2 Jul 2010 12:47:48 -0700 (PDT)
In-Reply-To: <7v630x1yl8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150161>

On Fri, Jul 2, 2010 at 3:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> For example, so i could say
>> $ git config --global hooks.dir ~/git/hooks
>
> I don't think "global" hooks are useful for people who work on more than
> one project, or people who interact in more than one ways to projects.
> Different projects typically have different needs out of the hooks
> (e.g. pre-commit policy), and different workflows typically call for
> different needs out of the hooks (e.g. I would want to be able to rebase
> in my private working repository but not in the repository I use for
> integration of other people's branches).
>
> So I am fairly negative on your particular example above.


Well, you forgot about another half of users that are working with
many projects but using one policy for example in one company, or if
the guy works with several projects, but wants some of his custom
hooks to be applied for all his repos/projects, for example if he want
some general actions to be executed before commit, like spell check of
the commit message. If I have 40 repos --global approach is the way to
go.
In addition, i don't think there is a downside in this particular
example as it is not a mandatory property that I propose. If you need
a global hook there should be an easy way to work with it. If you
don't need it - just don't touch anything and work on per repo basis.

>
> But it is understandable for one to use more than one repository for the
> same project and use them in the same way; in such a case, I agree that a
> way to ensure that these repositories use the same set of hooks (and
> non-hooks, e.g. commit templates, local ignore pattern files, etc.) is
> desirable.
>
> So I would imagine that your example without "--global" would be a
> reasonable thing to do once per repository.

once again it is only a part of use cases. there might be several
repos/projects for one user. --global is necessary option
I'm talking about user level hooks. He has no admin access to
/usr/local/ and too many repos to deal with each one of them and set
up hooks per repo.


>   [alias]
>   set-hooks = !"sh -c 'rm -fr .git/hooks && ln -s $1 .git/hooks' -"

This is good one, but not enough. Not that it is too difficult to
execute it 40 times, but just the fact that in order to understand how
to do that i had to write to git list;) Having it in git config makes
it straight forward for end user and much user "friendlier"

Thanks,
Eugene
