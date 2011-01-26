From: Simeon Maxein <smaxein@googlemail.com>
Subject: Re: git filter-branch can "forget" directories on case insensitive
 filesystems
Date: Wed, 26 Jan 2011 01:24:50 +0100
Message-ID: <4D3F69D2.800@googlemail.com>
References: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com> <4D3F38E9.9060902@googlemail.com> <201101252256.03644.j6t@kdbg.org> <4D3F5C42.4040300@googlemail.com> <AANLkTimvwNs9EkV1GweT7VCdzvcz5J5_0pCUA44urQYH@mail.gmail.com>
Reply-To: smaxein@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 26 01:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhtC3-00068H-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 01:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab1AZAY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 19:24:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44951 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1AZAY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 19:24:57 -0500
Received: by fxm20 with SMTP id 20so425056fxm.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 16:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qgXihmb6pzw4QfZteUBzvAeaR9LnbSWCT1dfdkqSp1c=;
        b=p8Cv7F8tK+XHs8+ecPLL0f7IBQG+C3Y1gt9axcZMa9Dq1rmxJG+JMC70tDEV+MWH3c
         mQAWsr/34VQW5cydDfO5JegxWskYoiTkyiyuCs9EgZNSS401UMdyIPCezjAG27VvbMkN
         hYQwj7sToUWKQoy6kj8QcJG0OPn2Uu8XnfZjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=TT4nPteBLy7Rh00+Fu9pRnqnqKTGLnOkX4U/+dYe6klYxm5qt083AS8KM8diDFjbJw
         sRRyPMBO/COQXGSQk0huJgZ/fLc8a3vmztbvg0A706r4/ZkmFIUVTcGDTJ4kT/cXWzw1
         mQ+DcZfJNrZHzWhw41uRTi/MKbGVAJLkLu6fU=
Received: by 10.223.81.76 with SMTP id w12mr6507990fak.26.1296001496177;
        Tue, 25 Jan 2011 16:24:56 -0800 (PST)
Received: from [192.168.178.27] (kobz-590d7e94.pool.mediaWays.net [89.13.126.148])
        by mx.google.com with ESMTPS id e6sm5306479fav.8.2011.01.25.16.24.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 16:24:55 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTimvwNs9EkV1GweT7VCdzvcz5J5_0pCUA44urQYH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165489>

Am 26.01.2011 00:31, schrieb Erik Faye-Lund:
> On Wed, Jan 26, 2011 at 12:26 AM, Simeon Maxein <smaxein@googlemail.com> wrote:
>> Am 25.01.2011 22:56, schrieb Johannes Sixt:
>>> On Dienstag, 25. Januar 2011, Simeon Maxein wrote:
>>>> In my opinion this is a quite serious issue, because files are lost
>>>> without any indication to the user. As of git 1.7.3.1 (tested on
>>>> Windows/NTFS with msysGit this time), the problem still exists. Please
>>>> give it a look. Fullquote of the problem description / steps to
>>>> reproduce follows.
>>>>> mkdir testdir
>>>>> echo 'abc' >testdir/testfile
>>>>> git add testdir
>>>>> git commit -m foo
>>>>> git rm -r testdir
>>>>> mkdir testDir
>>>>> echo 'abc' >testDir/testfile
>>>>> git add testDir
>>>>> git commit -m bar
>>> Please retry with current release condidate of 1.7.4; it has some
>>> core.ignorecase improvements w.r.t. directories. It could well be that your
>>> problem is fixed.
>>>
>>> -- Hannes
>> Thanks for the suggestion. The directory doesn't vanish anymore with
>> 1.7.4, so a big Thank You to the developers for improving this. When
>> rewriting the second commit ls still prints testdir as lowercase though.
>> More of a nitpick, but it would still be neat to have it right.
>>
> This part is correct behavior  - git's internal representation is case
> sensitive. So git's record of the file is still 'testdir', even i
> you've deleted it and created a new called 'testDir'.
A normal checkout for those commits results in "testdir" for the first
one and "testDir" for the second one, so git does store the name
difference. I would intuitively expect the trees prepared during
filter-branch to be consistent with the result of a checkout.

Simeon
