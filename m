From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Re: git gc exit with out of memory, malloc failed error
Date: Wed, 14 Sep 2011 19:42:18 -0700
Message-ID: <CAGAhT3ksjRmGVpd2p+q9EjC58xgermTDHsOS64_N_eKDWXyXJQ@mail.gmail.com>
References: <CAGAhT3mbGB-0q3EKh5MrGqB59wUea7NfaaY18DvnL3qimwh9QA@mail.gmail.com>
	<CAFfmPPP58J90758TRB2sAj-Wr5HB=rQtaJipKovsHXyTcswuJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 04:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41uH-0000qz-8y
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab1IOCmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 22:42:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33495 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab1IOCmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 22:42:20 -0400
Received: by wwf22 with SMTP id 22so3038733wwf.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4RMXsjfbEcvxKInKtSFsg2J2+w75V5ibAWHI/u+7HRE=;
        b=wEBwAaPRPVQMox/Xju80OewBDw160P2wyX6QOCTBm7jEHq/OfjOpubCX8/iZJ9c5JJ
         Dk3MT3xYQFHFglsRwox1SAPlcFoeqhctZwd57D1ZqwVpzu/K/y8PpjgwbGTPAxmMglf1
         tyiCLkj7ywp/M1JCZl6OWiYi/ykIx4JXXMEiE=
Received: by 10.216.133.69 with SMTP id p47mr532283wei.53.1316054538949; Wed,
 14 Sep 2011 19:42:18 -0700 (PDT)
Received: by 10.216.159.134 with HTTP; Wed, 14 Sep 2011 19:42:18 -0700 (PDT)
In-Reply-To: <CAFfmPPP58J90758TRB2sAj-Wr5HB=rQtaJipKovsHXyTcswuJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181429>

Thanks!
--window-memory=3D50m worked for my project. 256m was still throwing
error. Probably real memory consumption is close to threads number *
window memory.


On Wed, Sep 14, 2011 at 7:20 PM, David Michael Barr
<davidbarr@google.com> wrote:
> On Thu, Sep 15, 2011 at 11:33 AM, Alexander Kostikov
> <alex.kostikov@gmail.com> wrote:
>> I'm new to git and I'm getting the following out of memory error on =
git gc:
>>
>> $ git gc
>> Counting objects: 80818, done.
>> Delta compression using up to 8 threads.
>> fatal: Out of memory, malloc failed (tried to allocate 24359675 byte=
s)
>> error: failed to run repack
>>
>> The only advice I found in the internet suggested to run repack with
>> --window-memory parameter specified. But this call also fails:
>>
>> $ git repack -adf --window-memory=3D0
>> Counting objects: 80818, done.
>> Delta compression using up to 8 threads.
>> warning: suboptimal pack - out of memory
>> fatal: Out of memory, malloc failed (tried to allocate 24356363 byte=
s)
>>
>> How do I cleanup my repository?
>>
>> $ git version
>> git version 1.7.6.msysgit.0
>>
>> OS: Windows Server 2008 R2 SP1 (x64)
>> Physical memory: 24 GB
>> The commands listed were executed under x64 console process.
>>
>> --
>> Thanks,
>> Alexander Kostikov
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> Hi,
>
> My understanding is that msysgit is a 32-bit build.
> So if your existing pack is ~2GB, repack will fail.
> Also, I think that setting window-memory to 0
> means no limit, which is not what you want.
> One value I have seen suggested is 256m.
> In my experience, peak memory consumption of
> repack is proportional to the value of --window,
> so you might want to try tweaking that.
> There are quite a few config parameters that
> affect the memory consumption of repack.
>
> --
> David Barr
>



--
Your sincerely,
Alexander Kostikov
