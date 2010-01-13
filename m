From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 17:03:45 -0500
Message-ID: <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com>
References: <20100113135753.GA7095@Knoppix> <20100113144745.GA7246@Knoppix> 
	<20100113161711.GB17687@inner.home.ulmdo.de> <20100113173610.GA7609@Knoppix> 
	<20100113183520.GA23674@inner.home.ulmdo.de> <20100113191802.GA8110@Knoppix> 
	<32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com> 
	<20100113200629.GA8383@Knoppix> <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com> 
	<20100113210414.GA8535@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 23:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVBK3-0005EL-85
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 23:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab0AMWEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 17:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756535Ab0AMWEH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 17:04:07 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:59827 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab0AMWEG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 17:04:06 -0500
Received: by iwn35 with SMTP id 35so16749385iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tDyl1Ud5QYu8g9AcBJL81NRptYi6oFlFbKtHXZUxlR0=;
        b=ZN2+JAO+9mKI7FMs7O2OZX5RPVPFhg2FJV10G06ITxWI6WcEZrXAHwVmetgBvSS2Oz
         Xux/4t5j0rd3M7+JQUCNCCIKbqpcRqHMMO7IdCiQ03sYdGCd42mmQZO78o4/MmnNcxhM
         yb0mj/FjjAabd91TmqVcXp9RhnTNbdpNgs16w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Tx2n8bwwkjg8WIT5GIHbsVYGmO4ycKFTguPm2neq7T70gXJjkrQIZxH2Yuv/paHNvB
         HxxApAaElU161GszhOZVn7S0ygExb+hy0ua3KSG+cs1Zlup9V1SgcrewN3d5aNeoqfMb
         EGnOQ7UcQslkXrxpLh7/mahuY7TtfXtdq8jJA=
Received: by 10.231.9.33 with SMTP id j33mr324623ibj.37.1263420245124; Wed, 13 
	Jan 2010 14:04:05 -0800 (PST)
In-Reply-To: <20100113210414.GA8535@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136888>

On Wed, Jan 13, 2010 at 4:04 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Wed, Jan 13, 2010 at 03:13:40PM -0500, Avery Pennarun wrote:
>> On Wed, Jan 13, 2010 at 3:06 PM, Ilari Liusvaara
>> > As said, I got fed up with failure modes of SSH.
>>
>> I think this is the answer that needs clarification. =A0What failure
>> modes are these? =A0ssh doesn't seem to fail for me. =A0And github.c=
om
>> seems to be working rather well with a huge number of users and ssh
>> authentication.
>
> Those failure modes tend to be show up at setup phase. But when they
> show up, at worst I have seen ones that took hours to debug because
> of multitude of possible causes and no good information on what's
> wrong.
>
> And don't get me started about multi-key setups.
>
> SSH uses fixed sets of keys, which has inherent failure modes. And ss=
h
> server tends to be worse than the client (Github can avoid the server
> failure modes since they control the SSH server).
>
> But not even github can avoid all the failure modes.
>
>> If you're upset at the failure modes of ssh, is it possible to fix s=
sh
>> instead of introducing Yet Another Tunneling Protocol?
>
> No, those failure modes can't be solved in SSH.

This is still not very illuminating.  How do you know your replacement
will not have these same failure modes?  If you solve your main
annoyances with ssh, how do you know you won't introduce any new
annoying failure modes?  *Why* can't ssh be fixed to solve the
problem?  Will I have to generate and manage yet another new set of
keys to use the new system?

You seem to be positioning your implementation as a competitor to
*all* of ssh, https, and straight TLS (including stunnel), and
moreover, presenting it as superior to all three.  This is surely
possible (they all suck differently), but it's going to be hard to
convince people.  And if your new security protocol *only* works with
git, it loses points automatically against other solutions.  (Even if
ssh is hard to set up, I've *already set it up*, so any new
alternative starts with an immediate negative score.)

Have fun,

Avery
