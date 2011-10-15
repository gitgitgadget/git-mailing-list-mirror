From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sat, 15 Oct 2011 11:51:15 +1100
Message-ID: <CACsJy8CB4uBZkM8xPH6N+HPR-KX+KCCvfT4RrBV+gzTy=zz8og@mail.gmail.com>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org> <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net> <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net> <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net> <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net> <20111014211244.GA16429@sigill.intra.peff.net>
 <20111014211921.GB16429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 15 02:51:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REsTh-0002Bd-Jj
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 02:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab1JOAvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 20:51:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48291 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196Ab1JOAvr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 20:51:47 -0400
Received: by bkbzt19 with SMTP id zt19so608966bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gEIGSjgPiuZiwMrnKUlwLCieapG4H6S2Gih/tzSTbGQ=;
        b=WaxhrXn1tZe8WoVtGa5Mt4POCFoCjfefRXRqERPZ4ram+3z1j4RYghl3ggcrLFZT0m
         6w0YiazzWdSBJEmQNf8HcE9KTYXF1ZU1bOfHfPH8LCrWbUuvyMaFCIGZJJGN6IbbYXS0
         j9cSb0pIeNqLZjh/qdRhRGpl64ewFdv9v5jA8=
Received: by 10.204.140.78 with SMTP id h14mr8487822bku.29.1318639906166; Fri,
 14 Oct 2011 17:51:46 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Fri, 14 Oct 2011 17:51:15 -0700 (PDT)
In-Reply-To: <20111014211921.GB16429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183633>

On Sat, Oct 15, 2011 at 8:19 AM, Jeff King <peff@peff.net> wrote:
> @@ -257,11 +266,11 @@ static int run_service(char *dir, struct daemon=
_service *service)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!enabled && !service->overridable) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logerror("'%s'=
: service not enabled.", service->name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EACC=
ES;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return daemon_erro=
r(dir, "service not enabled");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Nit picking. In this case the service is disabled entirely regardless
dir and it uses the same message with the case where service is
disabled per repo later on. Maybe we could reword it a little bit to
differentiate the two cases? Say the first case "service disabled",
and the second one "service not enabled"?
--=20
Duy
