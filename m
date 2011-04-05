From: Alif Wahid <alif.wahid@gmail.com>
Subject: Re: Git exhausts memory.
Date: Tue, 5 Apr 2011 14:35:56 +1000
Message-ID: <BANLkTik6XoWaehp7=5fxwcyhkTHWCO8-Eg@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
	<alpine.LFD.2.00.1104021103130.28032@xanadu.home>
	<BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
	<alpine.LFD.2.00.1104031110150.28032@xanadu.home>
	<BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
	<BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
	<20110405022235.GA4414@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Fries <david@fries.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 06:36:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6y03-0000av-Cy
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 06:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940Ab1DEEf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 00:35:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64852 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1DEEf6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 00:35:58 -0400
Received: by vws1 with SMTP id 1so4670877vws.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5LisE3l4a9B4RM9zC960Bds/HZSyt+rAdwRPyjPkvSM=;
        b=Okaxy8E0LzQFLqjMu0Fb68tcJZFA6060+f+doFYJrTVCeXF2dc9eyXm/lmdPzeneOG
         x5xvvknbDtoEYUlKBFuZ6QEQ0fCUTwl9BTeHe6jgpFzHr1j935HndCQ2xAs4XTqkBB3F
         6cJOX9Dorz/KLgM6gmwG+BfYGFZRv4ocRid0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oGZD7N2d5rS8neO9e/XY6hJTvULRMC/QzTUOzWDdSKBpzsI8MFH0cLbKOzNqBTB7Jv
         cqhkEQGdJZz1Ae0YiUiZ0J7Q3RNB0YIAZAZ/pYnZT5KzJIaFbPzmlHBQPedfjVrbtzGe
         A61xXo+FPl20z/BtY653o05C0+WVbc2ABkr4w=
Received: by 10.52.168.8 with SMTP id zs8mr931605vdb.184.1301978156873; Mon,
 04 Apr 2011 21:35:56 -0700 (PDT)
Received: by 10.52.155.70 with HTTP; Mon, 4 Apr 2011 21:35:56 -0700 (PDT)
In-Reply-To: <20110405022235.GA4414@spacedout.fries.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170865>

Hi everyone,

On 5 April 2011 12:22, David Fries <david@fries.net> wrote:
> On Mon, Apr 04, 2011 at 09:57:01PM +0700, Nguyen Thai Ngoc Duy wrote:
>> On Mon, Apr 4, 2011 at 7:52 PM, Alif Wahid <alif.wahid@gmail.com> wr=
ote:
>> > Hi Nicolas,
>> >
>> > On 4 April 2011 01:18, Nicolas Pitre <nico@fluxnic.net> wrote:
>> >>
>> >> Something you can try is to simply tell Git not to attempt any de=
lta
>> >> compression on those tar files using gitattributes (see the man p=
age of
>> >> the same name).
>>
>> Should we change the default to not delta if a blob exceeds predefin=
ed
>> limit (say 128M)? People who deliberately wants to delta them can
>> still set delta attr. 1.8.0 material maybe?
>
> I think it would be better to define it in terms of available memory.
> Something like the minimum of system memory or address space, and
> delta up to X amount of that (it might be good to leave off swap to
> reduce trashing). =C2=A0There has to be a better way than a straight =
128MB
> default.
>
> The number which works on my 8GB desktop is going to kill the compute=
r
> in the trunk of my car with 48MB of ram. =C2=A0I've actually seen a 7=
00 MB
> repository fail with `git-gc --aggressive` on a system with 4GB of ra=
m
> because it ran out of memory, it only worked by leaving off the
> --aggressive option.

It seems to me that if "git init" creates a $GIT_DIR/info/attributes
file by default with a line like "*.gz -delta", then that will disable
the memory intensive deltra compression plumbing for those special
cases where people need to track gzip archives (similarly another line
"*.bz2 -delta" for bzip2 archives and so on). Since these files can't
supposedly be compressed much more, I think Git ought to have a
default heuristic to not attempt any compression on them.

Cheers

Alif
