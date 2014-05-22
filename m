From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH v4 3/3] add command performance tracing to
 debug scripted commands
Date: Thu, 22 May 2014 02:40:48 +0200
Message-ID: <537D4790.6030106@gmail.com>
References: <537BA806.50600@gmail.com> <537BA8DC.9070104@gmail.com> <20140521165508.GC2040@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBD4P6WNQKGQEOCU34BY@googlegroups.com Thu May 22 02:40:50 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBD4P6WNQKGQEOCU34BY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBD4P6WNQKGQEOCU34BY@googlegroups.com>)
	id 1WnH3w-0001Ss-OL
	for gcvm-msysgit@m.gmane.org; Thu, 22 May 2014 02:40:48 +0200
Received: by mail-we0-f186.google.com with SMTP id u57sf272287wes.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 May 2014 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=1ZpjVgXYRnN4WfzXEYskN7aCT4kp6A8KbeMdnrV6Ifo=;
        b=wSCBjMPaeknUXT6obpDjITyRESVH8AZquFZvyummuTqnHv+R5BXI1Z50qeRjzyR0iM
         7x66bTh7mE0XP1ogdmZq0iX/4XORlJiE6nrfl/akNZPC6aEJ50a8EXBxsnClsC7vnWex
         FgUdu3nOjkSASoggK1ogOkiejrVGTNkm4c+B7Exi5n4MAGyulpooYbcXRkXjYJsooZY5
         e61vphXX/rKIWx9B4E581yA9vyDDr3r3LCpowsgtSxeu3RYB1tn6UgKfzB61bFRiA7IZ
         UlUhPrFTZYuWJ1A2rQhpBdPlZi5m0mbgAsXdPiiS0aUTvVASB92/QpPLp526UJ/J9PZ7
         kMHw==
X-Received: by 10.152.43.227 with SMTP id z3mr84963lal.3.1400719248444;
        Wed, 21 May 2014 17:40:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.66 with SMTP id r2ls191496lag.29.gmail; Wed, 21 May
 2014 17:40:47 -0700 (PDT)
X-Received: by 10.152.22.38 with SMTP id a6mr1827laf.6.1400719247127;
        Wed, 21 May 2014 17:40:47 -0700 (PDT)
Received: from mail-ee0-x22b.google.com (mail-ee0-x22b.google.com [2a00:1450:4013:c00::22b])
        by gmr-mx.google.com with ESMTPS id r49si2436274eep.0.2014.05.21.17.40.47
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 17:40:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22b as permitted sender) client-ip=2a00:1450:4013:c00::22b;
Received: by mail-ee0-f43.google.com with SMTP id d17so2062433eek.2
        for <msysgit@googlegroups.com>; Wed, 21 May 2014 17:40:47 -0700 (PDT)
X-Received: by 10.14.194.133 with SMTP id m5mr8467824een.38.1400719247032;
        Wed, 21 May 2014 17:40:47 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id t4sm15650797eeb.29.2014.05.21.17.40.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 May 2014 17:40:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140521165508.GC2040@sigill.intra.peff.net>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22b
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249866>

Am 21.05.2014 18:55, schrieb Jeff King:
> On Tue, May 20, 2014 at 09:11:24PM +0200, Karsten Blees wrote:
>=20
>> Add performance tracing to identify which git commands are called and ho=
w
>> long they execute. This is particularly useful to debug performance issu=
es
>> of scripted commands.
>>
>> Usage example: > GIT_TRACE_PERFORMANCE=3D~/git-trace.log git stash list
>>
>> Creates a log file like this:
>> performance: at trace.c:319, time: 0.000303280 s: git command: 'git' 're=
v-parse' '--git-dir'
>> performance: at trace.c:319, time: 0.000334409 s: git command: 'git' 're=
v-parse' '--is-inside-work-tree'
>> performance: at trace.c:319, time: 0.000215243 s: git command: 'git' 're=
v-parse' '--show-toplevel'
>> performance: at trace.c:319, time: 0.000410639 s: git command: 'git' 'co=
nfig' '--get-colorbool' 'color.interactive'
>> performance: at trace.c:319, time: 0.000394077 s: git command: 'git' 'co=
nfig' '--get-color' 'color.interactive.help' 'red bold'
>> performance: at trace.c:319, time: 0.000280701 s: git command: 'git' 'co=
nfig' '--get-color' '' 'reset'
>> performance: at trace.c:319, time: 0.000908185 s: git command: 'git' 're=
v-parse' '--verify' 'refs/stash'
>> performance: at trace.c:319, time: 0.028827774 s: git command: 'git' 'st=
ash' 'list'
>=20
> Neat. I actually wanted something like this just yesterday. It looks
> like you are mainly tracing the execution of programs. Would it make
> sense to just tie this to regular trace_* calls, and if
> GIT_TRACE_PERFORMANCE is set, add a timestamp to each line?
>=20
> Then we would not need to add separate trace_command_performance calls,
> and other parts of the code that are already instrumented with GIT_TRACE
> would get the feature for free.
>=20
> -Peff
>=20

IMO printing timestamps in all trace output would be a useful feature on it=
s own, but its not what I'm trying to achieve here. Timestamps only give yo=
u a broad overview of when things started, not how long they took. And calc=
ulating the durations from timestamps in the log output is tedious work, es=
p. if multiple processes and threads are involved (would need pid and threa=
d-id as well).

The first patch helps calculating durations (without having to mess with st=
ruct timespec/timeval), and the second helps logging the results. Its basic=
ally a utility for manual profiling. Printing total command execution time =
(this patch) is just one possible use case.

E.g. if I'm interested in a particular code section, I throw in 2 lines of =
code (before and after the code section). This gives very accurate results,=
 without significantly affecting overall performance. I can then push the c=
hanges to my Linux/Windows box and get comparable results there. No need to=
 disable optimization. No worries that the profiling tool isn't available o=
n the other platform. No analyzing megabytes of mostly irrelevant profiling=
 data.

Does that make sense?

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
