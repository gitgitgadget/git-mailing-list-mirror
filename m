From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 18:16:03 -0400
Message-ID: <32541b131003271516l3a41ad6dnb75eacb0ad7a8850@mail.gmail.com>
References: <20100326230537.GC10910@spearce.org> <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> 
	<4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> 
	<alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> 
	<alpine.LFD.2.00.1003262142121.694@xanadu.home> <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com> 
	<alpine.LFD.2.00.1003270959110.694@xanadu.home> <20100327191405.GF10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 23:16:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NveIv-0007AI-Sp
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 23:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0C0WQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 18:16:24 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:64491 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0C0WQY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 18:16:24 -0400
Received: by yxe37 with SMTP id 37so3992460yxe.21
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9x6ocvm9nKeC9swKW6j+ziVLOtSio5Ay+XrEAiboTmk=;
        b=jPwiaWxYv/P5+Mp5lLP5j6unzhwKySfuEy90J1nazx0soX4ZvARZQrjEQWP2mkjuB9
         vzfXdxumZEy/kDbB5UhzlqGyBYshtZcaXdIX74Z3WD/cTRCe+oitK9vPEL+2uGWfryBS
         dIUZXUfdB43iFcd5+Ce4yT6LJ/FrpRSJ6VovA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rx7U1/MSd6dChYFRG0IxuA+r/RVnhfHyf9SR69i3T9CF754La3non6e7IOEZ05J4FW
         HgqBReEh0Hh+LW6dfgYsY7k/ycOK47jRS6PhgnxlAe8Trc7RVZJt8cSa4sf9EsuaIWIl
         H3mepe5QXfAK4d3R2cEN9bdxlhhoafAW47qM8=
Received: by 10.151.51.17 with HTTP; Sat, 27 Mar 2010 15:16:03 -0700 (PDT)
In-Reply-To: <20100327191405.GF10910@spearce.org>
Received: by 10.150.120.15 with SMTP id s15mr3016310ybc.143.1269728183172; 
	Sat, 27 Mar 2010 15:16:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143360>

On Sat, Mar 27, 2010 at 3:14 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Sat, 27 Mar 2010, Scott Chacon wrote:
>> > , and the only reason it's an
>> > issue at all is that JGit is not following the authoritative CGit
>> > implementation of basically ignoring it.
>>
>> But again CGit's fsck is not ignoring this discrepancy. =A0And if th=
e CGit
>> core is otherwise silently accepting it then it is a mistake.
>
> Right. =A0I tend to agree. =A0CGit was too lax here, fsck shouldn't
> be issuing a warning, it should be a fatal error. =A0Both CGit and
> JGit are too lax by not failing when reading that tree during
> normal processing.

Gah, no!  Why would you want to make CGit work *less*?  Print a
warning, sure, but since the tree is perfectly readable, there's no
reason to refuse to read it.  That's just rude.

Similarly, there should be no reason for fsck to treat *any*
recoverable error as fatal.  If it drops dead, it then misses the
chance to diagnose later problems.  When I run fsck, I want to see all
the problems, not just the first one, especially if the first one can
be fixed by filter-branch.  Bonus points if (like e2fsck) it offers to
fix it for me, though that's probably not worth implementing here.

CGit works fine already.  The only problem it has is that it works so
well that Scott didn't notice his bug.  This can be fixed by adding a
simple warning.

Have fun,

Avery
