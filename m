From: demerphq <demerphq@gmail.com>
Subject: Re: Poor status output during conflicted merge
Date: Wed, 7 Jul 2010 14:43:48 +0200
Message-ID: <AANLkTinlLQEQuvX5zTmj6ulsnLdyzyuIdZC7fR4am0pC@mail.gmail.com>
References: <loom.20100701T195742-266@post.gmane.org>
	<7v1vbm3g8j.fsf@alter.siamese.dyndns.org>
	<AANLkTimBQULqlIVLOOpFoOO5Lg7hGrgm7N69qouafFyG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 14:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWTym-0002sO-7Y
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 14:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab0GGMnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 08:43:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48673 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab0GGMnu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 08:43:50 -0400
Received: by fxm14 with SMTP id 14so5505451fxm.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=US/euUDwNk98v6nn8/u7o7EQjzafKYk7ak2CHXfYvNo=;
        b=CDpdNP57qGODqWX1PBTLu8tqEj+rHi6wFGmi7OOdXreU8AzD2W1cMAdWULXJObnPJJ
         4PDtk4voHpCl9ELi3M8qt9YIldojbySI1ZiISwfKJlIb4EhtF8ydMRzYDjlahEqar1t6
         +juiji1Ht7kRQbMZOTsTkpyNAIrwi/b86O08Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pxix3q3Z7ef9jrULkz51L79CXZR1w/j2Hl5+An8nE3+IvzZoRh4oywS+liTLCpQec2
         AF3xXGOKqvH1PKHAZWO75R6bcccuJbn2Q0WXw4QbLM2qptB7rhf0zvnV6SqHuM147eeI
         zj2C8VZKWUCmAQD9OQ0cybN6B661/tCecRFeM=
Received: by 10.239.162.136 with SMTP id l8mr711771hbd.212.1278506628347; Wed, 
	07 Jul 2010 05:43:48 -0700 (PDT)
Received: by 10.239.183.201 with HTTP; Wed, 7 Jul 2010 05:43:48 -0700 (PDT)
In-Reply-To: <AANLkTimBQULqlIVLOOpFoOO5Lg7hGrgm7N69qouafFyG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150468>

On 7 July 2010 02:12, Eric Raible <raible@gmail.com> wrote:
> On Thu, Jul 1, 2010 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> It might be just a simple matter of ...
>>
>> =A0wt-status.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/wt-status.c b/wt-status.c
>> index 2f9e33c..757536f 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -674,6 +674,8 @@ void wt_status_print(struct wt_status *s)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(s->fp, "# No =
changes\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (s->nowarn)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0; /* nothing */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (s->in_merge)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("merge result w=
ill be the same as HEAD commit\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (s->workdir_dirty)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("no changes ad=
ded to commit%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0advic=
e_status_hints
>
> I suppose that's better than nothing, but I can't help but think that
> the output would =A0be more useful if it explicitly mentioned the mer=
ge.
>
> Most sensible people probably already have that in their bash prompt,
> of course, but we have some users at $dayjob who use the anemic
> windows cmd.exe as their "command shell".
>
> So how about something like this:
>
> $ git status
> # Merging branch 'master' into topic
> # Changes to be committed:
> #
> # =A0 =A0 =A0 modified: =A0 file2
>
> The "branch 'master' into topic" part can come
> from .git/MERGE_MSG

+1


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
