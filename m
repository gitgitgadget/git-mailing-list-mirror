From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 2/2] Smart-http: check if repository is OK to export 
	before serving it
Date: Mon, 28 Dec 2009 11:57:18 -0500
Message-ID: <905315640912280857g710b45fcne21a21d53ff0fedf@mail.gmail.com>
References: <7vk4w963np.fsf@alter.siamese.dyndns.org> <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com> 
	<1261870153-57572-2-git-send-email-tarmigan+git@gmail.com> 
	<20091227211033.GB609@spearce.org> <905315640912272007i8b4904dv2b93879789b453fb@mail.gmail.com> 
	<20091228155931.GC2252@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	rctay89@gmail.com, drizzd@aon.at, warthog9@kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 17:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPIud-0000yg-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 17:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZL1Q5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 11:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbZL1Q5j
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 11:57:39 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:39443 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbZL1Q5i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 11:57:38 -0500
Received: by pwj9 with SMTP id 9so6353910pwj.21
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=KduUqqWIr9nR8v02oGSGdeLe0Fj1Z4ituL+OB57044Y=;
        b=bduFknKbE6zPqB1CsCqwBmOqNAafUyL0fivro/HjSdZE4jRBRfZ+l6so/IXUV7LPsc
         j/1FVX5xfcK3qbYVaBl2L3GwqkiTuOt/f1ltz7FirIk3mdaOc+0gbUMHpEko+UPTWxAr
         I9reqCV69BNEp1aVBpuHyTrlXdPKZxiRLP6sE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=ZZLzXICn1xs7PcXszA84Bv4yqpduV/ZXOeOXdTSvtfjQWu2GhAj81MC4C821m3d4ae
         7br5MpjBteIsErAMizYCak9Lbl9+i757HXir+4H5gWzDuBuO6OVUKev5ihaj02MWzw90
         YsALfBiPmlKH0cWcUapsWzLKXBtuQw8vC743g=
Received: by 10.142.4.10 with SMTP id 10mr2879743wfd.124.1262019458114; Mon, 
	28 Dec 2009 08:57:38 -0800 (PST)
In-Reply-To: <20091228155931.GC2252@spearce.org>
X-Google-Sender-Auth: 625d27d60005c469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135747>

On Mon, Dec 28, 2009 at 10:59 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> Tarmigan <tarmigan+git@gmail.com> wrote:
>> I've been thinking that the not_found() to a forbidden() instead.
>
> Oh. =A0Interesting question.
>
> Because you can't resolve the access error by authenticating to
> the server, we may actually want to just return not_found() here
> with a message in the log of "Repository not exported: '%s'".

I'm no http expert, but isn't that what 401 would be?  From
http://tools.ietf.org/html/rfc2616#section-10.4.4
403 Forbidden
   The server understood the request, but is refusing to fulfill it.
   Authorization will not help and the request SHOULD NOT be repeated.
   If the request method was not HEAD and the server wishes to make
   public why the request has not been fulfilled, it SHOULD describe th=
e
   reason for the refusal in the entity.  If the server does not wish t=
o
   make this information available to the client, the status code 404
   (Not Found) can be used instead.
which to me points to 403 instead of 404.

I don't have a strong preference, and will resend with those changes
if you'd prefer 404.

Thanks,
Tarmigan
