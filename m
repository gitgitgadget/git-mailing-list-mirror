From: Eric Raible <raible@gmail.com>
Subject: Re: Poor status output during conflicted merge
Date: Tue, 6 Jul 2010 17:12:54 -0700
Message-ID: <AANLkTimBQULqlIVLOOpFoOO5Lg7hGrgm7N69qouafFyG@mail.gmail.com>
References: <loom.20100701T195742-266@post.gmane.org>
	<7v1vbm3g8j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:13:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIG5-0004Pq-UE
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab0GGAM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 20:12:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62731 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab0GGAM4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 20:12:56 -0400
Received: by vws5 with SMTP id 5so8163716vws.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0QqAl7REGikC+ufqdmppHHjO841oz+jmJIp+phytYWE=;
        b=WHjLlVolVZk6Nm04jqB1ZcydujoQ/3yTnm9ETE8EUE28IXQYQS7zlRn0qF7Y53wDtQ
         M3TCbU+ecDJcu+pI3FQ/9MDKFI67pgeJq+IhqsDEOpQtrBdflWfeB9ylaZlPItb4nbox
         LDNvn5XiblXeuthzNxjgmHSlA+kpk2oQSy+i8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=poNiZE43jLhJI/MSKVzvaxbpNI7t+OxBHtP5upOgAfHHQvoOdaos4ocMyowQLEpZ3r
         tXdZdv6CuysY8vPb1I7BK4Lr7zqjhGQ8nDAhCWWFwM9u4IfTytDunJgEtbYiThT7qjpi
         B/II5luI8kVrgPcwI2rKQ0YSAWbMs13CRxf3I=
Received: by 10.220.127.94 with SMTP id f30mr2940498vcs.75.1278461574763; Tue, 
	06 Jul 2010 17:12:54 -0700 (PDT)
Received: by 10.220.46.147 with HTTP; Tue, 6 Jul 2010 17:12:54 -0700 (PDT)
In-Reply-To: <7v1vbm3g8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150421>

On Thu, Jul 1, 2010 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> It might be just a simple matter of ...
>
> =A0wt-status.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 2f9e33c..757536f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -674,6 +674,8 @@ void wt_status_print(struct wt_status *s)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(s->fp, "# No c=
hanges\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (s->nowarn)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0; /* nothing */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (s->in_merge)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("merge result wi=
ll be the same as HEAD commit\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (s->workdir_dirty)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("no changes add=
ed to commit%s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0advice=
_status_hints

I suppose that's better than nothing, but I can't help but think that
the output would  be more useful if it explicitly mentioned the merge.

Most sensible people probably already have that in their bash prompt,
of course, but we have some users at $dayjob who use the anemic
windows cmd.exe as their "command shell".

So how about something like this:

$ git status
# Merging branch 'master' into topic
# Changes to be committed:
#
#       modified:   file2

The "branch 'master' into topic" part can come
from .git/MERGE_MSG
