From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 12 Apr 2016 16:40:30 +0700
Message-ID: <CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
 <1460153784.5540.19.camel@twopensource.com> <1460417232.5540.53.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, aevarb@gmail.com,
	jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:41:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apuop-0005Hj-BG
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 11:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbcDLJlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 05:41:05 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35185 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbcDLJlC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 05:41:02 -0400
Received: by mail-lf0-f41.google.com with SMTP id c126so17116738lfb.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=roTJFRDZLajbbkkJNQaOmzXAkOc97z5FqaDOuHmfClI=;
        b=wG68zey7VOjgvThoCuDQ7K40JZdhixL3ylFB6pU9e7mIkuxq1hXNJwgNyy8sBXRUYN
         cz88bQY1gO1bDwzR/5diHYUgXrg/eM53JdJeK1dRjG8xvCl4Nj/uRSKEQcS9Wha6nywW
         EtPSeWQUfxxAr7P2vdBx8RA73YptsAJ3nFnK+HJpafZjR+eJ/Y6Mv3PHqXGXJA082crp
         cxrrc2Y9z6mdpPA3am1xZJ0cJnNEnPIRtksmWTsNCajlGv4XWoGUoHm1Kn+/H8yjGIQb
         qCzE3kSZAR1S0jurClzjVU+ilYBLdqJZE7Y6VM2IttvafQfNCIOIOx17BxWVp4iYzTj7
         7+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=roTJFRDZLajbbkkJNQaOmzXAkOc97z5FqaDOuHmfClI=;
        b=MYsdfSIXTQlt89k1n1OmbWR8b94x/gEtJxTXevz6cB5EGkymFma+KmXfUXOJFgoHDq
         9pDYo6xslmTczEyq9u7ZqRt0p+xcf0r2PEGF4sipbpid39tcnrhNEMJJTDxBo/23di/R
         FbZ0fegFHFoWhu+ZaGhuZ4X5MGm7TbyvGQn58eh0BtO0e52JtHe95ItHpbwoFf3RBgkl
         yze1rlRCt6k4VT3TM7ZiFXxdJZ7hzM9EhAYpzEfglFSKrM5fb81f0ot1i3KcKbIDSsHA
         eNaCsOoa5z6aE7kLpRsCiX4mxBSMHv5XkesBxJQjhgnxwdobtZ8F6s7CwuS1SKDqTt79
         Kn4g==
X-Gm-Message-State: AOPr4FVvFjWBKggScMlWK2nIVfK6baiN1ZWKqysx0b8E+Hthq0tYY+rS8lOX6RFuigVj9bR5+YHitPeGdVvr6g==
X-Received: by 10.25.212.213 with SMTP id l204mr977862lfg.118.1460454060441;
 Tue, 12 Apr 2016 02:41:00 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 12 Apr 2016 02:40:30 -0700 (PDT)
In-Reply-To: <1460417232.5540.53.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291251>

On Tue, Apr 12, 2016 at 6:27 AM, David Turner <dturner@twopensource.com> wrote:
> On Fri, 2016-04-08 at 18:16 -0400, David Turner wrote:
>> And SHM on Macs works a bit differently than on Linux in at least two
>> irritating ways.
>>
>> So, uh, new version to come once I actually make it work on Mac.
>> Probably Monday.
>
> I was chatting with a friend about this and he mentioned that SHM does
> not really fit well into the Unix "everything is a file" model.  It
> lives in a separate namespace, and still requires most of the file-like
> operations just with funny names and a separate namespace: shm_open,
> shm_unlink.  This weirdness is something I noticed in my porting work:
> on OS X, a shm name can only be 32 bytes long, requiring weird hacks.
> And on OSX, fstat on a shm fd is rounded up to the page size (!).
>  There may also be other portability issues that I have not yet
> discovered.
>
> Instead, my friend suggests that we should just use files.  For
> instance, we could do $TMPDIR/$index_helper_pid/shm-index.$sha.
>
> (I'm proposing $TMPDIR because it's cleaned up on reboot so we don't
> need any manual intervention or complicated gc schemes)
>
> What do folks think of this?

I avoided actual files for two reasons

 - disk error rate is higher than memory one, and we might need
trailing SHA-1 back
 - access is slow (unless cached, but we can't be sure)

If we can keep index-helper stuff on tmpfs or similar, then it would
address both, but that's even more OS-specific than shm. If we have a
good abstraction layer then people can put stuff on $TMPDIR on Mac,
for example. But then it's not full POSIX file interface anymore...
And you forgot Windows which does not strictly follow UNIX design.
-- 
Duy
