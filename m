From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Is there a quick way to identify commits that reference missing
 trees or blobs?
Date: Tue, 26 Jul 2011 14:20:00 +1000
Message-ID: <CAH3Anrp-pQg8x-UHKDMb+VXFT_m4LiWX=cezoZWstCoFsiJWMQ@mail.gmail.com>
References: <CAH3AnroyfeGOo_23nHKhLjxEnP_qEMi7as1UjXEFjjuVOckBjw@mail.gmail.com>
	<20110725223449.GA25560@toss.lan>
	<20110725224408.GA26057@toss.lan>
	<CAH3AnrouGUPvnYk_O1W_a5qZCmePC41GgEX_qcS3HLpkEm9pHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jul 26 06:20:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlZ7p-0003x7-3U
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 06:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816Ab1GZEUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 00:20:04 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58658 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1GZEUC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 00:20:02 -0400
Received: by vxh35 with SMTP id 35so58246vxh.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 21:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uQUueLvy29AcZOTRy2mcytZPpv8pIRhA63bnTTnLCd8=;
        b=B2iWzWSECbl2Zo1lfLRH0fGUJt5c2XiALM/JTzrbQ6imlgZN5Oc5Y7q7RYJ33bp5Ci
         CLQk6+lmAmm1DNM1eUI4fBETqkgKtf1FgH9cMhATk3uirG483Py7Kjx+tq6IRPRs8BK1
         q/8Rx4Ftp/xNvf4CRb+n2z1LMaYzSY0eZh9f4=
Received: by 10.52.98.198 with SMTP id ek6mr4769753vdb.240.1311654001746; Mon,
 25 Jul 2011 21:20:01 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Mon, 25 Jul 2011 21:20:00 -0700 (PDT)
In-Reply-To: <CAH3AnrouGUPvnYk_O1W_a5qZCmePC41GgEX_qcS3HLpkEm9pHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177838>

On Tue, Jul 26, 2011 at 11:39 AM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
> On Tue, Jul 26, 2011 at 8:44 AM, Clemens Buchacher <drizzd@aon.at> wr=
ote:
>> On Tue, Jul 26, 2011 at 12:34:50AM +0200, Clemens Buchacher wrote:
>>> On Sun, Jul 24, 2011 at 02:48:20AM +1000, Jon Seymour wrote:
>>> >
>>> > I was wondering if there is a quick way to identify commits that
>>> > reference missing trees or blobs as identified by git fsck?
>>>
>>> The following command has served me well for this purpose. I apply
>>> it to each ref in git-for-each-ref:
>>>
>>> $ git rev-list --objects $ref | git cat-file --batch-check
>>
>> Oh, and here is the output you get for different situations. Exit
>> status is always 0 unfortunately.
>>
>> =C2=A0- missing blob
>>
>> fatal: missing blob object '78981922613b2afb6025042ff6bd878ac1994e85=
'
>> d165426eba5cb4c125bd6e100d1b5de7298eb601 commit 168
>> 848740929e99bda0e1a9783e7daa314c5a9732d5 =C2=A0missing
>>
>> =C2=A0- missing tree
>>
>> error: Could not read 84bf061d017459b4be45a49b8d8dc945e7a7fdf5
>> fatal: bad tree object 84bf061d017459b4be45a49b8d8dc945e7a7fdf5
>> abce3ad54002628ab74d72b7e2baa687abcb77f9 commit 168
>>
>> =C2=A0- missing parent commit
>>
>> error: Could not read 3aa66f30aa9799ac38a53b551ac4faca9cbd400b
>> fatal: Failed to traverse parents of commit 3cfb98a3cbd3f42852e20bd0=
11c7b835b8750df7
>>
>> Clemens
>>
>
> Thanks for that.
>
> Junio, also pointed out in another thread that git rev-list --objects
> is quite useful for this purpose. His variant used git pack-objects
> which apparently does exit with zero status code.

| _non-zero_ !
