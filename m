From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Re: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Mon, 1 Feb 2010 21:20:27 +0530
Message-ID: <6f8b45101002010750t5541faefv5b4640dfb9949306@mail.gmail.com>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com> 
	<1265013127-12589-1-git-send-email-ford_prefect@gentoo.org> 
	<20100201152010.GC8916@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 16:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbyY9-0006Pe-Pm
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 16:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab0BAPus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 10:50:48 -0500
Received: from mail-qy0-f198.google.com ([209.85.221.198]:43332 "EHLO
	mail-qy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab0BAPur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2010 10:50:47 -0500
X-Greylist: delayed 17482 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2010 10:50:47 EST
Received: by qyk36 with SMTP id 36so2070366qyk.15
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=etKUaFTXhWAzDN1dNssD/XrwlPL7OvGDegCmbxXZB0M=;
        b=R1cMrrIka1J7dx5WHOJUpePSexqaU3dhRVUS/XI7rvfRTnIk4hrmbNkMsdF5GesfjL
         +XmUaLL1ybYbztOYA6MtUYUPSj7uKg07bEyE+Xkzkfv/uuejmZzY7fkRf1vNNWxPUB0C
         HS4Wk9+BrlyGflMsnwyv4uNZEuUm2ivejRVu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=GPg6J1chSOIrPaS8t+31UisY64jeyW0ISO1Kmc8apnRdlAMkf4ZESasJbS/Gx4O6ps
         zF/x9tV3NvJAyfIpFW+L+fEXafTBmVzfylaa3uitPuqehV/lErUVgO7EYpjWw9HHDbWt
         HpGFAAFeVauojK9tJHuCy00KaDZrlcJPAW8t0=
Received: by 10.229.100.226 with SMTP id z34mr1791578qcn.7.1265039447074; Mon, 
	01 Feb 2010 07:50:47 -0800 (PST)
In-Reply-To: <20100201152010.GC8916@spearce.org>
X-Google-Sender-Auth: a6208d410d749ac0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138617>

On 1 February 2010 20:50, Shawn O. Pearce <spearce@spearce.org> wrote:
> Arun Raghavan <ford_prefect@gentoo.org> wrote:
>> This patch set reintroduces the post-upload-pack hook and adds a
>> pre-upload-pack hook. These are now only built if 'ALLOW_INSECURE_HO=
OKS' is set
>> at build time. The idea is that only system administrators who need =
this
>> functionality and are sure the potential insecurity is not relevant =
to their
>> system will enable it.
>
> *sigh*
>
> I guess this is better, having it off by default, but allowing an
> administrator who needs this feature to build a custom package.
>
> Unfortunately... I'm sure some distro out there is going to think
> they know how to compile Git better than we do, and enable this by
> default, exposing their users to a security hole. =A0Ask the OpenSSL
> project about how well distros package code... =A0:-\
>
> I'd like a bit more than just a compile time flag.

I was hoping the all-caps INSECURE in the name would give distributors =
pause. :)

Suggestions on what else might work?

>> At some point if the future, if needed, this could also be made a pa=
rt of the
>> negotiation between the client and server.
>
> I'm not sure I follow.
>
> Are you proposing the server advertises that it wants to run hooks,
> and lets the client decide whether or not they should be executed?

Something like that. I was thinking the client could always advertise
whether the it wants to allow the hooks to be executed or not (which
would override the default value of the global variable I introduced).
Either approach would work, though the second is simpler but also
dumber.

Again, this might be over-complicating things, which is why I did not
implement it. I just wanted to make a note of the fact that this could
be done if the need is felt.

Cheers,
--=20
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
