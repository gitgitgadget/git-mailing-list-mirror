From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 23:06:36 +0200
Message-ID: <BANLkTikzcSuDQyHsd5Oepk_N5WhF_JVCPw@mail.gmail.com>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com> <20110414175212.GB23342@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:07:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATks-00072B-Fe
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab1DNVHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 17:07:01 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52211 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab1DNVG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 17:06:58 -0400
Received: by pvg12 with SMTP id 12so751107pvg.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jwHh+iFByC0MX5Hy8n8RNZCmQIQ8SG6VoiLmNufbI1U=;
        b=L7sRgnphXjdAHlwNootXI8dgYMB836AMfpj0aY/bMqhqbBMT1kFwiDKdYBF7Or/U+K
         eMc/hxs7ICCw8Wig+Lsx7qfYftvn1GDuzzxwhKlq2kUrYXjAG7O94NNRpCgPQZiX7PR9
         3JZPbLmJcDDIemHgl0GOK9midfYghj+6ppteg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=hSw9eX0EJRpsPrnktksJyx61ErcKzzriCcmuV4OUv80M7fGBFV5ZVVl67j8+witrQr
         zcSP6oNFF0OH4FywmwgxJ5+jKdptzzpXwvhEYL+mJjy6hFZtgkIw9g5rDfqpCHSxUrMx
         kQR/rpHeQo0wrJWFG/MydPeKZJDQ7n7uAF4Bg=
Received: by 10.68.20.166 with SMTP id o6mr843312pbe.196.1302815216065; Thu,
 14 Apr 2011 14:06:56 -0700 (PDT)
Received: by 10.68.56.105 with HTTP; Thu, 14 Apr 2011 14:06:36 -0700 (PDT)
In-Reply-To: <20110414175212.GB23342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171553>

On Thu, Apr 14, 2011 at 7:52 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 14, 2011 at 07:01:41PM +0200, Erik Faye-Lund wrote:
>
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index 9c66367..a4b8b59 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -793,4 +793,19 @@ test_expect_success 'format-patch wraps extreme=
ly
>> long headers (rfc2047)' '
>
> Speaking of wrapping, your MUA seems to have mangled the patch.
>
>> +M8=3D"foo_bar_"
>> +M64=3D$M8$M8$M8$M8$M8$M8$M8$M8
>> +cat >expect <<'EOF'
>> +From: foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_b=
ar
>> + <foobar@foo.bar>
>> +EOF
>
> Your expect data is missing the trailing "_". You could probably just
> do:
>
> =A0cat >expect <<EOF
> =A0From: $M64
> =A0 <foobar@foo.bar>
> =A0EOF
>
> which is even simpler.
>
> -Peff
>
