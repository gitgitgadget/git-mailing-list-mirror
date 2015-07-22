From: =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2015, #01; Wed, 1)
Date: Wed, 22 Jul 2015 21:32:48 +0200
Message-ID: <55AFEFE0.9000606@gmail.com>
References: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com>
 <55AE8ACF.6090508@gmail.com>
 <alpine.LSU.2.00.1507220957350.16350@hermes-1.csi.cam.ac.uk>
 <55AF7B9C.4000108@gmail.com>
 <alpine.LSU.2.00.1507221351420.12758@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:33:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzla-0007XE-0v
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbbGVTdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2015 15:33:17 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36052 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbGVTdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:33:17 -0400
Received: by wicgb10 with SMTP id gb10so112566094wic.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=1irSTJm+IdIJHvNLcyb1+cmW/fn+gjv4Z1r9n+GJg5o=;
        b=tEssF5mDC8myJ4EaMYrSScwgZuBe/WymtpP6o0VgmTjbYy8kWZMzr7JqsCbC+ezHxA
         kWfZREn1okw6uZ1/VVLUQ302JJ+G3G/EcJ4mx1LdjhYluJ4AYj6qhtf1cWoCDjAvACRd
         +UCHn5gKS4CBYHH/8OS6wexR4fMFoGhuhFIR4rL/uS6jj/qhtHS0iaXZywFZaNAhMpC8
         X+ViY4kkU+ezqlnFkapwJXDGWKP8PO2JWRY1AkWjhx3BQphs6pHPLjOAg+lCNA0M5K7z
         vZvTqUm6J/y9yK8hMfALgeUfnskkUwCvjHsIgDh6WVcHjMi/5Wwk/QuHr+nSJ8oAmapF
         d+YQ==
X-Received: by 10.180.206.41 with SMTP id ll9mr34771694wic.88.1437593595719;
        Wed, 22 Jul 2015 12:33:15 -0700 (PDT)
Received: from [192.168.1.53] (afu155.neoplus.adsl.tpnet.pl. [83.25.150.155])
        by smtp.googlemail.com with ESMTPSA id ha4sm23494057wib.0.2015.07.22.12.33.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jul 2015 12:33:14 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <alpine.LSU.2.00.1507221351420.12758@hermes-1.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274459>

W dniu 2015-07-22 o 15:19, Tony Finch pisze:
> Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>>
>> A question about implementation: why emptying $path_info in
>> evaluate_path_info()?
>=20
> That was for consistency with other parts of the subroutine which (mo=
stly)
> remove items from the global $path_info variable when they are added =
to
> %input_params. But since $path_info isn't used after it has been pars=
ed, I
> suppose it is redundant.

If it is for consistency, better leave it in my opinion.

>>>> - I think that people would want to be able to configure how
>>>>   many levels of directory hierarchy gets turned into categories.
>>>>   Perhaps only top level should be turned into category? Deep
>>>>   hierarchies means deep categories (usually with very few
>>>>   repositories) with current implementation.
>>>
>>> Good question. I was assuming flat-ish directory hierarchies, but t=
hat's
>>> clearly not very true, e.g. https://git.kernel.org/cgit/
>>>
>>> I think it would be right to make this a %feature since categories =
already
>>> nearly fit the %feature per-project override style.
>>
>> On the other hand $projects_list_group_categories is a global gitweb
>> configuration variable, and $projects_list_directory_is_category was
>> patterned after it.
>=20
> Yes... Which do you prefer? :-)

Hmmm... does it makes sense to have per-repository override?  If yes,
then we need to use %features. If not... I am not sure, %features is
newer than global (or rather package) variables for gitweb configuratio=
n,
which must be left for legacy config support (and few are needed before
%features are parsed).

>> A few thoughts about implementation:
>=20
> Helpful, thanks!
>=20
>> - can we turn category header into link even if the category didn't
>>   came from $projects_list_directory_is_category?
>=20
> That would mean changing the project filter to match categories as we=
ll as
> paths. I don't know if this is the right thing to do; perhaps it is,
> because the current behaviour of my category headings is a bit surpri=
sing.
>=20
> At the moment, clicking on the "git" category heading on the page lin=
ked
> below takes you to a page that does not list all the repos that were =
under
> the category heading on the main page.
>=20
> https://git.csx.cam.ac.uk/x/ucs/

I thought gitweb had a way to list all projects belonging to given cate=
gory,
but I see that it doesn't.  So you need to find out if 'category' came =
from
category or from pathname, to decide whether to link it using 'projects=
_list'
action and 'project_filter' parameter (or their PATH_INFO version), or =
not.

This can be done either by checking that category name is directory (th=
ough
we could have false positives here), or when adding categories denote w=
here
it came from (e.g. with additional field).  I think the second is bette=
r,
if we are to hyperlink category-from-pathname headings.

There is interesting corner case: what if some projects use category, a=
nd
some have the same category from pathname?  Clicking on category if=20
hyper-linked would show only a subset of projects inside category. (I t=
hink
this is the oddity you noticed.)

>> - even if $projects_list_directory_is_category is true, the category
>>   could came from 'category' file, or otherwise manually set categor=
y,
>>   though I wonder how we can easily detect this...
>=20
> Yes - I use this to list my personal/experimental repos alongside
> the production repos.
>=20
> I'm not sure why gitweb would need to detect this or what it would do=
 in
> response. At the moment it "just works", apart from the oddity with
> categories vs project filters i described above.

What if there is synthetic category that has no representative in the
path hierarchy?  Then "project_filter" link would lead to strange empty
list of projects...

=46or example http://git.zx2c4.com/ (cgit) uses "Mirrors" category...

We could either abuse "project_filter" for categories, or add a new
query parameter "project_category" or "cat" in short. In either case
it would not have PATH_INFO URL unless category came from directory.

=46ood for thought
--=20
Jakub Nar=C4=99bski
