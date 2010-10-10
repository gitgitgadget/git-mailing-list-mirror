From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 08/14] daemon: use run-command api for async serving
Date: Sun, 10 Oct 2010 22:42:44 +0200
Message-ID: <AANLkTinZgXF5pxq_HG1veQwO9_=Pmm5Vk2PUHd6=h7yQ@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-9-git-send-email-kusmabite@gmail.com> <4CB21A5D.4020408@sunshineco.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: msysgit+bncCOPdven-DxDaysjlBBoEN4Sd9w@googlegroups.com Sun Oct 10 22:43:34 2010
Return-path: <msysgit+bncCOPdven-DxDaysjlBBoEN4Sd9w@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f186.google.com ([209.85.216.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDaysjlBBoEN4Sd9w@googlegroups.com>)
	id 1P52jz-0003Ob-Td
	for gcvm-msysgit@m.gmane.org; Sun, 10 Oct 2010 22:43:32 +0200
Received: by qyk4 with SMTP id 4sf2494459qyk.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 10 Oct 2010 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:mime-version:received
         :reply-to:in-reply-to:references:from:date:message-id:subject:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=3CFrknEeznY238Ki54mpctBvaIvI+vU316IChvBzwEM=;
        b=gNMNgdVnhQYTK52vM00SlYtDh23UO2yOFlhTTOe0Nv6dukQcvg+jwLz8pqDBeVbrQG
         5mmoT/Di50DYe0V6/YVquuJSV9EGkONb2rE6gGMO0djRE8jWSrm+N40/J/O1nEdhS5BD
         xYorGDWkQiAHtlZTXoEWH1p60TsuaFQ5vUoJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        b=VH7omrbN4URlQyMI/FG0tlmTrxWw5KP7ZO74tYhrOPEyQgmo4EgY0+hRA5waEGY2Dl
         SYrLQo5hgfv9n00YmtvR2CCCV95vPDHhQBWhk+roldAvjfKczO4Oh/HDoPbVdbN5YOqF
         T+rTdccGb7N/2Nkft3jiwGpfWbEvJPUVe4oZI=
Received: by 10.229.44.3 with SMTP id y3mr272917qce.38.1286743386799;
        Sun, 10 Oct 2010 13:43:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.173.155 with SMTP id p27ls630918qcz.3.p; Sun, 10 Oct 2010
 13:43:06 -0700 (PDT)
Received: by 10.229.192.137 with SMTP id dq9mr807343qcb.14.1286743386122;
        Sun, 10 Oct 2010 13:43:06 -0700 (PDT)
Received: by 10.229.192.137 with SMTP id dq9mr807342qcb.14.1286743386075;
        Sun, 10 Oct 2010 13:43:06 -0700 (PDT)
Received: from mail-vw0-f52.google.com (mail-vw0-f52.google.com [209.85.212.52])
        by gmr-mx.google.com with ESMTP id n15si2915597qcu.11.2010.10.10.13.43.05;
        Sun, 10 Oct 2010 13:43:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.52 as permitted sender) client-ip=209.85.212.52;
Received: by vws8 with SMTP id 8so158292vws.25
        for <msysgit@googlegroups.com>; Sun, 10 Oct 2010 13:43:04 -0700 (PDT)
Received: by 10.220.177.1 with SMTP id bg1mr1654299vcb.193.1286743384779; Sun,
 10 Oct 2010 13:43:04 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 13:42:44 -0700 (PDT)
In-Reply-To: <4CB21A5D.4020408@sunshineco.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.52 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158703>

On Sun, Oct 10, 2010 at 9:56 PM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>
>> fork() is only available on POSIX, so to support git-daemon
>> on Windows we have to use something else.
>>
>> Instead we invent the flag --serve, which is a stripped down
>> version of --inetd-mode. We use start_command() to call
>> git-daemon with this flag appended to serve clients.
>>
>> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
>> ---
>> @@ -654,14 +641,14 @@ static void remove_child(pid_t pid)
>> =A0 */
>> =A0static void kill_some_child(void)
>> =A0{
>> - =A0 =A0 =A0 const struct child *blanket, *next;
>> + =A0 =A0 =A0 struct child *blanket, *next;
>
> It is not immediately obvious why 'const' was dropped.
>

It's a left-over hunk from a previous version. Thanks for pointing it out!

>> @@ -671,18 +658,26 @@ static void check_dead_children(void)
>> =A0 =A0 =A0 =A0int status;
>> =A0 =A0 =A0 =A0pid_t pid;
>>
>> - =A0 =A0 =A0 while ((pid =3D waitpid(-1,&status, WNOHANG))> =A00) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *dead =3D "";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_child(pid);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!WIFEXITED(status) || (WEXITSTATUS(sta=
tus)> =A00))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dead =3D " (with error)";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 loginfo("[%"PRIuMAX"] Disconnected%s", (ui=
ntmax_t)pid,
>> dead);
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 struct child **cradle, *blanket;
>> + =A0 =A0 =A0 for (cradle =3D&firstborn; (blanket =3D *cradle);)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pid =3D waitpid(blanket->cld.pid,&sta=
tus, WNOHANG))>
>> =A01) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *dead =3D "";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dead =3D "=
 (with error)";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 loginfo("[%"PRIuMAX"] Disc=
onnected%s",
>> (uintmax_t)pid, dead);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* remove the child */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cradle =3D blanket->next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 live_children--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(blanket);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cradle =3D&blanket->next;
>> =A0}
>>
>> +char **cld_argv;
>> =A0static void handle(int incoming, struct sockaddr *addr, int addrlen)
>> =A0{
>
> Should 'cld_argv' be declared static?
>

Yes it should, thanks!
