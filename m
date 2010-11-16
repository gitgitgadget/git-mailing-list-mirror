From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 07/10] checkout: add -S to update sparse checkout
Date: Tue, 16 Nov 2010 10:08:27 +0700
Message-ID: <AANLkTim3LMhQiO0RmPTW3dLNQa0FxkyX3m7Jjd_rPN7C@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-8-git-send-email-pclouds@gmail.com> <20101115211636.GH16385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 04:09:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIBv0-0005wl-M8
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 04:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759246Ab0KPDIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 22:08:54 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46967 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759225Ab0KPDIs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 22:08:48 -0500
Received: by wyb28 with SMTP id 28so217001wyb.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 19:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=F145jrq15X0oOBhUf8/9ynmX7cFJkJ3X3RJVv2IawBU=;
        b=Wba6dlDxEVdP0zJ12oNaPC2Y0ZgloYxOOkhyNObnJ+JwNL+WlMW/C/0GyMpS0XBKNj
         ZoAxLflE3F9U3Aufh7tKVJoFbt2ZuToSqUFB03ptVHbMgShiltDBGdPkdw6MyTcMVvPD
         kjWJ2U6xrMZlCwE00bYzvG/QEYKUTnUOws9/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eDFHk0z4+s72NAF2iu9ZGVOKJRpRP1dd95fXt6tYh1oIT3x2PoxC/vfjqxb5tHPqMi
         0r+jSTItVPRUeYO2mz5Hl498S0Ed8p1tMclTBMxDJE2Jk8BhsMGR6tGl6FEFSS5INT8R
         mVE8EAtmYn8zqN0xO6z2f59chLfO3DEEl8WZU=
Received: by 10.216.172.9 with SMTP id s9mr6018208wel.56.1289876927386; Mon,
 15 Nov 2010 19:08:47 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 15 Nov 2010 19:08:27 -0800 (PST)
In-Reply-To: <20101115211636.GH16385@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161537>

2010/11/16 Jonathan Nieder <jrnieder@gmail.com>:
>> =C2=A0DESCRIPTION
>> =C2=A0-----------
>> @@ -176,6 +177,13 @@ the conflicted merge in the specified paths.
>> =C2=A0This means that you can use `git checkout -p` to selectively d=
iscard
>> =C2=A0edits from your current working tree.
>>
>> +-S::
>> +--update-sparse-checkout::
>> + =C2=A0 =C2=A0 An editor is invoked to let you update your sparse c=
heckout
>> + =C2=A0 =C2=A0 patterns. The updated patterns will be saved in
>> + =C2=A0 =C2=A0 $GIT_DIR/info/sparse-checkout. The working directory=
 is also
>> + =C2=A0 =C2=A0 updated. An empty file will abort the process.
>
> Wording nit: this doesn't make the worktree more up-to-date. =C2=A0Ho=
w
> about:
>
> =C2=A0--edit-sparse-checkout
> =C2=A0--define-work-area
> =C2=A0--narrow-worktree
>
> Hmph.
>
> --edit-sparse-checkout seems best for consistency of the choices I ca=
n
> think of.

Yep. --edit-sparse-checkout.

>> @@ -316,6 +324,14 @@ $ git add frotz
>> =C2=A0------------
>>
>>
>> +ENVIRONMENT AND CONFIGURATION VARIABLES
>> +---------------------------------------
>> +The editor used to edit the commit log message will be chosen from =
the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^
> =C2=A0patterns defining what subset of the tracked tree to work on
>
>> +GIT_EDITOR environment variable, the core.editor configuration vari=
able, the
>
> Might be simpler to say:

That was copied from git-commit.txt (I think). Maybe that file should
be updated too.

> [...]
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -675,6 +675,31 @@ static const char *unique_tracking_name(const c=
har *name)
>> =C2=A0 =C2=A0 =C2=A0 return NULL;
>> =C2=A0}
>>
>> +static void edit_info_sparse_checkout()
>> +{
>> + =C2=A0 =C2=A0 char *tmpfile =3D xstrdup(git_path("sparse-checkout"=
));
>
> git_pathdup()?

Yup.

>
>> + =C2=A0 =C2=A0 for (i =3D 0; i < el.nr; i++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(el.excludes[i]);
>> + =C2=A0 =C2=A0 free(el.excludes);
>
> Neat.

This code is actually duplicated in unpack_trees(). It's time to
create free_exclude() function.

>> +
>> + =C2=A0 =C2=A0 if (rename(tmpfile, git_path("info/sparse-checkout")=
) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno("Can't update =
%s", git_path("info/sparse-checkout"));
>
> Wouldn't git_path() clobber errno? =C2=A0Probably worth keeping a tem=
porary
> with the result from git_path before the rename.

OK

>> --- a/t/t1011-read-tree-sparse-checkout.sh
>> +++ b/t/t1011-read-tree-sparse-checkout.sh
>> @@ -184,4 +184,22 @@ test_expect_success 'read-tree --reset removes =
outside worktree' '
>> =C2=A0 =C2=A0 =C2=A0 test_cmp empty result
>> =C2=A0'
>>
>> +test_expect_success 'git checkout -S fails to launch editor' '
>> + =C2=A0 =C2=A0 GIT_EDITOR=3D/non-existent test_must_fail git checko=
ut -S &&
>
> Exporting envvars via a function is non-portable. =C2=A0The usual wor=
karound:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_EDITOR=3D.=
=2E. &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export =C2=A0G=
IT_EDITOR &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail=
 ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
>
> Maybe it's time to introduce
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval_must_fail GIT_EDITOR=3D/non-existent =
git checkout -S
>
> ?

I'll go with the former.
--=20
Duy
