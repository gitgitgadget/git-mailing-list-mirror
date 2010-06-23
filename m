From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/3] builtin/checkout: change -b from an OPTION_STRING to 
	a OPTION_SET_INT
Date: Thu, 24 Jun 2010 03:04:41 +0800
Message-ID: <AANLkTikYgbVlyLlaba2G2CTFc0wFgylPRvhm-BX0igFz@mail.gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
	<1277140782-4064-1-git-send-email-rctay89@gmail.com>
	<1277140782-4064-2-git-send-email-rctay89@gmail.com>
	<1277140782-4064-3-git-send-email-rctay89@gmail.com>
	<AANLkTikyugBxwyCu0GY4dTLW6n_OQhIPNnPfd0_i6k0t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:04:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVFh-0003kl-52
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab0FWTEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 15:04:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54793 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab0FWTEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:04:42 -0400
Received: by iwn1 with SMTP id 1so38312iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J1Ij2xCRPdbC43Pr9wJhtEj2QLE0cmXWZWvMtsqMyT0=;
        b=dNcpTUp/vv+GMp6z9lJs7iAI8VxyaPvQo5DdLWXRzRlDYYXT+sjm2T9YGOwyc+9d/T
         jPXYDpt58K7E3ud9OIQPt1tWrDtyE4hKzA5OBIdBBbTtXvohNeudCTV+r5Mn6s/vrplf
         sjuzeUliPt9Wz+Us/+yjfCSBFnxMjcvs+XNBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bo4Kg1Z+fVIbjsAJ5fu1/Ft6Jd4eoIFV3QcMVJ33M/ps1k9bynWCyVI8KxDMjz+wt5
         K3VJB0Fg6qhUlB2JiJ19Qtb4EdnMwbbJZKjF4Yh3yYDRik7lsA3XTCKj5F7K/8LE0K2y
         Ezq3y9ZFwPr5i/0XFT9RBmsZgLXtEv0w2b1T8=
Received: by 10.231.139.148 with SMTP id e20mr9488088ibu.164.1277319882098; 
	Wed, 23 Jun 2010 12:04:42 -0700 (PDT)
Received: by 10.231.17.193 with HTTP; Wed, 23 Jun 2010 12:04:41 -0700 (PDT)
In-Reply-To: <AANLkTikyugBxwyCu0GY4dTLW6n_OQhIPNnPfd0_i6k0t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149530>

Hi,

On Tue, Jun 22, 2010 at 7:04 AM, Erick Mattos <erick.mattos@gmail.com> =
wrote:
> Hi,
>
> 2010/6/21 Tay Ray Chuan <rctay89@gmail.com>:
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 1994be9..e794e1e 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -32,7 +32,8 @@ struct checkout_opts {
>> =A0 =A0 =A0 =A0int writeout_stage;
>> =A0 =A0 =A0 =A0int writeout_error;
>>
>> - =A0 =A0 =A0 const char *new_branch;
>> + =A0 =A0 =A0 int new_branch;
>> + =A0 =A0 =A0 const char *new_branch_name;
>
> The change of name of the existent variable creates more hassle than
> helps.
>
> As you are adding a new option I suggest you to create a new
> variable named new_branch_forced or whatever. =A0This way you avoid
> making a lot of changes as you did and minimize the possibility of
> adding new bugs by not catching all the problems affected by the
> name change.

Erick, thanks for the suggestion - I've a new iteration that takes
some of your points.

--=20
Cheers,
Ray Chuan
