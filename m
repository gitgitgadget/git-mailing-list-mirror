From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 04 Nov 2010 01:04:52 +0000
Message-ID: <87r5f1x5jf.fsf@fox.patthoyts.tk>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
	<877hgunmdc.fsf@fox.patthoyts.tk>
	<AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
	<AANLkTin6120QbxyxHt=UM9Dpk_3C-vaD2z8RaRuut76r@mail.gmail.com>
	<8739rind8u.fsf@fox.patthoyts.tk>
	<AANLkTimcYdQD-En+SfkH5dkaxaWXveuA5Oz-Hn0Cf1v+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 04 02:05:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDoGP-0003i7-4L
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab0KDBFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 21:05:05 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:53953 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753948Ab0KDBFE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 21:05:04 -0400
Received: from [172.23.144.246] (helo=asmtp-out2.blueyonder.co.uk)
	by smtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PDoG5-00036d-6B; Thu, 04 Nov 2010 01:04:54 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PDoG5-0000n0-1F; Thu, 04 Nov 2010 01:04:53 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 927DB2510B; Thu,  4 Nov 2010 01:04:52 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTimcYdQD-En+SfkH5dkaxaWXveuA5Oz-Hn0Cf1v+@mail.gmail.com>
	(Erik Faye-Lund's message of "Thu, 4 Nov 2010 01:53:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160660>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>On Thu, Nov 4, 2010 at 1:28 AM, Pat Thoyts
><patthoyts@users.sourceforge.net> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com=
> wrote:
>>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>>> index b780200..47e7d26 100644
>>>> --- a/compat/mingw.c
>>>> +++ b/compat/mingw.c
>>>> @@ -1519,8 +1519,10 @@ pid_t waitpid(pid_t pid, int *status, unsig=
ned options)
>>>> =A0 =A0 =A0 =A0}
>>>>
>>>> =A0 =A0 =A0 =A0if (pid > 0 && options & WNOHANG) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingle=
Object((HANDLE)pid, 0))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingle=
Object((HANDLE)pid, 0)) {
>>>
>>>AAAND the last one is right here as well:
>>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WAIT_OBJECT_0 !=3D WaitForSingleObj=
ect((HANDLE)pid, 0))
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WAIT_OBJECT_0 !=3D WaitForSingleObj=
ect(h, 0)) {
>>>
>>
>> Applying both of these doesn't fix the handle leak when I test
>> this. Looking further I believe it is due to the use of a reallocate=
d
>> array. When you remove a pinfo structure you realloc to the one you
>> found, potentially freeing items you still require.
>>
>
>If this is the reason, then that's a bug. The code TRIES to do the
>right thing by memmove'ing the the entro to be deleted to the end.
>Looking over the code, I still don't see anyhing obviously wrong.
>But...
>
>> Attached is a patch that switches to a linked list for this
>> instead. Using this I no longer accumulate leaked handles.
>>
>> ----
>> From e0c05f8f9ed8729648eea92cf654f357fa884e40 Mon Sep 17 00:00:00 20=
01
>> From: Pat Thoyts <patthoyts@users.sourceforge.net>
>> Date: Thu, 4 Nov 2010 00:23:08 +0000
>> Subject: [PATCH] win32-daemon: fix handle leaks
>>
>> The use of an array of pinfo structures and the realloc used when cl=
eaning
>> up a closed child can free structures that are still in use. Use a l=
inked
>> list instead.
>> This stops the leaking of handles in the win32-daemon.
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>> =A0compat/mingw.c | =A0 43 ++++++++++++++++++++++++-----------------=
--
>> =A01 files changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index b780200..29f4036 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -637,11 +637,12 @@ static int env_compare(const void *a, const vo=
id *b)
>> =A0 =A0 =A0 =A0return strcasecmp(*ea, *eb);
>> =A0}
>>
>> -struct {
>> +struct pinfo_t {
>> + =A0 =A0 =A0 struct pinfo_t *next;
>> =A0 =A0 =A0 =A0pid_t pid;
>> =A0 =A0 =A0 =A0HANDLE proc;
>> -} *pinfo;
>> -static int num_pinfo;
>> +} pinfo_t;
>> +struct pinfo_t *pinfo =3D NULL;
>> =A0CRITICAL_SECTION pinfo_cs;
>>
>> =A0static pid_t mingw_spawnve_fd(const char *cmd, const char **argv,=
 char **env,
>> @@ -746,10 +747,13 @@ static pid_t mingw_spawnve_fd(const char *cmd,=
 const char **argv, char **env,
>> =A0 =A0 =A0 =A0 * Keep the handle in a list for waitpid.
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0EnterCriticalSection(&pinfo_cs);
>> - =A0 =A0 =A0 num_pinfo++;
>> - =A0 =A0 =A0 pinfo =3D xrealloc(pinfo, sizeof(*pinfo) * num_pinfo);
>> - =A0 =A0 =A0 pinfo[num_pinfo - 1].pid =3D pi.dwProcessId;
>> - =A0 =A0 =A0 pinfo[num_pinfo - 1].proc =3D pi.hProcess;
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pinfo_t *info =3D xmalloc(sizeo=
f(struct pinfo_t));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->pid =3D pi.dwProcessId;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->proc =3D pi.hProcess;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->next =3D pinfo;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinfo =3D info;
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0LeaveCriticalSection(&pinfo_cs);
>>
>> =A0 =A0 =A0 =A0return (pid_t)pi.dwProcessId;
>> @@ -1519,13 +1523,15 @@ pid_t waitpid(pid_t pid, int *status, unsign=
ed options)
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (pid > 0 && options & WNOHANG) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleOb=
ject((HANDLE)pid, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleOb=
ject(h, 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CloseHandle(h);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0options &=3D ~WNOHANG;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (options =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pinfo_t **ppinfo;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WaitForSingleObject(h, INFINITE) =
!=3D WAIT_OBJECT_0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CloseHandle(h);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> @@ -1536,17 +1542,16 @@ pid_t waitpid(pid_t pid, int *status, unsign=
ed options)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EnterCriticalSection(&pinfo_cs);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < num_pinfo; ++i)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pinfo[i].pid =3D=3D=
 pid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppinfo =3D &pinfo;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (*ppinfo) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pinfo_t *info =3D=
 *ppinfo;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->pid =3D=3D p=
id) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CloseH=
andle(info->proc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ppinf=
o =3D info->next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(i=
nfo);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break=
;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < num_pinfo) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CloseHandle(pinfo[i].p=
roc);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memmove(pinfo + i, pin=
fo + i + 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*pinfo)=
 * (num_pinfo - i - 1));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_pinfo--;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinfo =3D xrealloc(pin=
fo,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*pinfo)=
 * num_pinfo);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppinfo =3D &info->next=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LeaveCriticalSection(&pinfo_cs);
>
>...yeah, using a linked list is more elegant. Do you mind if I snatch
>your code and leave a comment in the commit message?
>

Sure. When I wrote the comment I'd forgotten about the memmove. So
hmmm. However, I just pulled you win32-daemon branch and applied this
patch on top. Now there are no more warnings so your union fix is
good. As I understand it thats the way to handle this particular
warning. ipv6 and ipv4 both still work fine as well.

With my patch a while true; do git ls-remote; done shows no more leakin=
g
handles or memory. So the use of a list is fixing something. Looking
great now.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
