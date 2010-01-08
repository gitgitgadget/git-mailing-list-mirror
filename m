From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for 
	subset of Pthreads API
Date: Fri, 8 Jan 2010 11:58:56 +0100
Message-ID: <40aa078e1001080258n67e0711sf4733a99d512bf1@mail.gmail.com>
References: <cover.1262895936.git.j6t@kdbg.org>
	 <44c7183e43089c64fb65bd248f7fa5b9731067ea.1262895936.git.j6t@kdbg.org>
	 <20100108033232.GA28263@dpotapov.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit <msysgit@googlegroups.com>, git@vger.kernel.org, 
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: 38w9HSwkOB5U9JHBz07I35DD5A3Bz7A.1DBBHNH57I5DD5A35GDJEH.1DB@listserv.bounces.google.com Fri Jan 08 11:59:18 2010
Return-path: <38w9HSwkOB5U9JHBz07I35DD5A3Bz7A.1DBBHNH57I5DD5A35GDJEH.1DB@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f143.google.com ([209.85.210.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTCYn-0000VO-4D
	for gcvm-msysgit@m.gmane.org; Fri, 08 Jan 2010 11:59:17 +0100
Received: by yxe7 with SMTP id 7sf51097604yxe.25
        for <gcvm-msysgit@m.gmane.org>; Fri, 08 Jan 2010 02:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=GP2HU/DkpCCZa//rokFI8fQ0dQR271B4uHR8kLiZk7E=;
        b=6BBU89uMMdOrmzr2AjNKwzPIOMTqaQ18XHLnEuUBzMbIeBeny+0zfwrXydcaL3SB/0
         xwfkUTMi6uMt3efBPWhqCPQ6ga2nPl59sNKlpmMFIi4n2R0DF8vkrud5CyBxm365oEti
         bHfgEouJ4F8+Z2kegZo9mMRM0mSx0aY2dOBAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=6+zDJMWIgbmYGrN4wd3M5rkpNu4zD9XhESMLklunq+5sE28DYmz75cK8JDNgGci11B
         EznEF0iJznWfiXFwJf77+5/q7uRKiixifgdvVltIKV1EW+kzv2BiWJnDUAeHmVtoLRtM
         stCoGgeV1vbBt3iURLDqES3iJs+w1Dg/KkZ+A=
Received: by 10.101.6.11 with SMTP id j11mr3397764ani.0.1262948339746;
        Fri, 08 Jan 2010 02:58:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.57.18 with SMTP id a18ls599010ebh.3.p; Fri, 08 Jan 2010 
	02:58:58 -0800 (PST)
Received: by 10.213.100.210 with SMTP id z18mr4106743ebn.3.1262948338116;
        Fri, 08 Jan 2010 02:58:58 -0800 (PST)
Received: by 10.213.100.210 with SMTP id z18mr4106742ebn.3.1262948338094;
        Fri, 08 Jan 2010 02:58:58 -0800 (PST)
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com [209.85.219.221])
        by gmr-mx.google.com with ESMTP id 12si2943495ewy.2.2010.01.08.02.58.57;
        Fri, 08 Jan 2010 02:58:57 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.221 as permitted sender) client-ip=209.85.219.221;
Received: by mail-ew0-f221.google.com with SMTP id 21so11807224ewy.22
        for <msysgit@googlegroups.com>; Fri, 08 Jan 2010 02:58:57 -0800 (PST)
Received: by 10.216.87.83 with SMTP id x61mr3385057wee.7.1262948336884; Fri, 
	08 Jan 2010 02:58:56 -0800 (PST)
In-Reply-To: <20100108033232.GA28263@dpotapov.dyndns.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.221 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/89026b66486ea92e
X-Message-Url: http://groups.google.com/group/msysgit/msg/f669058590122754
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136424>

On Fri, Jan 8, 2010 at 4:32 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Thu, Jan 07, 2010 at 10:54:57PM +0100, Johannes Sixt wrote:
>> +
>> +int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
>> +{
>> + =A0 =A0 /* serialize access to waiters count */
>> + =A0 =A0 EnterCriticalSection(&cond->waiters_lock);
>> + =A0 =A0 ++cond->waiters;
>> + =A0 =A0 LeaveCriticalSection(&cond->waiters_lock);
>
> InterlockedIncrement(&cond->waiters);
>
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Unlock external mutex and wait for signal.
>> + =A0 =A0 =A0* NOTE: we've held mutex locked long enough to increment
>> + =A0 =A0 =A0* waiters count above, so there's no problem with
>> + =A0 =A0 =A0* leaving mutex unlocked before we wait on semaphore.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 LeaveCriticalSection(mutex);
>> +
>> + =A0 =A0 /* let's wait - ignore return value */
>> + =A0 =A0 WaitForSingleObject(cond->sema, INFINITE);
>> +
>> + =A0 =A0 /* we're done waiting, so make sure we decrease waiters count =
*/
>> + =A0 =A0 EnterCriticalSection(&cond->waiters_lock);
>> + =A0 =A0 --cond->waiters;
>> + =A0 =A0 LeaveCriticalSection(&cond->waiters_lock);
>
> InterlockedDecrement(&cond->waiters);

Nice.

>> +
>> + =A0 =A0 /* lock external mutex again */
>> + =A0 =A0 EnterCriticalSection(mutex);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +int pthread_cond_signal(pthread_cond_t *cond)
>> +{
>> + =A0 =A0 int have_waiters;
>> +
>> + =A0 =A0 /* serialize access to waiters count */
>> + =A0 =A0 EnterCriticalSection(&cond->waiters_lock);
>> + =A0 =A0 have_waiters =3D cond->waiters > 0;
>> + =A0 =A0 LeaveCriticalSection(&cond->waiters_lock);
>
> AFAIK, Win32 API assumes that reading LONG is always atomic, so
> the critical section is not really necesary here, but you need
> to declare 'waiters' as 'volatile':

"Simple reads and writes to properly-aligned 32-bit variables are
atomic operations."
http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx

In other words: Yes, you are right.

>> +
>> +int pthread_cond_init(pthread_cond_t *cond, const void *unused)
>> +{
>> + =A0 =A0 cond->waiters =3D 0;
>> +
>> + =A0 =A0 InitializeCriticalSection(&cond->waiters_lock);
>
> Is waiters_lock really necessary?

(Yeah, I moved this one to the end)

No, I think you've proven that it isn't.

--=20
Erik "kusma" Faye-Lund
