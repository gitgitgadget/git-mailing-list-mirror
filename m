From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http protocol
Date: Tue, 13 Oct 2009 21:10:12 +1100
Message-ID: <d2e97e800910130310wa9731a6j9b9bdd25047ade85@mail.gmail.com>
References: <4ACF7296.3010809@gmail.com> <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com> 
	<4AD09F5E.9090304@gmail.com> <be6fef0d0910100811l325d3df1jdf8d3d9dd51e3385@mail.gmail.com> 
	<4AD0AE84.1070500@gmail.com> <be6fef0d0910100907t61ea922bqf117e6c025e94ce7@mail.gmail.com> 
	<4AD0BBCB.8000306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>
To: eduard stefan <eduard.stefan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 12:12:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxeMH-0004Wi-8n
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 12:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933764AbZJMKLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 06:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933314AbZJMKLK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 06:11:10 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56395 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759007AbZJMKLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 06:11:09 -0400
Received: by ywh6 with SMTP id 6so8830998ywh.4
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=z0rv5BvnS153nf5bQ9za0QveiA7O46hAmGObC93+OjQ=;
        b=PZLvUNB76VETJn0bJNOW2nbqI8ioXbbabT33JSx+H640J349bo8YuRjc8db8OvznjW
         onL3au1bf2usis40z33FnjDRsGT08IjurkjnCEF8QoYQgSBwIFF3nVQ7ITonxPqoBvA4
         Hry8tEAa+mmgmIY1rKb/noLW3GAVXdRvTxxdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oqVFx3zgc+7o0ClZnKPTRtUuZeph6MHOK7yHecFWaYR5EtJ4aT/gAAfLy7PdXplBzX
         16jXvncC7sjxyCWhOrlQwiDgNg47kwawcjvdE8UTCw1AP/qbjQjB9z+zBzi7jRMyTU39
         GlC8ZDmadvjnoVOaPX2dFxINREf3Bu17tMikg=
Received: by 10.91.143.18 with SMTP id v18mr4237718agn.71.1255428632178; Tue, 
	13 Oct 2009 03:10:32 -0700 (PDT)
In-Reply-To: <4AD0BBCB.8000306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130152>

2009/10/11 eduard stefan <eduard.stefan@gmail.com>:
> Tay Ray Chuan wrote:
>> I suspect, as you do, it's got to do with remote-curl.
>>
>> Could you try this command?
>>
>> =C2=A0 echo list | git remote-curl http://github.com/loudej/spark.gi=
t
>
> Inside an empty repository it crashes the same way,
> without any additional information.
> "git remote-curl" crashes in the same way,
> but "git remote-curl --help" tries to launch the browser.
>
> Is there any way to obtain more information from this crash?
> Some debug mode?

Using the above repository, I see the same crash with msysGit at git
revision 1.6.5. Using windbg as the post-mortem debugger, the
following information is captured:

  (a14.e8c): Access violation - code c0000005 (!!! second chance !!!)
  eax=3D00000000 ebx=3D00000000 ecx=3Dffffffff edx=3D0046cc00 esi=3D004=
6f98f edi=3D00000000
  eip=3D00420354 esp=3D0022fd80 ebp=3D0022fda8 iopl=3D0         nv up e=
i pl zr na pe nc
  cs=3D001b  ss=3D0023  ds=3D0023  es=3D0023  fs=3D003b  gs=3D0000     =
        efl=3D00010246

=2E..and the faulting instruction is:

  git_remote_curl+0x20354:
  00420354 f2ae            repne scas byte ptr es:[edi]

so, a NULL dereference. The initial disassembly of the function is this=
:

  0:000> u 0042033C
  git_remote_curl+0x2033c:
  0042033c 55              push    ebp
  0042033d 89e5            mov     ebp,esp
  0042033f 57              push    edi
  00420340 56              push    esi
  00420341 53              push    ebx
  00420342 83ec1c          sub     esp,1Ch
  00420345 8b5d08          mov     ebx,dword ptr [ebp+8]
  00420348 8b750c          mov     esi,dword ptr [ebp+0Ch]
  0042034b 31c0            xor     eax,eax
  0042034d b9ffffffff      mov     ecx,0FFFFFFFFh
  00420352 89df            mov     edi,ebx
  00420354 f2ae            repne scas byte ptr es:[edi]
  00420356 f7d1            not     ecx
  00420358 8d51ff          lea     edx,[ecx-1]
  0042035b b9ffffffff      mov     ecx,0FFFFFFFFh
  00420360 89f7            mov     edi,esi
  00420362 f2ae            repne scas byte ptr es:[edi]
  00420364 f7d1            not     ecx
  00420366 49              dec     ecx
  00420367 7466            je      git_remote_curl+0x203cf (004203cf)
  00420369 85d2            test    edx,edx
  0042036b 0f84b1000000    je      git_remote_curl+0x20422 (00420422)
  00420371 89f7            mov     edi,esi
  00420373 89de            mov     esi,ebx
  ...

So its the first parameter that is NULL. The second parameter is:

  0:000> da poi(ebp+c)
  0046f98f  "libexec/git-core"

I don't know how to build msysGit so that symbols are generated so
I've attempted to reconstruct the source code; which ends up looking
something like the following:

  int some_unknown_func(char *arg1, char *arg2)
  {
      len1 =3D strlen(arg1) - 1;  // <- crash here
      len2 =3D strlen(arg2);
      len3 =3D len2 - 1;

      if (len2 !=3D 1) {
          if (!len1)
              return 0;
          for (;;) {
              x =3D arg1[len1 - 1];

              if (x !=3D '/' && x !=3D '\\') {
                  --len1;
                  --len3;
                  if (arg1[len1] !=3D arg2[len3])
                      return 0;
              } else {
                  ...
              }
          }
      }
  }

Perhaps those more familiar with git's sources might recognise code
that looks similar to the above sequence.
