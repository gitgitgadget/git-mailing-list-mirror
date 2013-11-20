From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Wed, 20 Nov 2013 14:03:20 +0100
Message-ID: <528CB318.1070201@web.de>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com> <7v4nffpbct.fsf@alter.siamese.dyndns.org> <CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com> <7vbo8j600q.fsf@alter.siamese.dyndns.org> <CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com> <7va9o2zba9.fsf@alter.siamese.dyndns.org> <CABPQNSaWTMCeCCnxkRV-Cri7-iQrRknHfJvvN_2Rs9V51OS81w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Filipe Cabecinhas <filcab@gmail.com>, 
 GIT Mailing-list <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com, Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCUZ3EUT2ADRBHXGWKKAKGQEG4APBOI@googlegroups.com Wed Nov 20 14:03:27 2013
Return-path: <msysgit+bncBCUZ3EUT2ADRBHXGWKKAKGQEG4APBOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f56.google.com ([74.125.83.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBHXGWKKAKGQEG4APBOI@googlegroups.com>)
	id 1Vj7RH-00082o-Lb
	for gcvm-msysgit@m.gmane.org; Wed, 20 Nov 2013 14:03:27 +0100
Received: by mail-ee0-f56.google.com with SMTP id e52sf944097eek.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 20 Nov 2013 05:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=5X+wJ9IyOO2/i76ITQ3uR2CdEftragbcjWJ8YcY3PeY=;
        b=NaCcnBEsNQw32IVG5kEuVgFGVwcfFYAxnkXy7FhXze7+oVgzBlKK6vcAz0BoT8JzHu
         ZFpw3/hOfCsLydtMWcI0Mz8tG2hkO0Ifacwyhvurfxnbugonx7ZU1J5DtjIxLY32HW8h
         W/NUpf0RPxIbO/Sd+6XKr9I6Je2LmO/cfzTKo0MfZbprE99ozxr3/VKd5LtV+hckzmp0
         bQrO+tgiW9xLXN1Cfi1dIxPc0YJQ8eV/AIHgoHk5WvidqmFrA5MEzoPS71o88yAfpyLD
         SveF31IiMYZrS3qmlM6wuRMjbpmQNh0Ty/FRpXR5xn6N5CxlhUdvtk5wKFRL7X1zHxGQ
         iW3A==
X-Received: by 10.180.12.70 with SMTP id w6mr12779wib.7.1384952607375;
        Wed, 20 Nov 2013 05:03:27 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.87.229 with SMTP id bb5ls52868wib.15.gmail; Wed, 20 Nov
 2013 05:03:26 -0800 (PST)
X-Received: by 10.180.211.114 with SMTP id nb18mr622178wic.3.1384952606327;
        Wed, 20 Nov 2013 05:03:26 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.15.14])
        by gmr-mx.google.com with ESMTPS id s47si3554616eew.1.2013.11.20.05.03.26
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2013 05:03:26 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of tboegi@web.de designates 212.227.15.14 as permitted sender) client-ip=212.227.15.14;
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Ma2Pz-1VyK0I399L-00LpRj for
 <msysgit@googlegroups.com>; Wed, 20 Nov 2013 14:03:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CABPQNSaWTMCeCCnxkRV-Cri7-iQrRknHfJvvN_2Rs9V51OS81w@mail.gmail.com>
X-Provags-ID: V03:K0:NqPXKovH+r7Kce66ZNVby6NPnTIzRI9w9xr8sIq7lhLhWXGhJcZ
 4yaYJI5tbWepDXb/s97blm1TXo9XOngUviueszCc7dlrbV0QTk97y74SlwngP7KAo5Mopto
 DgEtELFTLnRBLOQ1ykgdH5NLeSFULHB0BBrYs8+h8vb/Ialig8zgl2K/8mkGY7tsY0NlKWH
 0NRyUqys0+Rpe5XEWRG/A==
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of tboegi@web.de designates
 212.227.15.14 as permitted sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238079>

Hej,
I think the patch went in and out in git.git, please see below.

(I coudn't the following  in msysgit,
 but if it was there, the clipped_write() for Windows could go away.

/Torsten



commit 0b6806b9e45c659d25b87fb5713c920a3081eac8
Author: Steffen Prohaska <prohaska@zib.de>
Date:   Tue Aug 20 08:43:54 2013 +0200

    xread, xwrite: limit size of IO to 8MB
    
    Checking out 2GB or more through an external filter (see test) fails
    on Mac OS X 10.8.4 (12E55) for a 64-bit executable with:
    
        error: read from external filter cat failed
        error: cannot feed the input to external filter cat
        error: cat died of signal 13
        error: external filter cat failed 141
        error: external filter cat failed
    
    The reason is that read() immediately returns with EINVAL when asked
    to read more than 2GB.  According to POSIX [1], if the value of
    nbyte passed to read() is greater than SSIZE_MAX, the result is
    implementation-defined.  The write function has the same restriction
    [2].  Since OS X still supports running 32-bit executables, the
    32-bit limit (SSIZE_MAX = INT_MAX = 2GB - 1) seems to be also
    imposed on 64-bit executables under certain conditions.  For write,
    the problem has been addressed earlier [6c642a].
    
    Address the problem for read() and write() differently, by limiting
    size of IO chunks unconditionally on all platforms in xread() and
    xwrite().  Large chunks only cause problems, like causing latencies
    when killing the process, even if OS X was not buggy.  Doing IO in
    reasonably sized smaller chunks should have no negative impact on
    performance.
    
    The compat wrapper clipped_write() introduced earlier [6c642a] is
    not needed anymore.  It will be reverted in a separate commit.  The
    new test catches read and write problems.
    
    Note that 'git add' exits with 0 even if it prints filtering errors
    to stderr.  The test, therefore, checks stderr.  'git add' should
    probably be changed (sometime in another commit) to exit with
    nonzero if filtering fails.  The test could then be changed to use
    test_must_fail.


On 2013-11-20 11.15, Erik Faye-Lund wrote:
> I know I'm extremely late to the party, and this patch has already
> landed, but...
> 
> On Sat, May 11, 2013 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Filipe Cabecinhas <filcab@gmail.com> writes:
>>
>>> Due to a bug in the Darwin kernel, write() calls have a maximum size of
>>> INT_MAX bytes.
>>>
>>> This patch introduces a new compat function: clipped_write
>>> This function behaves the same as write() but will write, at most, INT_MAX
>>> characters.
>>> It may be necessary to include this function on Windows, too.
> 
> We are already doing something similar for Windows in mingw_write (see
> compat/mingw.c), but with a much smaller size.
> 
> It feels a bit pointless to duplicate this logic.
> 
>> diff --git a/compat/clipped-write.c b/compat/clipped-write.c
>> new file mode 100644
>> index 0000000..9183698
>> --- /dev/null
>> +++ b/compat/clipped-write.c
>> @@ -0,0 +1,13 @@
>> +#include <limits.h>
>> +#include <unistd.h>
>> +
>> +/*
>> + * Version of write that will write at most INT_MAX bytes.
>> + * Workaround a xnu bug on Mac OS X
>> + */
>> +ssize_t clipped_write(int fildes, const void *buf, size_t nbyte)
>> +{
>> +       if (nbyte > INT_MAX)
>> +               nbyte = INT_MAX;
>> +       return write(fildes, buf, nbyte);
>> +}
> 
> If we were to reuse this logic with Windows, we'd need to have some
> way of overriding the max-size of the write.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
