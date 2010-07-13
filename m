From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 19:41:45 -0500
Message-ID: <AANLkTinfo1QDguIbNgOt9w9V9xuJbhrCmusfe9g8fosm@mail.gmail.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com> 
	<7vaapw8ehn.fsf@alter.siamese.dyndns.org> <7vocec6xlt.fsf@alter.siamese.dyndns.org> 
	<7viq4k6xea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pickens, James E" <james.e.pickens@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:42:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYTZg-0002Am-9P
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab0GMAmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 20:42:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51507 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0GMAmK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 20:42:10 -0400
Received: by gxk23 with SMTP id 23so2906730gxk.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 17:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CJ//S9e0rppFxSGqPuPtPVe124eYfF28AbfgjJq5gjQ=;
        b=iLm19FwanxAc7hHUJKSHsDkXRtoKCM37flp6VYOrQrIRK3O5YwykZnHAnh9XiEz3Oj
         U3Xt7rFp2uO6mji61pO1mK61oFfMqU4Ns8Fm0vpX/XXK3Qj7d3xgCCoWV/GRFpFsh4v3
         1rb5fm5ztu+sFTnJu7dzc2YrcP1PFDoC2yJNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iTJGAHrzYXjloRLBfSXuXCTdpvdFu9SuY8fkp8b1xgqz6XKDYZv7ZpW2EAuklSC0ql
         h7YQ2HTmZwX7Z6IhLKuDI43JqU29SYiNRDPbPmt8gs2nhb+mnCGVHZhUJIGjO8lg3MBP
         /y0pZJWqCJj0Hn/dnooNdDwCP0+ek/IiDWX1I=
Received: by 10.151.124.5 with SMTP id b5mr5915391ybn.333.1278981725157; Mon, 
	12 Jul 2010 17:42:05 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Mon, 12 Jul 2010 17:41:45 -0700 (PDT)
In-Reply-To: <7viq4k6xea.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150860>

Heya,

On Mon, Jul 12, 2010 at 19:25, Junio C Hamano <gitster@pobox.com> wrote=
:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ents !=3D i + =
2 ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ent=
[i+1].item->flags & UNINTERESTING) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!en=
t[i].item->flags & SYMMETRIC_LEFT) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ent=
[i+1].item->flags & SYMMETRIC_LEFT))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("what do you mean by that?");

That's about as helpful an error message as "Your parents must hate
you" or whatever it is. Can we rephrase it to tell the user what they
did wrong, and how to fix it?

--=20
Cheers,

Sverre Rabbelier
