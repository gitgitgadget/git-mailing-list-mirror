From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] push: Use sideband channel for hook messages
Date: Fri, 5 Feb 2010 17:14:12 +0100
Message-ID: <40aa078e1002050814m1edb90f8lf3d8d138fa65c332@mail.gmail.com>
References: <20100205033748.GA19255@spearce.org>
	 <4B6C07E3.5030705@viscovery.net> <20100205153252.GC19255@spearce.org>
	 <4B6C3E9C.7040009@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:22:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdQwb-00020L-GU
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440Ab0BEQWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 11:22:04 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:43938 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab0BEQWB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 11:22:01 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2010 11:22:00 EST
Received: by fxm3 with SMTP id 3so4178019fxm.39
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 08:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nDhjjDxbFYhnaZ10SZ6GZ6/lnfNt78cdQyXVE0E6fpA=;
        b=xvCNjgAXORSVkh7Kd9kk59khbPUdR/8CBO3/gGlBG+puuZGuEF1q65EQnwcHamd/Gv
         J0jWstwV21QDhCmAW6j2HSgY37VzWoGk+6oNcDGcGhilV+2BnXT916eg7/n0tFuvfpum
         MJvdmZ+iLqqr12jGkA4XY6UbeSx07TXn4sdCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=dvnVEiNR89KJXnsNZOqGJd30zjtp/NVQ0OA2zrcT9qnCQ36QPcgCY853VjbDywRqms
         HGjGGj5+qC4BjeUfjsJGhsqB2IjURH466miqvpwLPjeE6mMfTU7bfDXtMFunGnG6gfUq
         2kSpEBgbKaI9xRUlJUFsLRExvxOwz3YX50+lI=
Received: by 10.216.89.135 with SMTP id c7mr1578717wef.62.1265386452480; Fri, 
	05 Feb 2010 08:14:12 -0800 (PST)
In-Reply-To: <4B6C3E9C.7040009@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139054>

On Fri, Feb 5, 2010 at 4:51 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Shawn O. Pearce schrieb:
>> Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> What would you think about passing both channels to the async callb=
ack,
>>> and the communicating parties must agree on which channel they comm=
unicate
>>> by closing the unused one? It would require slight changes to all c=
urrent
>>> async users, though. (It also requires in the threaded case that we=
 pass
>>> dup()s of the pipe channels.)
>>
>> Yup, I could do that. =A0I feel like it might be over-engineering th=
e
>> solution a bit. =A0But I'll respin the patch by splitting it apart,
>> and doing a bidirectional async here, since you asked nicely.
>
> I do agree about the over-engineering aspect. I mentioned it because =
in
> one patch in the past Erik Faye-Lund also extended the async
> infrastructure for bidirectional communication to use it in git-daemo=
n
> (Windows port).

Just for reference, here's the latest version I wrote of that patch,
in case it's useful to have a peak at or something:

http://repo.or.cz/w/git/kusma.git/commit/682d90a174fc128910c1c8a4f81edb=
3cf9f0d9e2


--=20
Erik "kusma" Faye-Lund
