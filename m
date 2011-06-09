From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Thu, 9 Jun 2011 12:26:11 +0200
Message-ID: <BANLkTimBF=hVmPLdh1Wqe4WBNFA2kpw6mg@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com> <20110608194205.GI27715@elie>
 <20110608221908.GB15530@sigill.intra.peff.net> <20110609080912.GB4885@elie>
 <BANLkTincedbjH+ta6g7+uA3=3k_30RQaCg@mail.gmail.com> <20110609084342.GC4885@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 12:26:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUcS0-0000rG-KT
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 12:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab1FIK0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 06:26:52 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50912 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab1FIK0v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 06:26:51 -0400
Received: by qyk7 with SMTP id 7so2392687qyk.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=evUlQbstFArhuVqJmLqN7UwzqI5mC8Q/UD6D9AfYwT8=;
        b=WhRUKGnVO6fjqa3EDyWib3DMdELTnoTzdpUeKu6qc/oHXYPiVyHFVWWC2pYeQjJpFV
         cX+7BC186rgfnIpZQen+MZMzCQkFEoXov8hbqOtP1pY+5l3VMC5d682xmlglQdwrRxsA
         cnrpmFNNLijfNTPOfdw1gD54/c/A0Wocp2Ca8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cMyaSIByCq0zFHvCQx2aqTy+9wzcNYrp0e/vris6tIdzsWCDtOxqmfvBl6cO34yw0q
         6zQ5CIxLTO35J1ki6sKzbmhzlkKrts9NPopNm8CzF7vw7CX1F6YRX7gAyxEYjlrKhtQ2
         Pq/wgiEodwdql/GOAaLXcuDGjK2KGi4WS9fXc=
Received: by 10.229.135.12 with SMTP id l12mr416124qct.53.1307615211083; Thu,
 09 Jun 2011 03:26:51 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 03:26:11 -0700 (PDT)
In-Reply-To: <20110609084342.GC4885@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175515>

Heya,

On Thu, Jun 9, 2011 at 10:43, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Sverre Rabbelier wrote:
>> On Thu, Jun 9, 2011 at 10:09, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :1 refs/heads/foo
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :2 refs/heads/bar
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :3 +refs/heads/force
>>>
>>> with :1, :2, and :3 being marks in the fast-import stream.
>>
>> The only problem there is that we don't know the relevant marks befo=
rehand.
>
> Since this requires changing "git fast-export" anyway, we could
> arrange to know.

How? Or do you mean like, 'reserve' a certain mark?

> A related problem, though: it is not friendly to stomp on mark number=
s
> which an exporter might want to use for some other purpose. =C2=A0So =
yeah,
> the precise syntax above is not so great.

We might just want to do it _afterward_. We already have some
communication after the import (the "ok ..." lines), so why not add a
"update :1 /refs/heads/master"?

--=20
Cheers,

Sverre Rabbelier
