From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc warning
Date: Thu, 9 Dec 2010 20:46:02 +0100
Message-ID: <AANLkTi=SzDhoQnLeKUvWe7A6r-7MT-DTLuDGLprqid9X@mail.gmail.com>
References: <4CFA92A2.4030801@ramsay1.demon.co.uk> <20101204205206.GB3170@burratino>
 <4D011D30.4070405@ramsay1.demon.co.uk> <7vmxoeg3wp.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 20:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQmRh-0002n9-GY
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 20:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab0LITqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 14:46:24 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:33978 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab0LITqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 14:46:24 -0500
Received: by fxm18 with SMTP id 18so2840328fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 11:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=A02zivJjtmkK93zHn5k3FVWFXpSDE822MtiNIf4X5oE=;
        b=B4CQzs0+gXug9M98VnUccPpDAb494Iq0pkRVdRweF4arUa2w/rV86DlDoZEmnbni0+
         HhXF8p/c6vY4VW+7/KQ3nZemGMuV2EhNbqueKCNXjw/ca6U47us/q6a8UP2eF8L8Ekyo
         7Hb3hKoZEEZRfycaLXIBBlXTjPhk947CbiDuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=URSLqVhnnjbMSNETMXXViUxXjz+jFz0VrXGpXK5B+b2cBd7zYHmU6FDWK2aTLAHgcm
         YnT+1KLsgTkh49V0ExxMcWF66MH+YIK7AKXIc5IP5Tr4cyJoCFKnO5ivFW2oneUT+iQH
         J1dHSGqyN9G0t1m0R5EQ3gL8PPg315PZP7fvM=
Received: by 10.223.83.11 with SMTP id d11mr10404571fal.37.1291923982529; Thu,
 09 Dec 2010 11:46:22 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Thu, 9 Dec 2010 11:46:02 -0800 (PST)
In-Reply-To: <7vmxoeg3wp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163306>

On Thu, Dec 9, 2010 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> Junio, could you please drop patches 5-14 from the series; the first four patches
>> are the important ones and I'd rather they didn't get held up. Thanks!
>
> Have these four patches been Acked by interested parties?
>
> I think I saw 1/N and 2/N acked by Erik and 4/N acked by SSchuberth and
> J6t, but any words on 3/N?
>
> Not that I deeply care nor have environment to test changes to [3/N], but
> I am wondering if these need conditional definition to futureproof (e.g.
> what happens when the header you are using the definition _I64_MIN from,
> or some other headers, started defining these constats?).

I'm not sure if I follow this entirely. _I64_MIN is defined by
limits.h on Windows, and limits.h has a header-guard (or "#pragma
once" as Microsoft-code tends to prefer).

Oh, right. You mean if someone else starts defining INTMAX_MAX etc? If
someone includes an stdint/inttypes-implementation while including
git-compat-util.h, we're going to have a boat-load of similar issues
anyway. I think guarding them is something that's better left to when
we encounter the problem (if ever).

All in all, patch 1 though 4 looks good to me. And thanks to Ramsay
for cleaning up my mess :)
