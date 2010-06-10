From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH next v2] log_ref_setup: don't return stack-allocated array
Date: Thu, 10 Jun 2010 18:09:26 +0000
Message-ID: <AANLkTimPCMbprIKQ__SfMej3oST5agPZ06hM2dkyiUfj@mail.gmail.com>
References: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch>
	<47daf53b6b2cc25cc013c5f2183e309a671dc9d3.1276174233.git.trast@student.ethz.ch>
	<AANLkTinI44rPfeXvWr-7jvAVyw5itX_gUsHimwSL74Lv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:09:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmC7-0008Qe-EH
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759537Ab0FJSJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 14:09:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35732 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138Ab0FJSJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 14:09:29 -0400
Received: by gwj15 with SMTP id 15so162923gwj.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kKkIsHN9BBwpn2FwMk3CyS0laHAqOGiYYjQEeYRodBc=;
        b=k1mi9fKMDZ0+GcAQJ4e1qO+SBsIPTotYrt6JQWo0IvVVQeCOYfP2lEmsZ9ng1gqTSe
         BFZwsLhyTbtUkMcAE0GXBHrI3LsbY8iGREcsS/VP+Tk8c6AMMn6maHcPsAM+HNEdbNZD
         8u9ZydVRk5pRG1ypl1X3hqo52llBm+xIIU7Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aOXxUr36SsDiLAb444RGx4ZLaxv15KlBTXVaRCyE7Y/6GfpVkV6keIo9M0IEf5O3Ch
         zQ9Jr1YMdJdrqSHfTK/KSAX94c/vD3eQeGDBsPAfYayU/f7yKCepZh0sQbdzwR83ltO+
         8yJRXkIIVAYiRz91Uf9pdW2svQjNX/GnIBOxs=
Received: by 10.90.107.5 with SMTP id f5mr1309224agc.18.1276193366412; Thu, 10 
	Jun 2010 11:09:26 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 10 Jun 2010 11:09:26 -0700 (PDT)
In-Reply-To: <AANLkTinI44rPfeXvWr-7jvAVyw5itX_gUsHimwSL74Lv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148901>

