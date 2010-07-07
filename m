From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 7 Jul 2010 10:30:12 +0000
Message-ID: <AANLkTinxDSS2G60_nQ12UqZpSJCvg_kfWYKzmTqJU7Ox@mail.gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 12:30:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWRtd-0005w1-I8
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 12:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab0GGKaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 06:30:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42677 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab0GGKaN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 06:30:13 -0400
Received: by iwn7 with SMTP id 7so7711427iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qS3K1MKUjNx24uG1YZBOeLSOOW5RsTMMy08XByIsiFQ=;
        b=YyEr0ehOlc12DVUhVr5jwqFgrM6MJeiRiT+P+Bx/i/2zTEb+6+gqP5mkzNulHAixzy
         DWICOuOAxjXAtV5dP+QTj3ECpZRhm0q+kjC7A062Zu5LLBmR8HWNbt09dg/OeuOtAMA8
         RzNQooKg8EA8WqJHscDcI2Eo8EfRz9//yhKOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bu40qTfyB+kL4Wr76strgWY0T38LdscrqU9yTQWZlLA/cLMw9Hr+xe0ViwZZXZzYNx
         d0mefnOgrlzX+K3Aym3gFnI5mth8z+QkeGzVsTjnnUAQ18quZ+wuISSzKx9QzslbMCJ/
         CMx1lbDdRgmEYmJP+my/SWUkv23YMvzMft6Xw=
Received: by 10.231.170.144 with SMTP id d16mr6649175ibz.160.1278498612980; 
	Wed, 07 Jul 2010 03:30:12 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 7 Jul 2010 03:30:12 -0700 (PDT)
In-Reply-To: <1278496676-26575-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150464>

On Wed, Jul 7, 2010 at 09:57, Jakub Narebski <jnareb@gmail.com> wrote:
> [...]
> =C2=A0use strict;
> =C2=A0use warnings;
> +
> +use File::Spec;
> +# __DIR__ is taken from Dir::Self __DIR__ fragment
> +sub __DIR__ () {
> + =C2=A0 =C2=A0 =C2=A0 File::Spec->rel2abs(join '', (File::Spec->spli=
tpath(__FILE__))[0, 1]);
> +}
> +use lib __DIR__ . '/lib';
> +

What was the result of the discussion about using __DIR__ again? You
only need to use that method when you call a perl program whith *then*
includes a module. If you just need to add the lib/ directory relative
to the script you're invoking you can use FindBin:

    use FindBin qw($Bin);
    use lib "$Bin/lib";

> =C2=A0use CGI qw(:standard :escapeHTML -nosticky);
> =C2=A0use CGI::Util qw(unescape);
> =C2=A0use CGI::Carp qw(fatalsToBrowser set_message);
> @@ -16,6 +24,7 @@ use Encode;
> =C2=A0use Fcntl ':mode';
> =C2=A0use File::Find qw();
> =C2=A0use File::Basename qw(basename);
> +
> =C2=A0binmode STDOUT, ':utf8';

The whitespace change distracts from the real patch a bit.
