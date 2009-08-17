From: skillzero@gmail.com
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 02:41:57 -0700
Message-ID: <2729632a0908170241m415867e6t4286f8bfb6116c26@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
	 <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
	 <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
	 <alpine.DEB.1.00.0908171113420.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 11:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcyj8-0001eJ-N8
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 11:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbZHQJl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 05:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbZHQJl4
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 05:41:56 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:8239 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZHQJl4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 05:41:56 -0400
Received: by qw-out-2122.google.com with SMTP id 8so951390qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2qP1cn/Hj+/hGcVprBFHLByo0gNvyDbV2qEs9cxsy/8=;
        b=sZ/J5u2knv5BGOSZDoD7Nlp2bTp6K6qkzzBro8nmN34s4d2dCLMTxEGRrJLVul6NUW
         ljRZsSnE8PUvwgu/8EKgI7xlve+ARPf0DD0vEtQFgQ+LVcHRv8aT1MoDoakqzd5zi3zj
         zpZnNxRJ1bnnML1f51axCy999zshJvWjmzexs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qGX8LsLWT7jM0BUChCtlligbRbqK5s9g1yPlRFJrYr3gqO4t+i2u8J2Vf6RSEmYKF7
         sPCdVIAz0p9hG2n6o3WmOaHtszr2hpUuMcA7EEQBGzwEdo4IKl+eN7VTQ960v3OUGBV0
         BYhsb+onz6zpYfOFisu4M8lp6M07vr90k4Q9Q=
Received: by 10.224.50.137 with SMTP id z9mr4063233qaf.83.1250502117293; Mon, 
	17 Aug 2009 02:41:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171113420.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126149>

On Mon, Aug 17, 2009 at 2:15 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, skillzero@gmail.com wrote:
>
>> On Mon, Aug 17, 2009 at 1:17 AM, Nguyen Thai Ngoc Duy<pclouds@gmail.=
com> wrote:
>> > On Mon, Aug 17, 2009 at 1:09 PM, <skillzero@gmail.com> wrote:
>> >> 1. Have people decided whether it should be on by default if you =
have
>> >> =C2=A0 =C2=A0a .git/info/sparse file? I'd definitely like it to b=
e on by
>> >> =C2=A0 =C2=A0default. =C2=A0When I first tried it, I didn't reali=
ze I had to use
>> >> =C2=A0 =C2=A0--sparse to git checkout to get it to use the sparse=
 rules. The
>> >> =C2=A0 =C2=A0same goes for a merge I did that happened to have a =
file in the
>> >> =C2=A0 =C2=A0excluded area (it included it because I didn't use -=
-sparse to git
>> >> =C2=A0 =C2=A0merge).
>> >
>> > I tend to make it enabled by default too. I have made it stricter =
to
>> > trigger reading sparse in unpack_trees() -- only do it when
>> > unpack_opts.update is TRUE. This should make it safer to be enable=
d by
>> > default.
>>
>> Other than it being new and not-widely-tested code, is there any
>> additional risk to having it enabled by default if there are no spar=
se
>> patterns defined?
>
> I think that in and of itself is reason enough to turn off the featur=
e
> when .git/info/sparse is not present.
>
> It also may have a runtime cost, dunno.

I was thinking that it would effectively do this:

Try to read .git/info/sparse
if valid patterns read
=C2=A0 =C2=A0Sparse is enabled
else (e.g. file missing or nothing but empty lines/comments)
=C2=A0 =C2=A0Sparse is disabled

I wouldn't think there would be any additional cost or risk (other
than the extra code to read the .git/info/sparse file) because the
result is the same as if sparse had been disabled by being defaulted
to off since even in the default off case, it's still a runtime check.

I would think --sparse would really only be useful as a way to negate
--no-sparse (i.e. act as if .git/info/sparse didn't exist
temporarily).