On Thu, Jun 10, 2010 at 16:46, Erick Mattos <erick.mattos@gmail.com> wr=
ote:
> Hi there,
>
> 2010/6/10 Thomas Rast <trast@student.ethz.ch>
>>
>> 859c301 (refs: split log_ref_write logic into log_ref_setup,
>> 2010-05-21) refactors the stack allocation of the log_file array int=
o
>> the new log_ref_setup() function, but passes it back to the caller.
>>
>> Since the original intent seems to have been to split the work betwe=
en
>> log_ref_setup and log_ref_write, make it the caller's responsibility
>> to allocate the buffer.
>>
>> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>>
>> Sorry for the first one, that was completely botched and didn't even
>> compile.
>>
>> This one does, and as an added bonus also passes some tests.
>>
>> =C2=A0builtin/checkout.c | =C2=A0 =C2=A04 ++--
>> =C2=A0refs.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 26 +=
+++++++++++--------------
>> =C2=A0refs.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
2 +-
>> =C2=A03 files changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 5107eda..1994be9 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -496,12 +496,12 @@ static void update_refs_for_switch(struct
>> checkout_opts *opts,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts->new=
_orphan_branch) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (opts->new_branch_log && !log_all_ref_updates) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int temp;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *log_file;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char log_file[PATH_MAX];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *ref_name =3D mkpath("re=
fs/heads/%s",
>> opts->new_orphan_branch);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D log_all_ref_updates;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_all_ref_updates =3D 1;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (log_ref_setup(ref_name, &log=
_file)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (log_ref_setup(ref_name, log_=
file,
>> sizeof(log_file))) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
printf(stderr, "Can not do reflog
>> for '%s'\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0opts->new_orphan_branch);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l=
og_all_ref_updates =3D temp;
>> diff --git a/refs.c b/refs.c
>> index 3436649..6f486ae 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1262,43 +1262,41 @@ static int copy_msg(char *buf, const char *m=
sg)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return cp - buf;
>> =C2=A0}
>>
>> -int log_ref_setup(const char *ref_name, char **log_file)
>> +int log_ref_setup(const char *ref_name, char *logfile, int bufsize)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int logfd, oflags =3D O_APPEND | O_WRONLY=
;
>> - =C2=A0 =C2=A0 =C2=A0 char logfile[PATH_MAX];
>>
>> - =C2=A0 =C2=A0 =C2=A0 git_snpath(logfile, sizeof(logfile), "logs/%s=
", ref_name);
>> - =C2=A0 =C2=A0 =C2=A0 *log_file =3D logfile;
>> + =C2=A0 =C2=A0 =C2=A0 git_snpath(logfile, bufsize, "logs/%s", ref_n=
ame);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (log_all_ref_updates &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!prefixcmp(ref_name, "refs=
/heads/") ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !prefixcmp(ref_name, "refs=
/remotes/") ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !prefixcmp(ref_name, "refs=
/notes/") ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !strcmp(ref_name, "HEAD"))=
) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (safe_create_l=
eading_directories(*log_file) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (safe_create_l=
eading_directories(logfile) < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return error("unable to create directory for %s",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*log_file);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logfile);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oflags |=3D O=
_CREAT;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> - =C2=A0 =C2=A0 =C2=A0 logfd =3D open(*log_file, oflags, 0666);
>> + =C2=A0 =C2=A0 =C2=A0 logfd =3D open(logfile, oflags, 0666);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (logfd < 0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(oflags =
& O_CREAT) && errno =3D=3D ENOENT)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((oflags &=
 O_CREAT) && errno =3D=3D EISDIR) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (remove_empty_directories(*log_file)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (remove_empty_directories(logfile)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("There are still=
 logs under
>> '%s'",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*log_file);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0logfile);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 logfd =3D open(*log_file, oflags, 0666);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 logfd =3D open(logfile, oflags, 0666);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (logfd < 0=
)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return error("Unable to append to %s: %s",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*log_file, s=
trerror(errno));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logfile, str=
error(errno));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> - =C2=A0 =C2=A0 =C2=A0 adjust_shared_perm(*log_file);
>> + =C2=A0 =C2=A0 =C2=A0 adjust_shared_perm(logfile);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0close(logfd);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> =C2=A0}
>> @@ -1309,14 +1307,14 @@ static int log_ref_write(const char *ref_nam=
e,
>> const unsigned char *old_sha1,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int logfd, result, written, oflags =3D O_=
APPEND | O_WRONLY;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned maxlen, len;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int msglen;
>> - =C2=A0 =C2=A0 =C2=A0 char *log_file;
>> + =C2=A0 =C2=A0 =C2=A0 char log_file[PATH_MAX];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *logrec;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *committer;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (log_all_ref_updates < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_all_ref_u=
pdates =3D !is_bare_repository();
>>
>> - =C2=A0 =C2=A0 =C2=A0 result =3D log_ref_setup(ref_name, &log_file)=
;
>> + =C2=A0 =C2=A0 =C2=A0 result =3D log_ref_setup(ref_name, log_file, =
sizeof(log_file));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (result)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return result=
;
>>
>> diff --git a/refs.h b/refs.h
>> index 594c9d9..762ce50 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -69,7 +69,7 @@ extern void unlock_ref(struct ref_lock *lock);
>> =C2=A0extern int write_ref_sha1(struct ref_lock *lock, const unsigne=
d char
>> *sha1, const char *msg);
>>
>> =C2=A0/** Setup reflog before using. **/
>> -int log_ref_setup(const char *ref_name, char **log_file);
>> +int log_ref_setup(const char *ref_name, char *logfile, int bufsize)=
;
>>
>> =C2=A0/** Reads log for the value of ref during at_time. **/
>> =C2=A0extern int read_ref_at(const char *ref, unsigned long at_time,=
 int cnt,
>> unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cu=
toff_tz,
>> int *cutoff_cnt);
>> --
>> 1.7.1.553.ga798e
>>
>
> I can't get your point.
>
> I don't see any improvement here.=C2=A0 Unless you want to get rid of=
 using
> references on calling functions which is only going to add another bu=
ffer to
> the stack, sized PATH_MAX, once that log_file is going to be really
> allocated in the heap after git_snpath().=C2=A0 As folks use to say h=
ere:
> "changing six by half a dozen".
>
> Even though I think you will need to turn static log_file or to call
> git_snpath again in the calling functions for this proposed change, d=
on't
> you?
>
>> Causes t5516 to fail, but only if I run it under valgrind. =C2=A0(=C3=
=86var
>> managed to trigger it in other ways apparently.)
>
> I haven't ever seen this happening so I think you have found some
> particularity of valgrind which could route a patch to it.

Actually I think my test failure is related to da3efdb17b, see the
"[PATCH v2 2/2] receive-pack: detect aliased updates which can occur
with symrefs" thread.

The patch under discussion here might be good, I don't have the
knowledge to review it. But it's probably not what's causing the issue
i had with t5516.
