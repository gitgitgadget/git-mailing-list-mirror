From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Git on QNX
Date: Tue, 15 Dec 2009 14:13:53 -0800
Message-ID: <905315640912151413g10ee5befh58fbd171237e7659@mail.gmail.com>
References: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com> 
	<7v6387zzfi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, mkraai@beckman.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 23:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKff5-0000HS-3Q
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 23:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933936AbZLOWOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 17:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933877AbZLOWOS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 17:14:18 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60610 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761365AbZLOWOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2009 17:14:15 -0500
Received: by pwj9 with SMTP id 9so217856pwj.21
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 14:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=FNxbiUwhXD/kLnqwpOLpw755srcpzLm7UuBoNE0qAu4=;
        b=J5wb18LZwi8WioMpNjR110bYcCDONWxCmYqeNkX1BCy43NQ4lvH06RGg2jq9rDREtn
         SE91pPJ0k3zGoIx/ddBHqntvm2tttMWObc8CmxzEBGJ8PCj4OGCDfWSokLGrjCyckQs0
         ii6Cbk+jXnSkkiY+Bi335NyLm+JwsA8i3RAK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=lgNtYUXZiaZsI5WQmAfSsdXXdhMoG5DkWojG9TAwIRbo3gx66+hJkd3LBl60vwZzNI
         uuZxbrjX72Ssjn/1qOh0tT25kLqq6uJ/jjL0vHy+ecNtR4YZNCrj22e2eujeADwClGce
         JQVzsBK4sAaDREqr1FGo+tiEYeunbdTJXML7Y=
Received: by 10.142.249.2 with SMTP id w2mr79464wfh.198.1260915253064; Tue, 15 
	Dec 2009 14:14:13 -0800 (PST)
In-Reply-To: <7v6387zzfi.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: c5efee971f5161ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135304>

On Tue, Dec 15, 2009 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tarmigan <tarmigan+git@gmail.com> writes:
>
>> diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
>> index 8ed4a6f..5cbc16c 100644
>> --- a/builtin-fetch-pack.c
>> +++ b/builtin-fetch-pack.c
>> @@ -778,7 +778,7 @@ static int fetch_pack_config(const char *var,
>> const char *value, void *cb)
>> =A0 =A0 =A0 return git_default_config(var, value, cb);
>> =A0}
>>
>> -static struct lock_file lock;
>> +static struct lock_file lockfile;
>>
>> =A0static void fetch_pack_setup(void)
>> =A0{
>> @@ -958,14 +958,14 @@ struct ref *fetch_pack(struct fetch_pack_args =
*my_args,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 )
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("shallow file was ch=
anged during fetch");
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 fd =3D hold_lock_file_for_update(&lock, sh=
allow,
>> + =A0 =A0 =A0 =A0 =A0 =A0 fd =3D hold_lock_file_for_update(&lockfile=
, shallow,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0LOCK_DIE_ON_ERROR);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!write_shallow_commits(&sb, 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| write_in_full(fd, sb.buf, sb.len) =
!=3D sb.len) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unlink_or_warn(shallow);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rollback_lock_file(&lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rollback_lock_file(&lockfi=
le);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_lock_file(&lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_lock_file(&lockfile=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_release(&sb);
>> =A0 =A0 =A0 }
>
> Is this because QNX uses "lock" as some global identifier for some ot=
her
> purpose? =A0I think moving the file-scope-static definition to the sc=
ope
> it is used in without renaming would make a cleaner patch.

Yes, exactly that reason.  I agree the declaration should just move
into fetch_pack() as a static, but I didn't realize that until after I
had renamed all of the uses, and I was lazy as this was not for
submission.

>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5c59687..857e938 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -79,6 +84,7 @@
>> =A0#include <stdlib.h>
>> =A0#include <stdarg.h>
>> =A0#include <string.h>
>> +#include <strings.h>
>> =A0#include <errno.h>
>> =A0#include <limits.h>
>> =A0#include <sys/param.h>
>
> Other hunks are QNX specific enough but this hunk is worrisome; you c=
annot
> tell how you are hurting other platforms with this change. =A0Can you=
 tell
> declarations of which functions are missing on QNX without this chang=
e?

strcasecmp()
http://www.opengroup.org/onlinepubs/000095399/functions/strcasecmp.html

I agree that this change could affect other platforms and they've
gotten along fine without it so far.  I'm surprised no others have
needed it.  Would it be better wrapped in a #ifdef?

Thanks,
Tarmigan
