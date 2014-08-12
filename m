From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/8] mv: unindent one level for directory move code
Date: Tue, 12 Aug 2014 21:57:17 +0700
Message-ID: <CACsJy8B2P-UMvbkW2HtyxrYPP8TyXnt25CYw9=ZZp6Ks+ed=yA@mail.gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
 <1407637776-19794-7-git-send-email-pclouds@gmail.com> <xmqq61hy7tii.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 16:57:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHDWL-000781-4Q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 16:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbaHLO5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2014 10:57:49 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36371 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbaHLO5s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2014 10:57:48 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so6962621iga.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wOPGKP2PCbPW/cJmwg25G4WYVK9ztl+X+jsWI3GpYSk=;
        b=pWepGtOvKtIYPk7RXEXLnajDPznfyRT1+Jh8/vhYcAF1GWhBdhuK5JnV/4dzMY/+Vr
         uDJ4+a4UQz9u0BILplH160zFBd22xdReiDagQGrNpmF+8myOOWw4mperaQ8E89vhVAG5
         08mSIEx69xNbrlFEXVYC2DBa4xepzkJQiUq5/2QF++oABP3N/v24Ye0dkyM/2eNtWa75
         fHqaMK3yQ3SBCoS7VPAHTqsUiQ4qksQDng+leLXT44mTrttXAUgKqIfa/K6ykvoT+Vop
         /faAUsb7rvxst+X0AecebS8wQlkGvUJEFVaRolwyxtdx4mTnfCNd5wSO8XwDBcDZrBkB
         M6og==
X-Received: by 10.43.129.74 with SMTP id hh10mr40473954icc.48.1407855467687;
 Tue, 12 Aug 2014 07:57:47 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Tue, 12 Aug 2014 07:57:17 -0700 (PDT)
In-Reply-To: <xmqq61hy7tii.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255147>

On Tue, Aug 12, 2014 at 1:47 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  builtin/mv.c | 47 +++++++++++++++++++++--------------------------
>>  1 file changed, 21 insertions(+), 26 deletions(-)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index dcfcb11..988945c 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -171,42 +171,37 @@ int cmd_mv(int argc, const char **argv, const =
char *prefix)
>>                               && lstat(dst, &st) =3D=3D 0)
>>                       bad =3D _("cannot move directory over file");
>>               else if (src_is_dir) {
>> +                     int first =3D cache_name_pos(src, length), las=
t;
>>                       if (first >=3D 0)
>>                               prepare_move_submodule(src, first,
>>                                                      submodule_gitfi=
le + i);
>> +                     else if (index_range_of_same_dir(src, length,
>> +                                                      &first, &last=
) < 1) {
>
> The function returns (last - first), so (last - first) < 1 holds
> inside this block, right?
>
>>                               modes[i] =3D WORKING_DIRECTORY;
>>                               if (last - first < 1)
>>                                       bad =3D _("source directory is=
 empty");
>
> Then do you need this conditional, or it is always bad here?
>
> If it is always bad, then modes[i] do not need to be assigned to,
> either, I think.
>
> Am I missing something?

No you're right.

>> +                     } else { /* last - first >=3D 1 */
>> +                             int j, dst_len, n;
>
>> +                             modes[i] =3D WORKING_DIRECTORY;
>> +                             n =3D argc + last - first;
>> ...
>
> Otherwise, perhaps squash this in?

Sure. But I'm having second thought about this series.

mv.c is centered around files on worktree, which makes it pretty hard
if we want to make it more like rm.c where index and worktree entries
are treated more equally and pathspec is applied. Doing that in mv.c
would require a lot more reorganization that makes this series
obsolete. But on the other hand, I'm not even sure if I have time to
pursue that. So..
--=20
Duy
